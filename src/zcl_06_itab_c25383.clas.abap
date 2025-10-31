CLASS zcl_06_itab_c25383 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    "Estructura para datos de empleado
    TYPES: BEGIN OF ty_employee,
             id            TYPE n LENGTH 8,
             first_name    TYPE c LENGTH 40,
             last_name     TYPE c LENGTH 40,
             email         TYPE c LENGTH 50,
             phone_number  TYPE c LENGTH 20,
             salary        TYPE p LENGTH 8 DECIMALS 2,
             currency_code TYPE c LENGTH 3,
           END OF ty_employee.
    "Tipo de tabla para usar con VALUE
    TYPES ty_t_employees TYPE STANDARD TABLE OF ty_employee
          WITH EMPTY KEY.
ENDCLASS.

CLASS zcl_06_itab_c25383 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*   out->write( '═══════════════════════════════════════════════' ).
*   out->write( '   SISTEMA DE GESTIÓN DE EMPLEADOS' ).
*   out->write( '═══════════════════════════════════════════════' ).
*   out->write( | | ).
*   "═══════════════════════════════════════════════════════════
*   " ESCENARIO 1: CARGA INICIAL DEL MES
*   " Usar VALUE cuando tenemos varios registros predefinidos
*   "═══════════════════════════════════════════════════════════
*   out->write( '--- ESCENARIO 1: Carga inicial del mes ---' ).
*   out->write( 'RR.HH. tiene 3 empleados nuevos que empiezan hoy' ).
*   out->write( | | ).
*   "VALUE permite crear la tabla con todos los datos de una vez
*   "Cada par de paréntesis internos representa UN empleado
*   DATA(lt_empleados_mes) = VALUE ty_t_employees(
*     ( id = '00000001'
*       first_name = 'Carlos'
*       last_name = 'García'
*       email = 'carlos.garcia@empresa.com'
*       phone_number = '+34 912345601'
*       salary = '2500.00'
*       currency_code = 'EUR' )
*     ( id = '00000002'
*       first_name = 'Ana'
*       last_name = 'Martínez'
*       email = 'ana.martinez@empresa.com'
*       phone_number = '+34 912345602'
*       salary = '2800.00'
*       currency_code = 'EUR' )
*     ( id = '00000003'
*       first_name = 'Luis'
*       last_name = 'Rodríguez'
*       email = 'luis.rodriguez@empresa.com'
*       phone_number = '+34 912345603'
*       salary = '2600.00'
*       currency_code = 'EUR' )
*   ).
*   out->write( 'Empleados cargados con VALUE:' ).
*   out->write( | | ).
*   "Mostramos los empleados cargados
*   LOOP AT lt_empleados_mes INTO DATA(ls_emp).
*     out->write( |{ ls_emp-id } - { ls_emp-first_name } { ls_emp-last_name }| ).
*   ENDLOOP.
*   out->write( | | ).
*   out->write( 'VALUE es ideal para carga inicial' ).
*   out->write( '  porque podemos definir todos los registros de una vez' ).
*   out->write( | |  ).
*   out->write( | |  ).
*   "═══════════════════════════════════════════════════════════
*   " ESCENARIO 2: LLEGA UN DIRECTOR QUE DEBE IR PRIMERO
*   " Usar INSERT cuando necesitamos posición específica
*   "═══════════════════════════════════════════════════════════
*   out->write( '--- ESCENARIO 2: Llega el nuevo director ---' ).
*   out->write( 'Debe aparecer en la primera posición de la lista' ).
*   out->write( | | ).
*   "Forma clásica: usando estructura intermedia
*   DATA ls_director TYPE ty_employee.
*   ls_director-id = '00000004'.
*   ls_director-first_name = 'María'.
*   ls_director-last_name = 'Fernández'.
*   ls_director-email = 'maria.fernandez@empresa.com'.
*   ls_director-phone_number = '+34 912345604'.
*   ls_director-salary = '4500.00'.
*   ls_director-currency_code = 'EUR'.
*   "INSERT permite especificar la posición INDEX 1 = primera posición
*   INSERT ls_director INTO lt_empleados_mes INDEX 1.
*   out->write( 'Director insertado en posición 1 con INSERT' ).
*   out->write( | |  ).
*   out->write( 'Lista actualizada:' ).
*   out->write( | |  ).
*   LOOP AT lt_empleados_mes INTO ls_emp.
*     IF sy-tabix = 1.
*       out->write( |-> { ls_emp-id } - { ls_emp-first_name } { ls_emp-last_name } (DIRECTOR)| ).
*     ELSE.
*       out->write( |  { ls_emp-id } - { ls_emp-first_name } {  ls_emp-last_name }| ).
*     ENDIF.
*   ENDLOOP.
*   out->write( | |  ).
*   out->write( 'INSERT es ideal para posiciones específicas' ).
*   out->write( '  porque podemos usar INDEX para indicar dónde' ).
*   out->write( | |  ).
*   out->write( | |  ).
*   "═══════════════════════════════════════════════════════════
*   " ESCENARIO 3: VAN LLEGANDO SOLICITUDES DURANTE EL DÍA
*   " Usar APPEND para ir agregando al final
*   "═══════════════════════════════════════════════════════════
*   out->write( '--- ESCENARIO 3: Solicitudes durante el día ---' ).
*   out->write( 'Cada solicitud se agrega al final de la cola' ).
*   out->write( | |  ).
*   "APPEND siempre agrega al FINAL de la tabla
*   "Es más rápido que INSERT cuando no importa la posición
*   "Primera solicitud del día - usando estructura
*   DATA ls_nuevo_empleado TYPE ty_employee.
*   ls_nuevo_empleado-id = '00000005'.
*   ls_nuevo_empleado-first_name = 'Pedro'.
*   ls_nuevo_empleado-last_name = 'Sánchez'.
*   ls_nuevo_empleado-email = 'pedro.sanchez@empresa.com'.
*   ls_nuevo_empleado-phone_number = '+34 912345605'.
*   ls_nuevo_empleado-salary = '2400.00'.
*   ls_nuevo_empleado-currency_code = 'EUR'.
*   APPEND ls_nuevo_empleado TO lt_empleados_mes.
*   out->write( 'Solicitud 1: Pedro agregado al final con APPEND' ).
*   "Segunda solicitud - usando VALUE # directamente
*   APPEND VALUE #(
*     id = '00000006'
*     first_name = 'Laura'
*     last_name = 'López'
*     email = 'laura.lopez@empresa.com'
*     phone_number = '+34 912345606'
*     salary = '2700.00'
*     currency_code = 'EUR'
*   ) TO lt_empleados_mes.
*   out->write( 'Solicitud 2: Laura agregada al final con APPEND' ).
*   out->write( | |  ).
*   out->write( 'Lista final completa:' ).
*   out->write( | |  ).
*   LOOP AT lt_empleados_mes INTO ls_emp.
*     out->write( |{ sy-tabix }. { ls_emp-id } - {
*                   ls_emp-first_name } { ls_emp-last_name } | &&
*                 |({ ls_emp-salary } { ls_emp-currency_code })| ).
*   ENDLOOP.
*   out->write( | | ).
*   out->write( 'APPEND es ideal para agregar al final' ).
*   out->write( '  porque es la forma más rápida de añadir registros' ).
*   out->write( | | ).
*   out->write( | | ).
*   "═══════════════════════════════════════════════════════════
*   " COMPARACIÓN FINAL
*   "═══════════════════════════════════════════════════════════
*   out->write( '═══════════════════════════════════════════════' ).
*   out->write( '   RESUMEN: ¿CUÁNDO USAR CADA UNO?' ).
*   out->write( '═══════════════════════════════════════════════' ).
*   out->write( ' ' ).
*   out->write( 'VALUE:' ).
*   out->write( '  -> Carga inicial con múltiples registros' ).
*   out->write( '  -> Cuando conoces todos los datos de antemano' ).
*   out->write( '  -> Código más compacto y legible' ).
*   out->write( ' ' ).
*   out->write( 'INSERT:' ).
*   out->write( '  -> Cuando necesitas posición específica (INDEX)' ).
*   out->write( '  -> Funciona con TODOS los tipos de tablas' ).
*   out->write( '  -> Más flexible pero más lento' ).
*   out->write( ' ' ).
*   out->write( 'APPEND:' ).
*   out->write( '  -> Siempre agrega AL FINAL' ).
*   out->write( '  -> Solo para tablas STANDARD' ).
*   out->write( '  -> La forma MÁS RÁPIDA de agregar' ).


