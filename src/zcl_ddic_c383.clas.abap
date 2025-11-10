CLASS zcl_ddic_c383 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ddic_c383 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(ls_employee) = VALUE yst_employee_c383( employee_id = 1
                                                 name = 'Mateo'
                                                 last_name = 'García'
                                                 age = 30
                                                 sex = 'M'
                                                 address-address_id  = 1
                                                 address-street_name = 'Street 1'
                                                 address-int_number  = 2
                                                 address-city        = 'New York'
                                                 address-country     = 'US' ).

    out->write( ls_employee ).

    DATA(ls_employee2) = VALUE yst_employee2_c383( employee_id = 1
                                                 name = 'Mateo'
                                                 last_name = 'García'
                                                 age = 30
                                                 sex = 'M'
                                                 address_id  = 1
                                                 street_name = 'Street 1'
                                                 int_number  = 2
                                                 city        = 'New York'
                                                 country     = 'US' ).

    out->write( ls_employee2 ).


    DATA(lt_empl_addr) = VALUE ytt_emp_address_c383(  (   address_id  = 1
                                                         street_name = 'Street 1'
                                                         int_number  = 2
                                                         city        = 'New York'
                                                         country     = 'US' )
                                                      (   address_id  = 2
                                                         street_name = 'Street 2'
                                                         int_number  = 12
                                                         city        = 'New York'
                                                         country     = 'US' )   ).

    out->write( lt_empl_addr ).


    DATA(ls_employee3) = VALUE yst_employee3_c383(  employee_id = 1
                                                     name = 'Mateo'
                                                     last_name = 'García'
                                                     age = 30
                                                     sex = 'M' ).

   ls_employee3-address = Value #( ( address_id  = 1
                                     street_name = 'Street 1'
                                     int_number  = 2
                                     city        = 'New York'
                                     country     = 'US' )
                                    ( address_id  = 2
                                     street_name = 'Street 2'
                                     int_number  = 3
                                     city        = 'New York'
                                     country     = 'US' )  ).

    out->write( ls_employee3 ).


  ENDMETHOD.

ENDCLASS.
