SELECT
    {{ dbt_utils.generate_surrogate_key(['c."id"']) }} AS customer_sk,
    c."id" as customer_id,
    initcap(trim(c."Customer_name")) as name,
    trim(c."Phone_Number") as phone_number,
    initcap(trim(c."Address")) as address

FROM {{ source('BDL_Source', 'Customers_tbl') }} c


