SELECT
    {{ dbt_utils.generate_surrogate_key(['c."id"']) }} AS customer_sk,
    c."id" as customer_id,
    c."Customer_name" as name,
    c."Phone_Number" as phone_number,
    c."Address" as address

FROM {{ source('BDL_Source', 'Customers_tbl') }} c


