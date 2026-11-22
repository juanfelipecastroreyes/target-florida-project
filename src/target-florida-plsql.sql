-- FUNCION: fn_customer_credit_balance
-- Devuelve el saldo de credito de tienda de un cliente (RN-07).
-- Saldo = suma de ABONOS (devoluciones) - suma de REDENCIONES (credito usado como pago).
-- Se invoca desde consultas o desde otros bloques PL/SQL.
CREATE OR REPLACE FUNCTION fn_customer_credit_balance(p_customer_id IN NUMBER)
RETURN NUMBER
IS
    v_balance NUMBER(12,2);
BEGIN
SELECT NVL(SUM(CASE WHEN movement_type = 'ABONO' THEN amount ELSE -amount END), 0)
INTO v_balance
FROM store_credit_movements
WHERE customer_id = p_customer_id;

RETURN v_balance;
END;
/

-- PROCEDIMIENTO: sp_register_adjustment
-- Registra un ajuste manual de inventario (dano, perdida o conteo fisico) y
-- actualiza el stock de la variante en la misma transaccion.
-- Valida que el empleado este activo y que el stock no quede negativo.
-- El id del ajuste se toma de la secuencia inv_adj_seq.
-- No hace COMMIT: la confirmacion o reversion la decide quien lo invoca.
-- Se invoca con: CALL sp_register_adjustment(variante, cantidad, motivo, empleado);
CREATE OR REPLACE PROCEDURE sp_register_adjustment(
    p_variant_id IN NUMBER,
    p_quantity_change IN NUMBER,
    p_reason IN VARCHAR2,
    p_employee_id IN NUMBER
)
IS
    v_active employees.is_active%TYPE;
    v_stock variants.stock%TYPE;
    v_new_id inventory_adjustments.adjustment_id%TYPE;
BEGIN
SELECT is_active INTO v_active FROM employees WHERE employee_id = p_employee_id;
IF v_active = 'N' THEN
        RAISE_APPLICATION_ERROR(-20001, 'El empleado esta inactivo y no puede registrar ajustes');
END IF;

SELECT stock INTO v_stock FROM variants WHERE variant_id = p_variant_id FOR UPDATE;
IF v_stock + p_quantity_change < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El ajuste dejaria el stock en negativo');
END IF;

v_new_id := inv_adj_seq.NEXTVAL;

INSERT INTO inventory_adjustments (adjustment_id, quantity_change, reason, adjustment_date, variant_id, employee_id)
VALUES (v_new_id, p_quantity_change, p_reason, SYSDATE, p_variant_id, p_employee_id);

UPDATE variants SET stock = stock + p_quantity_change WHERE variant_id = p_variant_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'No existe el empleado o la variante indicada');
END;
/

-- TRIGGER: trg_scm_customer_check
-- Se dispara antes de insertar o actualizar un movimiento de credito.
-- Verifica que el cliente del movimiento sea el mismo cliente de la venta
-- devuelta (si es ABONO) o de la venta/apartado pagado (si es REDENCION).
-- Resuelve la correccion de la Entrega 2 sobre la consistencia del credito.
CREATE OR REPLACE TRIGGER trg_scm_customer_check
BEFORE INSERT OR UPDATE ON store_credit_movements
FOR EACH ROW
DECLARE
v_customer_id customers.customer_id%TYPE;
BEGIN
    IF :NEW.return_id IS NOT NULL THEN
SELECT sales.customer_id INTO v_customer_id
FROM returns
         JOIN sales ON sales.sale_id = returns.sale_id
WHERE returns.return_id = :NEW.return_id;
ELSIF :NEW.payment_id IS NOT NULL THEN
SELECT NVL(sales.customer_id, layaways.customer_id) INTO v_customer_id
FROM payments
         LEFT JOIN sales ON sales.sale_id = payments.sale_id
         LEFT JOIN layaways ON layaways.layaway_id = payments.layaway_id
WHERE payments.payment_id = :NEW.payment_id;
END IF;

    IF v_customer_id IS NOT NULL AND v_customer_id <> :NEW.customer_id THEN
        RAISE_APPLICATION_ERROR(-20010, 'El cliente del movimiento no coincide con el de la devolucion o el pago');
END IF;
END;
/

-- TRIGGER: trg_sale_details_stock
-- Se dispara antes de insertar una linea de venta (RN-02).
-- Verifica que la variante tenga stock suficiente para la cantidad vendida y,
-- si lo tiene, descuenta esa cantidad del stock automaticamente.
-- Si la venta viene de un apartado completado, no descuenta de nuevo, porque
-- el stock ya se habia reservado al crear el apartado.
-- Nota: se crea despues de cargar el DML, cuyos datos ya traen el stock final.
CREATE OR REPLACE TRIGGER trg_sale_details_stock
BEFORE INSERT ON sale_details
FOR EACH ROW
DECLARE
    v_stock variants.stock%TYPE;
    v_layaway_id sales.layaway_id%TYPE;
