with low as 
(
select
 supp.supplier_name 
,supp.supp_contact_name 
,count(po_number) po_count
,decode(length(supp_con.contact_number),7,substr(supp_con.contact_number,1,3)||'-'||substr(supp_con.contact_number,4,7), substr(supp_con.contact_number,1,4)||'-'||substr(supp_con.contact_number,5,8)) contact_number
,sum(po_total_amount) po_tot_amt
,row_number() over (partition by supp.supplier_name order by supp_con.contact_number) rn
from 
HDRS_PO hdpo
,SPLR supp
,CONT_SUPP supp_con
where 1=1
and hdpo.supplier_id = supp.supplier_id
and po_date between '01-JAN-2017' and '31-AUG-2017'
and supp_con.supplier_id = supp.supplier_id
group by supp.supplier_name 
,supp.supp_contact_name 
,supp_con.contact_number 
)
select
 low.SUPPLIER_NAME "Supplier Name"
,low.supp_contact_name "Supplier Contact Name"
,max(case when rn = 1 then regexp_replace(low.contact_number, '\s+', '') end) "Supplier Contact No. 1"
,max(case when rn = 2 then regexp_replace(low.contact_number, '\s+', '') end) "Supplier Contact No. 2"
,sum(po_count) "Total Orders"
,to_char(sum(po_tot_amt),'fm999G999G999D00') "Order Total Amount"
from low
group by low.SUPPLIER_NAME, low.SUPP_CONTACT_NAME
order by low.SUPPLIER_NAME, low.SUPP_CONTACT_NAME
;