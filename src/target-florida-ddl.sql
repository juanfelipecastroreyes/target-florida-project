-- =====================================================================
-- Target Florida — Script DDL (Oracle)
-- Crea las 25 tablas del modelo relacional en 3FN, en orden de dependencia.
-- =====================================================================

-- ---------------------------------------------------------------------
-- PERSONS: supertipo de clientes y empleados. Guarda los datos comunes.
-- person_type ('C' cliente, 'E' empleado) es el discriminador de la jerarquía.
-- El UNIQUE (person_id, person_type) permite que CUSTOMERS y EMPLOYEES lo
-- referencien con una FK compuesta, de modo que una persona solo puede
-- pertenecer a uno de los dos subtipos.
-- ---------------------------------------------------------------------
CREATE table persons (
  person_id NUMBER(10),
  first_name VARCHAR2(50) CONSTRAINT persons_first_name_nn NOT NULL,
  last_name VARCHAR2(50) CONSTRAINT persons_last_name_nn NOT NULL,
  phone VARCHAR2(20) CONSTRAINT persons_phone_nn NOT NULL,
  person_type CHAR(1) CONSTRAINT persons_person_type_nn NOT NULL,
  CONSTRAINT persons_pk PRIMARY KEY(person_id),
  CONSTRAINT persons_person_type_ck CHECK(person_type IN ('C', 'E')),
  CONSTRAINT persons_person_id_person_type_uk UNIQUE(person_id, person_type)
);

-- ROLES: catálogo de roles del personal (cajero, bodeguero, administrador).
CREATE TABLE roles (
  role_id NUMBER(10),
  name VARCHAR2(50) CONSTRAINT roles_name_nn NOT NULL,
  CONSTRAINT roles_pk PRIMARY KEY(role_id),
  CONSTRAINT roles_name_uk UNIQUE(name)
);

-- CATEGORIES: catálogo de categorías de prendas (busos, jeans, sacos...).
CREATE TABLE categories (
  category_id NUMBER(10),
  name VARCHAR2(50) CONSTRAINT categories_name_nn NOT NULL,
  CONSTRAINT categories_pk PRIMARY KEY(category_id),
  CONSTRAINT categories_name_uk UNIQUE(name)
);

-- BRANDS: catálogo de marcas (Nike, Adidas, Openmind, TRUST...).
CREATE TABLE brands (
    brand_id NUMBER(10),
    name VARCHAR2(50) CONSTRAINT brands_name_nn NOT NULL,
    CONSTRAINT brands_pk PRIMARY KEY(brand_id),
    CONSTRAINT brands_name_uk UNIQUE(name)
);

-- SUPPLIERS: proveedores a los que se les recogen los lotes en persona.
-- is_active indica si el proveedor sigue activo (RN-05).
CREATE TABLE suppliers (
  supplier_id NUMBER(10),
  name VARCHAR2(100) CONSTRAINT suppliers_name_nn NOT NULL,
  phone VARCHAR2(20) CONSTRAINT suppliers_phone_nn NOT NULL,
  building VARCHAR2(100) CONSTRAINT suppliers_building_nn NOT NULL,
  local_number VARCHAR2(20) CONSTRAINT suppliers_local_number_nn NOT NULL,
  is_active CHAR(1) CONSTRAINT suppliers_is_active_nn NOT NULL,
  CONSTRAINT suppliers_pk PRIMARY KEY(supplier_id),
  CONSTRAINT suppliers_is_active_ck CHECK(is_active IN ('Y', 'N'))
);

-- PROMOTIONS: promociones con precio fijo y vigencia.
-- El CHECK garantiza que la fecha final no sea anterior a la inicial.
CREATE TABLE promotions (
  promotion_id NUMBER(10),
  fixed_price NUMBER(12,2) CONSTRAINT promotions_fixed_price_nn NOT NULL,
  start_date DATE CONSTRAINT promotions_start_date_nn NOT NULL,
  end_date DATE CONSTRAINT promotions_end_date_nn NOT NULL,
  CONSTRAINT promotions_pk PRIMARY KEY(promotion_id),
  CONSTRAINT promotions_fixed_price_ck CHECK(fixed_price > 0),
  CONSTRAINT promotions_valid_range_date_ck CHECK (end_date >= start_date)
);

