select 

   {{dbt_utils.generate_surrogate_key(['"id"'])}} as  date_sk,
     "id" as order_id,
    "Order_date" as full_date ,
    DAYNAME("Order_date") AS day_name ,
    MONTH("Order_date") AS month ,
    year("Order_date") AS year

    from 
    {{source('BDL_Source','Orders_tbl')}}
