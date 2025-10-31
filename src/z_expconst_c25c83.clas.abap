CLASS z_expconst_c25c83 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_expconst_c25c83 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*"NEW -
*"CREATE OBJECT - CREATE DATA
*
*"REF
*    TYPES: BEGIN OF ty_config,
*             parametro TYPE string,
*             valor TYPE string,
*           END OF ty_config.
*
*    DATA lt_configuraciones TYPE TABLE OF ty_config.
*
*    lt_configuraciones = VALUE #(
*      ( parametro = 'max_usuarios' valor = '100' )
*      ( parametro = 'timeout' valor = '30' )
*      ( parametro = 'modo_debug' valor = 'ON' )
*    ).
*    out->write( |Ejemplo de REF - Obtener referencias| ).
*    out->write( |=================================| ).
*
*    " REF con tabla interna - referencia al segundo registro
*    DATA(lr_config) = REF #( lt_configuraciones[ 2 ] ).
*    out->write( |Referencia al registro 2:| ).
*    out->write( |  Parámetro: { lr_config->parametro }| ).
*    out->write( |  Valor: { lr_config->valor }| ).
*
*    " Modificar a través de la referencia afecta al original
*    lr_config->valor = '60'.
*
*    out->write( |Después de modificar vía referencia:| ).
*    out->write( lt_configuraciones ).
*
*    out->write( |\n| ).
*    out->write( |DIFERENCIA NEW vs REF:| ).
*    out->write( | NEW → Crea algo NUEVO en memoria| ).
*    out->write( | REF → Apunta a algo que YA EXISTE| ).

*"CONV
*    out->write( |Ejemplo de CONV - Conversiones de tipo| ).
*    out->write( |===================================| ).
*
*    " CASO: Cálculo de precio con IVA
*    DATA lv_precio TYPE p LENGTH 10 DECIMALS 2 VALUE '100.00'.
*    DATA lv_iva TYPE p LENGTH 5 DECIMALS 2 VALUE '0.21'.
*
*    " Sin CONV (necesitas variable auxiliar)
*    " DATA lv_mensaje TYPE string.
*    " DATA lv_total_aux TYPE p LENGTH 10 DECIMALS 2.
*    " lv_total_aux = lv_precio * ( 1 + lv_iva ).
*    " lv_mensaje = lv_total_aux.
*
*    " Con CONV (directo, sin variable auxiliar)
*    DATA(lv_mensaje) = |Precio final: { CONV string( lv_precio * ( 1 + lv_iva ) ) } EUR|.
*
*    out->write( lv_mensaje ).
*
*    " Otro ejemplo: convertir tabla SORTED a STANDARD
*    DATA lt_numeros_sorted TYPE SORTED TABLE OF i WITH NON-UNIQUE DEFAULT KEY.
*    lt_numeros_sorted = VALUE #( ( 3 ) ( 1 ) ( 4 ) ( 1 ) ( 5 ) ).
*
*    TYPES tt_numeros_standard TYPE STANDARD TABLE OF i WITH EMPTY KEY.
*    DATA(lt_numeros_standard) = CONV tt_numeros_standard( lt_numeros_sorted ).
*
*    out->write( |Tabla convertida de SORTED a STANDARD| ).
*    out->write( lt_numeros_standard ).
*
*    out->write( |\n| ).
*    out->write( |RESUMEN CONV:| ).
*    out->write( |• Convierte tipos sin variables auxiliares| ).
*    out->write( |• Código más limpio y directo| ).

*"EXACT
*
*
*    out->write( |Ejemplo de EXACT - Conversión segura| ).
*    out->write( |================================| ).
*
*    " CASO: Validación de cantidad de stock
*    DATA lv_stock_float TYPE f VALUE '150.00'.
*
*    TRY.
*        " EXACT valida que no haya decimales antes de convertir
*        DATA(lv_stock_int) = EXACT i( lv_stock_float ).
*        out->write( |Stock convertido correctamente: { lv_stock_int }| ).
*      CATCH cx_sy_conversion_error INTO DATA(lx_error).
*        out->write( |ERROR: { lx_error->get_text( ) }| ).
*    ENDTRY.
*
*    " Caso que falla
*    DATA lv_stock_decimal TYPE f VALUE '150.75'.
*
*    TRY.
*        lv_stock_int = EXACT i( lv_stock_decimal ).
*        out->write( |Stock: { lv_stock_int }| ).
*      CATCH cx_sy_conversion_error INTO lx_error.
*        out->write( |ERROR: No se puede convertir 150.75 a entero sin perder datos| ).
*    ENDTRY.
*
*    out->write( |\n| ).
*    out->write( |CONV vs EXACT:| ).
*    out->write( |• CONV → Convierte siempre (puede perder datos)| ).
*    out->write( |• EXACT → Solo si es exacto, sino excepción| ).
*    out->write( |• Usa EXACT cuando la precisión es crítica| ).