-- PAYMENT_METHODS: catálogo de métodos de pago (efectivo, transferencia,
-- Sistecrédito, crédito de tienda).
CREATE TABLE payment_methods (
  payment_method_id NUMBER(10),
  name VARCHAR2(50) CONSTRAINT payment_methods_name_nn NOT NULL,
  CONSTRAINT payment_methods_pk PRIMARY KEY(payment_method_id),
  CONSTRAINT payment_methods_name_uk UNIQUE(name)
);

-- ---------------------------------------------------------------------
-- CUSTOMERS: subtipo de PERSONS para los clientes.
-- person_type siempre vale 'C' (DEFAULT + CHECK). La FK compuesta
-- (customer_id, person_type) -> PERSONS exige que la persona esté
-- registrada como cliente, lo que impide que también sea empleado.
-- ---------------------------------------------------------------------
CREATE TABLE customers (
  customer_id NUMBER(10),
  person_type CHAR(1) DEFAULT 'C' CONSTRAINT customers_person_type_nn NOT NULL,
  is_active CHAR(1) CONSTRAINT customers_is_active_nn NOT NULL,
  CONSTRAINT customers_pk PRIMARY KEY(customer_id),
  CONSTRAINT customers_person_type_ck CHECK(person_type = 'C'),
  CONSTRAINT customers_is_active_ck CHECK(is_active IN ('Y', 'N')),
  CONSTRAINT customers_persons_fk FOREIGN KEY(customer_id, person_type) REFERENCES persons(person_id, person_type)
);

-- EMPLOYEES: subtipo de PERSONS para los empleados.
-- Misma técnica que CUSTOMERS, con person_type fijo en 'E'.
-- is_active permite bloquear a empleados inactivos (RN-04).
CREATE TABLE employees (
  employee_id NUMBER(10),
  person_type CHAR(1) DEFAULT 'E' CONSTRAINT employees_person_type_nn NOT NULL,
  hire_date DATE CONSTRAINT employees_hire_date_nn NOT NULL,
  is_active CHAR(1) CONSTRAINT employees_is_active_nn NOT NULL,
  CONSTRAINT employees_pk PRIMARY KEY(employee_id),
  CONSTRAINT employees_person_type_ck CHECK(person_type = 'E'),
  CONSTRAINT employees_is_active_ck CHECK(is_active IN ('Y', 'N')),
  CONSTRAINT employees_id_type_fk FOREIGN KEY(employee_id, person_type) REFERENCES persons(person_id, person_type)
);

-- EMPLOYEE_ROLES: tabla intermedia de la relación N:M entre empleados y
-- roles. Un empleado puede tener varios roles a la vez. PK compuesta.
CREATE TABLE employee_roles (
    employee_id NUMBER(10),
    role_id NUMBER(10),
    CONSTRAINT employee_roles_pk PRIMARY KEY(employee_id, role_id),
    CONSTRAINT employee_roles_employees_fk FOREIGN KEY(employee_id) REFERENCES employees(employee_id),
    CONSTRAINT employee_roles_roles_fk FOREIGN KEY(role_id) REFERENCES roles(role_id)
);

