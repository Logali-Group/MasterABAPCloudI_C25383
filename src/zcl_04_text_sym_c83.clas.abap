CLASS zcl_04_text_sym_c83 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_04_text_sym_c83 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    "Text symbols
*   out->write( text-001 ).
*   out->write( text-002 ).

    "Funciones de Longitud
*  "strlen() and numofchar
*   DATA(lv_num) = strlen( 'Logali Group' ). "longitud del string
*   out->write( lv_num ).
*
*   lv_num = numofchar( 'Logali Group' ). "num de caracteres del string
*   out->write( lv_num ).

    "Funciones de Búsqueda (count)

*    DATA lv_string TYPE string VALUE 'LOGALI local'.
*    DATA(lv_num)   = strlen( lv_string ).
    "count

*    lv_num = count( val = lv_string sub = 'LO' ). "encuentra el número de coincidencias con el patron exacto
*    out->write( lv_num ).
*
*    lv_num = count_any_of( val = lv_string sub = 'LO' ). "encuentra las coincidencias no importa el orden
*    out->write( lv_num ). "encuentra el caracter L dos veces y O una vez
*
*    lv_num = count_any_not_of( val = lv_string sub = 'LO'  ).
*    out->write( lv_num ). "devuelve todas las posiciones que no coinciden con el patrón

*    "FIND
*    lv_num = find( val = lv_string sub = 'LI' ).
*    out->write( lv_num ).
*
*    lv_num = find_any_of( val = lv_string sub = 'LI' ).
*    out->write( lv_num ).
*
*    lv_num = find_any_not_of( val = lv_string sub = 'LI' ).
*    out->write( lv_num ).

"Funciones de procesamiento

   DATA lv_string TYPE string VALUE ' ¡Logali Group! Welcome to ABAP Cloud Master  '.

   "Change Case of characters
*   out->write( |TO_UPPER         = {   to_upper(  lv_string ) } | ).
*   out->write( |TO_LOWER         = {   to_lower(  lv_string ) } | ).
*   out->write( |TO_MIXED         = {   to_mixed(  lv_string ) } | ).
*   out->write( |FROM_MIXED       = { from_mixed(  lv_string ) } | ).

   out->write( |REVERSE             = {  reverse( lv_string ) } | ).
   out->write( |SHIFT_LEFT  (places)= {  shift_left(  val = lv_string places   = 5  ) } | ).
   out->write( |SHIFT_RIGHT (places)= {  shift_right( val = lv_string places   = 5  ) } | ).
   out->write( |SHIFT_LEFT  (circ)  = {  shift_left(  val = lv_string circular = 5  ) } | ).
   out->write( |SHIFT_RIGHT (circ)  = {  shift_right( val = lv_string circular = 5  ) } | ).

  ENDMETHOD.

ENDCLASS.
