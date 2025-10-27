CREATE or replace TABLE "Orders_tbl" (
	"id" INTEGER NOT NULL UNIQUE,
	"Customer_id" INTEGER NOT NULL,
	"Order_date" TIMESTAMP NOT NULL,
	"Order_status" VARCHAR(255),
	"orders_total" DECIMAL NOT NULL,
	PRIMARY KEY("id")
);

CREATE or replace TABLE "Customers_tbl" (
	"id" INTEGER NOT NULL UNIQUE,
	"Customer_name" VARCHAR(255) NOT NULL,
	"Phone_Number" VARCHAR(255) NOT NULL,
	"Address" VARCHAR(255),
	PRIMARY KEY("id")
);

CREATE or replace TABLE "Products_tbl" (
	"id" INTEGER NOT NULL UNIQUE,
	"Product_name" VARCHAR(255) NOT NULL,
	"Description" VARCHAR(255),
	"category" VARCHAR(255) NOT NULL,
	"Price" float NOT NULL,
	PRIMARY KEY("id")
);


CREATE or replace  TABLE "Loyalty_tbl" (
	"id" INTEGER NOT NULL UNIQUE,
	"Customer_id" INTEGER,
	"Order_id" INTEGER NOT NULL,
	"Loyalty_Points" INTEGER,
	PRIMARY KEY("id")
);

CREATE or replace  TABLE "Customization_tbl" (
	"id" INTEGER NOT NULL UNIQUE,
	"Milk_Type" VARCHAR(255),
	"Size" VARCHAR(255),
	"Add-ins" VARCHAR(255),
	"Product_id" INTEGER,
	"Customer_id" INTEGER,
	PRIMARY KEY("id")
);

CREATE or replace  TABLE "Order_items_tbl" (
	"id" INTEGER NOT NULL UNIQUE,
	"Order_id" INTEGER NOT NULL,
	"Product_id" INTEGER NOT NULL,
	"Quantity" INTEGER NOT NULL,
	"Customization_id" INTEGER NOT NULL,
	PRIMARY KEY("id")
);

CREATE or replace  TABLE "Inventory_tbl" (
	"id" INTEGER NOT NULL UNIQUE,
	"Product_id" INTEGER NOT NULL,
	"Current_stock" INTEGER,
	"Re-order_level" INTEGER NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "Orders_tbl"
ADD FOREIGN KEY("Customer_id") REFERENCES "Customers_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Loyalty_tbl"
ADD FOREIGN KEY("Customer_id") REFERENCES "Customers_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Loyalty_tbl"
ADD FOREIGN KEY("Order_id") REFERENCES "Orders_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Customization_tbl"
ADD FOREIGN KEY("Product_id") REFERENCES "Products_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Customization_tbl"
ADD FOREIGN KEY("Customer_id") REFERENCES "Customers_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Order_items_tbl"
ADD FOREIGN KEY("Order_id") REFERENCES "Orders_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Order_items_tbl"
ADD FOREIGN KEY("Product_id") REFERENCES "Products_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Order_items_tbl"
ADD FOREIGN KEY("Customization_id") REFERENCES "Customization_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Inventory_tbl"
ADD FOREIGN KEY("Product_id") REFERENCES "Products_tbl"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;


show tables;


Drop table CUSTOMERS_TBL;
Drop table CUSTOMIZATION_TBL;
Drop table INVENTORY_TBL;
Drop table LOYALTY_TBL;
Drop table ORDERS_TBL;
Drop table ORDER_ITEMS;
Drop table ORDER_ITEMS_TBL;
Drop table "Order_items";
Drop table PRODUCTS_TBL;

select * from "Orders_tbl";