-- ---------------------------------------------------------------------
-- PRODUCTS: diseños de prendas. Cada producto tiene SKU único (RN-01),
-- una categoría, una marca y el empleado que lo modificó por última vez.
-- ---------------------------------------------------------------------
CREATE TABLE products (
    product_id NUMBER(10),
    sku VARCHAR2(30) CONSTRAINT products_sku_nn NOT NULL,
    name VARCHAR2(100) CONSTRAINT products_name_nn NOT NULL,
    is_active CHAR(1) CONSTRAINT products_is_active_nn NOT NULL,
    updated_at DATE CONSTRAINT products_updated_at_nn NOT NULL,
    category_id NUMBER(10) CONSTRAINT products_category_id_nn NOT NULL,
    brand_id NUMBER(10) CONSTRAINT products_brand_id_nn NOT NULL,
    employee_id NUMBER(10) CONSTRAINT products_employee_id_nn NOT NULL,
    CONSTRAINT products_pk PRIMARY KEY(product_id),
    CONSTRAINT products_sku_uk UNIQUE(sku),
    CONSTRAINT products_is_active_ck CHECK(is_active IN ('Y', 'N')),
    CONSTRAINT products_categories_fk FOREIGN KEY(category_id) REFERENCES categories(category_id),
    CONSTRAINT products_brands_fk FOREIGN KEY(brand_id) REFERENCES brands(brand_id),
    CONSTRAINT products_employees_fk FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

-- VARIANTS: combinación de talla, color y material de un producto, con su
-- propio precio y stock. Es la unidad que se vende, aparta y recibe.
--   - UNIQUE (product_id, variant_size, color, material): RN-01.
--   - CHECK de talla en S, M, L, XL, XXL, precio > 0, stock y umbral >= 0.
--   - stock <= min_stock_threshold marca la alerta de stock bajo (RN-03).
CREATE TABLE variants (
    variant_id NUMBER(10),
    product_id NUMBER(10) CONSTRAINT variants_product_id_nn NOT NULL,
    variant_size VARCHAR2(3) CONSTRAINT variants_variant_size_nn NOT NULL,
    color VARCHAR2(30) CONSTRAINT variants_color_nn NOT NULL,
    material VARCHAR2(50) CONSTRAINT variants_material_nn NOT NULL,
    price NUMBER(12,2) CONSTRAINT variants_price_nn NOT NULL,
    stock NUMBER(10) DEFAULT 0 CONSTRAINT variants_stock_nn NOT NULL,
    min_stock_threshold NUMBER(10) CONSTRAINT variants_min_stock_threshold_nn NOT NULL,
    CONSTRAINT variants_pk PRIMARY KEY(variant_id),
    CONSTRAINT variants_products_fk FOREIGN KEY(product_id) REFERENCES products(product_id),
    CONSTRAINT variants_variant_size_ck CHECK(variant_size IN ('S', 'M', 'L', 'XL', 'XXL')),
    CONSTRAINT variants_price_ck CHECK(price > 0),
    CONSTRAINT variants_stock_ck CHECK(stock >= 0),
    CONSTRAINT variants_min_stock_threshold_ck CHECK(min_stock_threshold >= 0),
    CONSTRAINT variants_combo_uk UNIQUE (product_id, variant_size, color, material)
);

-- ---------------------------------------------------------------------
-- BATCHES: lotes de mercancía recibidos, cada uno de un proveedor (RN-05).
-- ---------------------------------------------------------------------
CREATE TABLE batches (
    batch_id NUMBER(10),
    entry_date DATE CONSTRAINT batches_entry_date_nn NOT NULL,
    supplier_id NUMBER(10) CONSTRAINT batches_supplier_id_nn NOT NULL,
    CONSTRAINT batches_pk PRIMARY KEY(batch_id),
    CONSTRAINT batches_suppliers_fk FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id)
);