BEGIN
    SELECT layaway_id INTO v_layaway_id FROM sales WHERE sale_id = :NEW.sale_id;

    IF v_layaway_id IS NULL THEN
        SELECT stock INTO v_stock FROM variants WHERE variant_id = :NEW.variant_id FOR UPDATE;

        IF v_stock < :NEW.quantity THEN
            RAISE_APPLICATION_ERROR(-20020, 'Stock insuficiente: la variante ' || :NEW.variant_id || ' tiene ' || v_stock || ' unidades disponibles');
        END IF;

        UPDATE variants SET stock = stock - :NEW.quantity WHERE variant_id = :NEW.variant_id;
    END IF;
END;
/

-- =====================================================================
-- PRUEBAS
-- =====================================================================

-- ---------- FUNCION: fn_customer_credit_balance ----------
-- Cliente 1: tiene un abono de 50000 por la devolucion 1. Esperado: 50000
SELECT fn_customer_credit_balance(1) AS saldo FROM dual;

-- Cliente 5: abono de 5000 y redencion de 5000. Esperado: 0
SELECT fn_customer_credit_balance(5) AS saldo FROM dual;

-- Saldo de todos los clientes usando la funcion dentro de una consulta
SELECT customers.customer_id, persons.first_name || ' ' || persons.last_name AS cliente, fn_customer_credit_balance(customers.customer_id) AS saldo
FROM customers
         JOIN persons ON persons.person_id = customers.customer_id
ORDER BY saldo DESC;


-- ---------- PROCEDIMIENTO: sp_register_adjustment ----------
-- Caso valido: se registra el ajuste y el stock de la variante 1 baja en 1
SELECT stock AS stock_antes FROM variants WHERE variant_id = 1;
CALL sp_register_adjustment(1, -1, 'Prenda danada en vitrina', 11);
SELECT stock AS stock_despues FROM variants WHERE variant_id = 1;
SELECT * FROM inventory_adjustments ORDER BY adjustment_id DESC FETCH FIRST 1 ROWS ONLY;

-- Caso de error: el empleado 15 esta inactivo. Esperado: ORA-20001
CALL sp_register_adjustment(1, -1, 'Prueba empleado inactivo', 15);

-- Caso de error: el ajuste dejaria el stock negativo. Esperado: ORA-20002
CALL sp_register_adjustment(2, -50, 'Prueba stock negativo', 11);

-- Caso de error: la variante no existe. Esperado: ORA-20003
CALL sp_register_adjustment(999, -1, 'Prueba variante inexistente', 11);


-- ---------- TRIGGER: trg_scm_customer_check ----------
-- Preparacion: el cliente 1 (saldo de 50000) abre un apartado y paga un abono
-- de 20000 con credito de tienda (metodo de pago 4 = CREDITO_TIENDA).
INSERT INTO layaways (layaway_id, created_date, due_date, status, customer_id, employee_id)
VALUES (5, SYSDATE, SYSDATE + 30, 'VIGENTE', 1, 11);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id)
VALUES (33, 20000, SYSDATE, 4, NULL, 5);

-- Caso de error: el pago 33 es del cliente 1, pero la redencion se registra
-- a nombre del cliente 2. Esperado: ORA-20010
INSERT INTO store_credit_movements (movement_id, movement_type, amount, movement_date, customer_id, return_id, payment_id)
VALUES (99, 'REDENCION', 20000, SYSDATE, 2, NULL, 33);

-- Caso valido: la redencion se registra a nombre del cliente 1, dueno del pago.
-- El trigger la deja pasar y el saldo del cliente 1 baja de 50000 a 30000.
INSERT INTO store_credit_movements (movement_id, movement_type, amount, movement_date, customer_id, return_id, payment_id)
VALUES (100, 'REDENCION', 20000, SYSDATE, 1, NULL, 33);
SELECT * FROM store_credit_movements WHERE movement_id = 100;
SELECT fn_customer_credit_balance(1) AS saldo_cliente_1 FROM dual;

-- ---------- TRIGGER: trg_sale_details_stock ----------
-- Preparacion: nueva venta del cliente 1 atendida por el empleado 11.
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id)
VALUES (27, SYSDATE, 130000, 1, 11, NULL);

-- Caso valido: la variante 6 tiene 11 unidades; se venden 2 y el stock baja a 9.
SELECT stock AS stock_antes FROM variants WHERE variant_id = 6;
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (27, 6, 2, 65000);
SELECT stock AS stock_despues FROM variants WHERE variant_id = 6;

-- Caso de error: la variante 2 tiene 2 unidades y se intentan vender 5.
-- Esperado: ORA-20020
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (27, 2, 5, 65000);


-- Deshace todas las pruebas (el ajuste de inventario, el apartado, el pago,
-- la redencion y la venta 27) para que los datos queden como los dejo el DML.
ROLLBACK;