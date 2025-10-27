select
{{dbt_utils.generate_surrogate_key(['o."id"'])}} as order_sk,
o."id" as id,
o."Order_date" as order_date,
o."Order_status" as order_status

from {{source('BDL_Source','Orders_tbl')}} o