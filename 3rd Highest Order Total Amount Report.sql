select
 res.po_num "Order Reference"
,res.po_date "Order Date"
,res.po_supp "Supplier Name"
,res.po_total "Order Total Amount"
,res.po_status "Order Status"
,listagg(res.invoice_reference,', ') 
within group(order by res.po_num)as "Invoice References"
from 
(select distinct to_number(substr(hdpo.po_number,3,length(hdpo.po_number))) po_num
,to_char(hdpo.po_date,'MONTH DD,YYYY') po_date
,upper(supp.supplier_name) po_supp
,to_char(hdpo.po_total_amount,'fm999G999G999D00') po_total
,hdpo.po_status
,lin.invoice_reference
,dense_rank() over(order by hdpo.po_total_amount desc) high
from 
HDRS_PO hdpo
,SPLR supp
,LINE_PO lip
,HDRS_INVC hdin
,LIN_INVC lin
where 1=1
and hdpo.supplier_id = supp.supplier_id
and hdin.invoice_header_id = lin.invoice_header_id
and lin.po_line_id = lip.po_line_id
and hdpo.po_header_id = lip.po_header_id

order by lin.invoice_reference
) res
where high = 3
group by res.po_num
,res.po_date
,res.po_supp
,res.po_total
,res.po_status
;