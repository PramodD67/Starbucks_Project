with cte as ( 

select
{{dbt_utils.generate_surrogate_key(['"id"'])}} as product_sk,
"id" as product_id, 
CASE
    WHEN INITCAP( TRANSLATE(
        REGEXP_REPLACE(TRIM("Product_name"), '[[:space:]\u00A0]+', ' '),
        'ÁÀÄÂáàäâÉÈËÊéèëêÍÌÏÎíìïîÓÒÖÔóòöôÚÙÜÛúùüûÇçÑñ',
        'AAAAaaaaEEEEeeeeIIIIiiiiOOOOooooUUUUuuuuCcNn'
      )) IN ('Cappuchino', 'Cappuccino')
         THEN 'Cappuccino'
    ELSE INITCAP( TRANSLATE(
        REGEXP_REPLACE(TRIM("Product_name"), '[[:space:]\u00A0]+', ' '),
        'ÁÀÄÂáàäâÉÈËÊéèëêÍÌÏÎíìïîÓÒÖÔóòöôÚÙÜÛúùüûÇçÑñ',
        'AAAAaaaaEEEEeeeeIIIIiiiiOOOOooooUUUUuuuuCcNn'
      ))
END AS product_name,
 INITCAP( TRANSLATE(
        REGEXP_REPLACE(TRIM("Description"), '[[:space:]\u00A0]+', ' '),
        'ÁÀÄÂáàäâÉÈËÊéèëêÍÌÏÎíìïîÓÒÖÔóòöôÚÙÜÛúùüûÇçÑñ',
        'AAAAaaaaEEEEeeeeIIIIiiiiOOOOooooUUUUuuuuCcNn'
      )) as description,
 INITCAP( TRANSLATE(
        REGEXP_REPLACE(TRIM("category"), '[[:space:]\u00A0]+', ' '),
        'ÁÀÄÂáàäâÉÈËÊéèëêÍÌÏÎíìïîÓÒÖÔóòöôÚÙÜÛúùüûÇçÑñ',
        'AAAAaaaaEEEEeeeeIIIIiiiiOOOOooooUUUUuuuuCcNn'
      ))  as category,
       INITCAP( TRANSLATE(
        REGEXP_REPLACE(TRIM("Price"), '[[:space:]\u00A0]+', ' '),
        'ÁÀÄÂáàäâÉÈËÊéèëêÍÌÏÎíìïîÓÒÖÔóòöôÚÙÜÛúùüûÇçÑñ',
        'AAAAaaaaEEEEeeeeIIIIiiiiOOOOooooUUUUuuuuCcNn'
      )) as price,
      row_number() over(partition by "Product_name","Description","category",
"Price" order by "Product_name") as rn
from
{{source('BDL_Source','Products_tbl')}} 
qualify rn=1
)

select 
product_sk,
product_id,
product_name,
description,
category,
price
from cte 