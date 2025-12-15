CLASS zcl_sql_functions_c383 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_functions_c383 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    INSERT zdemo_exp_c383 FROM @( VALUE #( id = 'L'
*                                       num1 = 15
*                                       num2 = 8
*                                       char1 = 'aaBBCcDde'
*                                       char2 = '123456'
*                                       dec3 = '160.934'
*                                       amount = '100.00'
*                                       currency = 'USD' ) ).


* Numeric Functions

*DATA lv_decimal TYPE p LENGTH 5 DECIMALS 2 VALUE '17.82'.
*
*SELECT SINGLE FROM zdemo_exp_c383
*       FIELDS id,
*              num1,
*              num2,
*              CAST( num1 AS FLTP ) / CAST( num2 AS FLTP ) AS ratio,
*              division( num1, num2, 2 ) AS division,
*              div( num1, num2 ) AS div,
*              mod( num1, num2 ) AS mod,
*              num1 + num2 + @lv_decimal AS sum,
*              abs( num1 + num2 ) AS abs,
*              ceil( @lv_decimal ) AS ceil,
*              floor( @lv_decimal ) AS floor,
*              round( @lv_decimal, 2 ) AS round
*
*       WHERE id = 'L'
*       INTO @DATA(ls_results).
*
*IF sy-subrc = 0.
*  out->write( ls_results ).
*ENDIF.

** String Functions
*
*SELECT SINGLE FROM zdemo_exp_c383
*       FIELDS id,
*              char1,
*              char2,
*              left( char1, 2 ) AS left,
*              right( char1, 2 ) AS right,
*              lpad( char2, 18, '0' ) AS lpad,
*              rpad( char2, 18, '0' ) AS rpad,
*              ltrim( char1, 'B' ) AS ltrim,
*              rtrim( char1, 'e' ) AS rtrim,
*              instr( char1, 'BC' ) AS instr,
*              substring( char1, 3, 2 ) AS substring,
*              length( char1 ) AS length,
*              replace( char1, 'BC', '__' ) AS replace,
*              upper( char1 ) AS upper,
*              lower( char1 ) AS lower
*
*       WHERE id = 'L'
*       INTO @DATA(ls_results).
*
*IF sy-subrc = 0.
*  out->write( ls_results ).
*ENDIF.


* Concat functions

SELECT SINGLE FROM zdemo_exp_c383
       FIELDS id,
              char1,
              char2,
              concat( char1, char2 ) as concat,
              concat_with_space( char1, char2, 2 ) as concatSpace,
              char1 && char2 && 'Logali' as concatman

       WHERE id = 'L'
       INTO @DATA(ls_results).

IF sy-subrc = 0.
  out->write( ls_results ).
ENDIF.


** Function conversions
*
*CONSTANTS lc_currency type c LENGTH 3 VALUE 'EUR'.
*
*SELECT SINGLE FROM zdemo_exp_c383
*       FIELDS id,
*              dec3 AS currentQuantity,
*              'MI' AS currentunit,
*
*              unit_conversion( quantity = dec3,
*                              source_unit = unit`MI`,
*                              target_unit = unit`KM`,
*                              on_error = @sql_unit_conversion=>c_on_error-set_to_null ) AS ConvertedQuantity,
*              'KM' AS ConvertedUnit,
*
*
*              currency_conversion( amount = amount,
*                                  source_currency = currency,
*                                  target_currency = @lc_currency,
*                                  exchange_rate_date = @( cl_abap_context_info=>get_system_date( ) ),
*                                  round = 'X',
*                                  on_error = @sql_currency_conversion=>c_on_error-set_to_null ) as convertedAmount,
*
*              @lc_currency as convertedCurr
*
*
*       WHERE id = 'L'
*       INTO @DATA(ls_results).
*
*    IF sy-subrc = 0.
*      out->write( ls_results ).
*    ENDIF.


*    "Date Functions
*    DELETE FROM zdemo_exp_lgl.
*    INSERT zdemo_exp_lgl FROM  @( VALUE #( id    = 'L'
*                                           dats1 = '20300101'
*                                           dats2 = '20310101'
*                                           datn1 = '20400101'
*                                           datn2 = '20400101' ) ).
*
*    SELECT SINGLE FROM zdemo_exp_lgl
*           FIELDS id,
*                  dats1,
*                  dats2,
*                  datn1,
*                  datn2,
*
*                  dats_is_valid( dats1 ) AS valid,
*
*                  dats_days_between( dats1, dats2 ) AS days_between_d,
*                  datn_days_between( datn1, datn2 ) AS dats_between_n,
*
*                  dats_add_days( dats1, 30 ) AS add_days_d,
*                  datn_add_days( datn1, 30 ) AS add_days_n,
*
*                  dats_add_months( dats1, -2 ) AS add_months_d,
*                  datn_add_months( datn1, -2 ) AS add_months_n,
*
*                  dats_from_datn( datn1 ) AS dats_from_n,
*                  dats_to_datn( dats1 ) AS dats_to_n
*
*            WHERE id EQ 'L'
*            INTO @DATA(ls_result).
*
*    IF sy-subrc EQ 0.
*      out->write( ls_result ).
*    ENDIF.

**Timestamp functions
*
*    DATA(lv_seconds) = 3600.
*
*    GET TIME STAMP FIELD DATA(lv_timestamp).
*
*    DELETE FROM zdemo_exp_lgl.
*    INSERT zdemo_exp_lgl FROM @( VALUE #( id         = 'L'
*                                          num1       = lv_seconds
*                                          timestamp1 = lv_timestamp ) ).
*
*    SELECT SINGLE FROM zdemo_exp_lgl
*           FIELDS id,
*                  num1,
*                  timestamp1,
*                  tstmp_is_valid( timestamp1 ) AS valid,
*                  tstmp_seconds_between( tstmp1 = tstmp_current_utctimestamp( ),
*                                        tstmp2 = tstmp_add_seconds( tstmp   = timestamp1,
*                                                                    seconds = CAST( num1 AS DEC( 15,0 ) ) ) ) AS difference
*           WHERE id EQ 'L'
*           INTO @DATA(ls_result).
*
*    IF sy-subrc EQ 0.
*      out->write( ls_result ).
*    ENDIF.

  ENDMETHOD.

ENDCLASS.
