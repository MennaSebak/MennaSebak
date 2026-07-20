*&---------------------------------------------------------------------*
*& Report  Z_SO_FILTER_SAMPLE
*& Sample ABAP report: filter sales orders and display in ALV
*&---------------------------------------------------------------------*
REPORT z_so_filter_sample.

TYPE-POOLS: slis.

* Creation date mandatory, sales order optional
PARAMETERS: p_erdat TYPE vbak-erdat OBLIGATORY,
            p_vbeln TYPE vbak-vbeln.

TYPES: BEGIN OF ty_out,
         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         auart TYPE vbak-auart,
         ernam TYPE vbak-ernam,
       END OF ty_out.

DATA: gt_out      TYPE STANDARD TABLE OF ty_out,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv.

START-OF-SELECTION.

  IF p_vbeln IS INITIAL.
    SELECT vbeln erdat auart ernam
      INTO TABLE gt_out
      FROM vbak
      WHERE erdat = p_erdat.
  ELSE.
    SELECT vbeln erdat auart ernam
      INTO TABLE gt_out
      FROM vbak
      WHERE erdat = p_erdat
        AND vbeln = p_vbeln.
  ENDIF.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'VBELN'.
  gs_fieldcat-seltext_l = 'Sales Order'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'ERDAT'.
  gs_fieldcat-seltext_l = 'Date of Creation'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'AUART'.
  gs_fieldcat-seltext_l = 'Order Type'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'ERNAM'.
  gs_fieldcat-seltext_l = 'Created By'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat   = gt_fieldcat
    TABLES
      t_outtab      = gt_out
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying ALV' TYPE 'I'.
  ENDIF.
