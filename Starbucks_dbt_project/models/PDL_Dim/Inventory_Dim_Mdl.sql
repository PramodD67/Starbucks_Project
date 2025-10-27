select 
  {{dbt_utils.generate_surrogate_key(['"id"'])}} as inventory_sk,
    "id" as inventory_id,
    "Current_stock" as current_stock  ,
    "Re-order_level" as re_order_level,
    "Product_id" as product_id

    from 

    {{source('BDL_Source','Inventory_tbl')}}