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
Agosto 3 de 2026 — actualizado para la Entrega 2 (octubre de 2026)

## Contenido del repositorio

| Archivo | Contenido |
|---|---|
| `README.md` | Caso de estudio ajustado, reglas de negocio y descripción de los modelos (este documento) |
| `Historias_de_Usuario.pdf` / `.docx` | Especificación de requerimientos: 17 historias de usuario con criterios de aceptación |
| `diagrama_mer.pdf` | Modelo Entidad-Asociación corregido (notación Barker) |
| `diagrama_relacional.pdf` | Modelo relacional normalizado en 3FN |
| `Modelo_Relacional_3FN_y_DF.pdf` / `.docx` | Esquema relacional, listado de dependencias funcionales y verificación 1FN–2FN–3FN |
| `Diagramas segunda entrega.dmd` + `Diagramas segunda entrega/` | Diseño de Oracle SQL Developer Data Modeler (modelo lógico y relacional) |
| `Target_Florida_DDL.sql` | Script DDL para Oracle generado a partir del modelo (tablas, PK, UK, CHECK y FK) |
| `Bitacora_Seguimiento_Entrega2.pdf` / `.docx` | Bitácora de seguimiento de la Entrega 2 (áreas por integrante) |


## Descripción del caso

Este caso es **original**, basado en la operación real de una tienda minorista de ropa, de la cual es propietario un familiar de un miembro del grupo.

## Objetivo de la app

Diseñar e implementar la base de datos para un sistema transaccional que controle el inventario por prendas, variantes (talla, color, material), proveedores, ventas, apartados, encargos, pagos y devoluciones.

## Enunciado (caso de estudio ajustado)

Target Florida es una tienda local de ropa que busca actualizar su servicio de gestión de inventario, proveedores y ventas para cambiar el control manual que se realiza a papel actualmente.

De cada producto (diseño) se registra un código SKU único, nombre, categoría (busos, jeans, sacos, suéteres, shorts, sudaderas, pantalonetas, entre otras) y marca. Las prendas no se venden de forma genérica sino a través de sus **variantes**: cada variante combina talla (S, M, L, XL o XXL), color y material o tipo de tela, y tiene su propio precio. El precio depende del tipo de tela: las prendas de tela fría se manejan en el rango de \$55.000, \$60.000, \$65.000 y hasta \$85.000, mientras que las prendas oversize o de tela gruesa tienen un precio fijo de \$90.000. Además, un grupo de variantes puede pertenecer a una **promoción** con vigencia (fecha de inicio y fin), durante la cual el precio queda fijo independientemente del rango que se maneja. El precio efectivamente cobrado queda registrado en cada línea de venta.

El almacén no maneja un restock de un mismo diseño: cada lote de mercancía ingresado trae varias marcas con diseños variados en tallas variadas, cada uno asociado a una marca puntual (por ejemplo, Nike, Adidas, Amiri, Jordan, GodSpeed, Psycho Bunny), así como marcas nacionales con buena relación con el almacén, como Openmind y TRUST. La recolección de estos lotes se hace de manera presencial ante un proveedor, del cual se registra su nombre, teléfono de contacto, número de local, edificio donde está ubicado y si está activo, para evitar así procesos formales de devolución por mercancía defectuosa. Cada lote registra, por variante, la cantidad y el costo unitario de compra; como un mismo diseño puede llegar en lotes distintos, un producto puede quedar asociado a más de un proveedor a lo largo del tiempo.

Cada variante guarda su **stock disponible** y un **umbral mínimo** de reabastecimiento. El stock se incrementa con cada lote ingresado y se descuenta con cada venta y cada apartado; cualquier corrección manual (daño, pérdida, conteo físico) se registra como un **ajuste de inventario** con su motivo y el empleado responsable.

Respecto a los clientes, se registra su información básica (nombre, apellido y teléfono) para llevar un historial de compras. Clientes y empleados son **personas**; una persona es cliente o empleado. Existen clientes que van con frecuencia, aunque la tienda no maneja un programa de beneficios especiales o servicio VIP asociado a esta condición.

La tienda ofrece un servicio de **apartado**, por el cual un cliente paga un adelanto (por Sistecrédito, transferencia o efectivo) para retirar una o varias prendas de la venta pública y reservarlas exclusivamente para sí mismo hasta completar el pago mediante abonos. El apartado tiene una fecha límite y un estado (vigente, completado, vencido o cancelado); al completarse se convierte en una venta. Simultáneamente existe el servicio de **encargo**, en el cual un cliente paga un adelanto por la búsqueda de una prenda que no se encuentra en el local y que se consigue en otra ciudad; del encargo se registra la descripción de la prenda, la ciudad de origen y su estado (solicitado, en gestión, recibido, entregado o cancelado).