*"CORRESPONDING
*   "=================================================================
*   " DEMOSTRACIÓN 1: Copia Básica de Campos Coincidentes
*   "=================================================================
*   " Definimos un tipo local con solo los campos que necesitamos.
*   " La tabla origen /dmo/flight tiene muchos más campos, pero solo
*   " queremos trabajar con estos tres.
*   TYPES: BEGIN OF lty_flights,
*            carrier_id    TYPE /dmo/carrier_id,
*            connection_id TYPE /dmo/connection_id,
*            flight_date   TYPE /dmo/flight_date,
*          END OF lty_flights.
*
*   DATA: gt_my_flights TYPE STANDARD TABLE OF lty_flights, "itab
*         gs_my_flight  TYPE lty_flights.                   "structure
*
*   " Obtenemos todos los vuelos en EUR de la base de datos
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'EUR'
*     INTO TABLE @DATA(gt_flights).
*
*   out->write( |=======================================================| ).
*   out->write( |  CASO 1: Copia básica con campos coincidentes        | ).
*   out->write( |=======================================================| ).
*   out->write( | | ).
*   out->write( |Tabla origen tiene { lines( gt_flights ) } registros con TODOS los campos| ).
*
*   " FORMA ANTIGUA: Usando MOVE-CORRESPONDING
*   MOVE-CORRESPONDING gt_flights TO gt_my_flights.
*   out->write( |FORMA ANTIGUA: MOVE-CORRESPONDING gt_flights TO gt_my_flights.| ).
*   out->write( |Resultado: { lines( gt_my_flights ) } registros copiados| ).
*   out->write( gt_my_flights ).
*   out->write( | | ).
*   " Limpiamos para demostrar la forma moderna
*   CLEAR gt_my_flights.
*
*   " FORMA MODERNA: Usando el operador CORRESPONDING
*   gt_my_flights = CORRESPONDING #( gt_flights ).
*   out->write( |FORMA MODERNA: gt_my_flights = CORRESPONDING #( gt_flights ).| ).
*   out->write( |Resultado: { lines( gt_my_flights ) } registros copiados| ).
*   out->write( gt_my_flights ).
*   out->write( |==> Ambas formas producen el MISMO resultado| ).
*   out->write( |\n\n| ).
*   "=================================================================
*   " DEMOSTRACIÓN 2: Agregar Registros Sin Borrar los Existentes
*   "=================================================================
*   " Ahora imaginen que gt_my_flights ya tiene datos y queremos
*   " AGREGAR más registros sin perder los que ya teníamos.
*   " Esto es muy común cuando acumulamos datos de diferentes fuentes.
*   out->write( |=======================================================| ).
*   out->write( |  CASO 2: Agregar datos conservando los existentes    | ).
*   out->write( |=======================================================| ).
*   out->write( | | ).
*   " Primero llenamos gt_my_flights con algunos vuelos en EUR
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'EUR'
*     INTO TABLE @gt_flights
*     UP TO 3 ROWS.
*
*   gt_my_flights = CORRESPONDING #( gt_flights ).
*   out->write( |Comenzamos con { lines( gt_my_flights ) } vuelos en EUR| ).
*   out->write( gt_my_flights ).
*   out->write( | | ).
*
*   " Ahora obtenemos vuelos en USD y queremos AGREGARLOS
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'USD'
*     INTO TABLE @gt_flights
*     UP TO 3 ROWS.
*   out->write( |Queremos agregar { lines( gt_flights ) } vuelos en USD| ).
*   out->write( | | ).
*
*   " FORMA ANTIGUA: MOVE-CORRESPONDING con KEEPING TARGET LINES
*   MOVE-CORRESPONDING gt_flights TO gt_my_flights KEEPING TARGET LINES.
*   out->write( |FORMA ANTIGUA: MOVE-CORRESPONDING gt_flights TO gt_my_flights KEEPING TARGET LINES.| ).
*   out->write( |Resultado: Ahora tenemos { lines( gt_my_flights ) } vuelos totales| ).
*   out->write( |Los primeros 3 EUR se conservaron + 3 USD se agregaron| ).
*   out->write( gt_my_flights ).
*   out->write( | | ).
*
*   " Reiniciamos para demostrar la forma moderna
*   CLEAR gt_my_flights.
*
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'EUR'
*     INTO TABLE @DATA(gt_flights_eur)
*     UP TO 3 ROWS.
*
*   gt_my_flights = CORRESPONDING #( gt_flights_eur ).
*
*   " FORMA MODERNA: CORRESPONDING con BASE
*   gt_my_flights = CORRESPONDING #( BASE ( gt_my_flights ) gt_flights ).
*
*   out->write( |FORMA MODERNA: gt_my_flights = CORRESPONDING #( BASE ( gt_my_flights ) gt_flights ).| ).
*   out->write( |Resultado: Ahora tenemos { lines( gt_my_flights ) } vuelos totales| ).
*   out->write( |Los primeros 3 EUR se conservaron + 3 USD se agregaron| ).
*   out->write( gt_my_flights ).
*   out->write( |==> Ambas formas producen el MISMO resultado| ).
*   out->write( |\n\n| ).
*   "=================================================================
*   " DEMOSTRACIÓN 3: Mapeo de Campos con Nombres Diferentes
*   "=================================================================
*   " ¿Qué pasa si los campos tienen información similar pero con
*   " nombres diferentes? Aquí necesitamos hacer un mapeo manual.
*   out->write( |=======================================================| ).
*   out->write( |  CASO 3: Mapeo de campos con nombres diferentes      | ).
*   out->write( |=======================================================| ).
*   out->write( | | ).
*   " Definimos un tipo donde los campos se llaman diferente
*   TYPES: BEGIN OF lty_flights_renamed,
*            carrier    TYPE /dmo/carrier_id,      "En origen: carrier_id
*            connection TYPE /dmo/connection_id,   "En origen: connection_id
*            date       TYPE /dmo/flight_date,     "En origen: flight_date
*          END OF lty_flights_renamed.
*
*   DATA gt_flights_renamed TYPE STANDARD TABLE OF lty_flights_renamed.
*
*   " Obtenemos datos origen
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'EUR'
*     INTO TABLE @gt_flights
*     UP TO 5 ROWS.
*
*   out->write( |Tabla origen tiene campos: carrier_id, connection_id, flight_date| ).
*   out->write( |Tabla destino tiene campos: carrier, connection, date| ).
*   out->write( |Los nombres NO coinciden, pero la información es la misma.| ).
*   out->write( | | ).
*   " Con CORRESPONDING necesitamos usar MAPPING para indicar
*   " qué campo origen corresponde a qué campo destino
*   gt_flights_renamed = CORRESPONDING #( gt_flights MAPPING carrier    = carrier_id
*                                                            connection = connection_id
*                                                            date       = flight_date ).
*   out->write( |Usamos MAPPING para relacionar los campos:| ).
*   out->write( |  carrier    = carrier_id| ).
*   out->write( |  connection = connection_id| ).
*   out->write( |  date       = flight_date| ).
*   out->write( | | ).
*   out->write( |Resultado con campos mapeados:| ).
*   out->write( gt_flights_renamed ).
*   out->write( | | ).
*
*   " IMPORTANTE: MOVE-CORRESPONDING NO tiene una forma de hacer MAPPING.
*   " Si los nombres no coinciden exactamente, MOVE-CORRESPONDING simplemente
*   " no copia esos campos. Esta es una ventaja clara del operador CORRESPONDING.
*   "=================================================================


*    "READ TABLE
*    " Obtenemos datos de aeropuertos para trabajar
*    SELECT FROM /dmo/airport
*      FIELDS *
*      WHERE country EQ 'DE'
*      INTO TABLE @DATA(lt_airports).
*
*    DATA lt_airports_sort TYPE SORTED TABLE OF /dmo/airport WITH UNIQUE KEY city.
*    DATA lt_airports_sort2 TYPE SORTED TABLE OF /dmo/airport WITH NON-UNIQUE KEY city.
*
*    DATA lt_airports_hash TYPE HASHED TABLE OF /dmo/airport WITH UNIQUE KEY city.
*
*    IF sy-subrc EQ 0.
*      "============================================================
*      " CASO 1: Lectura por ÍNDICE (posición)
*      "============================================================
*      out->write( |CASO 1: Acceso por ÍNDICE (muy rápido siempre)| ).
*      out->write( |-------------------------------------------| ).
*      " Forma tradicional: READ TABLE con INDEX
*
*      READ TABLE lt_airports INTO DATA(ls_airport1) INDEX 1.
*      out->write( |Forma antigua: READ TABLE ... INDEX 1| ).
*      out->write( ls_airport1 ).
*
*      " Forma moderna: Expresión de tabla con corchetes
*      DATA(ls_airport2) = lt_airports[ 2 ].
*      out->write( |Forma moderna: lt_airports[ 2 ]| ).
*      out->write( ls_airport2 ).
*
*      " Si el índice puede no existir, usar OPTIONAL
*      DATA(ls_safe) = VALUE #( lt_airports[ 999 ] OPTIONAL ).
*      out->write( |Con OPTIONAL no falla si no existe el índice| ).
*      out->write( |\n| ).
*
*      "============================================================
*      " CASO 2: Lectura por CLAVE (campo específico)
*      "============================================================
*      out->write( |CASO 2: Acceso por CAMPO (lento si hay muchos registros)| ).
*      out->write( |-------------------------------------------| ).
*
*      " Forma tradicional: WITH KEY
*      READ TABLE lt_airports INTO DATA(ls_berlin)
*        WITH KEY city = 'Berlin'.
*      out->write( |Forma antigua: WITH KEY city = 'Berlin'| ).
*      out->write( ls_berlin ).
*
*      " Forma moderna: campo = valor entre corchetes
*      DATA(ls_munich) = lt_airports[ city = 'Munich' ].
*      out->write( |Forma moderna: lt_airports[ city = 'Munich' ]| ).
*      out->write( ls_munich ).
*
*      " Acceso directo a un componente específico
*      DATA(lv_name) = lt_airports[ city = 'Hamburg' ]-name.
*      out->write( |Acceso a componente: ...[ city = 'Hamburg' ]-name| ).
*      out->write( |Resultado: { lv_name }| ).
*      out->write( |\n| ).
*
*     "============================================================
*     " CASO 3: Lectura OPTIMIZADA con tabla SORTED
*     "============================================================
*     out->write( |CASO 3: Acceso OPTIMIZADO con tabla SORTED| ).
*     out->write( |-------------------------------------------| ).
*
*     " Declaramos tabla con clave para búsquedas rápidas
*     DATA gt_sorted TYPE SORTED TABLE OF /dmo/airport
*       WITH NON-UNIQUE KEY airport_id.
*
*     SELECT FROM /dmo/airport
*       FIELDS *
*       INTO TABLE @gt_sorted.
*     " IMPORTANTE: Especificar KEY primary_key para usar optimización
*
*     DATA(ls_fast) = gt_sorted[ KEY primary_key airport_id = 'FRA' ].
*     out->write( |Con KEY primary_key: Búsqueda MUY rápida| ).
*     out->write( ls_fast ).
*
*     " Sin KEY funciona pero es menos eficiente
*     DATA(ls_slow) = gt_sorted[ airport_id = 'MUC' ].
*     out->write( |Sin KEY: Funciona pero más lento en tablas grandes| ).
*     out->write( ls_slow ).
*     out->write( |\n| ).
*
*     "============================================================
*     " RESUMEN RÁPIDO
*     "============================================================
*     out->write( |RESUMEN: ¿Cuándo usar cada forma?| ).
*     out->write( |-------------------------------------------| ).
*     out->write( |Por ÍNDICE: Siempre rápido. Úsalo si conoces la posición.| ).
*     out->write( |Por CLAVE en tabla STANDARD: Solo para tablas pequeñas.| ).
*     out->write( |Por CLAVE en tabla SORTED/HASHED: Siempre usa KEY primary_key.| ).
*     out->write( |OPTIONAL: Para evitar errores si el registro puede no existir.| ).
*
*    ENDIF.

*
*"FOR
*   " Estructuras para productos
*   TYPES: BEGIN OF ty_producto,
*            id       TYPE i,
*            nombre   TYPE string,
*            precio   TYPE p LENGTH 10 DECIMALS 2,
*            categoria TYPE string,
*          END OF ty_producto.
*
*   TYPES: BEGIN OF ty_producto_con_descuento,
*            id              TYPE i,
*            nombre          TYPE string,
*            precio_original TYPE p LENGTH 10 DECIMALS 2,
*            descuento       TYPE i,
*            precio_final    TYPE p LENGTH 10 DECIMALS 2,
*          END OF ty_producto_con_descuento.
*
*   DATA lt_productos TYPE TABLE OF ty_producto.
*
*   DATA lt_productos_descuento TYPE STANDARD TABLE OF ty_producto_con_descuento.
*
*   "=================================================================
*   " CASO 1: Generar catálogo de productos con FOR UNTIL
*   "=================================================================
*   out->write( |CASO 1: Generar productos automáticamente| ).
*   out->write( |======================================| ).
*
*   " SIN FOR (forma tradicional - muchas líneas):
*   " DO 10 TIMES.
*   "   APPEND VALUE #( id = sy-index
*   "                   nombre = |Producto { sy-index }|
*   "                   precio = 100 + ( sy-index * 20 )
*   "                   categoria = ... ) TO lt_productos.
*   " ENDDO.
*
*   " CON FOR (forma moderna - una sola expresión):
*
*   lt_productos = VALUE #(
*     FOR i = 1 UNTIL i > 10
*     ( id        = i
*       nombre    = |Producto { i }|
*       precio    = 100 + ( i * 20 )
*       categoria = COND #( WHEN i <= 5 THEN 'Basico' ELSE 'Premium' ) ) ).
*
*   out->write( |Generados { lines( lt_productos ) } productos| ).
*   out->write( lt_productos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 2: Aplicar descuento a todos con FOR...IN
*   "=================================================================
*
*   out->write( |CASO 2: Aplicar descuentos según precio| ).
*   out->write( |==================================| ).
*
*   " SIN FOR (forma tradicional):
*   " LOOP AT lt_productos INTO DATA(ls_prod).
*   "   DATA(ls_con_desc) = VALUE ty_producto_con_descuento( ... ).
*   "   IF ls_prod-precio >= 200.
*   "     ls_con_desc-descuento = 20.
*   "   ELSE...
*   "   ls_con_desc-precio_final = ls_prod-precio * ...
*   "   APPEND ls_con_desc TO lt_productos_descuento.
*   " ENDLOOP.
*
*   " CON FOR (forma moderna con COND):
*
*   lt_productos_descuento = VALUE #( FOR ls_prod IN lt_productos
*                                         LET descuento_aplicado = COND i( WHEN ls_prod-precio >= 200 THEN 20 "Transformación a entero para guardarlo en la variable
*                                            WHEN ls_prod-precio >= 150 THEN 15
*                                            ELSE 10 ) IN
*                                             ( id              = ls_prod-id
*                                               nombre          = ls_prod-nombre
*                                               precio_original = ls_prod-precio
*                                               descuento       = descuento_aplicado
*                                               precio_final    = ls_prod-precio * ( 100 - descuento_aplicado ) / 100 )  ).
*
*   out->write( |Todos los productos con descuento aplicado:| ).
*
*   LOOP AT lt_productos_descuento INTO DATA(ls_desc).
*     out->write( |{ ls_desc-nombre }: { ls_desc-precio_original } EUR -> { ls_desc-precio_final } EUR ({ ls_desc-descuento }% desc)| ).
*   ENDLOOP.
*
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 3: Filtrar solo productos Premium con FOR...IN WHERE
*   "=================================================================
*   out->write( |CASO 3: Reporte solo de productos Premium| ).
*   out->write( |====================================| ).
*
*   " SIN FOR (forma tradicional):
*   " DATA lt_premium TYPE TABLE OF ty_producto.
*   " LOOP AT lt_productos INTO DATA(ls_producto).
*   "   IF ls_producto-categoria = 'Premium'.
*   "     APPEND ls_producto TO lt_premium.
*   "   ENDIF.
*   " ENDLOOP.
*   " CON FOR WHERE (filtrar y copiar):
*
*   DATA lt_solo_premium TYPE TABLE OF ty_producto.
*
*   lt_solo_premium = VALUE #( FOR ls_prod IN lt_productos
*                                WHERE ( categoria = 'Premium' )
*                                ( ls_prod ) ).
*
*   out->write( |Productos Premium: { lines( lt_solo_premium ) } de { lines( lt_productos ) }| ).
*   out->write( lt_solo_premium ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN SIMPLE:| ).
*   out->write( |=============| ).
*   out->write( |1. FOR i = 1 UNTIL i > 10| ).
*   out->write( |  -> Crea registros automáticamente (como DO)| ).
*   out->write( | | ).
*   out->write( |2. FOR elemento IN tabla| ).
*   out->write( |  -> Transforma cada elemento a nueva tabla| ).
*   out->write( | | ).
*   out->write( |3. FOR elemento IN tabla WHERE ( condición )| ).
*   out->write( |  -> Filtra Y transforma al mismo tiempo| ).
*   out->write( | | ).
*   out->write( |COND: IF-THEN-ELSE en una sola línea| ).
*   out->write( |LET: Define variables temporales dentro del FOR| ).



*"SORT
*
*"Ordenar registros - en qué tipos de tablas?
*
*   " Obtenemos vuelos desde la CDS View estándar
*   SELECT FROM /DMO/I_Flight
*     FIELDS AirlineID,
*            ConnectionID,
*            FlightDate,
*            Price,
*            CurrencyCode
*     WHERE CurrencyCode = 'EUR'
*     INTO TABLE @DATA(lt_vuelos)
*     UP TO 10 ROWS.
*   out->write( |Datos originales sin ordenar:| ).
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 1: SORT por clave primaria (ascendente por defecto)
*   "=================================================================
*   out->write( |CASO 1: Ordenar por clave primaria| ).
*   out->write( |================================| ).
*   " Como lt_vuelos se declaró inline con DATA(...), tiene clave vacía.
*   " SORT ordenará por TODOS los campos en orden de aparición.
*   SORT lt_vuelos.
*   out->write( |Después de SORT (clave primaria ascendente):| ).
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 2: SORT DESCENDING (orden inverso)
*   "=================================================================
*   out->write( |CASO 2: Ordenar descendente| ).
*   out->write( |=======================| ).
*   SORT lt_vuelos DESCENDING.
*   out->write( |Después de SORT DESCENDING:| ).
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 3: SORT BY campo específico
*   "=================================================================
*   out->write( |CASO 3: Ordenar por campo específico (FlightDate)| ).
*   out->write( |=============================================| ).
*   " Ordenar solo por fecha de vuelo (ascendente)
*   SORT lt_vuelos BY FlightDate.
*   out->write( |Ordenado por FlightDate ascendente:| ).
*   LOOP AT lt_vuelos INTO DATA(ls_vuelo).
*     out->write( |{ ls_vuelo-AirlineID }{ ls_vuelo-ConnectionID } - { ls_vuelo-FlightDate } - { ls_vuelo-Price } { ls_vuelo-CurrencyCode }| ).
*   ENDLOOP.
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 4: SORT BY campo descendente
*   "=================================================================
*   out->write( |CASO 4: Ordenar por precio (más caro primero)| ).
*   out->write( |=========================================| ).
*   " Ordenar por precio de mayor a menor
*   SORT lt_vuelos BY Price DESCENDING.
*   out->write( |Ordenado por Price descendente:| ).
*   LOOP AT lt_vuelos INTO ls_vuelo.
*     out->write( |{ ls_vuelo-AirlineID }{ ls_vuelo-ConnectionID } - Precio: { ls_vuelo-Price } { ls_vuelo-CurrencyCode }| ).
*   ENDLOOP.
*   out->write( |\n| ).
*
*
*   "=================================================================
*   " CASO 5: SORT múltiples campos con diferentes direcciones
*   "=================================================================
*   out->write( |CASO 5: Ordenar por varios campos| ).
*   out->write( |=============================| ).
*   " Primero por aerolínea (ascendente), luego por precio (descendente)
*   SORT lt_vuelos BY AirlineID ASCENDING
*                     Price DESCENDING.
*   out->write( |Ordenado por CarrierID (asc) y luego Price (desc):| ).
*   LOOP AT lt_vuelos INTO ls_vuelo.
*     out->write( |{ ls_vuelo-AirlineID } - { ls_vuelo-ConnectionID } - { ls_vuelo-Price } EUR| ).
*   ENDLOOP.
*   out->write( |\n| ).
*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN:| ).
*   out->write( |=======| ).
*   out->write( |• SORT tabla               → Ordena por clave primaria ascendente| ).
*   out->write( |• SORT tabla DESCENDING    → Ordena por clave primaria descendente| ).
*   out->write( |• SORT tabla BY campo      → Ordena por campo específico| ).
*   out->write( |• SORT tabla BY campo DESCENDING → Campo descendente| ).
*   out->write( |• SORT tabla BY campo1 ASC campo2 DESC → Múltiples campos| ).
*   out->write( | | ).
*   out->write( |IMPORTANTE:| ).
*   out->write( |• Solo aplica a tablas STANDARD y HASHED| ).
*   out->write( |• Las tablas SORTED ya están ordenadas, no necesitan SORT| ).
*   out->write( |• Por defecto el orden es ASCENDING (ascendente)| ).

