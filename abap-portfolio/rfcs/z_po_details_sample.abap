*&---------------------------------------------------------------------*
*& Function  Z_PO_DETAILS_SAMPLE
*& Sample RFC: return PO item details by PO number
*&---------------------------------------------------------------------*
*& Create structure ZPO_RFC_OUTPUT_SAMPLE with fields:
*& PO_NUMBER, VENDOR_NO, VENDOR_NAME, ITEM_NO, MATERIAL,
*& DESCRIPTION, MPN, PO_QTY, RECEIVED_QTY, STORAGE_LOC, UOM
*& Then create table type ZPO_RFC_OUTPUT_SAMPLE_T (line type = structure)
*&---------------------------------------------------------------------*
FUNCTION z_po_details_sample.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EBELN) TYPE  EBELN
*"  EXPORTING
*"     VALUE(ET_OUTPUT) TYPE  ZPO_RFC_OUTPUT_SAMPLE_T
*"----------------------------------------------------------------------

  TYPES: BEGIN OF ty_ekpo,
           ebeln TYPE ebeln,
           ebelp TYPE ebelp,
           matnr TYPE matnr,
           menge TYPE bstmg,
           lgort TYPE lgort_d,
           meins TYPE meins,
           lifnr TYPE lifnr,
         END OF ty_ekpo.

  TYPES: BEGIN OF ty_makt,
           matnr TYPE matnr,
           maktx TYPE maktx,
         END OF ty_makt.

  TYPES: BEGIN OF ty_mara,
           matnr TYPE matnr,
           mfrpn TYPE mfrpn,
         END OF ty_mara.

  TYPES: BEGIN OF ty_lfa1,
           lifnr TYPE lifnr,
           name1 TYPE name1_gp,
         END OF ty_lfa1.

  TYPES: BEGIN OF ty_eket,
           ebeln TYPE ebeln,
           ebelp TYPE ebelp,
           wemng TYPE menge_d,
         END OF ty_eket.

  DATA: lt_ekpo   TYPE STANDARD TABLE OF ty_ekpo,
        lt_makt   TYPE STANDARD TABLE OF ty_makt,
        lt_mara   TYPE STANDARD TABLE OF ty_mara,
        lt_lfa1   TYPE STANDARD TABLE OF ty_lfa1,
        lt_eket   TYPE STANDARD TABLE OF ty_eket,
        ls_ekpo   TYPE ty_ekpo,
        ls_makt   TYPE ty_makt,
        ls_mara   TYPE ty_mara,
        ls_lfa1   TYPE ty_lfa1,
        ls_eket   TYPE ty_eket,
        ls_output TYPE zpo_rfc_output_sample,
        lv_lifnr  TYPE lifnr,
        lv_recv   TYPE menge_d.

  CLEAR et_output[].

  SELECT SINGLE lifnr
    FROM ekko
    INTO lv_lifnr
    WHERE ebeln = iv_ebeln.

  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  SELECT ekpo~ebeln ekpo~ebelp ekpo~matnr ekpo~menge
         ekpo~lgort ekpo~meins ekko~lifnr
    INTO TABLE lt_ekpo
    FROM ekpo
    INNER JOIN ekko ON ekko~ebeln = ekpo~ebeln
    WHERE ekpo~ebeln = iv_ebeln.

  IF lt_ekpo IS INITIAL.
    RETURN.
  ENDIF.

  SELECT lifnr name1
    INTO TABLE lt_lfa1
    FROM lfa1
    FOR ALL ENTRIES IN lt_ekpo
    WHERE lifnr = lt_ekpo-lifnr.

  SELECT matnr maktx
    INTO TABLE lt_makt
    FROM makt
    FOR ALL ENTRIES IN lt_ekpo
    WHERE matnr = lt_ekpo-matnr
      AND spras = sy-langu.

  SELECT matnr mfrpn
    INTO TABLE lt_mara
    FROM mara
    FOR ALL ENTRIES IN lt_ekpo
    WHERE matnr = lt_ekpo-matnr.

  SELECT ebeln ebelp wemng
    INTO TABLE lt_eket
    FROM eket
    WHERE ebeln = iv_ebeln.

  LOOP AT lt_ekpo INTO ls_ekpo.
    CLEAR ls_output.

    ls_output-po_number   = ls_ekpo-ebeln.
    ls_output-vendor_no   = ls_ekpo-lifnr.
    ls_output-item_no     = ls_ekpo-ebelp.
    ls_output-material    = ls_ekpo-matnr.
    ls_output-po_qty      = ls_ekpo-menge.
    ls_output-storage_loc = ls_ekpo-lgort.
    ls_output-uom         = ls_ekpo-meins.

    READ TABLE lt_lfa1 INTO ls_lfa1 WITH KEY lifnr = ls_ekpo-lifnr.
    IF sy-subrc = 0.
      ls_output-vendor_name = ls_lfa1-name1.
    ENDIF.

    READ TABLE lt_makt INTO ls_makt WITH KEY matnr = ls_ekpo-matnr.
    IF sy-subrc = 0.
      ls_output-description = ls_makt-maktx.
    ENDIF.

    READ TABLE lt_mara INTO ls_mara WITH KEY matnr = ls_ekpo-matnr.
    IF sy-subrc = 0.
      ls_output-mpn = ls_mara-mfrpn.
    ENDIF.

    CLEAR lv_recv.
    LOOP AT lt_eket INTO ls_eket
      WHERE ebeln = ls_ekpo-ebeln
        AND ebelp = ls_ekpo-ebelp.
      lv_recv = lv_recv + ls_eket-wemng.
    ENDLOOP.
    ls_output-received_qty = lv_recv.

    APPEND ls_output TO et_output.
  ENDLOOP.

ENDFUNCTION.
