select 

  {{dbt_utils.generate_surrogate_key(['o."id"', 'ot."Order_id"', 'ot."Product_id"', 'ot."Customization_id"'])}} as starbucks_fact_id,
    od.order_sk  ,
    c.customer_sk ,
    p.product_sk  ,
    cz.customization_sk ,
    d.date_sk ,
    l."Loyalty_Points" as loyalty_points,
    l."id" as loyalty_id,
    (p.price*ot."Quantity") as line_item_amount,
    ot."Quantity" as quantity ,
    i.inventory_sk

    from
    {{source('BDL_Source','Orders_tbl')}} o
    left  join {{ref('Customer_Dim_Mdl')}} c
     on o."Customer_id"=c.customer_id
    left join {{ref('Orders_Dim_Mdl')}} od
     on od.id= o."id"
    left join  {{source('BDL_Source','Order_items_tbl')}} ot
     on o."id"= ot."Order_id"
   left  join  {{ref('Products_Dim_Mdl')}} p
     on  p.product_id=ot."Product_id"
   left  join {{ref('Customization_Dim_Mdl')}} cz
   on cz.customization_id=ot."Customization_id"
   left join {{ref('Date_Dim_Mdl')}} d
   on  d.full_date= o."Order_date"
   left join {{source('BDL_Source','Loyalty_tbl')}} l
   on l."Order_id"=od.id
   left join {{ref('Inventory_Dim_Mdl')}} i
   on i.product_id=ot."Product_id"



