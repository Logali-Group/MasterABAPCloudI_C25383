CLASS z_prog_din_c25383 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_prog_din_c25383 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    "═══════════════════════════════════════════════════════════
*    " EJEMPLO 1: FIELD SYMBOLS BÁSICO - Modificar UNA estructura
*    "═══════════════════════════════════════════════════════════
*    out->write( |=== EJEMPLO 1: Field Symbol Básico ===| ).
*
*    " Crear una aerolínea (carrier)
*    DATA(gs_carrier) = VALUE /dmo/carrier( carrier_id    = 'LG'
*                                           name          = 'Logali Airlines'
*                                           currency_code = 'EUR' ).
*
*    out->write( |ANTES: { gs_carrier-name }| ).
*
*    "Usar Field Symbol para modificar
*    ASSIGN gs_carrier TO FIELD-SYMBOL(<fs_carrier>).
*
*    IF <fs_carrier> IS ASSIGNED.
*      " Acceso dinámico a un campo específico
*      ASSIGN COMPONENT 'NAME' OF STRUCTURE <fs_carrier>
*             TO FIELD-SYMBOL(<fs_data>).
*
*      IF <fs_data> IS ASSIGNED.
*        <fs_data> = 'Logali Group Airlines'.  "Cambia el original
*        UNASSIGN <fs_data>.
*      ENDIF.
*
*      UNASSIGN <fs_carrier>.
*    ENDIF.
*
*    out->write( |DESPUÉS: { gs_carrier-name }| ).
*
*    "═══════════════════════════════════════════════════════════
*    " EJEMPLO 2: FIELD SYMBOLS CON DECLARACIÓN INLINE
*    "═══════════════════════════════════════════════════════════
*    out->write( |=== EJEMPLO 2: Declaración Inline ===| ).
*
*    DATA(gs_connection) = VALUE /dmo/connection(  carrier_id      = 'AA'
*                                                  connection_id   = '0017'
*                                                  airport_from_id = 'JFK'
*                                                  airport_to_id   = 'SFO' ).
*
*    out->write( |ANTES: De { gs_connection-airport_from_id } a { gs_connection-airport_to_id }| ).
*
*    "Field Symbol inline (más moderno)
*    ASSIGN gs_connection TO FIELD-SYMBOL(<fs_conn>).
*
*    IF <fs_conn> IS ASSIGNED.
*      " Con field symbol tipado, puedes acceder directamente
*      <fs_conn>-airport_from_id = 'LAX'.
*      <fs_conn>-airport_to_id   = 'ORD'.
*      UNASSIGN <fs_conn>.
*    ENDIF.
*
*    out->write( |DESPUÉS: De { gs_connection-airport_from_id } a { gs_connection-airport_to_id }| ).
*
*
*    "═══════════════════════════════════════════════════════════
*    " EJEMPLO 3: MODIFICAR TABLA MASIVAMENTE con Field Symbols
*    "═══════════════════════════════════════════════════════════
*    out->write( |=== EJEMPLO 3: Modificación Masiva ===| ).
*
*    " Leer vuelos
*    SELECT * FROM /dmo/flight
*      WHERE carrier_id = 'AA'
*      INTO TABLE @DATA(gt_flights)
*      UP TO 5 ROWS.
*
*    out->write( |Total vuelos: { lines( gt_flights ) }| ).
*    out->write( |--- PRECIOS ORIGINALES ---| ).
*
*    LOOP AT gt_flights INTO DATA(ls_flight_show).
*      out->write( |Vuelo { ls_flight_show-connection_id }: { ls_flight_show-price } { ls_flight_show-currency_code }| ).
*    ENDLOOP.
*
*    " ⭐ Modificar precios aplicando 10% descuento
*    " Sin field symbol necesitarías MODIFY en cada iteración
*    LOOP AT gt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>).
*      <fs_flight>-price = <fs_flight>-price * '0.9'.
*    ENDLOOP.
*
*    out->write( |--- PRECIOS CON DESCUENTO ---| ).
*    LOOP AT gt_flights INTO ls_flight_show.
*      out->write( |Vuelo { ls_flight_show-connection_id }: { ls_flight_show-price } { ls_flight_show-currency_code }| ).
*    ENDLOOP.

    "═══════════════════════════════════════════════════════════
    " EJEMPLO 4: ASSIGN DINÁMICO - Por nombre de campo
    "═══════════════════════════════════════════════════════════
    out->write( |=== EJEMPLO 4: ASSIGN Dinámico ===| ).

    DATA(gs_customer) = VALUE /dmo/customer(  customer_id  = '000001'
                                              first_name   = 'Laura'
                                              last_name    = 'Martinez'
                                              city         = 'Madrid'
                                              country_code = 'ES' ).

    " El nombre del campo viene de una variable
    DATA(lv_field_name) = 'FIRST_NAME'.

    FIELD-SYMBOLS <fs_generic> TYPE data. "tipo genérico

    ASSIGN gs_customer-(lv_field_name) TO <fs_generic>.

    IF <fs_generic> IS ASSIGNED.
      out->write( |Campo { lv_field_name }: { <fs_generic> }| ).
      <fs_generic> = 'María'.
      UNASSIGN <fs_generic>.
    ENDIF.

    out->write( |Nombre modificado: { gs_customer-first_name }| ).

    "═══════════════════════════════════════════════════════════
    " EJEMPLO 5: ASSIGN DINÁMICO - Varios campos
    "═══════════════════════════════════════════════════════════
    out->write( |=== EJEMPLO 5: Múltiples Campos Dinámicos ===| ).

    " Usar conversión a string para compatibilidad

    DATA lt_field_names TYPE TABLE OF string. "genérico

    lt_field_names = VALUE #( ( CONV string( 'FIRST_NAME' ) )
                              ( CONV string( 'LAST_NAME' ) )
                              ( CONV string( 'CITY' ) ) ).

    LOOP AT lt_field_names INTO DATA(lv_field).
      ASSIGN gs_customer-(lv_field) TO <fs_generic>.
      IF <fs_generic> IS ASSIGNED.
        out->write( |{ lv_field }: { <fs_generic> }| ).
        UNASSIGN <fs_generic>.
      ENDIF.
    ENDLOOP.

    "═══════════════════════════════════════════════════════════
    " EJEMPLO 6: OBJETO ANÓNIMO con SELECT
    "═══════════════════════════════════════════════════════════
    out->write( |=== EJEMPLO 6: Objeto Anónimo con SELECT ===| ).

    " Crear tabla interna anónima directamente en SELECT
    SELECT *
      FROM /dmo/carrier
      INTO TABLE NEW @DATA(lr_carriers)
      UP TO 5 ROWS.

    " Para usarla, desreferenciar
    out->write( |Aerolíneas encontradas: { lines( lr_carriers->* ) }| ).

    LOOP AT lr_carriers->* ASSIGNING FIELD-SYMBOL(<fs_carr>).
      out->write( |{ <fs_carr>-carrier_id }: { <fs_carr>-name }| ).
    ENDLOOP.


    "═══════════════════════════════════════════════════════════
    " EJEMPLO 7: CASO PRÁCTICO PROG DINÁMICA - Reporte Configurable
    "═══════════════════════════════════════════════════════════
    out->write( |=== EJEMPLO 7: Reporte Configurable ===| ).

    " Usuario selecciona qué campos quiere ver
    " Usar conversión a string para compatibilidad

    DATA lt_selected_fields TYPE TABLE OF string.

    lt_selected_fields = VALUE #( ( CONV string( 'CARRIER_ID' ) )
                                  ( CONV string( 'CONNECTION_ID' ) )
                                  ( CONV string( 'PRICE' ) ) ).

    " Leer datos
    SELECT * FROM /dmo/flight
      WHERE carrier_id = 'LH'
      INTO TABLE @DATA(lt_flights_report)
      UP TO 3 ROWS.

    " Mostrar solo los campos seleccionados
    DATA lv_line_number TYPE i VALUE 0.

    LOOP AT lt_flights_report ASSIGNING FIELD-SYMBOL(<fs_flight_rep>).
      lv_line_number = lv_line_number + 1.
      out->write( |--- Registro { lv_line_number } ---| ). "Para el registro

      LOOP AT lt_selected_fields INTO DATA(lv_selected_field).
        ASSIGN <fs_flight_rep>-(lv_selected_field) TO <fs_generic>. "Elección Dinámica
        IF <fs_generic> IS ASSIGNED.
          out->write( |  { lv_selected_field }: { <fs_generic> }| ).
          UNASSIGN <fs_generic>.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    "═══════════════════════════════════════════════════════════
    " EJEMPLO 8: SELECT DINÁMICO
    "═══════════════════════════════════════════════════════════
    out->write( |=== EJEMPLO 8: SELECT Dinámico ===| ).

    " El nombre de la tabla se decide en tiempo de ejecución
    DATA(lv_table_name) = '/DMO/CARRIER'.

    " SELECT dinámico - NO puede usar inline declaration
    " Primero declaramos la tabla con tipo genérico
    DATA lt_dynamic_data TYPE STANDARD TABLE OF /dmo/carrier WITH EMPTY KEY.

    SELECT *
      FROM (lv_table_name)
      INTO TABLE @lt_dynamic_data
      UP TO 3 ROWS.

    out->write( |Registros leídos de { lv_table_name }: { lines( lt_dynamic_data ) }| ).

    " Mostrar los datos
    LOOP AT lt_dynamic_data ASSIGNING FIELD-SYMBOL(<fs_dynamic>).
      ASSIGN COMPONENT 'CARRIER_ID' OF STRUCTURE <fs_dynamic> TO <fs_generic>.
      IF <fs_generic> IS ASSIGNED.
        out->write( |Carrier ID: { <fs_generic> }| ).
        UNASSIGN <fs_generic>.
      ENDIF.
    ENDLOOP.

**********Solución a variación de nombre de tabla y tipo
    out->write( |=== EJEMPLO 8: SELECT Verdaderamente Dinámico ===| ).

    DATA(lv_table_name2) = '/DMO/CUSTOMER'.

    "Declarar field symbol genérico
    FIELD-SYMBOLS <ft_data> TYPE ANY TABLE.

    "Crear tabla dinámica
    DATA lr_table TYPE REF TO data.
    CREATE DATA lr_table TYPE STANDARD TABLE OF (lv_table_name2).

    "Asignar al field symbol
    ASSIGN lr_table->* TO <ft_data>.

    "SELECT dinámico
    SELECT * FROM (lv_table_name2)
      INTO TABLE @<ft_data>
      UP TO 5 ROWS.

    out->write( |Tabla: { lv_table_name2 }| ).
    out->write( |Registros: { lines( <ft_data> ) }| ).

    LOOP AT <ft_data> ASSIGNING FIELD-SYMBOL(<fs>).
      out->write( <fs> ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
