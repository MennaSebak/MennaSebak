# SAP ABAP Portfolio

Sample ABAP development work demonstrating practical skills used in real SAP projects.

> These are **sanitized learning samples** (not client-specific productive code).

## Skills Demonstrated

- Executable ABAP reports with selection screens
- ALV output
- Open SQL data retrieval
- Remote-Enabled Function Modules (RFC)
- Dictionary structures and table parameters
- Input validation and optional/mandatory filters

## Projects

### 1) Sales Order Filter Report
**File:** `reports/z_so_filter_sample.abap`

- Selection screen with date (mandatory) and sales order (optional)
- Filters sales orders from `VBAK`
- Displays results in classical ALV Grid

### 2) Purchase Order Details RFC
**File:** `rfcs/z_po_details_sample.abap`  
**Structure notes:** `docs/z_po_details_structure.md`

- Remote-enabled function module
- Input: Purchase Order number
- Output: item-level table (vendor, material, qty, received qty, storage location, MPN)
- Reads from `EKKO`, `EKPO`, `LFA1`, `MAKT`, `MARA`, `EKET`

### 3) Open PO Documents Mapping Sample
**File:** `rfcs/z_po_open_docs_sample.abap`

- Pattern for enriching purchasing document rows
- Calculates received qty/value
- Maps invoice qty/value into still-to-be-delivered fields
- Derives first/last ETA from schedule lines

## How to Use in SAP

1. Create the related Dictionary objects (structure/table type) if needed
2. Create report/function module in your SAP system
3. Paste the sample code
4. Activate and test

## Notes for Recruiters

This repository reflects ABAP patterns I used in practice:
report development, RFC interfaces, SQL reads, and ALV presentation.
Client-confidential objects are intentionally excluded.