*"MODIFY
*
*   " Estructura simple
*
*   TYPES: BEGIN OF ty_vuelo,
*            id     TYPE i,
*            precio TYPE i,
*            estado TYPE string,
*          END OF ty_vuelo.
*   DATA lt_vuelos TYPE TABLE OF ty_vuelo.
*
*   " Crear algunos vuelos
*   lt_vuelos = VALUE #(
*     ( id = 1 precio = 200 estado = 'Disponible' )
*     ( id = 2 precio = 300 estado = 'Disponible' )
*     ( id = 3 precio = 250 estado = 'Disponible' ) ).
*
*   out->write( |Datos originales:| ).
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 1: MODIFY por índice (posición específica)
*   "=================================================================
*
*   out->write( |CASO 1: Modificar el segundo vuelo por índice| ).
*
*   " Crear nueva estructura con los cambios
*   DATA(ls_cambio) = VALUE ty_vuelo( id = 2 precio = 350 estado = 'Promoción' ).
*
*   " Modificar la posición 2
*   MODIFY lt_vuelos FROM ls_cambio INDEX 2.
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 2: MODIFY en LOOP con FIELD-SYMBOL (más común y eficiente)
*   "=================================================================
*   out->write( |CASO 2: Aplicar descuento 10% a todos| ).
*
*   " Modificar directamente cada registro en el LOOP
*   LOOP AT lt_vuelos ASSIGNING FIELD-SYMBOL(<fs_vuelo>).
*     <fs_vuelo>-precio = <fs_vuelo>-precio * 90 / 100.  " 10% descuento
*     <fs_vuelo>-estado = 'Rebajado'.
*   ENDLOOP.
*
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 3: MODIFY condicional (solo algunos registros)
*   "=================================================================
*   out->write( |CASO 3: Cambiar estado solo si precio < 300| ).
*
*   LOOP AT lt_vuelos ASSIGNING FIELD-SYMBOL(<fs_v>).
*     IF <fs_v>-precio < 300.
*       <fs_v>-estado = 'Oferta Especial'.
*     ENDIF.
*   ENDLOOP.
*
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
**   "=================================================================
**   " RESUMEN
**   "=================================================================
**   out->write( |RESUMEN:| ).
**   out->write( |• MODIFY tabla FROM estructura INDEX n → Cambia posición n| ).
**   out->write( |• LOOP con FIELD-SYMBOL → Forma más común y eficiente| ).
**   out->write( |• FIELD-SYMBOL modifica directamente, sin copias| ).
*

