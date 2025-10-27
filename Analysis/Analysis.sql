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
where lower(p.category) not in ('pastry')