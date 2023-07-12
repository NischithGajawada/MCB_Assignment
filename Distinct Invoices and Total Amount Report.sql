select 
to_number(substr(hdp.po_number,3,length(hdp.po_number))) "Order Reference"
,to_char(hdp.po_date,'MON-YY') "Order Period"
,initcap(supp.supplier_name) "Supplier Name"
,to_char(hdp.po_total_amount,'fm999G999G999D00') "Order Total Amount"
,hdp.po_status "Order Status"
,hin.invoice_number "Invoice Reference"
,to_char(sum(lin.invoice_amount),'fm999G999G999D00') "Invoice Total Amount"
,decode(sum(decode(lin.INVOICE_STATUS,'Paid','0','1')),'0','OK','To follow up') "Action"
from 
HDRS_PO hdp
,SPLR supp
,LINE_PO lip
,HDRS_INVC hin
,LIN_INVC lin
where 
1=1
and hdp.supplier_id = supp.supplier_id
and hin.invoice_header_id = lin.invoice_header_id
and lin.po_line_id = lip.po_line_id
and hdp.po_header_id = lip.po_header_id
group by hdp.po_number
,to_char(hdp.po_date,'MON-YY')
,supp.supplier_name
,to_char(hdp.po_total_amount,'fm999G999G999D00')
,hdp.po_status
,hin.invoice_number
order by hdp.po_number
;