Una venta o un apartado puede pagarse con **uno o varios pagos**, cada uno con su método (efectivo, transferencia, Sistecrédito o crédito de tienda), monto y fecha.

Respecto a las devoluciones, Target no realiza reembolsos en efectivo: toda prenda devuelta se resuelve mediante **crédito de tienda** por el mismo precio de la prenda devuelta o mediante un **cambio** a otra prenda. Si el cliente quiere una prenda de mayor costo debe pagar la diferencia, y si es de menor costo el saldo restante queda guardado como crédito a su favor. El crédito se lleva como un historial de movimientos (abonos generados por devoluciones y redenciones usadas como pago), y el saldo del cliente es la diferencia entre ambos.

El personal de la tienda está conformado por empleados, de quienes se registra la fecha de vinculación y si están activos. Un empleado puede desempeñar simultáneamente varios roles (por ejemplo cajero y bodeguero), sin que existan roles excluyentes entre sí. Mensualmente se calculan comisiones o descuentos en nómina con base en el consolidado de las ventas generadas por cada empleado.

Por último, las ventas se realizan en tienda física, detallando las variantes vendidas (producto, talla, color y material), la cantidad, el precio aplicado, el **cliente** y el **empleado** que la procesa, descontando automáticamente las existencias de cada variante vendida.

## Reportes de interés

**Reporte 1 (Top Productos):** Listado del top 10 de prendas más vendidas en el último mes por categoría.

**Reporte 2 (Alertas de Stock Bajo):** Identificación de productos y prendas con existencias por debajo del umbral mínimo configurado para reabastecimiento.

**Reporte 3 (Ventas por Empleado):** Entrega un consolidado mensual de ingresos generados por cada vendedor para cálculo de comisiones o descuento en nómina.

## Especificación de Requerimientos / Historias de Usuario

La especificación completa está en [`Historias_de_Usuario.docx`](Historias_de_Usuario.docx): 17 historias (HU-01 a HU-17) con prioridad, estimación, criterios de aceptación y la forma en que el modelo las soporta. Resumen:

| HU | Historia | Usuario |
|---|---|---|
| 01 | Gestión del catálogo de productos | Administrador |
| 02 | Gestión de variantes de producto | Administrador |
| 03 | Gestión de proveedores | Administrador |
| 04 | Ingreso de mercancía por lote | Bodeguero |
| 05 | Registro de clientes | Cajero |
| 06 | Gestión de empleados y roles múltiples | Administrador |
| 07 | Registro de venta en tienda física | Cajero |
| 08 | Registro de pagos y métodos de pago | Cajero |
| 09 | Creación de apartado con adelanto | Cajero |
| 10 | Abonos y cierre de apartado | Cajero |
| 11 | Registro y seguimiento de encargos | Cajero |
| 12 | Devolución con crédito de tienda o cambio | Cajero |
| 13 | Consulta y redención de crédito de tienda | Cajero |
| 14 | Gestión de promociones | Administrador |
| 15 | Reporte de productos más vendidos | Administrador |
| 16 | Alerta de existencias bajas | Administrador / Bodeguero |
| 17 | Consolidado mensual de ventas por empleado | Administrador |

## Reglas del Negocio (RN)

- **RN-01 (Identificación de Producto y SKU):** Cada prenda registrada debe pertenecer a una categoría y a una marca y poseer un código SKU único. Las prendas no se venden de forma genérica, sino a través de sus **variantes** (talla, color, material); la combinación producto + talla + color + material es única.

- **RN-02 (Control Restrictivo de Inventario):** No se permite vender ni apartar una variante si la cantidad solicitada supera el stock disponible actual. Toda venta confirmada debe descontar en tiempo real las existencias de la variante vendida.

- **RN-03 (Umbral de Reabastecimiento):** Cada variante tiene configurado un nivel de stock mínimo. Si el stock actual es menor o igual a este umbral, la variante queda en estado de *Alerta de Stock Bajo*.

- **RN-04 (Trazabilidad de Ventas y Comisiones):** Toda venta debe estar asociada obligatoriamente a un **Empleado** (vendedor) y a un **Cliente** registrados. Un empleado no puede procesar ventas si su estado actual es inactivo.

- **RN-05 (Recepción de Mercancía de Proveedores):** Toda entrada de mercancía a bodega debe estar vinculada a un **Proveedor** previamente registrado y activo, detallando el costo unitario de compra y las cantidades por variante.

