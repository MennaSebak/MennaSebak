# Structure: ZPO_RFC_OUTPUT_SAMPLE

Use this as a checklist when creating the Dictionary structure for the PO Details RFC sample.

| Component     | Suggested Type | Description        |
|---------------|----------------|--------------------|
| PO_NUMBER     | EBELN          | PO number          |
| VENDOR_NO     | LIFNR          | Vendor number      |
| VENDOR_NAME   | NAME1_GP       | Vendor name        |
| ITEM_NO       | EBELP          | Item number        |
| MATERIAL      | MATNR          | Material number    |
| DESCRIPTION   | MAKTX          | Material text      |
| MPN           | MFRPN          | Manufacturer part  |
| PO_QTY        | BSTMG          | PO quantity        |
| RECEIVED_QTY  | MENGE_D        | Received quantity  |
| STORAGE_LOC   | LGORT_D        | Storage location   |
| UOM           | MEINS          | Unit of measure    |

Then create table type `ZPO_RFC_OUTPUT_SAMPLE_T` with line type = this structure.
