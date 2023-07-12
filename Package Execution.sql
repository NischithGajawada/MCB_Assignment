exec BCM_DATA_MIGRATION_PKG.prc_inv_holds;
exec BCM_DATA_MIGRATION_PKG.prc_inv_headers;
exec BCM_DATA_MIGRATION_PKG.prc_inv_lines;
exec BCM_DATA_MIGRATION_PKG.prc_supp_address;
exec BCM_DATA_MIGRATION_PKG.prc_suppliers;
exec BCM_DATA_MIGRATION_PKG.prc_supplier_contact;
exec BCM_DATA_MIGRATION_PKG.prc_po_headers;
exec BCM_DATA_MIGRATION_PKG.prc_po_lines;


select * from HOLD_INVC;
select * from HDRS_INVC;
select * from LIN_INVC;
select * from ADDR_SUPP;
select * from SPLR;
select * from CONT_SUPP;
select * from HDRS_PO;
select * from LINE_PO;
