select 

{{dbt_utils.generate_surrogate_key(['"id"'])}} as product_sk,
"id" as product_id, 
"Product_name" as product_name,
"Description" as description,
"category" as category,
"Price" as price

from

{{source('BDL_Source','Products_tbl')}} 