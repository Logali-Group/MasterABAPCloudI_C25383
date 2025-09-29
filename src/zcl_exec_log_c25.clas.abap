CLASS zcl_exec_log_c25 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_exec_log_c25 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'This is my first class in ABAP' ).

*esto es un comment

    "ABAP Built-in

    DATA: lv_string TYPE string,
          lv_int    TYPE i VALUE 20251212,
          lv_date   TYPE d,
          lv_dec    TYPE p LENGTH 8 DECIMALS 2 VALUE '202501.11',
          lv_car    TYPE c LENGTH 10 VALUE 'Logali'.


    lv_string = '20251212'.
    lv_date   = '20251212'.
    lv_int    = '1234'.

    out->write(  lv_string ).
    out->write(  lv_int ).
    out->write(  lv_date ).
    out->write(  lv_dec ).
    out->write(  lv_car ).


    "TYPES
    TYPES: BEGIN OF lty_employee,
             id   TYPE i,
             name TYPE string,
             age  TYPE i,
    END OF lty_employee.

DATA ls_employee TYPE lty_employee.

ls_employee = VALUE #( id  = 12234
                       name = 'Laura'
                       age  = 28  ).


out->write( |ID: { ls_employee-id }, Nombre: { ls_employee-name }, Edad: { ls_employee-age }| ).




    " ABAP Dictionary

" Reference

DATA: lvr_int TYPE REF TO i.

DATA lvr_int1 LIKE lvr_int.

DATA lo_ref TYPE REF TO zcl01_hello_world.


"Constants
CONSTANTS:lc_const TYPE c LENGTH 6 VALUE 'Logali'.

"lc_const = 'als'.


"Inline Declarations
DATA(lv_str) = `Alejandro`.
DATA(lv_str2) = 'Laura'.
DATA(lv_var) = 4 + 7.
out->write( lv_var ).






  ENDMETHOD.

ENDCLASS.
