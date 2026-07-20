*&---------------------------------------------------------------------*
*& Function  Z_PO_OPEN_DOCS_SAMPLE
*& Sample RFC style: enrich purchasing document rows
*& (Sanitized pattern similar to ME2M-based RFC work)
*&---------------------------------------------------------------------*
*& Expected input table row fields (example):
*& EBELN, EBELP, MENGE, NETWR, MGLIEF, WTLIEF
*& Output structure should also include:
*& MGINV, WTINV, RCVDQTY, RCVDVALUE, FIRST_ETA, LAST_ETA
*&---------------------------------------------------------------------*
FUNCTION z_po_open_docs_sample.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      ITAB STRUCTURE  ZPO_OPEN_DOCS_SAMPLE
*"----------------------------------------------------------------------

  TYPES: BEGIN OF ty_eket,
           ebeln TYPE ebeln,
           ebelp TYPE ebelp,
           eindt TYPE eindt,
         END OF ty_eket.

  DATA: ls_wa     TYPE zpo_open_docs_sample,
        lt_eket   TYPE TABLE OF ty_eket,
        ls_eket   TYPE ty_eket,
        lv_mglief TYPE menge_d,
        lv_wtlief TYPE netwr.

  FIELD-SYMBOLS: <fs_mginv> TYPE ANY,
                 <fs_wtinv> TYPE ANY.

  LOOP AT itab INTO ls_wa.
    CLEAR: lt_eket[], ls_eket, lv_mglief, lv_wtlief.
    UNASSIGN: <fs_mginv>, <fs_wtinv>.

    " Keep original still-to-be-delivered values
    lv_mglief = ls_wa-mglief.
    lv_wtlief = ls_wa-wtlief.

    " In real ME2M capture these come from ALV fields MGINV / WTINV.
    " Here we keep placeholders so the mapping pattern is clear.
    ASSIGN COMPONENT 'MGINV' OF STRUCTURE ls_wa TO <fs_mginv>.
    IF <fs_mginv> IS ASSIGNED.
      ls_wa-mginv = <fs_mginv>.
    ENDIF.

    ASSIGN COMPONENT 'WTINV' OF STRUCTURE ls_wa TO <fs_wtinv>.
    IF <fs_wtinv> IS ASSIGNED.
      ls_wa-wtinv = <fs_wtinv>.
    ENDIF.

    " Received qty/value from original deliver values
    ls_wa-rcvdqty   = ls_wa-menge - lv_mglief.
    ls_wa-rcvdvalue = ls_wa-netwr - lv_wtlief.

    " Populate still-to-be-delivered with invoice values
    ls_wa-mglief = ls_wa-mginv.
    ls_wa-wtlief = ls_wa-wtinv.

    " First / last ETA from schedule lines
    SELECT ebeln ebelp eindt
      FROM eket
      INTO CORRESPONDING FIELDS OF TABLE lt_eket
      WHERE ebeln = ls_wa-ebeln
        AND ebelp = ls_wa-ebelp.

    SORT lt_eket ASCENDING BY eindt.
    READ TABLE lt_eket INTO ls_eket INDEX 1.
    IF sy-subrc = 0.
      ls_wa-first_eta = ls_eket-eindt.
    ENDIF.

    CLEAR ls_eket.
    SORT lt_eket DESCENDING BY eindt.
    READ TABLE lt_eket INTO ls_eket INDEX 1.
    IF sy-subrc = 0.
      ls_wa-last_eta = ls_eket-eindt.
    ENDIF.

    MODIFY itab FROM ls_wa.
  ENDLOOP.

ENDFUNCTION.
