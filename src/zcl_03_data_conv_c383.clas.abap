CLASS zcl_03_data_conv_c383 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_03_data_conv_c383 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*  DATA: lv_string TYPE string VALUE `12345`,
*        lv_int    TYPE i.
*
*  DATA: lv_date    TYPE d,
*        lv_decimal TYPE p LENGTH 3 DECIMALS 2.

*   lv_int = lv_string.
*
*   out->write( 'OK' ). "XXXXXXX
*   out->write( lv_int ).
*
*   lv_string = `20230101`.
*   lv_date = lv_string.
*
*
*   out->write( |String value: { lv_string }| ).
*   out->write( |Date Value: { lv_date DATE = USER }| ).

*  "Conversión de número entero a decimal, no permitido por exceso de longitud del tipo
*      lv_string  = `1234678`.
*      lv_decimal = lv_string.
*      out->write( lv_decimal ).

    "usando el valor de fecha del sistema
*      lv_date = cl_abap_context_info=>get_system_date(  ).
*      out->write( lv_date ).

    "1. Truncamiento de Caracteres (Pérdida de datos)
    DATA: lv_string TYPE string VALUE `LOGALI`,
          lv_char   TYPE c LENGTH 3.

    " Se intenta guardar "LOGALI" (6 caracteres) en una variable de solo 2
    lv_char = lv_string.
    out->write( lv_char ).

*"2. Redondeo
* DATA: lv_decimal TYPE p LENGTH 3 DECIMALS 2.
*
*   " Caso A: 1 / 6 = 0.166666...
*   lv_decimal = 1 / 6.
*   out->write( lv_decimal ).
*
*   " Caso B: 1 / 12 = 0.083333...
*   lv_decimal = 1 / 12.
*   out->write( |1 / 12 is rounded to { lv_decimal }| ).

    "Conversión de tipo forzado
*    DATA(lv_date) = '20250101'.
*    out->write( lv_date ).
*
*    DATA(lv_date2) = CONV d( '20250101' ).
*    out->write( lv_date2 ).

  ENDMETHOD.

ENDCLASS.
