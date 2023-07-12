CREATE TABLE HOLD_INVC(
	invoice_hold_id number generated always as identity(start with 1 INCREMENT BY 1)  PRIMARY KEY,
	invoice_hold_reason VARCHAR(250)
    );

CREATE TABLE ADDR_SUPP(
    address_id number generated always as identity(start with 1 INCREMENT BY 1)  PRIMARY KEY,
	Address_line1 VARCHAR(250), Address_line2 VARCHAR(250), Address_line3 VARCHAR(250),Address_line4 VARCHAR(250), Address_line5 VARCHAR(250)
)
;

CREATE TABLE SPLR(
    supplier_id number generated always as identity(start with 1 INCREMENT BY 1)  PRIMARY KEY,supplier_name VARCHAR(250),supp_contact_name VARCHAR(250),    supp_address_id NUMBER,
    supp_email VARCHAR(250)
);


CREATE TABLE CONT_SUPP(
    contact_id number generated always as identity(start with 1 INCREMENT BY 1)  PRIMARY KEY,
	supplier_id NUMBER,
    contact_number VARCHAR(250)
);


CREATE TABLE HDRS_PO(
    po_header_id number generated always as identity(start with 1 INCREMENT BY 1)  PRIMARY KEY,po_number VARCHAR(150),po_date DATE,po_desc VARCHAR(500),
    po_total_amount NUMBER,po_status VARCHAR(150),supplier_id NUMBER
);


CREATE TABLE LINE_PO(
	po_reference VARCHAR(150),po_header_id NUMBER,po_line_id number generated always as identity(start with 1 INCREMENT BY 1)  PRIMARY KEY,
    po_line_num VARCHAR(150),po_line_desc VARCHAR(500),po_line_amount NUMBER,po_line_status VARCHAR(150)
);


CREATE TABLE HDRS_INVC(
    invoice_header_id number generated always as identity(start with 1 INCREMENT BY 1)  PRIMARY KEY,
    invoice_number VARCHAR(150)
);

CREATE TABLE LIN_INVC(
	invoice_header_id NUMBER,invoice_line_id number generated always as identity(start with 1 INCREMENT BY 1)  PRIMARY KEY,
	invoice_number NUMBER,invoice_reference VARCHAR2(150),po_line_id NUMBER,invoice_date DATE,invoice_desc VARCHAR(500),
    invoice_amount NUMBER,invoice_status VARCHAR(150), invoice_hold_id NUMBER
);
ALTER table CONT_SUPP add CONSTRAINT fk_con_supplier_id FOREIGN KEY(supplier_id) REFERENCES SPLR(supplier_id);
ALTER table LIN_INVC add CONSTRAINT fk_invoice_header_id FOREIGN KEY (invoice_header_id) REFERENCES HDRS_INVC(invoice_header_id);
ALTER table LIN_INVC add CONSTRAINT fk_po_line_id FOREIGN KEY (po_line_id) REFERENCES LINE_PO(po_line_id);
ALTER table LIN_INVC add CONSTRAINT fk_invoice_hold_id FOREIGN KEY (invoice_hold_id) REFERENCES HOLD_INVC(invoice_hold_id); 
ALTER table SPLR add CONSTRAINT fk_address_id FOREIGN KEY(supp_address_id) REFERENCES ADDR_SUPP(address_id);
ALTER table HDRS_PO add CONSTRAINT fk_supplier_id FOREIGN KEY(supplier_id) REFERENCES SPLR(supplier_id);
ALTER table LINE_PO add CONSTRAINT fk_po_header_id FOREIGN KEY (po_header_id) REFERENCES HDRS_PO(po_header_id);