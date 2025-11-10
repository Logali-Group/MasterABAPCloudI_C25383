CLASS zcl_ddic_c383c25 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ddic_c383c25 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(ls_employee) = value zst_employee_c83( employee_id = 1
                                                name        = 'Mat'
                                                last_name   = 'García'
                                                age         = 30
                                                sex         = 'M'
                                                address_id = 1
                                                street_name = 'Street 1'
                                                int_number  = 2
                                                city        = 'NY'
                                                ).

    out->write( ls_employee ).

DATA(lt_emp_addr) = VALUE ztt_emp_address_c83( (  address_id = 1
                                                street_name = 'Street 1'
                                                int_number  = 2
                                                city        = 'NY' )

                                              (    address_id = 1
                                                street_name = 'Street 1'
                                                int_number  = 2
                                                city        = 'NY' )  ).

   out->write( lt_emp_addr ).

  ENDMETHOD.

ENDCLASS.