-- ---------------------------------------------------------------------
-- LAYAWAYS: apartados. El cliente separa prendas pagando un adelanto.
-- Dominio de status: VIGENTE, COMPLETADO, VENCIDO, CANCELADO.
-- La fecha límite no puede ser anterior a la de creación.
-- ---------------------------------------------------------------------
CREATE TABLE layaways (
    layaway_id NUMBER(10),
    created_date DATE CONSTRAINT layaways_created_date_nn NOT NULL,
    due_date DATE CONSTRAINT layaways_due_date_nn NOT NULL,
    status VARCHAR2(10) DEFAULT 'VIGENTE' CONSTRAINT layaways_status_nn NOT NULL,
    customer_id NUMBER(10) CONSTRAINT layaways_customer_id_nn NOT NULL,
    employee_id NUMBER(10) CONSTRAINT layaways_employee_id_nn NOT NULL,
    CONSTRAINT layaways_pk PRIMARY KEY(layaway_id),
    CONSTRAINT layaways_date_range_ck CHECK (due_date >= created_date),
    CONSTRAINT layaways_status_ck CHECK (status IN ('VIGENTE', 'COMPLETADO', 'VENCIDO', 'CANCELADO')),
    CONSTRAINT layaways_customers_fk FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    CONSTRAINT layaways_employees_fk FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

-- LAYAWAY_DETAILS: variantes incluidas en cada apartado (N:M con atributos).
-- PK compuesta (layaway_id, variant_id).
CREATE TABLE layaway_details (
     layaway_id NUMBER(10),
     variant_id NUMBER(10),
     quantity NUMBER(10) CONSTRAINT layaway_details_quantity_nn NOT NULL,
     unit_price NUMBER(12,2) CONSTRAINT layaway_details_unit_price_nn NOT NULL,
     CONSTRAINT layaway_details_pk PRIMARY KEY(layaway_id, variant_id),
     CONSTRAINT layaway_details_layaways_fk FOREIGN KEY(layaway_id) REFERENCES layaways(layaway_id),
     CONSTRAINT layaway_details_variants_fk FOREIGN KEY(variant_id) REFERENCES variants(variant_id),
     CONSTRAINT layaway_details_quantity_ck CHECK(quantity > 0),
     CONSTRAINT layaway_details_unit_price_ck CHECK(unit_price > 0)
);

-- SPECIAL_ORDERS: encargos de prendas que se consiguen en otra ciudad.
-- Dominio de status: SOLICITADO, EN_GESTION, RECIBIDO, ENTREGADO, CANCELADO.
CREATE TABLE special_orders (
    special_order_id NUMBER(10),
    description VARCHAR2(500) CONSTRAINT special_orders_description_nn NOT NULL,
    order_date DATE CONSTRAINT special_orders_order_date_nn NOT NULL,
    deposit_amount NUMBER(12,2) CONSTRAINT special_orders_deposit_nn NOT NULL,
    status VARCHAR2(10) DEFAULT 'SOLICITADO' CONSTRAINT special_orders_status_nn NOT NULL,
    origin_city VARCHAR2(50) CONSTRAINT special_orders_origin_city_nn NOT NULL,
    customer_id NUMBER(10) CONSTRAINT special_orders_customer_id_nn NOT NULL,
    employee_id NUMBER(10) CONSTRAINT special_orders_employee_id_nn NOT NULL,
    CONSTRAINT special_orders_pk PRIMARY KEY(special_order_id),
    CONSTRAINT special_orders_deposit_ck CHECK(deposit_amount > 0),
    CONSTRAINT special_orders_status_ck CHECK(status IN ('SOLICITADO', 'EN_GESTION', 'RECIBIDO', 'ENTREGADO', 'CANCELADO')),
    CONSTRAINT special_orders_customers_fk FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    CONSTRAINT special_orders_employees_fk FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

-- ---------------------------------------------------------------------
-- SALES: ventas en tienda física. Toda venta tiene cliente y empleado (RN-04).
-- layaway_id es opcional y UNIQUE: implementa la relación 1:1 con LAYAWAYS
-- (un apartado completado genera como máximo una venta).
-- total se almacena para eficiencia de los reportes.
-- ---------------------------------------------------------------------
CREATE TABLE sales (
    sale_id NUMBER(10),
    sale_date DATE CONSTRAINT sales_sale_date_nn NOT NULL,
    total NUMBER(12,2) CONSTRAINT sales_total_nn NOT NULL,
    customer_id NUMBER(10) CONSTRAINT sales_customer_id_nn NOT NULL,
    employee_id NUMBER(10) CONSTRAINT sales_employee_id_nn NOT NULL,
    layaway_id NUMBER(10),
    CONSTRAINT sales_pk PRIMARY KEY(sale_id),
    CONSTRAINT sales_total_ck CHECK(total > 0),
    CONSTRAINT sales_customers_fk FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    CONSTRAINT sales_employees_fk FOREIGN KEY(employee_id) REFERENCES employees(employee_id),
    CONSTRAINT sales_layaway_id_uk UNIQUE(layaway_id),
    CONSTRAINT sales_layaways_fk FOREIGN KEY(layaway_id) REFERENCES layaways(layaway_id)
);

-- BATCH_DETAILS: variantes que trae cada lote, con cantidad y costo unitario
-- de compra (RN-05). PK compuesta (batch_id, variant_id).
CREATE TABLE batch_details (
    batch_id NUMBER(10),
    variant_id NUMBER(10),
    quantity NUMBER(10) CONSTRAINT batch_details_quantity_nn NOT NULL,
    unit_cost NUMBER(12,2) CONSTRAINT batch_details_unit_cost_nn NOT NULL,
    CONSTRAINT batch_details_pk PRIMARY KEY(batch_id, variant_id),
    CONSTRAINT batch_details_batches_fk FOREIGN KEY(batch_id) REFERENCES batches(batch_id),
    CONSTRAINT batch_details_variants_fk FOREIGN KEY(variant_id) REFERENCES variants(variant_id),
    CONSTRAINT batch_details_quantity_ck CHECK(quantity > 0),
    CONSTRAINT batch_details_unit_cost_ck CHECK(unit_cost > 0)
);

-- INVENTORY_ADJUSTMENTS: correcciones manuales de stock (daño, pérdida,
-- conteo físico) con su motivo y el empleado responsable.
-- quantity_change <> 0: puede sumar o restar, pero no ser cero.
CREATE TABLE inventory_adjustments (
   adjustment_id   NUMBER(10),
   quantity_change NUMBER(10)    CONSTRAINT inv_adj_quantity_change_nn NOT NULL,
   reason VARCHAR2(200) CONSTRAINT inv_adj_reason_nn NOT NULL,
   adjustment_date DATE CONSTRAINT inv_adj_adjustment_date_nn NOT NULL,
   variant_id NUMBER(10) CONSTRAINT inv_adj_variant_id_nn NOT NULL,
   employee_id NUMBER(10) CONSTRAINT inv_adj_employee_id_nn NOT NULL,
   CONSTRAINT inv_adj_pk PRIMARY KEY(adjustment_id),
   CONSTRAINT inv_adj_quantity_change_ck CHECK(quantity_change <> 0),
   CONSTRAINT inv_adj_variants_fk FOREIGN KEY(variant_id) REFERENCES variants(variant_id),
   CONSTRAINT inv_adj_employees_fk FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

-- PROMOTION_VARIANTS: tabla intermedia de la relación N:M entre promociones
-- y variantes. PK compuesta.
CREATE TABLE promotion_variants (
    promotion_id NUMBER(10),
    variant_id NUMBER(10),
    CONSTRAINT promotion_variants_pk PRIMARY KEY(promotion_id, variant_id),
    CONSTRAINT promo_variants_promotions_fk FOREIGN KEY(promotion_id) REFERENCES promotions(promotion_id),
    CONSTRAINT promo_variants_variants_fk FOREIGN KEY(variant_id) REFERENCES variants(variant_id)
);

-- SALE_DETAILS: líneas de cada venta. Guarda el precio efectivamente
-- cobrado (applied_price), que puede ser el de una promoción.
-- PK compuesta (sale_id, variant_id).
CREATE TABLE sale_details (
      sale_id NUMBER(10),
      variant_id NUMBER(10),
      quantity NUMBER(10)   CONSTRAINT sale_details_quantity_nn NOT NULL,
      applied_price NUMBER(12,2) CONSTRAINT sale_details_applied_price_nn NOT NULL,
      CONSTRAINT sale_details_pk PRIMARY KEY(sale_id, variant_id),
      CONSTRAINT sale_details_sales_fk FOREIGN KEY(sale_id) REFERENCES sales(sale_id),
      CONSTRAINT sale_details_variants_fk FOREIGN KEY(variant_id) REFERENCES variants(variant_id),
      CONSTRAINT sale_details_quantity_ck CHECK(quantity > 0),
      CONSTRAINT sale_details_applied_price_ck CHECK(applied_price > 0)
);

-- ---------------------------------------------------------------------
-- PAYMENTS: pagos de ventas o de apartados (una transacción admite varios
-- pagos con distintos métodos).
-- Arco exclusivo (RN-06): cada pago pertenece a una venta O a un apartado,
-- nunca a ambos ni a ninguno.
-- ---------------------------------------------------------------------
CREATE TABLE payments (
      payment_id NUMBER(10),
      amount NUMBER(12,2) CONSTRAINT payments_amount_nn NOT NULL,
      payment_date DATE CONSTRAINT payments_payment_date_nn NOT NULL,
      payment_method_id NUMBER(10) CONSTRAINT payments_payment_method_id_nn NOT NULL,
      sale_id NUMBER(10),
      layaway_id NUMBER(10),
      CONSTRAINT payments_pk PRIMARY KEY(payment_id),
      CONSTRAINT payments_amount_ck CHECK(amount > 0),
      CONSTRAINT payments_payment_methods_fk FOREIGN KEY(payment_method_id) REFERENCES payment_methods(payment_method_id),
      CONSTRAINT payments_sales_fk FOREIGN KEY(sale_id) REFERENCES sales(sale_id),
      CONSTRAINT payments_layaways_fk FOREIGN KEY(layaway_id) REFERENCES layaways(layaway_id),
      CONSTRAINT payments_arc_ck CHECK((sale_id IS NOT NULL AND layaway_id IS NULL) OR (sale_id IS NULL AND layaway_id IS NOT NULL))
);

-- ---------------------------------------------------------------------
-- RETURNS: devoluciones. Siempre referencian la venta original (RN-07) y se
-- resuelven con crédito de tienda o con cambio, nunca con efectivo.
-- El UNIQUE (return_id, sale_id) permite que RETURN_DETAILS lo referencie
-- con una FK compuesta.
-- ---------------------------------------------------------------------
CREATE TABLE returns (
     return_id NUMBER(10),
     return_date DATE CONSTRAINT returns_return_date_nn NOT NULL,
     resolution_type VARCHAR2(10) CONSTRAINT returns_resolution_type_nn NOT NULL,
     sale_id NUMBER(10) CONSTRAINT returns_sale_id_nn NOT NULL,
     CONSTRAINT returns_pk PRIMARY KEY(return_id),
     CONSTRAINT returns_resolution_type_ck CHECK(resolution_type IN ('CREDITO', 'CAMBIO')),
     CONSTRAINT returns_sales_fk FOREIGN KEY(sale_id) REFERENCES sales(sale_id),
     CONSTRAINT returns_return_sale_uk UNIQUE(return_id, sale_id)
);

-- RETURN_DETAILS: variantes devueltas en cada devolución.
-- Dos FK compuestas garantizan que solo se devuelva lo que se vendió:
--   - (return_id, sale_id) -> RETURNS: la venta es la misma de la devolución.
--   - (sale_id, variant_id) -> SALE_DETAILS: la variante se vendió en esa venta.
CREATE TABLE return_details (
    return_id  NUMBER(10),
    variant_id NUMBER(10),
    sale_id NUMBER(10) CONSTRAINT return_details_sale_id_nn NOT NULL,
    quantity NUMBER(10) CONSTRAINT return_details_quantity_nn NOT NULL,
    CONSTRAINT return_details_pk PRIMARY KEY(return_id, variant_id),
    CONSTRAINT return_details_quantity_ck CHECK(quantity > 0),
    CONSTRAINT return_details_returns_fk FOREIGN KEY(return_id, sale_id) REFERENCES returns(return_id, sale_id),
    CONSTRAINT return_details_sale_details_fk FOREIGN KEY(sale_id, variant_id) REFERENCES sale_details(sale_id, variant_id)
);

-- ---------------------------------------------------------------------
-- STORE_CREDIT_MOVEMENTS: historial del crédito de tienda de cada cliente.
-- El saldo es la suma de ABONOS menos la suma de REDENCIONES
-- (función fn_customer_credit_balance).
-- El CHECK amarra el tipo con su origen:
--   - ABONO: viene de una devolución (return_id) y no tiene pago.
--   - REDENCION: se usa como pago (payment_id) y no tiene devolución.
-- Los UNIQUE impiden que una devolución o un pago generen dos movimientos.
-- ---------------------------------------------------------------------
CREATE TABLE store_credit_movements (
    movement_id NUMBER(10),
    movement_type VARCHAR2(10) CONSTRAINT scm_movement_type_nn NOT NULL,
    amount NUMBER(12,2) CONSTRAINT scm_amount_nn NOT NULL,
    movement_date DATE CONSTRAINT scm_movement_date_nn NOT NULL,
    customer_id NUMBER(10) CONSTRAINT scm_customer_id_nn NOT NULL,
    return_id NUMBER(10),
    payment_id NUMBER(10),
    CONSTRAINT scm_pk PRIMARY KEY(movement_id),
    CONSTRAINT scm_amount_ck CHECK(amount > 0),
    CONSTRAINT scm_movement_type_ck CHECK(movement_type IN ('ABONO', 'REDENCION')),
    CONSTRAINT scm_return_id_uk UNIQUE(return_id),
    CONSTRAINT scm_payment_id_uk UNIQUE(payment_id),
    CONSTRAINT scm_customers_fk FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    CONSTRAINT scm_returns_fk FOREIGN KEY(return_id) REFERENCES returns(return_id),
    CONSTRAINT scm_payments_fk FOREIGN KEY(payment_id) REFERENCES payments(payment_id),
    CONSTRAINT scm_type_arc_ck CHECK((movement_type = 'ABONO' AND return_id IS NOT NULL AND payment_id IS NULL) OR (movement_type = 'REDENCION' AND payment_id IS NOT NULL AND return_id IS NULL))
);