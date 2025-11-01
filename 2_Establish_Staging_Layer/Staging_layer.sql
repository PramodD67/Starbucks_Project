create or replace storage integration s3_sti
type=External_stage
enabled=true
storage_provider='s3'
storage_aws_role_arn='arn:aws:iam::277707120370:role/Starbucks_role'
storage_allowed_locations=('s3://starbucks-analysis-buck/');

desc storage integration s3_sti;

create or replace stage ext_stg
url='s3://starbucks-analysis-buck/'
storage_integration=s3_sti;


select $1, $2 from @ext_stg/Customers/Customers.csv;

create or replace file format csvff
type='csv'
field_delimiter = ','
record_delimiter = '\n'
error_on_column_count_mismatch=false
parse_header=true
field_optionally_enclosed_by = '"';

create or replace file format pipe_csvff
type='csv'
field_delimiter = '|'
record_delimiter = '\n'
error_on_column_count_mismatch=false
parse_header=true
field_optionally_enclosed_by = '"';

CREATE OR REPLACE FILE FORMAT my_pipe_format
TYPE = 'CSV'             -- treat as CSV
FIELD_DELIMITER = '|'    -- delimiter is |
parse_header=true        -- if file has header, set to 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'  -- optional, if strings are quoted
NULL_IF = ('NULL','')    -- treat these as NULL
EMPTY_FIELD_AS_NULL = TRUE
error_on_column_count_mismatch=false;


create or replace table Customers_tbl using template(
    select array_agg(object_construct(*)) from table(
        infer_schema(
            location=>'@ext_stg/Customers/',
            file_format=>'csvff'
        )
    )
);


create or replace table Orders_tbl using template(
    select array_agg(object_construct(*)) from table(
        infer_schema(
            location=>'@ext_stg/Orders/',
            file_format=>'my_pipe_format'
        )
    )
);

create or replace table Inventory_tbl using template(
    select array_agg(object_construct(*)) from table(
        infer_schema(
            location=>'@ext_stg/Inventory/',
            file_format=>'csvff'
        )
    )
);


create or replace table Products_tbl using template(
    select array_agg(object_construct(*)) from table(
        infer_schema(
            location=>'@ext_stg/Products/',
            file_format=>'pipe_csvff'
        )
    )
);


create or replace table Order_items_tbl using template(
    select array_agg(object_construct(*)) from table(
        infer_schema(
            location=>'@ext_stg/Order_items/',
            file_format=>'csvff'
        )
    )
);


create or replace table Customization_tbl using template(
    select array_agg(object_construct(*)) from table(
        infer_schema(
            location=>'@ext_stg/Customization/',
            file_format=>'csvff'
        )
    )
);

create or replace table Loyalty_tbl using template(
    select array_agg(object_construct(*)) from table(
        infer_schema(
            location=>'@ext_stg/Loyalty/',
            file_format=>'csvff'
        )
    )
);


ALTER TABLE customers_tbl SET ENABLE_SCHEMA_EVOLUTION=TRUE;
ALTER TABLE orders_tbl SET ENABLE_SCHEMA_EVOLUTION=TRUE;
ALTER TABLE ORDER_ITEMS_TBL SET ENABLE_SCHEMA_EVOLUTION=TRUE;
ALTER TABLE LOYALTY_TBL SET ENABLE_SCHEMA_EVOLUTION=TRUE;
ALTER TABLE INVENTORY_TBL SET ENABLE_SCHEMA_EVOLUTION=TRUE;
ALTER TABLE PRODUCTS_TBL SET ENABLE_SCHEMA_EVOLUTION=TRUE;
ALTER TABLE customization_tbl SET ENABLE_SCHEMA_EVOLUTION=TRUE;

select distinct "Order_date" from orders_tbl ;

copy into customers_tbl 
from @ext_stg/Customers/
file_format=(format_name='csvff')
match_by_column_name=case_insensitive;

copy into orders_tbl 
from @ext_stg/Orders/
file_format=(format_name='my_pipe_format')
match_by_column_name=case_insensitive;


copy into Order_items_tbl 
from @ext_stg/Order_items/
file_format=(format_name='csvff')
match_by_column_name=case_insensitive;

copy into Products_tbl 
from @ext_stg/Products/
file_format=(format_name='pipe_csvff')
match_by_column_name=case_insensitive;


copy into Inventory_tbl 
from @ext_stg/Inventory/
file_format=(format_name='csvff')
match_by_column_name=case_insensitive;

copy into Loyalty_tbl 
from @ext_stg/Loyalty/
file_format=(format_name='csvff')
match_by_column_name=case_insensitive;

copy into Customization_tbl 
from @ext_stg/Customization/
file_format=(format_name='csvff')
match_by_column_name=case_insensitive;




desc table customers_tbl;

select * from customers_tbl;
----------------------------------------

Create pipe customers_pipe 
auto_ingest=true
as 
copy into customers_tbl 
from @ext_stg/Customers/
file_format=(format_name='csvff')
match_by_column_name=case_insensitive;



show pipes;
desc pipe CUSTOMERS_PIPE;