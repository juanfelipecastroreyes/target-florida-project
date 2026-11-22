# Target Florida: Sistema de Gestión de Inventario, Proveedores y Ventas

**Proyecto de curso — Sistemas Intensivos en Datos**  
Universidad Icesi · Facultad Barberi de Ingeniería, Diseño y Ciencias Aplicadas · Ingeniería de Sistemas

---

## Información general

| Campo | Detalle |
|:---|:---|
| **Curso** | Sistemas Intensivos en Datos |
| **Docente** | Mónica María Rojas Rincón |
| **Periodo académico** | 2026-2 |
| **Motor de base de datos** | Oracle Database |
| **Herramienta de modelado** | Oracle SQL Developer Data Modeler (notación Barker) |
| **Fecha de inicio** | 3 de agosto de 2026 |
| **Última actualización** | Noviembre de 2026 — Entrega 3 |

## Integrantes

| Nombre | Código |
|:---|:---:|
| José Daniel Córdoba Cabal | A00407856 |
| Daniel Montenegro Gil| A00409572 |
| Sebastián Mejía Trujillo | A00410557 |
| Juan Felipe Castro Reyes | A00410561 |
| Santiago Sierra Vásquez | A00410695 |

---

## Tabla de contenido

1. [Estructura del repositorio](#1-estructura-del-repositorio)
2. [Caso de estudio](#2-caso-de-estudio)
3. [Historias de usuario](#3-historias-de-usuario)
4. [Reglas de negocio](#4-reglas-de-negocio)
5. [Acuerdos del equipo](#5-acuerdos-del-equipo)
6. [Modelo Entidad-Asociación (MER)](#6-modelo-entidad-asociación-mer)
7. [Modelo relacional normalizado (3FN)](#7-modelo-relacional-normalizado-3fn)
8. [Implementación](#8-implementación)
9. [Cómo ejecutar los scripts](#9-cómo-ejecutar-los-scripts)

---

## 1. Estructura del repositorio

```
target-florida-project/
├── README.md
├── doc/                  Documentación: requerimientos, normalización, bitácoras y actas
│   ├── bitacoras/
│   └── reuniones/
├── model/                Diagramas (PDF) y fuentes de Data Modeler (.zip)
└── src/                  Scripts SQL: DDL, DML, DQL y PL/SQL
```

| Archivo | Contenido |
|---|---|
| [`README.md`](README.md) | Caso de estudio ajustado, reglas de negocio y descripción de los modelos (este documento) |
| **doc/** | |
| [`Descripcion_del_Caso.pdf`](doc/bitacoras/entrega1/Descripcion_del_Caso.pdf) / [`.docx`](doc/bitacoras/entrega1/Descripcion_del_Caso.docx) | Descripción del caso ajustado: objetivo, enunciado, reportes, reglas de negocio y origen (caso original) |
| [`Historias_de_Usuario.pdf`](doc/Historias_de_Usuario.pdf) / [`.docx`](doc/Historias_de_Usuario.docx) | Especificación de requerimientos: 17 historias de usuario con criterios de aceptación |
| [`Modelo_Relacional_3FN_y_DF.pdf`](doc/Modelo_Relacional_3FN_y_DF.pdf) / [`.docx`](doc/Modelo_Relacional_3FN_y_DF.docx) | Esquema relacional, listado de dependencias funcionales y verificación 1FN–2FN–3FN |
| [`Acuerdos_del_Equipo.pdf`](doc/bitacoras/entrega1/Acuerdos_del_Equipo.pdf) / [`.docx`](doc/bitacoras/entrega1/Acuerdos_del_Equipo.docx) | Acuerdos de trabajo en equipo: estrategia, roles, responsabilidades y cronograma |
| [`Bitacora_Seguimiento_Entrega2.pdf`](doc/bitacoras/entrega2/Bitacora_Seguimiento_Entrega2.pdf) / [`.docx`](doc/bitacoras/entrega2/Bitacora_Seguimiento_Entrega2.docx) | Bitácora de seguimiento de la Entrega 2 (áreas por integrante) |
| [`Bitacora_Seguimiento_Entrega3.pdf`](doc/bitacoras/entrega3/Bitacora_Seguimiento_Entrega3.pdf) / [`.docx`](doc/bitacoras/entrega3/Bitacora_Seguimiento_Entrega3.docx) | Bitácora de seguimiento de la Entrega 3 (áreas por integrante) |
| [`Acta_Reuniones_Entrega2.pdf`](doc/reuniones/entrega2/Acta_Reuniones_Entrega2.pdf) / [`.docx`](doc/reuniones/entrega2/Acta_Reuniones_Entrega2.docx) | Acta de las reuniones del equipo durante la Entrega 2 |
| [`Acta_Reuniones_Entrega3.pdf`](doc/reuniones/entrega3/Acta_Reuniones_Entrega3.pdf) / [`.docx`](doc/reuniones/entrega3/Acta_Reuniones_Entrega3.docx) | Acta de las reuniones del equipo durante la Entrega 3 |
| [`Bitacora_IA_Entrega3.pdf`](doc/uso-ia/entrega3/Bitacora_IA_Entrega3.pdf) / [`.docx`](doc/uso-ia/entrega3/Bitacora_IA_Entrega3.docx) | Bitácora de uso de IA generativa en la Entrega 3: prompts, validación, reflexión y riesgos en un contexto profesional |
| **model/** | |
| [`diagrama_mer.pdf`](model/diagrama_mer.pdf) | Modelo Entidad-Asociación corregido (notación Barker) |
| [`diagrama_relacional.pdf`](model/diagrama_relacional.pdf) | Modelo relacional normalizado en 3FN |
| [`Diagramas_segunda_entrega.zip`](model/Diagramas_mer_relacional.zip) | Fuentes de Oracle SQL Developer Data Modeler (`.dmd` + carpeta del diseño) |
| **src/** | |
| [`target-florida-ddl.sql`](src/target-florida-ddl.sql) | Script DDL: creación de las 25 tablas con PK, UNIQUE, CHECK y FK |
| [`target-florida-dml.sql`](src/target-florida-dml.sql) | Script DML: datos de prueba para generar los reportes |
| [`target-florida-dql.sql`](src/target-florida-dql.sql) | Script DQL: consultas de los 3 reportes |
| [`target-florida-plsql.sql`](src/target-florida-plsql.sql) | Script PL/SQL: función, procedimiento almacenado y trigger, con sus pruebas |

---

## 2. Caso de estudio

> **Origen del caso:** Este caso es **original**, basado en la operación real de una tienda minorista de ropa, de la cual es propietario un familiar de un miembro del grupo.

### 2.1 Objetivo de la aplicación

Diseñar e implementar la base de datos para un sistema transaccional que controle el inventario por prendas, variantes (talla, color, material), proveedores, ventas, apartados, encargos, pagos y devoluciones.

### 2.2 Enunciado

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

### 2.3 Reportes de interés

| # | Reporte | Descripción |
|---|---|---|
| 1 | **Top productos** | Listado del top 10 general de prendas más vendidas en el último mes, mostrando la categoría de cada prenda. |
| 2 | **Alertas de stock bajo** | Identificación de productos y prendas con existencias por debajo del umbral mínimo configurado para reabastecimiento. |
| 3 | **Ventas por empleado** | Consolidado mensual de ingresos generados por cada vendedor para el cálculo de comisiones o descuentos en nómina. |

---

## 3. Historias de usuario

La especificación completa está en [`doc/Historias_de_Usuario.pdf`](doc/Historias_de_Usuario.pdf): 17 historias (HU-01 a HU-17) con prioridad, estimación, criterios de aceptación y la forma en que el modelo las soporta. Resumen:

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

---

## 4. Reglas de negocio

| Código | Regla | Descripción |
|---|---|---|
| **RN-01** | Identificación de Producto y SKU | Cada prenda registrada debe pertenecer a una categoría y a una marca y poseer un código SKU único. Las prendas no se venden de forma genérica, sino a través de sus **variantes** (talla, color, material); la combinación producto + talla + color + material es única. |
| **RN-02** | Control Restrictivo de Inventario | No se permite vender ni apartar una variante si la cantidad solicitada supera el stock disponible actual. Toda venta confirmada debe descontar en tiempo real las existencias de la variante vendida. |
| **RN-03** | Umbral de Reabastecimiento | Cada variante tiene configurado un nivel de stock mínimo. Si el stock actual es menor o igual a este umbral, la variante queda en estado de *Alerta de Stock Bajo*. |
| **RN-04** | Trazabilidad de Ventas y Comisiones | Toda venta debe estar asociada obligatoriamente a un **Empleado** (vendedor) y a un **Cliente** registrados. Un empleado no puede procesar ventas si su estado actual es inactivo. |
| **RN-05** | Recepción de Mercancía de Proveedores | Toda entrada de mercancía a bodega debe estar vinculada a un **Proveedor** previamente registrado y activo, detallando el costo unitario de compra y las cantidades por variante. |
| **RN-06** | Pagos | Cada pago pertenece a una venta o a un apartado, nunca a ambos, y la suma de los pagos no puede superar el total de la transacción. |
| **RN-07** | Devoluciones sin efectivo | Una devolución siempre referencia la venta original y se resuelve solo con crédito de tienda o cambio. No se puede redimir más crédito que el saldo disponible del cliente. |
| **RN-08** | Promociones | Una variante no puede pertenecer a dos promociones vigentes al mismo tiempo. |

---

## 5. Acuerdos del equipo

**Estrategia de trabajo:** uso de GitHub Classroom para el control de versiones del proyecto, revisiones semanales después de clase y organización por áreas: cada integrante lidera un área de la entrega con el mismo nivel de responsabilidad.

**Cronograma:**

| Semana | Entrega | Contenido | Estado |
|:---:|:---|:---|:---|
| 2 | Entrega 0 | Caso de estudio, requerimientos y acuerdos | Entregada |
| 5 | Entrega 1 | Modelo Entidad-Asociación (MER) | Entregada |
| 10 | Entrega 2 | Modelo relacional normalizado en 3FN | Entregada |
| 16–17 | Entrega 3 | Scripts DDL, DML, DQL y PL/SQL + sustentación | Entrega actual |

**Roles y responsabilidades:** el documento completo está en [`doc/bitacoras/entrega1/Acuerdos_del_Equipo.pdf`](doc/bitacoras/entrega1/Acuerdos_del_Equipo.pdf). El reparto de áreas por integrante de cada entrega está en las bitácoras de seguimiento ([Entrega 2](doc/bitacoras/entrega2/Bitacora_Seguimiento_Entrega2.pdf), [Entrega 3](doc/bitacoras/entrega3/Bitacora_Seguimiento_Entrega3.pdf)).

---

## 6. Modelo Entidad-Asociación (MER)

El MER está construido en Oracle SQL Developer Data Modeler en notación Barker (fuentes en `model/Diagramas_segunda_entrega.zip`, diagrama en `model/diagrama_mer.pdf`). Tiene **23 entidades** y **31 relaciones**. Cada entidad fuerte tiene su propio identificador; las entidades asociativas (detalles) se identifican por las relaciones con sus dos entidades padre (barra UID), y las relaciones N:M sin atributos se dibujan directamente como N:M.

### 6.1 Entidades y atributos

**Personas y roles**

- **PERSON (supertipo):** person_id (identificador), first_name, last_name, phone, person_type (C = cliente, E = empleado).
- **CUSTOMER (subtipo de PERSON):** is_active.
- **EMPLOYEE (subtipo de PERSON):** hire_date, is_active.
- **ROLE:** role_id (identificador), name (único).

**Catálogo**

- **CATEGORY:** category_id (identificador), name (único).
- **BRAND:** brand_id (identificador), name (único).
- **PRODUCT:** product_id (identificador), sku (único), name, is_active, updated_at.
- **VARIANT:** variant_id (identificador), variant_size (S–XXL), color, material, price, stock, min_stock_threshold.
- **PROMOTION:** promotion_id (identificador), fixed_price, start_date, end_date.

**Inventario y proveedores**

- **SUPPLIER:** supplier_id (identificador), name, phone, building, local_number, is_active.
- **BATCH:** batch_id (identificador), entry_date.
- **BATCH_DETAIL (asociativa BATCH–VARIANT):** quantity, unit_cost.
- **INVENTORY_ADJUSTMENT:** adjustment_id (identificador), quantity_change, reason, adjustment_date.

**Ventas, apartados, encargos y pagos**

- **SALE:** sale_id (identificador), sale_date, total.
- **SALE_DETAIL (asociativa SALE–VARIANT):** quantity, applied_price.
- **LAYAWAY:** layaway_id (identificador), created_date, due_date, status.
- **LAYAWAY_DETAIL (asociativa LAYAWAY–VARIANT):** quantity, unit_price.
- **SPECIAL_ORDER:** special_order_id (identificador), description, order_date, deposit_amount, status, origin_city.
- **PAYMENT_METHOD:** payment_method_id (identificador), name (único).
- **PAYMENT:** payment_id (identificador), amount, payment_date.

**Devoluciones y crédito**

- **RETURN:** return_id (identificador), return_date, resolution_type (CREDITO / CAMBIO).
- **RETURN_DETAIL (asociativa RETURN–VARIANT):** quantity.
- **STORE_CREDIT_MOVEMENT:** movement_id (identificador), movement_type (ABONO / REDENCION), amount, movement_date.

### 6.2 Relaciones

**Jerarquía**

- **PERSON → CUSTOMER / EMPLOYEE:** supertipo con dos subtipos exclusivos (una persona es cliente o empleado).

**N:M (sin atributos propios)**

- **EMPLOYEE — ROLE** (N:M, opcional en ambos lados): un empleado desempeña varios roles a la vez, sin exclusividad.
- **PROMOTION — VARIANT** (N:M, opcional en ambos lados): una promoción aplica a un grupo de variantes.

**Entidades asociativas (N:M con atributos, relaciones identificadoras)**

- **SALE — SALE_DETAIL — VARIANT:** una venta incluye una o varias variantes, con cantidad y precio aplicado.
- **LAYAWAY — LAYAWAY_DETAIL — VARIANT:** un apartado reserva una o varias variantes.
- **BATCH — BATCH_DETAIL — VARIANT:** un lote trae varias variantes, con cantidad y costo unitario.
- **RETURN — RETURN_DETAIL — SALE_DETAIL:** una devolución incluye una o varias líneas de la venta original; cada variante devuelta tiene que haberse vendido en esa venta.

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

---

## 7. Modelo relacional normalizado (3FN)

El modelo relacional se obtiene del MER con las reglas de transformación de Data Modeler (diagrama en `model/diagrama_relacional.pdf`) y se implementa en [`src/target-florida-ddl.sql`](src/target-florida-ddl.sql). Tiene **25 tablas** y **35 llaves foráneas**.

**Convenciones de nombres:** tablas en inglés y en plural (`CUSTOMERS`, `SALES`, `VARIANTS`); cada PK se llama `<entidad>_id` y la FK que la referencia usa el mismo nombre (`variant_id`, no `VARIANT_variant_id`); los constraints siguen el patrón `tabla_columna_pk / _uk / _ck / _nn` y `tabla_tablareferenciada_fk`.

**Reglas de transformación aplicadas**

- Cada entidad es una tabla con su identificador como PK.
- Cada relación 1:N agrega una FK en la tabla del lado N; si la relación es obligatoria, la FK es NOT NULL.
- Las dos N:M sin atributos generan las tablas intermedias **EMPLOYEE_ROLES** y **PROMOTION_VARIANTS**, con PK compuesta por ambas FK.
- Las tablas de detalle (SALE_DETAILS, LAYAWAY_DETAILS, BATCH_DETAILS, RETURN_DETAILS) tienen PK compuesta: venta, apartado, lote o devolución + variante.
- La jerarquía se implementa con una tabla por subtipo. CUSTOMERS y EMPLOYEES usan como PK el mismo id de PERSONS.
- La 1:1 LAYAWAYS–SALES es una FK única y opcional (`sales.layaway_id`, UNIQUE).

### 7.1 Correcciones de la Entrega 2

| Observación | Cómo se resolvió |
|---|---|
| Subtipos: una persona podía quedar como cliente y como empleado a la vez | PERSONS tiene un discriminador `person_type` ('C' / 'E') y un UNIQUE `(person_id, person_type)`. CUSTOMERS y EMPLOYEES guardan `person_type` fijo ('C' o 'E', con DEFAULT y CHECK) y tienen una **FK compuesta** `(id, person_type)` hacia PERSONS. Así una persona solo puede estar en uno de los dos subtipos. |
| RETURN_DETAILS no garantizaba que la variante devuelta se hubiera vendido en la venta original | RETURN_DETAILS guarda `sale_id` y tiene dos FK compuestas: `(return_id, sale_id) → RETURNS` (la venta es la misma de la devolución) y `(sale_id, variant_id) → SALE_DETAILS` (la variante se vendió en esa venta). |
| Consistencia del crédito de tienda | El CHECK de STORE_CREDIT_MOVEMENTS amarra el tipo con su origen: un ABONO siempre viene de una devolución y una REDENCION siempre viene de un pago. Que el cliente del movimiento coincida con el de la devolución o el pago se valida con el trigger `trg_scm_customer_check`. |
| Dominios | Los atributos con valores fijos (`status`, `resolution_type`, `movement_type`, `variant_size`, `is_active`, `person_type`) se restringen con CHECK de dominio. |
| Tablas en singular | Todas las tablas se renombraron en plural. |
| Nombres de FK que repetían texto (`VARIANT_variant_id`) | Las FK usan el mismo nombre de la PK que referencian (`variant_id`). |

**Restricciones adicionales:** UNIQUE sobre las llaves candidatas (por ejemplo `products.sku` y la combinación producto–talla–color–material de VARIANTS), CHECK de montos y cantidades positivas, CHECK de rangos de fechas (promociones y apartados) y arcos exclusivos en PAYMENTS (venta o apartado) y STORE_CREDIT_MOVEMENTS (devolución o pago).

### 7.2 Normalización

- **1FN:** todos los atributos son atómicos y no hay grupos repetidos. Las líneas de venta, apartado, lote y devolución están en tablas de detalle.
- **2FN:** en las tablas con PK compuesta, los atributos no clave (cantidad, precio aplicado, costo unitario) dependen de la llave completa.
- **3FN:** no hay dependencias transitivas. Por ejemplo, el nombre de la categoría o de la marca vive en su propia tabla y no en PRODUCTS. Además, las columnas UNIQUE de STORE_CREDIT_MOVEMENTS y SALES son llaves candidatas, de modo que todo determinante es llave.

**Atributos derivados:** `sales.total` y `variants.stock` se almacenan para que la validación de RN-02 y los reportes sean eficientes. No violan la 3FN porque dependen de otras filas, no de otro atributo de la misma fila.

El listado completo de dependencias funcionales por tabla y la verificación detallada están en [`doc/Modelo_Relacional_3FN_y_DF.pdf`](doc/Modelo_Relacional_3FN_y_DF.pdf).

---

## 8. Implementación

Los scripts están en `src/` y se ejecutan en este orden: **DDL → DML → PL/SQL → DQL**.

### 8.1 DDL — [`target-florida-ddl.sql`](src/target-florida-ddl.sql)

Crea las 25 tablas con sus PK, UNIQUE, CHECK, NOT NULL y FK, y la secuencia `inv_adj_seq`, que genera los ids de los ajustes de inventario. Algunas reglas de negocio dependen de otras filas o tablas y no se pueden expresar con restricciones declarativas. De ellas, la consistencia del cliente en los movimientos de crédito se valida con el trigger `trg_scm_customer_check`, y el control de stock en las ventas (RN-02) con el trigger `trg_sale_details_stock`. Las demás (RN-04 empleado activo, RN-06 suma de pagos, RN-07 saldo de crédito y RN-08 promociones vigentes) quedan fuera del alcance de esta entrega y corresponderían a la lógica de la aplicación o a triggers adicionales.

### 8.2 DML — [`target-florida-dml.sql`](src/target-florida-dml.sql)

Carga los datos de prueba (272 registros). Las fechas son relativas a `SYSDATE`, para que el reporte del último mes siempre tenga datos sin importar cuándo se ejecute el script. Los datos son consistentes entre sí: el total de cada venta es igual a la suma de sus líneas, los pagos de cada venta suman su total y el stock de cada variante cuadra con los lotes, ventas, apartados vigentes, ajustes y devoluciones. Incluyen:

- 15 personas (10 clientes y 5 empleados, uno inactivo de cada tipo), 15 productos y 30 variantes, 12 de ellas con stock bajo.
- 26 ventas repartidas en tres meses, 4 apartados (vigente, completado, vencido y cancelado), 3 encargos, 2 promociones, 2 devoluciones y 3 movimientos de crédito.

### 8.3 DQL — [`target-florida-dql.sql`](src/target-florida-dql.sql)

| Reporte | Qué muestra | Técnicas SQL |
|---|---|---|
| **1. Top productos** | Top 10 general de las prendas más vendidas del último mes, con su categoría, marca, unidades e ingresos | INNER JOIN, filtro de fechas, GROUP BY, ORDER BY, TOP (`FETCH FIRST 10 ROWS ONLY`) |
| **2. Alertas de stock bajo** | Las variantes con stock menor o igual a su umbral (RN-03), con las unidades que faltan | INNER JOIN, columna calculada, ORDER BY |
| **3. Ventas por empleado** | El consolidado mensual de ventas e ingresos de cada empleado, para comisiones o descuentos de nómina | LEFT (OUTER) JOIN, GROUP BY por mes, COUNT, SUM, NVL, ORDER BY |

### 8.4 PL/SQL — [`target-florida-plsql.sql`](src/target-florida-plsql.sql)

| Objeto | Tipo | Qué hace |
|---|---|---|
| `fn_customer_credit_balance` | Función | Devuelve el saldo de crédito de tienda de un cliente: abonos menos redenciones (RN-07). |
| `sp_register_adjustment` | Procedimiento | Registra un ajuste de inventario y actualiza el stock en la misma transacción. Valida que el empleado esté activo y que el stock no quede negativo. |
| `trg_scm_customer_check` | Trigger | Antes de insertar o actualizar un movimiento de crédito, verifica que su cliente sea el de la devolución o el del pago relacionado (corrección de la Entrega 2). |
| `trg_sale_details_stock` | Trigger | Antes de insertar una línea de venta, verifica que la variante tenga stock suficiente y lo descuenta automáticamente (RN-02). Si la venta viene de un apartado, no descuenta de nuevo porque el stock ya estaba reservado. |

Al final del script hay una sección de pruebas con casos válidos y casos que deben fallar. El procedimiento no hace `COMMIT`, así que el `ROLLBACK` final deshace todas las pruebas y los datos quedan como los dejó el DML (la consola debe estar en modo de transacción manual).

---

## 9. Cómo ejecutar los scripts

Los scripts están pensados para ejecutarse en un esquema de Oracle vacío, en este orden:

| Paso | Script | Qué hace |
|---|---|---|
| 1 | [`src/target-florida-ddl.sql`](src/target-florida-ddl.sql) | Crea las 25 tablas, sus restricciones y la secuencia de ajustes |
| 2 | [`src/target-florida-dml.sql`](src/target-florida-dml.sql) | Carga los datos de prueba y hace `COMMIT` |
| 3 | [`src/target-florida-plsql.sql`](src/target-florida-plsql.sql) | Crea la función, el procedimiento y los triggers, y corre sus pruebas |
| 4 | [`src/target-florida-dql.sql`](src/target-florida-dql.sql) | Ejecuta los 3 reportes |

