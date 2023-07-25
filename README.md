Explanation for Bank_Data_Model

I have created Bank Data Model which consists of a series of tables.

These tables contain client information, credit information, transactions and etc.

Tables include:

Customer
Customer_Document
Employee_info
Branch
Product
Currency
Account
Card
Credit_contracts
Transaction
log_info

I have added constraints for these tables like primary key, foreign key, not null, check, default.

A Primary key is used to ensure that data in the specific column is unique. It cannot be a duplicate. A table cannot have more than one primary key.
If a table contains the primary key then it will be called a parent table for reference table.
Foreign key is a constraint on specific column that creates a relationship between two tables. The foreign keys identify parent-child relationships. The child table has the foreign key which references the parent. 

Also I have created 2 triggers for salary column on Employee_info table and Amount column on Transaction table. Therefore I created log_info table. When salary and amount column modfied by someone trigger will run and log_info table will contain with modified data. 
Log_info table contains some important columns:
Client_ID (for modified client data)
Old_value (for old salary or transaction amount)
New_value (for modified salary or transacyion amount)
Log_date (modified date)
Operation_type( inserting, deleting or updating)
Table_Name ( for modified column's table name)
Column_Name (for modified column's name)
User_name ( The user who modified data)
