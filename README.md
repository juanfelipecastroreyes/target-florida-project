# Sistema de Gestión de Inventario Target Florida

**Autores:** Jose Daniel Cordoba Cabal — A00407856  
Daniel Montenegro — A00409572  
Sebastian Mejia — A00410557  
Juan Felipe Castro — A00410561  
Santiago Sierra Vasquez — A00410695

Universidad Icesi  
Facultad Barberi de ingeniería diseño y ciencias aplicadas  
Ingeniería de Sistemas  
Sistemas intensivos de datos  
Monica Maria Rojas Rincon  
Agosto 3 de 2026

## Descripción del caso

Este caso es **original**, basado en la operación real de una tienda minorista de ropa, de la cual es propietario un familiar de un miembro del grupo.

## Objetivo de la app

Diseñar e implementar la base de datos para un sistema transaccional que controle el inventario por prendas, variantes (talla/color/material etc..), proveedores y registro de ventas

## Enunciado

Target Florida es una tienda local de ropa que busca actualizar su servicio de gestión de inventario, proveedores y ventas para cambiar el control manual que se realiza a papel actualmente.

En lo que se sabe sobre los productos, se registra un código único, nombre, categoría (buso, jean, sacos, suéteres, shorts, jeans, sudaderas, pantalonetas y entre otras), marca, tipo de tela. Los precios de cada una de las prendas varían del tipo de tela: las prendas que solo son tela fría se encuentran entre el rango de \$55.000, \$60.000, \$65.000 y hasta \$85.000, mientras que las prendas oversize o de tela gruesa tienen un precio fijo de \$90.000. Además, un grupo específico de prendas puede pertenecer a una promoción, donde el precio queda fijo independientemente del rango que se maneja. Cada producto se ofrece en tallas diversas desde S hasta XXL.

El almacén no maneja un restock de un mismo diseño: cada lote de mercancía ingresado pertenecen a varias marcas con diseños variados en tallas variadas y asociados a una marca puntual (Por ejemplo, Nike, Adidas, Amiri, Jordan, GodSpeed, Psycho Bunny, etc) También se usan marcas que son nacionales y tienen buena relación con el Almacén tales como Openmind y TRUST. La recolección de estos lotes se hace de manera presencial ante algún proveedor, del cual se registra su información de contacto (Numero de telefono), Numero de local, edificio donde esta ubicado, para evitar así procesos formales de devolución por mercancía defectuosa. Un producto puede estar asociado a más de un proveedor. Dado que no existe una reposición del mismo diseño, el stock disponible de una prenda se determina por lo que efectivamente ingresó a su lote y aún no ha sido vendido, apartado o entregado.

Respecto a los clientes, se registra la información básica para llevar un historial de compras. Existen clientes que van con frecuencia, aunque la tienda no maneja un programa de beneficios especiales o servicio VIP asociado a esta condición.

La tienda ofrece un servicio de apartado, por el cual un cliente puede pagar un adelanto mínimo (por Sistecredito, transferencia o efectivo) para retirar una prenda de la venta pública y reservada exclusivamente para sí mismo hasta completar el pago. Simultáneamente, existe el servicio de encargo, en el cual un cliente paga por la búsqueda de una prenda que no se encuentre por el momento en el local, la cual es conseguida en otra ciudad donde si hay existencias.

Respecto a las devoluciones, Target no realiza reembolsos en efectivo: toda prenda devuelta se resuelve mediante crédito de tienda por el mismo precio de la prenda devuelta o un cambio a otra prenda del mismo precio, en caso de querer una prenda de más costo el cliente debe añadir el crédito faltante y en caso de que sea menor al precio de la prenda devuelta se conserva el resto de credito guardado a su cuenta.

El personal de la tienda está conformado por empleados, quienes pueden desempeñar simultáneamente funciones de cajero y bodeguero, sin que existan roles excluyentes entre sí, Mensualmente se calculan comisiones o descuentos en nómina con base en el consolidado de las ventas generado por cada empleado.

Por último, las ventas se realizan en tienda física, detallando el producto, su respectiva talla, el cliente (si aplica) y el empleado que estuvo que la procesa, descontando automáticamente la existencia del lote correspondiente.

## Reportes de interés

**Reporte 1 (Top Productos):** Listado del top 10 de prendas más vendidas en el último mes por categoría.

**Reporte 2 (Alertas de Stock Bajo):** Identificación de productos y prendas con existencias por debajo del umbral mínimo configurado para reabastecimiento.

**Reporte 3 (Ventas por Empleado):** Entrega un consolidado mensual de ingresos generados por cada vendedor para cálculo de comisiones o descuento en nomina.

## Especificación de Requerimientos / Historias de Usuario

**HU-01 (Gestión de Catálogo):** Como administrador, quiero registrar prendas con sus atributos para mantener actualizado el catálogo.

**HU-02 (Ingreso de Mercancía):** Como encargado de bodega, quiero registrar la entrada de lote asociada a un proveedor para incrementar el stock.

**HU-03 (Registro de Ventas):** Como cajero, quiero procesar la venta detallando producto, cliente y vendedor para descontar existencias automáticamente.

## Reglas del Negocio (RN)

- **RN-01 (Identificación de Producto y SKU):** Cada prenda registrada debe pertenecer a una categoría y poseer un código SKU único. Las prendas no se venden de forma genérica, sino a través de sus **variantes** especificadas (talla, color, material).

