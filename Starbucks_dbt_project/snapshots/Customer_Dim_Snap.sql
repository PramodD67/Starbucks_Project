{% snapshot Customer_Dim_Snap %}

{{
  config(
     target_schema='PDL_SC',
     unique_key='Customer_sk',  
     strategy='check',
     check_cols=['Phone_Number', 'Address'] 
     )

}}

SELECT
  {{ dbt_utils.generate_surrogate_key(['Customer_id']) }} AS customer_sk,
   customer_id,
   name,
  phone_number,
  address

FROM {{ ref('Customer_Dim_Mdl') }} 


{%endsnapshot%}