"FILTER
    " ============================================
    " PASO 1: Definir la estructura de producto
    " ============================================
    TYPES: BEGIN OF ty_producto,
             codigo   TYPE string,
             nombre   TYPE string,
             precio   TYPE p LENGTH 10 DECIMALS 2,
             stock    TYPE i,
             en_oferta TYPE abap_bool,
           END OF ty_producto.

    " ============================================
    " PASO 2: Declarar la tabla de inventario
    " CLAVE: La clave debe incluir los campos que vas a filtrar
    " ============================================
    DATA lt_inventario TYPE SORTED TABLE OF ty_producto
      WITH NON-UNIQUE KEY en_oferta stock.

    " ============================================
    " PASO 3: Llenar el inventario con datos
    " ============================================
    lt_inventario = VALUE #(
      ( codigo = 'LAP001' nombre = 'Laptop HP'      precio = 800  stock = 3  en_oferta = abap_true )
      ( codigo = 'MOU001' nombre = 'Mouse Logitech' precio = 25   stock = 50 en_oferta = abap_true )
      ( codigo = 'TEC001' nombre = 'Teclado Mecánico' precio = 120 stock = 15 en_oferta = abap_true )
      ( codigo = 'MON001' nombre = 'Monitor Samsung' precio = 300  stock = 8  en_oferta = abap_false )
      ( codigo = 'WEB001' nombre = 'Webcam HD'      precio = 60   stock = 2  en_oferta = abap_true )
      ( codigo = 'AUR001' nombre = 'Auriculares'    precio = 45   stock = 20 en_oferta = abap_false )
      ( codigo = 'IMP001' nombre = 'Impresora'      precio = 200  stock = 12 en_oferta = abap_true )
    ).

    " ============================================
    " Mostrar inventario completo
    " ============================================
    out->write( |========================================| ).
    out->write( |  INVENTARIO COMPLETO DE LA TIENDA     | ).
    out->write( |========================================| ).
    out->write( |Total de productos: { lines( lt_inventario ) }| ).
    out->write( |\n| ).

    LOOP AT lt_inventario INTO DATA(ls_prod).
      DATA(lv_oferta_texto) = COND string( WHEN ls_prod-en_oferta = abap_true
                                           THEN 'EN OFERTA'
                                           ELSE '' ).

      out->write( |{ ls_prod-codigo } - { ls_prod-nombre WIDTH = 20 } | &&
                  |Precio: { ls_prod-precio WIDTH = 6 } EUR | &&
                  |Stock: { ls_prod-stock WIDTH = 3 } { lv_oferta_texto }| ).
    ENDLOOP.
    out->write( |\n| ).
    " ===========================================
    " PASO 4: APLICAR FILTER
    " ============================================
    out->write( |========================================| ).
    out->write( |  FILTRADO: Ofertas con Stock > 5      | ).
    out->write( |========================================| ).

    " FILTER
    DATA(lt_productos_para_promocion) = FILTER #( lt_inventario
                                                    WHERE en_oferta = abap_true AND stock > 5 ).

    " ============================================
    " PASO 5: Mostrar resultados filtrados
    " ============================================
    out->write( |Productos encontrados: { lines( lt_productos_para_promocion ) }| ).
    out->write( |\n| ).

    IF lt_productos_para_promocion IS NOT INITIAL.
      out->write( |Estos productos van a la campaña de email:| ).
      LOOP AT lt_productos_para_promocion INTO DATA(ls_promo).
        out->write( |{ ls_promo-nombre } - { ls_promo-precio } EUR (Stock: { ls_promo-stock })| ).
      ENDLOOP.
    ELSE.
      out->write( |No hay productos que cumplan los criterios| ).
    ENDIF.

    " ============================================
    " PASO 6: Calcular valor total de la promoción
    " ============================================
    out->write( |\n| ).

    DATA(lv_valor_total) = REDUCE i( INIT sum = 0
                                      FOR prod IN lt_productos_para_promocion
                                      NEXT sum = sum + ( prod-precio * prod-stock ) ).

    out->write( |Valor total del inventario promocional: { lv_valor_total } EUR| ).
    " ============================================
    " RESUMEN
    " ============================================
    out->write( |\n| ).
    out->write( |========================================| ).
    out->write( |            RESUMEN FILTER              | ).
    out->write( |========================================| ).
    out->write( |De { lines( lt_inventario ) } productos totales| ).
    out->write( |Filtrados: { lines( lt_productos_para_promocion ) } cumplen criterios| ).
    out->write( |Criterio: EN OFERTA = Sí Y STOCK > 5| ).
    out->write( |\n| ).
    out->write( |¿Qué hace FILTER?| ).
    out->write( |-> Recorre toda la tabla automáticamente| ).
    out->write( |-> Aplica las condiciones del WHERE| ).
    out->write( |-> Crea una NUEVA tabla solo con los que cumplen| ).
    out->write( |\n| ).
    out->write( |SIN FILTER necesitarías:| ).
    out->write( |  LOOP AT lt_inventario INTO DATA(ls_item).| ).
    out->write( |    IF ls_item-en_oferta = abap_true AND ls_item-stock > 5.| ).
    out->write( |      APPEND ls_item TO lt_productos_para_promocion.| ).
    out->write( |    ENDIF.| ).
    out->write( |  ENDLOOP.| ).
    out->write( |\n| ).
    out->write( |CON FILTER: 1 sola línea| ).
  ENDMETHOD.


ENDCLASS.
