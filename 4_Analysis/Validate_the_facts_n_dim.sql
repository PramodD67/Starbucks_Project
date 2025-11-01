select "Customer_name" from STARBUCKS_DB.BDL_SC."Customers_tbl";

select
    c.customer_sk,
    c.name,
    count(f.starbucks_fact_id) as total_orders,
    sum(f.line_item_amount) as total_amount
from STARBUCKS_DB.PDL_SC.CUSTOMER_DIM_MDL c
join STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f
    on f.customer_sk = c.customer_sk
group by c.customer_sk, c.name;



-- Check uniqueness of SK
SELECT customer_sk, COUNT(*)
FROM Customer_Dim_Mdl
GROUP BY customer_sk
HAVING COUNT(*) > 1;

SELECT "id", COUNT(*)
FROM STARBUCKS_DB.BDL_SC."Customers_tbl"
GROUP BY "id"
HAVING COUNT(*) > 1;

SELECT *
FROM STARBUCKS_DB.BDL_SC."Customers_tbl" c
join STARBUCKS_DB.BDL_SC."Loyalty_tbl" l
on c."id"=l."Customer_id";

select customer_sk, order_sk, product_sk, count(*)
from STARBUCKS_DB.PDL_SC.STARBUCKS_FACT
group by customer_sk, order_sk, product_sk
having count(*) > 1;


SELECT order_sk, customer_sk, product_sk, customization_sk, line_item_amount,inventory_sk,
       COUNT(*) as cnt
FROM Starbucks_Fact
GROUP BY order_sk, customer_sk, product_sk, customization_sk, line_item_amount,inventory_sk
HAVING COUNT(*) > 1;



  SELECT "id" FROM STARBUCKS_DB.BDL_SC."Customers_tbl" LIMIT 1;

SELECT
    t1.CUSTOMER_SK
FROM STARBUCKS_FACT AS t1
LEFT JOIN CUSTOMER_DIM_MDL AS t2
    ON t1.CUSTOMER_SK = t2.CUSTOMER_SK
WHERE t2.CUSTOMER_SK IS NULL
  AND t1.CUSTOMER_SK IS NOT NULL; -- Exclude records where the FK is intentionally NULL