*"DELETE
*
*"Eliminar registros
*   " Obtener clientes
*
*   SELECT FROM /DMO/I_Customer
*     FIELDS CustomerID, FirstName, LastName, CountryCode
*     INTO TABLE @DATA(lt_clientes)
*     UP TO 15 ROWS.
*
*   out->write( |Clientes iniciales: { lines( lt_clientes ) }| ).
*   out->write( lt_clientes ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 1: DELETE INDEX (eliminar por posición)
*   "=================================================================
*   out->write( |CASO 1: Eliminar el segundo cliente (posición 2)| ).
*   DELETE lt_clientes INDEX 2.
*   out->write( |Después de DELETE INDEX 2: { lines( lt_clientes ) } clientes| ).
*   out->write( lt_clientes ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 2: DELETE WHERE (eliminar por condición)
*   "=================================================================
*   out->write( |CASO 2: Eliminar clientes de Alemania| ).
*   DELETE lt_clientes WHERE CountryCode = 'DE'.
*   out->write( |Después de DELETE WHERE: { lines( lt_clientes ) } clientes| ).
*   out->write( lt_clientes ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 3: DELETE ADJACENT DUPLICATES (eliminar duplicados)
*   "=================================================================
*   out->write( |CASO 3: Eliminar duplicados por país| ).
*   " IMPORTANTE: Primero SORT, luego DELETE ADJACENT
*   SORT lt_clientes BY CountryCode.
*   DELETE ADJACENT DUPLICATES FROM lt_clientes COMPARING CountryCode.
*   out->write( |Solo un cliente por país: { lines( lt_clientes ) }| ).
*   out->write( lt_clientes ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 4: CLEAR vs FREE vs VALUE #()
*   "=================================================================
*   out->write( |CASO 4: Tres formas de vaciar una tabla| ).
*
*   DATA lt_temp TYPE TABLE OF /dmo/i_customer.
*
*   SELECT FROM /DMO/I_Customer
*     FIELDS *
*     INTO CORRESPONDING FIELDS OF TABLE @lt_temp
*     UP TO 50 ROWS.
*
*   out->write( |Tabla con { lines( lt_temp ) } registros| ).
*   " Opción 1: CLEAR (mantiene memoria)
*   CLEAR lt_temp.
*
*   out->write( |Después de CLEAR: { lines( lt_temp ) } - memoria reservada| ).
*
*   " Rellenar otra vez
*   SELECT FROM /DMO/I_Customer
*     FIELDS *
*     INTO CORRESPONDING FIELDS OF TABLE @lt_temp
*     UP TO 50 ROWS.
*
*   " Opción 2: FREE (libera memoria)
*   FREE lt_temp.
*   out->write( |Después de FREE: { lines( lt_temp ) } - memoria liberada| ).
*
*   " Rellenar otra vez
*   SELECT FROM /DMO/I_Customer
*     FIELDS *
*     INTO CORRESPONDING FIELDS OF TABLE @lt_temp
*     UP TO 50 ROWS.
*
*   " Opción 3: VALUE #() (forma moderna, igual que CLEAR)
*   lt_temp = VALUE #( ).
*   out->write( |Después de VALUE #(): { lines( lt_temp ) } - forma moderna| ).
*   out->write( |\n| ).
*
*
*
*
*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN:| ).
*   out->write( |DELETE:| ).
*   out->write( |  • DELETE tabla INDEX n -> Elimina posición n| ).
*   out->write( |  • DELETE tabla WHERE condición -> Elimina por condición| ).
*   out->write( |  • DELETE ADJACENT DUPLICATES -> Elimina duplicados (primero SORT)| ).
*   out->write( | | ).
*   out->write( |VACIAR TABLA:| ).
*   out->write( |  • CLEAR tabla -> Vacía, mantiene memoria| ).
*   out->write( |  • FREE tabla -> Vacía ->, libera memoria| ).
*   out->write( |  • tabla = VALUE #()- Forma moderna (igual que CLEAR)| ).


*"COLLECT
*
*   " Estructura para ventas
*   TYPES: BEGIN OF ty_venta,
*            producto  TYPE string,
*            cantidad  TYPE i,
*            importe   TYPE p LENGTH 10 DECIMALS 2,
*          END OF ty_venta.
*
*   " Tabla HASHED con clave en producto
*   " HASHED es perfecto para COLLECT - búsqueda rápida por clave
*   DATA lt_ventas_acumuladas TYPE HASHED TABLE OF ty_venta
*     WITH UNIQUE KEY producto.
*
*   DATA ls_venta TYPE ty_venta.
*   out->write( |Simulando ventas del día...| ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " Simulamos ventas que van llegando durante el día
*   "=================================================================
*   " Primera venta de Laptop
*   ls_venta = VALUE #( producto = 'Laptop' cantidad = 2 importe = 1000 ).
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*   out->write( |Venta 1: 2 Laptops por 1000 EUR| ).
*
*   " Venta de Mouse
*   ls_venta = VALUE #( producto = 'Mouse' cantidad = 5 importe = 50 ).
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*   out->write( |Venta 2: 5 Mouse por 50 EUR| ).
*
*   " Segunda venta de Laptop - COLLECT sumará automáticamente
*   ls_venta = VALUE #( producto = 'Laptop' cantidad = 1 importe = 500 ).
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*   out->write( |Venta 3: 1 Laptop por 500 EUR (se suma a la anterior)| ).
*
*   " Otra venta de Mouse - COLLECT sumará
*   ls_venta = VALUE #( producto = 'Mouse' cantidad = 10 importe = 100 ).
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*   out->write( |Venta 4: 10 Mouse por 100 EUR (se suma a la anterior)| ).
*
*   " Venta de Teclado
*   ls_venta = VALUE #( producto = 'Teclado' cantidad = 3 importe = 150 ).
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*   out->write( |Venta 5: 3 Teclados por 150 EUR| ).
*
*   " Tercera venta de Laptop
*   ls_venta = VALUE #( producto = 'Laptop' cantidad = 1 importe = 600 ).
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*
*   out->write( |Venta 6: 1 Laptop por 600 EUR (se suma a las anteriores)| ).
*   out->write( |\n| ).
*   out->write( |RESULTADO: Ventas acumuladas por producto| ).
*   out->write( |=========================================| ).
*
*   LOOP AT lt_ventas_acumuladas INTO DATA(ls_acum).
*     out->write( |Producto: { ls_acum-producto }| ).
*     out->write( |  Cantidad total: { ls_acum-cantidad } unidades| ).
*     out->write( |  Importe total: { ls_acum-importe } EUR| ).
*     out->write( |---| ).
*
*   ENDLOOP.
*
*   out->write( |\n| ).
*   out->write( |Observa cómo COLLECT acumuló automáticamente:| ).
*   out->write( |• Laptop: 2+1+1 = 4 unidades, 1000+500+600 = 2100 EUR| ).
*   out->write( |• Mouse: 5+10 = 15 unidades, 50+100 = 150 EUR| ).
*   out->write( |• Teclado: 3 unidades, 150 EUR (solo una venta)| ).
*   out->write( |\n| ).
*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN DE COLLECT:| ).
*   out->write( |=================| ).
*   out->write( |¿Qué hace?| ).
*   out->write( |  • Si la clave NO existe -> Inserta nuevo registro| ).
*   out->write( |  • Si la clave YA existe -> SUMA campos numéricos| ).
*   out->write( | | ).
*   out->write( |¿Cuándo usar?| ).
*   out->write( |   Para acumular totales (ventas, cantidades, importes)| ).
*   out->write( |   Con tablas HASHED o SORTED (rápidas)| ).
*   out->write( |   Cuando quieres evitar duplicados automáticamente| ).
*   out->write( | | ).
*   out->write( |¿Cuándo NO usar?| ).
*   out->write( |   Con tablas STANDARD (muy lento con muchos datos)| ).
*   out->write( |   Si no necesitas sumar, usa APPEND o INSERT| ).
*   out->write( | | ).
*   out->write( |Tipos de tabla recomendados:| ).
*   out->write( |  • HASHED TABLE -> Mejor rendimiento para COLLECT| ).
*   out->write( |  • SORTED TABLE -> También funciona bien| ).

"Enumeraciones

   "=================================================================
   " CASO 1: ENUM básico (valores numéricos automáticos)
   "=================================================================

   out->write( |CASO 1: Estados de pedido| ).
   " Definir tipo con valores permitidos

   TYPES: BEGIN OF ENUM ty_estado,
            pendiente,    " = 0
            procesado,    " = 1
            enviado,      " = 2
            entregado,    " = 3
          END OF ENUM ty_estado.

   DATA lv_estado TYPE ty_estado VALUE pendiente.

   out->write( |Estado inicial: { lv_estado }| ).

   lv_estado = enviado.

   out->write( |Estado actualizado: { lv_estado }| ).
   out->write( |\n| ).

   "=================================================================
   " CASO 2: ENUM con STRUCTURE (más organizado)
   "=================================================================
   out->write( |CASO 2: Con estructura| ).
   TYPES: BEGIN OF ENUM ty_prioridad STRUCTURE ls_prio,
            baja,
            media,
            alta,
            urgente,
          END OF ENUM ty_prioridad STRUCTURE ls_prio.

   DATA lv_prioridad TYPE ty_prioridad.

   " Acceso claro usando la estructura
   lv_prioridad = ls_prio-urgente.

   out->write( |Prioridad: { lv_prioridad }| ).
   out->write( |\n| ).

   "=================================================================
   " CASO 3: Uso práctico con CASE
   "=================================================================
   out->write( |CASO 3: Lógica según estado| ).
   lv_estado = enviado.
   CASE lv_estado.
     WHEN pendiente.
       out->write( |→ Esperando confirmación| ).
     WHEN procesado.
       out->write( |→ Preparando envío| ).
     WHEN enviado.
       out->write( |→ En camino al cliente| ).
     WHEN entregado.
       out->write( |→ Pedido completado| ).
   ENDCASE.
   out->write( |\n| ).

   "=================================================================
   " RESUMEN
   "=================================================================
   out->write( |RESUMEN:| ).
   out->write( |• ENUM = tipo con valores limitados| ).
   out->write( |• Solo puedes asignar los valores definidos| ).
   out->write( |• Perfecto para estados, prioridades, categorías| ).
   out->write( |• Sintaxis: BEGIN OF ENUM tipo ... END OF ENUM tipo| ).
   out->write( |• Con STRUCTURE es más claro: ls_nombre-valor| ).
 ENDMETHOD.


ENDCLASS.

