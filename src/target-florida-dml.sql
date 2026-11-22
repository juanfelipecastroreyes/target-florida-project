-- =====================================================================
-- Target Florida - Script DML (datos de prueba)
-- Fechas relativas a SYSDATE para que los reportes (ej. 'ultimo mes')
-- siempre tengan datos, sin importar cuando se ejecute el script.
-- =====================================================================

-- ========== PERSONS (10 clientes + 5 empleados) ==========
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (1, 'Laura', 'Gómez', '3104567890', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (2, 'Andrés', 'Muñoz', '3125678901', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (3, 'Valentina', 'Ruiz', '3006789012', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (4, 'Santiago', 'López', '3017890123', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (5, 'Camila', 'Torres', '3158901234', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (6, 'Mateo', 'Ramírez', '3189012345', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (7, 'Isabella', 'Castro', '3200123456', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (8, 'Sebastián', 'Vargas', '3111234567', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (9, 'Mariana', 'Herrera', '3142345678', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (10, 'Juan', 'Patiño', '3163456789', 'C');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (11, 'Carolina', 'Rojas', '3174567891', 'E');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (12, 'Felipe', 'Ortiz', '3195678912', 'E');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (13, 'Daniela', 'Mejía', '3016789123', 'E');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (14, 'Carlos', 'Zapata', '3027891234', 'E');
INSERT INTO persons (person_id, first_name, last_name, phone, person_type) VALUES (15, 'Natalia', 'Cárdenas', '3038912345', 'E');

-- ========== CUSTOMERS (person_type se llena con el DEFAULT 'C') ==========
INSERT INTO customers (customer_id, is_active) VALUES (1, 'Y');
INSERT INTO customers (customer_id, is_active) VALUES (2, 'Y');
INSERT INTO customers (customer_id, is_active) VALUES (3, 'Y');
INSERT INTO customers (customer_id, is_active) VALUES (4, 'Y');
INSERT INTO customers (customer_id, is_active) VALUES (5, 'Y');
INSERT INTO customers (customer_id, is_active) VALUES (6, 'Y');
INSERT INTO customers (customer_id, is_active) VALUES (7, 'Y');
INSERT INTO customers (customer_id, is_active) VALUES (8, 'Y');
INSERT INTO customers (customer_id, is_active) VALUES (9, 'N');
INSERT INTO customers (customer_id, is_active) VALUES (10, 'Y');

-- ========== EMPLOYEES (person_type se llena con el DEFAULT 'E') ==========
INSERT INTO employees (employee_id, hire_date, is_active) VALUES (11, DATE '2023-02-01', 'Y');
INSERT INTO employees (employee_id, hire_date, is_active) VALUES (12, DATE '2023-08-15', 'Y');
INSERT INTO employees (employee_id, hire_date, is_active) VALUES (13, DATE '2024-03-10', 'Y');
INSERT INTO employees (employee_id, hire_date, is_active) VALUES (14, DATE '2024-11-01', 'Y');
INSERT INTO employees (employee_id, hire_date, is_active) VALUES (15, DATE '2025-06-20', 'N');

-- ========== ROLES ==========
INSERT INTO roles (role_id, name) VALUES (1, 'CAJERO');
INSERT INTO roles (role_id, name) VALUES (2, 'BODEGUERO');
INSERT INTO roles (role_id, name) VALUES (3, 'ADMINISTRADOR');

-- ========== EMPLOYEE_ROLES (un empleado puede tener varios roles) ==========
INSERT INTO employee_roles (employee_id, role_id) VALUES (11, 3);
INSERT INTO employee_roles (employee_id, role_id) VALUES (11, 1);
INSERT INTO employee_roles (employee_id, role_id) VALUES (12, 1);
INSERT INTO employee_roles (employee_id, role_id) VALUES (12, 2);
INSERT INTO employee_roles (employee_id, role_id) VALUES (13, 1);
INSERT INTO employee_roles (employee_id, role_id) VALUES (14, 2);
INSERT INTO employee_roles (employee_id, role_id) VALUES (14, 1);
INSERT INTO employee_roles (employee_id, role_id) VALUES (15, 1);

-- ========== CATEGORIES ==========
INSERT INTO categories (category_id, name) VALUES (1, 'BUSOS');
INSERT INTO categories (category_id, name) VALUES (2, 'JEANS');
INSERT INTO categories (category_id, name) VALUES (3, 'SACOS');
INSERT INTO categories (category_id, name) VALUES (4, 'SUETERES');
INSERT INTO categories (category_id, name) VALUES (5, 'SHORTS');
INSERT INTO categories (category_id, name) VALUES (6, 'SUDADERAS');

-- ========== BRANDS ==========
INSERT INTO brands (brand_id, name) VALUES (1, 'Nike');
INSERT INTO brands (brand_id, name) VALUES (2, 'Adidas');
INSERT INTO brands (brand_id, name) VALUES (3, 'Amiri');
INSERT INTO brands (brand_id, name) VALUES (4, 'Jordan');
INSERT INTO brands (brand_id, name) VALUES (5, 'GodSpeed');
INSERT INTO brands (brand_id, name) VALUES (6, 'Psycho Bunny');
INSERT INTO brands (brand_id, name) VALUES (7, 'Openmind');
INSERT INTO brands (brand_id, name) VALUES (8, 'TRUST');

-- ========== SUPPLIERS (el 4 esta inactivo) ==========
INSERT INTO suppliers (supplier_id, name, phone, building, local_number, is_active) VALUES (1, 'Moda Express', '3201112233', 'CC Unicentro', 'L-105', 'Y');
INSERT INTO suppliers (supplier_id, name, phone, building, local_number, is_active) VALUES (2, 'Urban Wear', '3152223344', 'CC Chipichape', 'L-212', 'Y');
INSERT INTO suppliers (supplier_id, name, phone, building, local_number, is_active) VALUES (3, 'Distribuciones El Saman', '3183334455', 'Edificio Plaza Caicedo', 'L-08', 'Y');
INSERT INTO suppliers (supplier_id, name, phone, building, local_number, is_active) VALUES (4, 'Textiles del Valle', '3004445566', 'CC Palmetto', 'L-301', 'N');

-- ========== PROMOTIONS (1 vigente, 1 vencida) ==========
INSERT INTO promotions (promotion_id, fixed_price, start_date, end_date) VALUES (1, 50000, TRUNC(SYSDATE) - 10, TRUNC(SYSDATE) + 20);
INSERT INTO promotions (promotion_id, fixed_price, start_date, end_date) VALUES (2, 55000, TRUNC(SYSDATE) - 90, TRUNC(SYSDATE) - 75);

-- ========== PAYMENT_METHODS ==========
INSERT INTO payment_methods (payment_method_id, name) VALUES (1, 'EFECTIVO');
INSERT INTO payment_methods (payment_method_id, name) VALUES (2, 'TRANSFERENCIA');
INSERT INTO payment_methods (payment_method_id, name) VALUES (3, 'SISTECREDITO');
INSERT INTO payment_methods (payment_method_id, name) VALUES (4, 'CREDITO_TIENDA');

-- ========== PRODUCTS ==========
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (1, 'TF-0001', 'Buso Tech Fleece', 'Y', TRUNC(SYSDATE) - 110, 1, 1, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (2, 'TF-0002', 'Buso Essentials', 'Y', TRUNC(SYSDATE) - 110, 1, 2, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (3, 'TF-0003', 'Jean Slim Fit', 'Y', TRUNC(SYSDATE) - 110, 2, 3, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (4, 'TF-0004', 'Jean Baggy', 'Y', TRUNC(SYSDATE) - 110, 2, 7, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (5, 'TF-0005', 'Saco Hoodie Logo', 'Y', TRUNC(SYSDATE) - 110, 3, 4, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (6, 'TF-0006', 'Saco Basico', 'Y', TRUNC(SYSDATE) - 110, 3, 8, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (7, 'TF-0007', 'Sueter Cuello Redondo', 'Y', TRUNC(SYSDATE) - 110, 4, 6, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (8, 'TF-0008', 'Sueter Oversize', 'Y', TRUNC(SYSDATE) - 110, 4, 5, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (9, 'TF-0009', 'Short Deportivo', 'Y', TRUNC(SYSDATE) - 110, 5, 1, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (10, 'TF-0010', 'Short Cargo', 'Y', TRUNC(SYSDATE) - 110, 5, 7, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (11, 'TF-0011', 'Sudadera Jogger', 'Y', TRUNC(SYSDATE) - 110, 6, 2, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (12, 'TF-0012', 'Sudadera Wide Leg', 'Y', TRUNC(SYSDATE) - 110, 6, 5, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (13, 'TF-0013', 'Buso Estampado', 'Y', TRUNC(SYSDATE) - 110, 1, 8, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (14, 'TF-0014', 'Jean Recto', 'Y', TRUNC(SYSDATE) - 110, 2, 6, 11);
INSERT INTO products (product_id, sku, name, is_active, updated_at, category_id, brand_id, employee_id) VALUES (15, 'TF-0015', 'Saco Zip', 'Y', TRUNC(SYSDATE) - 110, 3, 3, 11);

-- ========== VARIANTS (12 variantes con stock <= umbral para el reporte 2) ==========
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (1, 1, 'S', 'Azul', 'Tela fria', 60000, 6, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (2, 1, 'M', 'Negro', 'Tela fria', 65000, 2, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (3, 2, 'L', 'Azul', 'Algodon grueso', 90000, 8, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (4, 2, 'XL', 'Negro', 'Algodon grueso', 90000, 9, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (5, 3, 'XXL', 'Azul', 'Tela fria', 60000, 1, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (6, 3, 'S', 'Negro', 'Tela fria', 65000, 11, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (7, 4, 'M', 'Azul', 'Algodon grueso', 90000, 3, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (8, 4, 'L', 'Negro', 'Algodon grueso', 90000, 5, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (9, 5, 'XL', 'Azul', 'Algodon grueso', 90000, 1, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (10, 5, 'XXL', 'Negro', 'Algodon grueso', 90000, 7, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (11, 6, 'S', 'Azul', 'Tela fria', 85000, 8, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (12, 6, 'M', 'Negro', 'Tela fria', 55000, 0, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (13, 7, 'L', 'Azul', 'Tela fria', 60000, 10, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (14, 7, 'XL', 'Negro', 'Tela fria', 65000, 2, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (15, 8, 'XXL', 'Azul', 'Algodon grueso', 90000, 12, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (16, 8, 'S', 'Negro', 'Algodon grueso', 90000, 5, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (17, 9, 'M', 'Azul', 'Tela fria', 60000, 1, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (18, 9, 'L', 'Negro', 'Tela fria', 65000, 7, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (19, 10, 'XL', 'Azul', 'Tela fria', 85000, 3, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (20, 10, 'XXL', 'Negro', 'Tela fria', 55000, 9, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (21, 11, 'S', 'Azul', 'Tela fria', 60000, 10, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (22, 11, 'M', 'Negro', 'Tela fria', 65000, 2, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (23, 12, 'L', 'Azul', 'Algodon grueso', 90000, 12, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (24, 12, 'XL', 'Negro', 'Algodon grueso', 90000, 5, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (25, 13, 'XXL', 'Azul', 'Tela fria', 60000, 1, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (26, 13, 'S', 'Negro', 'Tela fria', 65000, 7, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (27, 14, 'M', 'Azul', 'Tela fria', 85000, 3, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (28, 14, 'L', 'Negro', 'Tela fria', 55000, 9, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (29, 15, 'XL', 'Azul', 'Algodon grueso', 90000, 10, 3);
INSERT INTO variants (variant_id, product_id, variant_size, color, material, price, stock, min_stock_threshold) VALUES (30, 15, 'XXL', 'Negro', 'Algodon grueso', 90000, 2, 3);

-- ========== PROMOTION_VARIANTS ==========
INSERT INTO promotion_variants (promotion_id, variant_id) VALUES (1, 1);
INSERT INTO promotion_variants (promotion_id, variant_id) VALUES (1, 2);
INSERT INTO promotion_variants (promotion_id, variant_id) VALUES (1, 3);
INSERT INTO promotion_variants (promotion_id, variant_id) VALUES (2, 4);
INSERT INTO promotion_variants (promotion_id, variant_id) VALUES (2, 5);

-- ========== BATCHES (solo de proveedores activos) ==========
INSERT INTO batches (batch_id, entry_date, supplier_id) VALUES (1, TRUNC(SYSDATE) - 120, 1);
INSERT INTO batches (batch_id, entry_date, supplier_id) VALUES (2, TRUNC(SYSDATE) - 115, 2);
INSERT INTO batches (batch_id, entry_date, supplier_id) VALUES (3, TRUNC(SYSDATE) - 105, 3);
INSERT INTO batches (batch_id, entry_date, supplier_id) VALUES (4, TRUNC(SYSDATE) - 100, 1);
INSERT INTO batches (batch_id, entry_date, supplier_id) VALUES (5, TRUNC(SYSDATE) - 95, 2);

-- ========== BATCH_DETAILS ==========
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (1, 1, 8, 30000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (2, 2, 3, 32500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (3, 3, 10, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (4, 4, 11, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (5, 5, 4, 30000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (1, 6, 13, 32500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (2, 7, 5, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (3, 8, 5, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (4, 9, 2, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (5, 10, 9, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (1, 11, 10, 42500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (2, 12, 3, 27500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (3, 13, 12, 30000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (4, 14, 2, 32500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (5, 15, 15, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (1, 16, 6, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (2, 17, 3, 30000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (3, 18, 9, 32500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (4, 19, 4, 42500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (5, 20, 11, 27500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (1, 21, 11, 30000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (2, 22, 3, 32500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (3, 23, 13, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (4, 24, 6, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (5, 25, 2, 30000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (1, 26, 9, 32500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (2, 27, 5, 42500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (3, 28, 10, 27500);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (4, 29, 11, 45000);
INSERT INTO batch_details (batch_id, variant_id, quantity, unit_cost) VALUES (5, 30, 3, 45000);

-- ========== INVENTORY_ADJUSTMENTS ==========
INSERT INTO inventory_adjustments (adjustment_id, quantity_change, reason, adjustment_date, variant_id, employee_id) VALUES (inv_adj_seq.NEXTVAL, -1, 'Prenda dañada en exhibicion', TRUNC(SYSDATE) - 60, 5, 14);
INSERT INTO inventory_adjustments (adjustment_id, quantity_change, reason, adjustment_date, variant_id, employee_id) VALUES (inv_adj_seq.NEXTVAL, -2, 'Perdida en conteo fisico', TRUNC(SYSDATE) - 45, 12, 14);
INSERT INTO inventory_adjustments (adjustment_id, quantity_change, reason, adjustment_date, variant_id, employee_id) VALUES (inv_adj_seq.NEXTVAL, 1, 'Sobrante en conteo fisico', TRUNC(SYSDATE) - 30, 8, 12);
INSERT INTO inventory_adjustments (adjustment_id, quantity_change, reason, adjustment_date, variant_id, employee_id) VALUES (inv_adj_seq.NEXTVAL, -1, 'Mancha irreparable', TRUNC(SYSDATE) - 20, 17, 14);

-- ========== LAYAWAYS ==========
INSERT INTO layaways (layaway_id, created_date, due_date, status, customer_id, employee_id) VALUES (1, TRUNC(SYSDATE) - 40, TRUNC(SYSDATE) - 10, 'COMPLETADO', 3, 12);
INSERT INTO layaways (layaway_id, created_date, due_date, status, customer_id, employee_id) VALUES (2, TRUNC(SYSDATE) - 7, TRUNC(SYSDATE) + 23, 'VIGENTE', 5, 13);
INSERT INTO layaways (layaway_id, created_date, due_date, status, customer_id, employee_id) VALUES (3, TRUNC(SYSDATE) - 70, TRUNC(SYSDATE) - 40, 'VENCIDO', 7, 11);
INSERT INTO layaways (layaway_id, created_date, due_date, status, customer_id, employee_id) VALUES (4, TRUNC(SYSDATE) - 30, TRUNC(SYSDATE) - 1, 'CANCELADO', 2, 14);

-- ========== LAYAWAY_DETAILS ==========
INSERT INTO layaway_details (layaway_id, variant_id, quantity, unit_price) VALUES (1, 10, 1, 90000);
INSERT INTO layaway_details (layaway_id, variant_id, quantity, unit_price) VALUES (1, 18, 1, 65000);
INSERT INTO layaway_details (layaway_id, variant_id, quantity, unit_price) VALUES (2, 20, 1, 55000);
INSERT INTO layaway_details (layaway_id, variant_id, quantity, unit_price) VALUES (2, 26, 1, 65000);
INSERT INTO layaway_details (layaway_id, variant_id, quantity, unit_price) VALUES (3, 24, 1, 90000);
INSERT INTO layaway_details (layaway_id, variant_id, quantity, unit_price) VALUES (4, 28, 1, 55000);

-- ========== SPECIAL_ORDERS ==========
INSERT INTO special_orders (special_order_id, description, order_date, deposit_amount, status, origin_city, customer_id, employee_id) VALUES (1, 'Buso Jordan Retro talla L color rojo', TRUNC(SYSDATE) - 20, 30000, 'EN_GESTION', 'Bogota', 4, 11);
INSERT INTO special_orders (special_order_id, description, order_date, deposit_amount, status, origin_city, customer_id, employee_id) VALUES (2, 'Jean Amiri MX1 talla 32 negro', TRUNC(SYSDATE) - 50, 50000, 'ENTREGADO', 'Medellin', 6, 12);
INSERT INTO special_orders (special_order_id, description, order_date, deposit_amount, status, origin_city, customer_id, employee_id) VALUES (3, 'Saco Psycho Bunny talla M azul', TRUNC(SYSDATE) - 5, 25000, 'SOLICITADO', 'Barranquilla', 8, 13);

-- ========== SALES (la venta 26 viene del apartado 1 completado) ==========
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (1, TRUNC(SYSDATE) - 2, 100000, 1, 11, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (2, TRUNC(SYSDATE) - 4, 240000, 2, 12, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (3, TRUNC(SYSDATE) - 6, 90000, 3, 13, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (4, TRUNC(SYSDATE) - 8, 145000, 4, 14, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (5, TRUNC(SYSDATE) - 10, 180000, 5, 11, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (6, TRUNC(SYSDATE) - 12, 145000, 6, 12, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (7, TRUNC(SYSDATE) - 14, 60000, 7, 13, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (8, TRUNC(SYSDATE) - 16, 150000, 8, 14, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (9, TRUNC(SYSDATE) - 18, 170000, 10, 11, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (10, TRUNC(SYSDATE) - 20, 155000, 1, 12, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (11, TRUNC(SYSDATE) - 22, 155000, 2, 13, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (12, TRUNC(SYSDATE) - 24, 90000, 3, 14, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (13, TRUNC(SYSDATE) - 26, 145000, 4, 11, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (14, TRUNC(SYSDATE) - 34, 65000, 5, 11, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (15, TRUNC(SYSDATE) - 36, 155000, 6, 12, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (16, TRUNC(SYSDATE) - 38, 55000, 7, 13, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (17, TRUNC(SYSDATE) - 40, 155000, 8, 14, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (18, TRUNC(SYSDATE) - 45, 65000, 10, 11, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (19, TRUNC(SYSDATE) - 50, 145000, 1, 12, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (20, TRUNC(SYSDATE) - 66, 60000, 2, 11, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (21, TRUNC(SYSDATE) - 68, 150000, 3, 12, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (22, TRUNC(SYSDATE) - 70, 180000, 4, 13, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (23, TRUNC(SYSDATE) - 72, 65000, 5, 14, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (24, TRUNC(SYSDATE) - 78, 145000, 6, 15, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (25, TRUNC(SYSDATE) - 82, 90000, 7, 15, NULL);
INSERT INTO sales (sale_id, sale_date, total, customer_id, employee_id, layaway_id) VALUES (26, TRUNC(SYSDATE) - 15, 155000, 3, 12, 1);

-- ========== SALE_DETAILS ==========
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (1, 1, 1, 50000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (1, 3, 1, 50000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (2, 5, 1, 60000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (2, 7, 2, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (3, 9, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (4, 11, 1, 85000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (4, 13, 1, 60000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (5, 15, 2, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (6, 17, 1, 60000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (6, 19, 1, 85000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (7, 21, 1, 60000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (8, 23, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (8, 25, 1, 60000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (9, 27, 2, 85000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (10, 29, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (10, 2, 1, 65000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (11, 4, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (11, 6, 1, 65000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (12, 8, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (13, 10, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (13, 12, 1, 55000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (14, 14, 1, 65000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (15, 16, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (15, 18, 1, 65000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (16, 20, 1, 55000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (17, 22, 1, 65000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (17, 24, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (18, 26, 1, 65000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (19, 28, 1, 55000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (19, 30, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (20, 1, 1, 60000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (21, 4, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (21, 5, 1, 60000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (22, 3, 2, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (23, 6, 1, 65000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (24, 11, 1, 85000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (24, 13, 1, 60000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (25, 15, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (26, 10, 1, 90000);
INSERT INTO sale_details (sale_id, variant_id, quantity, applied_price) VALUES (26, 18, 1, 65000);

-- ========== PAYMENTS (cada pago es de una venta O de un apartado) ==========
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (1, 100000, TRUNC(SYSDATE) - 2, 2, 1, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (2, 240000, TRUNC(SYSDATE) - 4, 3, 2, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (3, 45000, TRUNC(SYSDATE) - 6, 2, 3, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (4, 45000, TRUNC(SYSDATE) - 6, 1, 3, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (5, 145000, TRUNC(SYSDATE) - 8, 2, 4, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (6, 5000, TRUNC(SYSDATE) - 10, 4, 5, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (7, 175000, TRUNC(SYSDATE) - 10, 1, 5, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (8, 145000, TRUNC(SYSDATE) - 12, 1, 6, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (9, 60000, TRUNC(SYSDATE) - 14, 2, 7, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (10, 150000, TRUNC(SYSDATE) - 16, 3, 8, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (11, 170000, TRUNC(SYSDATE) - 18, 1, 9, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (12, 155000, TRUNC(SYSDATE) - 20, 2, 10, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (13, 155000, TRUNC(SYSDATE) - 22, 3, 11, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (14, 90000, TRUNC(SYSDATE) - 24, 1, 12, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (15, 145000, TRUNC(SYSDATE) - 26, 2, 13, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (16, 65000, TRUNC(SYSDATE) - 34, 3, 14, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (17, 155000, TRUNC(SYSDATE) - 36, 1, 15, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (18, 55000, TRUNC(SYSDATE) - 38, 2, 16, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (19, 155000, TRUNC(SYSDATE) - 40, 3, 17, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (20, 65000, TRUNC(SYSDATE) - 45, 1, 18, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (21, 145000, TRUNC(SYSDATE) - 50, 2, 19, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (22, 60000, TRUNC(SYSDATE) - 66, 3, 20, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (23, 150000, TRUNC(SYSDATE) - 68, 1, 21, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (24, 180000, TRUNC(SYSDATE) - 70, 2, 22, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (25, 65000, TRUNC(SYSDATE) - 72, 3, 23, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (26, 145000, TRUNC(SYSDATE) - 78, 1, 24, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (27, 90000, TRUNC(SYSDATE) - 82, 2, 25, NULL);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (28, 60000, TRUNC(SYSDATE) - 40, 1, NULL, 1);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (29, 95000, TRUNC(SYSDATE) - 25, 2, NULL, 1);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (30, 40000, TRUNC(SYSDATE) - 7, 2, NULL, 2);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (31, 30000, TRUNC(SYSDATE) - 70, 1, NULL, 3);
INSERT INTO payments (payment_id, amount, payment_date, payment_method_id, sale_id, layaway_id) VALUES (32, 20000, TRUNC(SYSDATE) - 30, 1, NULL, 4);

-- ========== RETURNS ==========
INSERT INTO returns (return_id, return_date, resolution_type, sale_id) VALUES (1, TRUNC(SYSDATE) - 1, 'CREDITO', 1);
INSERT INTO returns (return_id, return_date, resolution_type, sale_id) VALUES (2, TRUNC(SYSDATE) - 30, 'CAMBIO', 14);

-- ========== RETURN_DETAILS (la variante tiene que estar en la venta original) ==========
INSERT INTO return_details (return_id, variant_id, sale_id, quantity) VALUES (1, 3, 1, 1);
INSERT INTO return_details (return_id, variant_id, sale_id, quantity) VALUES (2, 14, 14, 1);

-- ========== STORE_CREDIT_MOVEMENTS (ABONO = viene de devolucion, REDENCION = se uso como pago) ==========
INSERT INTO store_credit_movements (movement_id, movement_type, amount, movement_date, customer_id, return_id, payment_id) VALUES (1, 'ABONO', 50000, TRUNC(SYSDATE) - 1, 1, 1, NULL);
INSERT INTO store_credit_movements (movement_id, movement_type, amount, movement_date, customer_id, return_id, payment_id) VALUES (2, 'ABONO', 5000, TRUNC(SYSDATE) - 30, 5, 2, NULL);
INSERT INTO store_credit_movements (movement_id, movement_type, amount, movement_date, customer_id, return_id, payment_id) VALUES (3, 'REDENCION', 5000, TRUNC(SYSDATE) - 10, 5, NULL, 6);

COMMIT;