- **RN-02 (Control Restrictivo de Inventario):** No se permite procesar la venta de una variante si la cantidad solicitada supera el stock disponible actual. Toda venta confirmada debe descontar en tiempo real las existencias de la variante vendida.

- **RN-03 (Umbral de Reabastecimiento):** Cada variante de producto tiene configurado un nivel de stock mínimo. Si el stock actual es menor o igual a este umbral, el sistema debe marcar el ítem en estado de *Alerta de Stock Bajo*.

- **RN-04 (Trazabilidad de Ventas y Comisiones):** Toda venta debe estar asociada obligatoriamente a un **Empleado** (vendedor) registrado en el sistema y a un **Cliente**. Un empleado no puede procesar ventas si su estado actual es inactivo.

- **RN-05 (Recepción de Mercancía de Proveedores):** Toda entrada de mercancía a bodega debe estar vinculada a un **Proveedor** previamente registrado y activo en la base de datos, detallando el costo unitario de compra y las cantidades por variante.

## Acuerdos del Equipo

**Estrategia y Roles:** Uso de GitHub Classroom para versión del proyecto, revisiones semanales tras clase y división de roles (Líder/Coordinador, Diseñador de BD, Desarrollador SQL/PL-SQL y Documentador).

**Cronograma Breve:**

Semana 2: Entrega 0 (Caso escogido, requerimientos, acuerdos). (Este documento)

Semana 5: Entrega 1 - Modelo ER (MER).

Semana 10: Entrega 2 - Modelo Relacional Normalizado en 3FN.

Semana 16-17: Entrega 3 - Scripts DDL/DML/DQL/PL-SQL y Sustentación.

## Modelo Entidad-Relación (MER)

A continuación se documenta el Modelo Entidad-Relación (notación Barker) construido en Oracle SQL Developer Data Modeler para el sistema de gestión de inventario de Target Florida, correspondiente a la Entrega 1. Todas las entidades cuentan con un identificador propio (id) autogenerado; los atributos que actúan como llave foránea se indican explícitamente. El diagrama completo, generado en la herramienta, se incluye como anexo a este documento.

### Entidades y Atributos

- **Category:** id (PK), category_name.

- **Brand:** id (PK), name, origin (opcional).

- **Product:** id (PK), sku, name, discount_percentage (opcional).

- **Variant:** id (PK), product_id (FK), size, color, material, price, available_quantity.

- **Supplier:** id (PK), phone_number, building, local_number.

- **Batch:** id (PK), supplier_id (FK), entry_date.

- **BatchDetail:** id (PK), batch_id (FK), variant_id (FK), quantity, unit_cost.

- **Person (supertipo):** id (PK), name, phone_number, email, address.

- **Employee (subtipo de Person):** hire_date, status.

- **Customer (subtipo de Person):** registration_date.

- **EmployeeRole:** id (PK), role.

- **PaymentMethod:** id (PK), type.

- **Sale:** id (PK), customer_id (FK), employee_id (FK), sale_date.

- **Layaway:** id (PK), customer_id (FK), employee_id (FK), deposit_amount, due_date.

- **SpecialOrder:** id (PK), customer_id (FK), item_description, origin_city, deposit_amount, status (opcional).

- **Return:** id (PK), sale_id (FK), date, state, resolution_type.

- **StoreCredit:** id (PK), customer_id (FK), amount.

### Relaciones

- **Category — Product** (1:N) Cada producto pertenece a una única categoría; una categoría clasifica varios productos.

- **Brand — Product** (1:N) Cada producto pertenece a una única marca.

- **Product — Variant** (1:N, obligatorio) Todo producto debe tener al menos una variante registrada (RN-01).

- **Supplier — Batch** (1:N) Todo lote debe estar vinculado a un proveedor registrado (RN-05).

- **Batch — BatchDetail** (1:N) Un lote agrupa varias líneas de detalle.

- **Variant — BatchDetail** (1:N) Cada línea de detalle de lote referencia una única variante; una variante puede llegar en varios lotes distintos a lo largo del tiempo.

- **Employee — Sale** (1:N, obligatorio) Toda venta debe tener un empleado asociado (RN-04).

- **Customer — Sale** (1:N, obligatorio) Toda venta debe tener un cliente asociado (RN-04).

- **Sale — Variant** (N:M) Una venta puede incluir varias variantes, y una variante puede aparecer en varias ventas; resuelve el detalle de talla/color vendido y permite el descuento automático de stock (RN-02).

- **Sale — PaymentMethod** (N:1) Cada venta se paga con un único método; un método de pago se usa en muchas ventas.

- **Sale — Return** (1:N) Una devolución siempre referencia la venta original de la que proviene.

- **Employee — EmployeeRole** (N:M) Un empleado puede desempeñar varios roles simultáneamente (cajero y bodeguero a la vez), sin exclusividad entre ellos.

- **Customer — SpecialOrder** (1:N) Todo encargo está asociado a un cliente.

- **Customer — StoreCredit** (1:N) El crédito de tienda generado por devoluciones se acumula por cliente.

- **Customer — Layaway** (1:N) Todo apartado está asociado a un cliente.

- **Employee — Layaway** (1:N) Todo apartado queda registrado con el empleado que lo gestionó.

- **Layaway — Variant** (N:M) Un apartado puede reservar una o varias variantes.