- **RN-06 (Pagos):** Cada pago pertenece a una venta o a un apartado, nunca a ambos, y la suma de los pagos no puede superar el total de la transacción.

- **RN-07 (Devoluciones sin efectivo):** Una devolución siempre referencia la venta original y se resuelve solo con crédito de tienda o cambio. No se puede redimir más crédito que el saldo disponible del cliente.

- **RN-08 (Promociones):** Una variante no puede pertenecer a dos promociones vigentes al mismo tiempo.

## Acuerdos del Equipo

**Estrategia y Roles:** Uso de GitHub Classroom para versión del proyecto, revisiones semanales tras clase y división de roles (Líder/Coordinador, Diseñador de BD, Desarrollador SQL/PL-SQL y Documentador).

**Cronograma Breve:**

Semana 2: Entrega 0 (Caso escogido, requerimientos, acuerdos).

Semana 5: Entrega 1 - Modelo ER (MER).

Semana 10: Entrega 2 - Modelo Relacional Normalizado en 3FN. (Este documento)

Semana 16-17: Entrega 3 - Scripts DDL/DML/DQL/PL-SQL y Sustentación.

## Modelo Entidad-Asociación (MER) corregido

El MER está construido en Oracle SQL Developer Data Modeler en notación Barker (diseño `Diagramas segunda entrega`, diagrama en `diagrama_mer.pdf`). Tiene **23 entidades** y **31 relaciones**. Cada entidad fuerte tiene su propio identificador; las entidades asociativas (detalles) se identifican por las relaciones con sus dos entidades padre (barra UID), y las relaciones N:M sin atributos se dibujan directamente como N:M.

### Entidades y atributos

**Personas y roles**

- **PERSON (supertipo):** id (identificador), first_name, last_name, phone.
- **CUSTOMER (subtipo de PERSON):** is_active.
- **EMPLOYEE (subtipo de PERSON):** hire_date, is_active.
- **ROLE:** role_id (identificador), name (único).

**Catálogo**

- **CATEGORY:** category_id (identificador), name (único).
- **BRAND:** brand_id (identificador), brand_name (único).
- **PRODUCT:** product_id (identificador), sku (único), name, is_active, updated_at.
- **VARIANT:** variant_id (identificador), variant_size (S–XXL), color, material, price, stock, min_stock_threshold.
- **PROMOTION:** promotion_id (identificador), fixed_price, start_date, end_date.

**Inventario y proveedores**

- **SUPPLIER:** id (identificador), name, phone, building, local_number, is_active.
- **BATCH:** id (identificador), entry_date.
- **BATCH_DETAIL (asociativa BATCH–VARIANT):** quantity, unit_cost.
- **INVENTORY_ADJUSTMENT:** id (identificador), quantity_change, reason, adjustment_date.

**Ventas, apartados, encargos y pagos**

- **SALE:** sale_id (identificador), sale_date, total.
- **SALE_DETAIL (asociativa SALE–VARIANT):** quantity, applied_price.
- **LAYAWAY:** layaway_id (identificador), created_date, due_date, status.
- **LAYAWAY_DETAIL (asociativa LAYAWAY–VARIANT):** quantity, unit_price.
- **SPECIAL_ORDER:** special_order_id (identificador), description, order_date, deposit_amount, status, origin_city.
- **PAYMENT_METHOD:** id (identificador), name (único).
- **PAYMENT:** payment_id (identificador), amount, payment_date.

**Devoluciones y crédito**

- **RETURN:** return_id (identificador), return_date, resolution_type (CREDITO / CAMBIO).
- **RETURN_DETAIL (asociativa RETURN–VARIANT):** quantity.
- **STORE_CREDIT_MOVEMENT:** movement_id (identificador), movement_type (ABONO / REDENCION), amount, movement_date.

### Relaciones

**Jerarquía**

- **PERSON → CUSTOMER / EMPLOYEE:** supertipo con dos subtipos exclusivos (una persona es cliente o empleado).

**N:M (sin atributos propios)**

- **EMPLOYEE — ROLE** (N:M, opcional en ambos lados): un empleado desempeña varios roles a la vez, sin exclusividad.
- **PROMOTION — VARIANT** (N:M, opcional en ambos lados): una promoción aplica a un grupo de variantes.

**Entidades asociativas (N:M con atributos, relaciones identificadoras)**

- **SALE — SALE_DETAIL — VARIANT:** una venta incluye una o varias variantes, con cantidad y precio aplicado.
- **LAYAWAY — LAYAWAY_DETAIL — VARIANT:** un apartado reserva una o varias variantes.
- **BATCH — BATCH_DETAIL — VARIANT:** un lote trae varias variantes, con cantidad y costo unitario.
- **RETURN — RETURN_DETAIL — VARIANT:** una devolución incluye una o varias variantes devueltas.

