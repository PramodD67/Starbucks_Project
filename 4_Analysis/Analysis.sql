--1.List all drinks and food items currently available.
select product_name,category 
from STARBUCKS_DB.PDL_SC.PRODUCTS_DIM_MDL p
 join STARBUCKS_DB.PDL_SC.INVENTORY_DIM_MDL i
on p.product_id=i.product_id
where i.current_stock>1;

--Show product prices and categories.
select PRODUCT_NAME, Price,category
from STARBUCKS_DB.PDL_SC.PRODUCTS_DIM_MDL;

--Show which customizations (size, milk type, add-ins) are available per drink.
select distinct product_name,category, MILK_TYPE,SIZE,ADDINS
from  STARBUCKS_DB.PDL_SC.PRODUCTS_DIM_MDL p
join STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
on p.product_sk=f.product_sk
join STARBUCKS_DB.PDL_SC.CUSTOMIZATION_DIM_MDL c
on c.CUSTOMIZATION_SK=f.CUSTOMIZATION_SK
where lower(p.category) not in ('pastry');

--Track popular items.
select  product_name,sum(quantity) No_of_items_sold
from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o
 join STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
on o.order_sk=f.order_sk
join STARBUCKS_DB.PDL_SC.INVENTORY_DIM_MDL i
 on i.inventory_sk=f.inventory_sk
join STARBUCKS_DB.PDL_SC.PRODUCTS_DIM_MDL p
on p.PRODUCT_ID=i.product_id
where upper(order_status)='COMPLETED'
group by product_name
order by No_of_items_sold desc
limit 5;

--Track inventory levels for popular items.
with cte as (
select p.product_id as pid, product_name, sum(quantity) No_of_items_sold 
from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o
 join STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
on o.order_sk=f.order_sk
join STARBUCKS_DB.PDL_SC.PRODUCTS_DIM_MDL p
on p.product_sk=f.product_sk
where upper(order_status)='COMPLETED'
group by pid, product_name
order by No_of_items_sold desc )

select product_name,No_of_items_sold, CURRENT_STOCK
from cte c join 
STARBUCKS_DB.PDL_SC.INVENTORY_DIM_MDL i
on c.pid=i.product_id;

--Show all customers and their total loyalty points.

select c.customer_sk, NAME ,sum(LOYALTY_POINTS) as total_loyalty_points
from STARBUCKS_DB.PDL_SC.CUSTOMER_DIM_MDL c 
join STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
on c.customer_sk=f.customer_sk
group by c.customer_sk, c.name  
order by total_loyalty_points desc;

--Track which customers made purchases in the last week/month.

select c.name , d.month, d.FULL_DATE from 
STARBUCKS_DB.PDL_SC.CUSTOMER_DIM_MDL c
join STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f
on c.customer_sk=f.customer_sk
join STARBUCKS_DB.PDL_SC.DATE_DIM_MDL d 
on d.date_sk=f.date_sk
where d.FULL_DATE >=  dateadd(MONTH,-1,current_date());

--Find top customers by total spending and loyalty points earned.
select c.customer_sk,  c.name, sum(LINE_ITEM_AMOUNT) as total_spend,  SUM(f.loyalty_points) AS loyalty_points
from  STARBUCKS_DB.PDL_SC.CUSTOMER_DIM_MDL c 
join  STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f
on c.customer_sk=f.customer_sk
join STARBUCKS_DB.PDL_SC.PRODUCTS_DIM_MDL p 
on p.product_sk=f.product_sk
group by c.customer_sk, c.name
order by total_spend desc;


--Track loyalty points earned per order.

select id, loyalty_points
from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
join STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f
on o.order_sk=f.order_sk
where initcap(o.order_status)='Completed';

-- Track how many items per order, total amount per order.

select o.id as order_id,quantity, p.price,line_item_amount
from STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f
join STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
on o.order_sk=f.order_sk
join  STARBUCKS_DB.PDL_SC.PRODUCTS_DIM_MDL p
on p.product_sk=f.product_sk
order by line_item_amount desc;

-- Identify orders with customizations.
select o.id as order_id, milk_type,size,addins
from STARBUCKS_DB.PDL_SC.CUSTOMIZATION_DIM_MDL c 
join STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f
on c.customization_sk=f.customization_sk
join STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o
on o.order_sk=f.order_sk
WHERE  milk_type IS NOT NULL or size IS NOT NULL or addins IS NOT NULL;

  --Find daily/weekly/monthly order counts and Total daily, weekly, monthly sales.

  select count(*) as daily_sales, to_date(ORDER_DATE) as date, sum(line_item_amount)
  from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
  join  STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
  on o.order_sk=f.order_sk
  join STARBUCKS_DB.PDL_SC.DATE_DIM_MDL d 
  on d.date_sk=f.date_sk
  where initcap(o.order_status)='Completed'
  group by to_date(ORDER_DATE) 
  order by to_date(ORDER_DATE)  ;

  select WEEK_NUMBER, count(*) as weekly_orders , sum(line_item_amount)
  from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
  join  STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
  on o.order_sk=f.order_sk
  join STARBUCKS_DB.PDL_SC.DATE_DIM_MDL d 
  on d.date_sk=f.date_sk
  where initcap(o.order_status)='Completed'
  group by WEEK_NUMBER
  order by WEEK_NUMBER ;



--Average order value per day/week/month.

  select count(*) as daily_sales, to_date(ORDER_DATE) as date, avg(line_item_amount)
  from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
  join  STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
  on o.order_sk=f.order_sk
  join STARBUCKS_DB.PDL_SC.DATE_DIM_MDL d 
  on d.date_sk=f.date_sk
  where initcap(o.order_status)='Completed'
  group by to_date(ORDER_DATE) 
  order by to_date(ORDER_DATE)  ;

    select count(*) as daily_sales, week_number, avg(line_item_amount)
  from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
  join  STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
  on o.order_sk=f.order_sk
  join STARBUCKS_DB.PDL_SC.DATE_DIM_MDL d 
  on d.date_sk=f.date_sk
  where initcap(o.order_status)='Completed'
  group by week_number
  order by week_number ;

      select count(*) as daily_sales, month, avg(line_item_amount)
  from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
  join  STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
  on o.order_sk=f.order_sk
  join STARBUCKS_DB.PDL_SC.DATE_DIM_MDL d 
  on d.date_sk=f.date_sk
  where initcap(o.order_status)='Completed'
  group by month
  order by month ;

     select count(*) as daily_sales, year, sum(line_item_amount)
  from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
  join  STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
  on o.order_sk=f.order_sk
  join STARBUCKS_DB.PDL_SC.DATE_DIM_MDL d 
  on d.date_sk=f.date_sk
  where initcap(o.order_status)='Completed'
  group by year
  order by year ;


     select count(*) as daily_sales, day_name, sum(line_item_amount) as total_amount
  from STARBUCKS_DB.PDL_SC.ORDERS_DIM_MDL o 
  join  STARBUCKS_DB.PDL_SC.STARBUCKS_FACT f 
  on o.order_sk=f.order_sk
  join STARBUCKS_DB.PDL_SC.DATE_DIM_MDL d 
  on d.date_sk=f.date_sk
  where initcap(o.order_status)='Completed'
  group by day_name
  order by total_amount desc  ;



select * from products_dim_mdl
where product_name is null;

