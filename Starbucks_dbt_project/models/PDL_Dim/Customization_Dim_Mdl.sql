select 
{{dbt_utils.generate_surrogate_key(['c."id"'])}} as customization_sk,
c."id" as customization_id,
c."Milk_Type" as Milk_Type,
c."Size" as Size,
c."Add-ins" as Addins

from {{source('BDL_Source','Customization_tbl' )}} c