**1:N**

- **CATEGORY — PRODUCT**, **BRAND — PRODUCT:** cada producto pertenece a exactamente una categoría y una marca.
- **EMPLOYEE — PRODUCT:** cada producto registra el empleado responsable de su última modificación.
- **PRODUCT — VARIANT** (obligatoria en ambos lados): todo producto tiene al menos una variante (RN-01).
- **SUPPLIER — BATCH:** todo lote viene de un proveedor (RN-05).
- **VARIANT — INVENTORY_ADJUSTMENT**, **EMPLOYEE — INVENTORY_ADJUSTMENT:** cada ajuste afecta una variante y lo registra un empleado.
- **CUSTOMER — SALE**, **EMPLOYEE — SALE:** toda venta tiene cliente y empleado (RN-04).
- **CUSTOMER — LAYAWAY**, **EMPLOYEE — LAYAWAY:** todo apartado tiene cliente y empleado responsable.
- **CUSTOMER — SPECIAL_ORDER**, **EMPLOYEE — SPECIAL_ORDER:** todo encargo tiene cliente y empleado.
- **PAYMENT_METHOD — PAYMENT:** cada pago usa un método.
- **SALE — PAYMENT**, **LAYAWAY — PAYMENT:** una venta o un apartado admite varios pagos; cada pago pertenece a uno de los dos (arco exclusivo, RN-06).
- **SALE — RETURN:** cada devolución referencia la venta original (RN-07).
- **CUSTOMER — STORE_CREDIT_MOVEMENT:** el crédito se lleva por cliente.
- **RETURN — STORE_CREDIT_MOVEMENT**, **PAYMENT — STORE_CREDIT_MOVEMENT:** cada movimiento nace de una devolución (abono) o de un pago (redención), nunca de ambos (arco exclusivo).

**1:1**

- **LAYAWAY — SALE** (opcional en ambos lados): un apartado completado genera exactamente una venta.

## Modelo relacional normalizado (3FN)

El modelo relacional se obtiene del MER con las reglas de transformación de Data Modeler (diagrama en `diagrama_relacional.pdf`). Tiene **25 tablas** y **35 llaves foráneas**:

- Cada entidad es una tabla con su identificador como PK.
- Cada relación 1:N agrega una FK en la tabla del lado N; si la relación es obligatoria, la FK es NOT NULL.
- Las dos N:M sin atributos generan las tablas intermedias **EMPLOYEE_ROLE** y **PROMOTION_VARIANT**, con PK compuesta por ambas FK.
- Las entidades asociativas (SALE_DETAIL, LAYAWAY_DETAIL, BATCH_DETAIL, RETURN_DETAIL) tienen PK compuesta: venta, apartado, lote o devolución + variante.
- La jerarquía se implementa con una tabla por tipo: CUSTOMER y EMPLOYEE usan como PK el mismo `id` de PERSON, que es también FK.
- La 1:1 LAYAWAY–SALE es una FK única (`SALE.LAYAWAY_layaway_id`, UNIQUE).

Además de las PK y FK, el modelo declara restricciones UNIQUE sobre las llaves candidatas (por ejemplo PRODUCT.sku y la combinación producto–talla–color–material de VARIANT), restricciones CHECK de dominio y de montos positivos, y arcos exclusivos en PAYMENT (venta o apartado) y STORE_CREDIT_MOVEMENT (devolución o pago).

**Normalización:**

- **1FN:** todos los atributos son atómicos y no hay grupos repetidos. Las líneas de venta, apartado, lote y devolución están en tablas de detalle.
- **2FN:** en las tablas con PK compuesta, los atributos no clave (cantidad, precio aplicado, costo unitario) dependen de la llave completa.
- **3FN:** no hay dependencias transitivas. Por ejemplo, el nombre de la categoría o de la marca vive en su propia tabla y no en PRODUCT. Además, las columnas UNIQUE de STORE_CREDIT_MOVEMENT y SALE son llaves candidatas, de modo que todo determinante es llave.

**Atributos derivados:** `SALE.total` y `VARIANT.stock` se almacenan para que la validación de RN-02 y los reportes sean eficientes. No violan la 3FN porque dependen de otras filas, no de otro atributo de la misma fila.

El listado completo de dependencias funcionales por tabla y la verificación detallada están en `Modelo_Relacional_3FN_y_DF.pdf`. El script `Target_Florida_DDL.sql` crea las 25 tablas en Oracle con estas restricciones.
