CLASS zcl_05_ope_ch_c83 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_ope_ch_c83 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

"   DATA lv_string TYPE string VALUE ' ¡Logali Group! Welcome to ABAP Cloud Master  '.

*" Extract a Substring
*   out->write( |SUBSTRING        = {  substring( val = lv_string off = 9 len = 6 ) } | ).
*   out->write( |SUBSTRING_FROM   = {  substring_from( val = lv_string sub = 'ABAP'     ) } | ).
*   out->write( |SUBSTRING_AFTER  = {  substring_after( val = lv_string sub = 'ABAP'     ) } | ).
*   out->write( |SUBSTRING_TO     = {  substring_to( val = lv_string sub = 'ABAP'     ) } | ).
*   out->write( |SUBSTRING_BEFORE = {  substring_before( val = lv_string sub = 'ABAP'     ) } | ).

*   " Condense, REPEAT and Segment
*   out->write( |CONDENSE         = {   condense( val = lv_string ) } | ).
*   out->write( |REPEAT           = {   repeat(   val = lv_string occ = 2 ) } | ).
*   out->write( |SEGMENT1         = {   segment(  val = lv_string sep = '!' index = 1 ) } |  ).
*   out->write( |SEGMENT2         = {   segment(  val = lv_string sep = '!' index = 2 ) } |  ).

"PCRE - REGEX - Expresiones regulares

*  "Contains
*   DATA: lv_text    TYPE string,
*         lv_pattern TYPE string.
*
*   lv_text = 'The employee`s number is: 123-456-7890'.
*   lv_pattern = `\d{3}-\d{3}-\d{4}`. " Patrón para un número de teléfono
*
*   IF contains( val = lv_text pcre = lv_pattern ).
*     out->write( 'The text contains a phone number' ).
*   ELSE.
*     out->write( 'The text doesn`t contains a phone number' ).
*   ENDIF.
*
*   DATA(lv_number) = match( val = lv_text pcre = lv_pattern occ = 1 ).
*   out->write( lv_number ).

* "Contains
*   DATA: lv_string  TYPE string,
*         lv_pattern TYPE string.
*
*   lv_string = 'Please contact us at support@logali.com for more information'.
*   lv_pattern = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b`. " regex for a email
*
*   IF contains( val = lv_string pcre = lv_pattern ). "verdadero
*     out->write( 'The text contains an email address' ).
*
*     DATA(lv_count) = count( val = lv_string pcre = lv_pattern )." cuantas veces hay coincidencias
*     out->write( lv_count ).
*
*     DATA(lv_pos) = find( val = lv_string pcre = lv_pattern occ = 1 ). " dónde está en lv_String
*     out->write( lv_pos ).
*
*   ELSE.
*     out->write( 'The text does not contain an email address' ).
*   ENDIF.

"&&
"||
*  "Concatenación
*   DATA: lv_string_a TYPE string VALUE 'Welcome to Logali Group',
*         lv_string_b TYPE string.
*
*   "si no le especifico el espacio, quedan juntos
*   lv_string_b = 'ABAP' && ` ` && 'Student'.
*
*
*   DATA(lv_fin_string) = | Concatenation 1: { lv_string_a } / { lv_string_b } |. "recomendada
*   out->write( lv_fin_string ).
*
*
*   CONCATENATE lv_string_a lv_string_b INTO DATA(lv_fin_string2) SEPARATED BY ' '. "or space
*   out->write( | Concatenation 2: { lv_fin_string2 } | ).

*   "Insert
*   DATA(lv_ins_string) = insert( val = '123CLIENT02' sub = 'INV' off = 3 ).
*   out->write(  lv_ins_string  ).
*
*   lv_ins_string = insert( val = '123CLIENT02' sub = `INV` ).
*   out->write(  lv_ins_string  ).

*"  "Overlay
*   DATA(lv_company) = '--------------->Logali Group'.
*   DATA(lv_name) = 'ABAP_Class                        '.
*
*   OVERLAY lv_name WITH lv_company.
*   out->write( lv_name ).
*
*
*   DATA(lv_string) = 'a.b.c.a.b.c.A'.
*   DATA(lv_string2) = 'z.x.y.Z.x.y.z'.
*   OVERLAY lv_string WITH lv_string2 ONLY 'ab'.
*   out->write( lv_string ).

*  "SPLIT
*   DATA(lv_string1) = 'Logali-Group-SAP-Academy'.
*   out->write( lv_string1 ).
*
*   SPLIT lv_string1 AT '-' INTO DATA(gv_word1)
*                                DATA(gv_word2)
*                                DATA(gv_word3)
*                                DATA(gv_word4).
*
*   out->write( gv_word1 ).
*   out->write( gv_word2 ).
*   out->write( gv_word3 ).
*   out->write( gv_word4 ).

"SPLIT .... INTO TABLE

*" Reemplazar REPLACE
*  DATA(lv_replace) = 'Logali-Group-Academia-SAP'.
*  DATA(lv_sign) = '-'.
*
*  out->write( lv_replace ). "Valor Inicial

*  REPLACE '-' WITH '/' INTO lv_replace.
*  out->write( lv_replace ). "valor reemplazado el primero que encuentra

* REPLACE ALL OCCURRENCES OF '-' IN lv_replace WITH '/'.
* out->write( lv_replace ). "valor reemplazado todos

  "lv_replace = replace( val = lv_replace sub = lv_sign with = '/' occ = 0 ).

*  lv_replace = replace( val = lv_replace  with = `#` off = 5 len = 3  ).
*  out->write( lv_replace ).


