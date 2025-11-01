select 
{{dbt_utils.generate_surrogate_key(['c."id"'])}} as customization_sk,
c."id" as customization_id,
{{ clean_null_placeholders('c."Milk_Type"')}} as Milk_Type,
{{ clean_null_placeholders('c."Size"')}} as Size,
{{ clean_null_placeholders('c."Add-ins"')}} as Addins

from {{source('BDL_Source','Customization_tbl' )}} c

