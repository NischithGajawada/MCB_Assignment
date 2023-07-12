create or replace NONEDITIONABLE PACKAGE BCM_DATA_MIGRATION_PKG AUTHID CURRENT_USER
IS

PROCEDURE prc_valid_data;
PROCEDURE prc_inv_holds;
PROCEDURE prc_inv_headers;
PROCEDURE prc_inv_lines;
PROCEDURE prc_suppliers;
PROCEDURE prc_supplier_contact;
PROCEDURE prc_supp_address;
PROCEDURE prc_po_headers;
PROCEDURE prc_po_lines;


END BCM_DATA_MIGRATION_PKG;