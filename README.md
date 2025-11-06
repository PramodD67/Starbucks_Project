PROBLEM STATEMENT:
	
	Starbucks is opening a new location and needs a simple order management system. As a data engineer, you need to create a database that tracks orders, products, and basic customer information.
	Your task is to design a data model that:
	• Manages a menu of available drinks and food items
	• Tracks customer orders and their status
	• Handles basic customizations for drinks (size, milk type, add-ins)
	• Supports a simple loyalty program (points per purchase)
	• Enables daily, weekly, and monthly sales reporting
	Specific requirements:
	1. Each order can contain multiple items
	2. Drinks can have various customizations
	3. Customers can earn loyalty points for their purchases
	4. The system needs to track inventory for popular items
	5. Daily sales reports should be easy to generate
	
	From <https://code.datavidhya.com/data-modeling/starbucks-order-system> 

  Solution Developed:

  ![Architecture](https://github.com/user-attachments/assets/411e1275-06a3-43ff-ab43-e289bb5c41e4)


	1. Designed a Data model for the above requirement.
	2. Setup the AWS S3 bucket to create a source database.
	3. Loaded the data into S3 bucket in CSV file format.
	4. Created Storage Integration in snowflake to link AWS S3 bucket and Snowflake using external stage.
	5. Created tables in snowflake staging layer using Infer_schema() to automatically read the source schema and create the same in snowflake.
	6. Implemented Automatic Schema Evolution for all tables in staging layer to adopt the schema drifts.
	7. Loaded the data from External Stage (S3 bucket) to staging tables in snowflake using copy into command.
	8. Created SnowPipe to enable continuous Ingestion.
	9. Created Transformation Layer using the same data model as in the SDL.
	10. Cleaned the data, Applied the schema and loaded data from Staging layer to Transformation layer using Snowflake Tasks and Merge ( Incremental load strategy ).
	11. Created DBT project to transform the data and load it from Transformation Layer to Presentation Layer.
	12. Designed and Implemented Dimensional modelling using facts and dimensions in the Presentation layer to achieve fast query performance and quick reporting. 
	13. Applied the business logic in the DBT models to transform the data as per the business. 
	14. Created Macros in DBT for reusability of the logic across the models.
	15. Created DBT Generic Test models to test the unique, not null & relationships among the tables and to ensure the data quality.
	16. Implemented SCD Type 2 for Customers table to track the history of phone numbers and address by using DBT Snapshots.
	17. Integrated with Gitlab for CI/CD, Version Control, Tracking and Documentation.
	18. Scheduled Gitlab jobs to run the pipelines for batch processing of the data everyday.
	19. Integrated Power Bi on top of Presentation Layer for analysis.
	20. Created measures, KPIs, and visual dashboards showing daily, weekly, and monthly sales, top products, and loyalty trends.
	21. Generated the power bi report as per the business requirement.
	


  
✅ Summary of Transformations Applied :

     NULL Handling: COALESCE(column, default) used in most tables.
     String Cleaning / Formatting:
             REGEXP_REPLACE to remove unwanted characters.
             SPLIT_PART to parse string fields.
             trim to remove extra whitespace.
     Type Casting:   ::INT or ::timestamp for proper typing.
     Default Values:
             orders_total → default numeric formatting.
             Order_date → default timestamp.
     Phone Formatting: special regex to format as XXX-XXXX.

Solution Overview:

    1. Data Modeling & Architecture
    	• Designed a relational data model covering entities such as Customers, Orders, Products, and Customizations.
    	• Defined staging, transformation, and presentation layers following best practices for modularity and performance.
    	• Implemented dimensional modeling (star schema) for reporting (Fact_Orders, Dim_Customers, Dim_Products, Dim_Date).
    2. Data Ingestion & Storage
    	• Created an AWS S3 bucket to store source CSV files (Orders, Customers, Products, Customizations).
    	• Configured Snowflake Storage Integration and External Stage to securely connect with S3.
    	• Used INFER_SCHEMA() for automated table creation in the staging layer.
    	• Implemented Automatic Schema Evolution to adapt to schema drifts.
    	• Loaded data into staging using COPY INTO command and enabled continuous ingestion via Snowpipe.
    3. Data Transformation
    	• Built the Transformation layer in Snowflake using Tasks + Merge for incremental loading.
    	• Developed a dbt project for transforming and modeling data from the transformation layer to the presentation layer.
    	• Applied business logic and created reusable macros for consistency across models.
    	• Implemented dbt generic tests to validate uniqueness, not-null constraints, and relationships.
    	• Created SCD Type 2 slowly changing dimension for tracking historical customer details using dbt snapshots.
    4. CI/CD & Automation
    	• Integrated dbt with GitLab for version control, CI/CD, and documentation.
    	• Scheduled daily GitLab pipeline jobs to automate data refresh and quality checks.
    5. Reporting & Visualization
    	• Connected Power BI to the presentation layer for analytics.
    	• Created measures, KPIs, and visual dashboards showing daily, weekly, and monthly sales, top products, and loyalty trends.

Power Bi Report:


  <img width="284" height="376" alt="Screenshot 2025-10-29 133615" src="https://github.com/user-attachments/assets/9428c4e0-fe9a-40f7-ba67-6936c4a49de1" />

