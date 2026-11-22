-- REPORTE 1: Top 10 general de prendas mas vendidas en el ultimo mes.
-- Es un unico ranking para toda la tienda (no un top 10 dentro de cada categoria).
-- Muestra la categoria, el producto y la marca de cada prenda, con las
-- unidades vendidas y lo que se recaudo, ordenado de la mas vendida a la menos.
SELECT categories.name AS categoria, products.name AS producto, brands.name AS marca, SUM(sale_details.quantity) AS unidades_vendidas, SUM(sale_details.quantity * sale_details.applied_price) AS ingresos
FROM sale_details
JOIN sales ON sales.sale_id = sale_details.sale_id
JOIN variants ON variants.variant_id = sale_details.variant_id
JOIN products ON products.product_id = variants.product_id
JOIN categories ON categories.category_id = products.category_id
JOIN brands ON brands.brand_id = products.brand_id
WHERE sales.sale_date >= ADD_MONTHS(TRUNC(SYSDATE), -1)
GROUP BY categories.name, products.name, brands.name
ORDER BY unidades_vendidas DESC, ingresos DESC
FETCH FIRST 10 ROWS ONLY;

-- REPORTE 2: Alertas de stock bajo.
-- Lista las variantes cuyo stock actual es menor o igual a su umbral minimo
-- de reabastecimiento (RN-03), con su producto, categoria y cuantas unidades
-- faltan para llegar al umbral. Ordena primero las mas criticas (menos stock).
SELECT categories.name AS categoria, products.sku, products.name AS producto, variants.variant_size AS talla, variants.color, variants.material, variants.stock, variants.min_stock_threshold AS umbral, variants.min_stock_threshold - variants.stock AS unidades_faltantes
FROM variants
JOIN products ON products.product_id = variants.product_id
JOIN categories ON categories.category_id = products.category_id
WHERE variants.stock <= variants.min_stock_threshold
ORDER BY variants.stock, categories.name, products.name;

-- REPORTE 3: Consolidado mensual de ventas por empleado.
-- Por cada empleado y cada mes muestra cuantas ventas hizo y cuanto dinero
-- genero, para calcular comisiones o descuentos de nomina.
-- Usa LEFT JOIN para que tambien aparezcan los empleados sin ventas
-- (saldrian con 0 ventas y $0).
SELECT persons.first_name || ' ' || persons.last_name AS empleado, employees.is_active AS activo, TO_CHAR(sales.sale_date, 'YYYY-MM') AS mes, COUNT(sales.sale_id) AS numero_ventas, NVL(SUM(sales.total), 0) AS total_vendido
FROM employees
JOIN persons ON persons.person_id = employees.employee_id
LEFT JOIN sales ON sales.employee_id = employees.employee_id
GROUP BY persons.first_name, persons.last_name, employees.is_active, TO_CHAR(sales.sale_date, 'YYYY-MM')
ORDER BY mes DESC, total_vendido DESC;