*  "Funciones de comparación
*   DATA(lv_text) = 'This is an example text for SAP ABAP programming.'.
*   out->write( lv_text ).
*
*   " COMODINES:
*   " * = 0 o más caracteres
*   " + = 1 o más caracteres
*   " # = Exactamente 1 carácter
*
*   "CP (Contains Pattern) - Verifica si contiene el patrón
*   out->write( '--- Operador CP (Contains Pattern) ---' ).
*
*   IF lv_text CP '*SAP*'.
*     DATA(lv_match) = abap_true.
*     out->write( 'El texto contiene el patrón "SAP"' ).
*   ELSE.
*     lv_match = abap_false.
*     out->write( 'El texto NO contiene el patrón "SAP"' ).
*   ENDIF.
*
*   out->write( | | ).
*
*   " NP (Not contains Pattern) - Verifica si NO contiene el patrón
*   out->write( '--- Operador NP (Not contains Pattern) ---' ).
*   " El patrón 'g+' busca 'g' seguida de al menos 1 carácter
*   " En 'programming.' hay 'g.' que coincide con este patrón
*
*   IF lv_text NP '*g+*'.
*     out->write( 'El texto NO contiene el patrón "g+"' ).
*   ELSE.
*     out->write( 'El texto SÍ contiene el patrón "g+" (ej: "programming.")' ).
*   ENDIF.



"Expresiones Lógicas
*     =  EQ (igual)
*     <> NE (diferente)
*     <  LT (menor que)
*     >  GT (mayor que)
*     <= LE (menor o igual)
*     >= GE (mayor o igual)

*NOT - Niega la expresión
*AND - Ambas condiciones deben ser verdaderas
*OR - Al menos una condición debe ser verdadera

"Estructuras de control en ABAP

"Bifurcaciones (IF, CASE, SWITCH, COND)
"Bucles (DO, WHILE, LOOP, FOR)
"Control de flujo (CHECK)
"Manejo de excepciones (TRY-CATCH)


"IF

   DATA(lv_monto_compra) = 500.
   DATA(lv_descuento) = 0.

   IF lv_monto_compra >= 1000.
     lv_descuento = 10.  "10% de descuento
     out->write( |Monto: { lv_monto_compra } - Descuento: { lv_descuento }%| ).
   ELSEIF lv_monto_compra >= 500.
     lv_descuento = 5.   "5% de descuento
     out->write( |Monto: { lv_monto_compra } - Descuento: { lv_descuento }%| ).
   ELSE.
     out->write( |Monto: { lv_monto_compra } - Sin descuento| ).
   ENDIF.
   out->write( | | ).


  " 2. CASE - Determinar estado de orden de compra
   "=================================================================
   out->write( '=== CASE: ESTADO DE ORDEN DE COMPRA ===' ).

   DATA(lv_estado_orden) = 'A'. "A=Aprobada, P=Pendiente, R=Rechazada, E=Entregada

   CASE lv_estado_orden.
     WHEN 'A'.
       out->write( 'Estado: APROBADA - Proceder con la entrega' ).
     WHEN 'P'.
       out->write( 'Estado: PENDIENTE - Esperando aprobación' ).
     WHEN 'R'.
       out->write( 'Estado: RECHAZADA - Contactar con compras' ).
     WHEN 'E'.
       out->write( 'Estado: ENTREGADA - Orden completada' ).
     WHEN OTHERS.
       out->write( 'Estado: DESCONOCIDO - Verificar sistema' ).
   ENDCASE.
   out->write( | | ).

"DO/ENDDO

DATA(lv_numero_factura) = 10001.

