--Create Virtual Environment
python -m venv starbucks_dbt_PD_env

--Activate it:
starbucks_dbt_PD_env\Scripts\activate

--Install dbt along with snowflake connector:
pip install dbt-snowflake

 --create dbt profile
 mkdir  %userprofile%\.dbt
 --Once dbt is installed you can create a new project:
 dbt init my_dbt_project

--It asks for setting up the snowflake-dbt connection by asking DB,SC,Username,Password,
Role,Warehouse,Database,Schema,Threads information. Provide them all.

 --Once dbt project is created, Change the project directory: 
 cd my_dbt_project

 -- Run dbt debug command to check if the connection between snowflake and dbt is correct and if dbt project is correctly initialised.
dbt debug
;



desc table STARBUCKS_DB.BDL_SC."Customization_tbl";