DATA(lv_contador) = 0.

DO 5 TIMES.
  lv_contador = lv_contador + 1.
  out->write( |Factura { lv_contador }: FAC-{ lv_numero_factura }| ).
  lv_numero_factura = lv_numero_factura + 1.
ENDDO.

   out->write( | | ).
"WHILE

DATA(lv_deuda_total) = 5000.
DATA(lv_pago_acumulado) = 0.
DATA(lv_numero_pago) = 0.

WHILE lv_pago_acumulado < lv_deuda_total.
  lv_numero_pago = lv_numero_pago + 1.
  DATA(lv_pago) = 1500.
  lv_pago_acumulado = lv_pago_acumulado + lv_pago.

  out->write( |Pago { lv_numero_pago }: { lv_pago } - Acumulado: { lv_pago_acumulado }| ).
ENDWHILE.

"LOOP

TYPES: BEGIN OF ty_venta,
         vendedor TYPE string,
         monto    TYPE i,
       END OF ty_venta.

DATA: lt_ventas TYPE TABLE OF ty_venta.

lt_ventas = VALUE #(
  ( vendedor = 'Juan' monto = 1000 )
  ( vendedor = 'Maria' monto = 1500 )
  ( vendedor = 'Juan' monto = 2000 )
  ( vendedor = 'Maria' monto = 500 ) ).

DATA(lv_total_ventas) = 0.

LOOP AT lt_ventas INTO DATA(ls_venta). "recorrer
  lv_total_ventas = lv_total_ventas + ls_venta-monto.
  out->write( |{ ls_venta-vendedor }: { ls_venta-monto }| ).
ENDLOOP.


"CHECK
TYPES: BEGIN OF ty_factura,
            numero TYPE string,
            estado TYPE c LENGTH 1, "A=Aprobada, P=Pendiente
            monto  TYPE i,
          END OF ty_factura.

   DATA: lt_facturas TYPE TABLE OF ty_factura.

   lt_facturas = VALUE #(
     ( numero = 'FAC-001' estado = 'A' monto = 1000 )
     ( numero = 'FAC-002' estado = 'P' monto = 1500 )
     ( numero = 'FAC-003' estado = 'A' monto = 2000 )
     ( numero = 'FAC-004' estado = 'P' monto = 500 )
   ).
   LOOP AT lt_facturas INTO DATA(ls_factura).
     CHECK ls_factura-estado = 'A'. "Solo procesar aprobadas
     out->write( |Procesando: { ls_factura-numero } - Monto: { ls_factura-monto }| ).
   ENDLOOP.

"SWITCH

*DATA(lv_categoria) = 'ELECTRO'.
*
*DATA(lv_precio_producto) = 1000.
*
*DATA(lv_comision) = SWITCH decfloat34( lv_categoria
*                                         WHEN 'ELECTRO'   THEN lv_precio_producto * '0.15'
*                                         WHEN 'ROPA'      THEN lv_precio_producto * '0.10'
*                                         WHEN 'ALIMENTOS' THEN lv_precio_producto * '0.05'
*                                         ELSE                  lv_precio_producto * '0.03' ).

"TRY-CATCH

 out->write( '=== TRY: CONVERTIR MONTO DE STRING A NÚMERO ===' ).

   DATA(lv_monto_texto) = '1500.50'. "Cantidad como texto
   DATA: lv_monto_numero TYPE p DECIMALS 2.

   TRY.
       lv_monto_numero = lv_monto_texto.
       out->write( |✓ Conversión exitosa: { lv_monto_numero }| ).
       "Validar que el monto sea positivo
       IF lv_monto_numero <= 0.
         out->write( '✗ Error: El monto debe ser mayor a cero' ).
       ELSE.
         out->write( |Monto válido para procesamiento: { lv_monto_numero }| ).
       ENDIF.
     CATCH cx_sy_conversion_error INTO DATA(lx_error).
       out->write( |✗ Error de conversión: { lx_error->get_text( ) }| ).
   ENDTRY.

   out->write( | | ).

   "Ejemplo con error
   out->write( '--- Ejemplo con dato inválido ---' ).
   lv_monto_texto = 'ABC123'. "Texto inválido
   TRY.
       lv_monto_numero = lv_monto_texto.
       out->write( |Conversión exitosa: { lv_monto_numero }| ).
     CATCH cx_sy_conversion_error INTO lx_error.
       out->write( |✗ No se pudo convertir "{ lv_monto_texto }" a número| ).
       out->write( |  Razón: { lx_error->get_text( ) }| ).
   ENDTRY.

















  ENDMETHOD.

ENDCLASS.
