-- Create tables section for banking database --
-- Create Customer information table 
-- if the customer is Company some columns should be null Ex: Gender, Is_married, Is_dead etc. 
-- Therefore I have added check constraints on these columns. If specified value ('F','M') not added to the column the value will be null.
create table customer
( Load_date date,
  ID number(8) not null, --PK
  Branch_CODE   varchar(3), --FK
  Full_name varchar(200) not null,
  Gender char(1)  ,
  Is_married int  ,  
  Birth_place varchar(200),
  Birth_date date,
  Registered_Address varchar(300),
  Residential_Address varchar(300),
  Country varchar(50) not null,
  City varchar(50) not null,
  Is_Resident int,
  Is_Dead int  ,
  Mobile_phone varchar(20),
  Home_phone varchar(20),
  Job_phone varchar(20),
  Mail varchar(50),
  CONSTRAINT CK_Gender CHECK (Gender in ('F','M'))
  );
  
-- Add CHECK constraint on multiple column (when the table is already created)
Alter table customer
Add constraint CK_columns Check (Is_married in (0,1) and Is_Resident in (0,1) and Is_Dead in (0,1));

-- Add Primary_key --
Alter table customer
Add constraint ID_PK Primary key(ID);

-- Create ID_card information --
create table Customer_Document
(Load_date date,
 Client_ID number(8),-- FK
 Document_type varchar(50),
 Pin_code varchar(20) not null unique,
 Serial_number varchar(50) not null,
 Issue_date date not null,
 Expire_date date not null,
 CONSTRAINT CK_DATE CHECK(Issue_date< Expire_date)
 );
 
-- Create Customer workplace information --
create  table Employee_info
( Load_date date,
  Client_id number(8), --FK
  Company_code varchar(50) not null,
  Company_Name varchar(200)not null,
  Position varchar(50)not null,
  Salary number(8,2),
  Income_type varchar(30) DEFAULT 'Other',
  Begin_date date not null,
  End_date date,
  Constraints CK_s_d CHECK( Salary>0 and Begin_date<End_date)
  );
  
-- Create Branch table --
create table Branch
( Load_date date,
  Code varchar(3) not null, --PK
  Name varchar(50) not null,
  Adress varchar(200),
  Phone varchar(20),
  Email varchar(50)
);

-- Add primary key --
ALTER TABLE BRANCH 
ADD CONSTRAINTS BRANCH_CODE_PK PRIMARY KEY(CODE);

-- Create Product table --
create table Product
(Load_date date,
 Code varchar(4), --PK
 Product_name varchar(100),
 Description varchar(300),
 Created_date date not null,
 End_date date
 );
 
 -- Add primary key --
 ALTER TABLE Product
 ADD CONSTRAINT PRODUCT_code_PK PRIMARY KEY(CODE);
 
 -- Create Currency table --
 create  table currency
 (load_date date,
  ID varchar (3), --PK
  Currency char(3) not null ,
  Currency_name varchar(100) not null);
 
 --Add Primary key -- 
  Alter table currency
  add constraint currency_id_pk primary key(id);
  
-- Create Account table --
 create  table Account
 (Load_date date,
 ID number(8), --PK
 Client_ID number (8), --FK
 Currency_ID varchar(3), --FK
 Branch_code varchar(3),--FK
 IBAN varchar(28) not null unique,
 GL_code number(5) not null unique,
 Account_name varchar(100),
 Account_open_date date not null,
 Account_close_date date,
 Account_Status char(1) not null,
 Description varchar(300)
 );
 
 Alter table Account
 Add constraints Account_ID_Pk Primary key (ID);
  
-- CARD information --
create  table card 
( load_date date, 
  ID number(8),--PK
  Client_ID number (8), --FK
  Branch_code varchar(3), --FK
  Account_ID number(8), --FK
  Currency_ID varchar(3), --FK
  PAN varchar(20) not null,
  CARD_product_code INT,
  Card_product_name varchar(100),
  Create_date date not null,
  Close_date date,
  Cancel_date date,
  Status char(1));
  
  Alter table card
  ADD CONSTRAINT CARD_ID_PK PRIMARY KEY(ID);

-- Credit Table --
Create table credit_contracts
(Load_date date,
Bank_date date,
Client_id number (8),--FK
Guarantor_client_id number (8),--FK
Product_code varchar(4), --FK
Branch_code varchar(3),--FK
Currency_id varchar(3), --FK
Contract_ref_no varchar(50),
Start_date date,
Maturity_date date,
Close_date date,
Initial_Amount number(18,2),
Changed_Amount number (18,2),
Initial_limit number (18,2),
Changed_limit number (18,2),
Interest_Rate number(10,2),
Principal_overdue_day number,
Interest_overdue_day number,
Penalty_overdue_day number,
Principal_rest number (18,2),
Due_prinicpal_rest number (18,2),
Interest number (18,2),
Due_interest number (18,2),
Penalty number (18,2),
Write_off int ,
Write_off_date date,
Constraint CK_write_off check( Write_off in (1,0))
);


--- Create transaction table ---
create table  transaction
(Load_date date,
 Operation_date date not null,
 Value_date date,
 ID number(8), --PK
 Client_id number(8),--FK
 DT_account varchar(50),
 DT_currency varchar(3),
 DT_branch_code varchar(3),
 CR_account varchar(50),
 CR_currency varchar(3),
 CR_branch_code varchar(3),
 Amount number(18,2)not null);
 
 --ADD primary key -- 
 Alter table transaction
 ADD CONSTRAINT TR_ID PRIMARY KEY(ID);
 
-- create Log table ---
create  table  log_info
( ID int,
Client_ID number(8),
Old_value varchar(2000),
New_value varchar(2000),
Log_date date,
Operation_type varchar(20),
Table_Name varchar(50),
Column_Name varchar(50),
User_name varchar(50));

--- Create sequence for auto increment ---
CREATE SEQUENCE seq_ID
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 20;
 
-- if you are truncate table you should reset sequence with this code:
alter sequence seq_id restart start with 1;


--- Create relationship section ---
Alter table customer
ADD CONSTRAINT CUST_BRANCH_FK FOREIGN KEY( BRANCH_CODE)
REFERENCES BRANCH(CODE);

ALTER TABLE Customer_Document
ADD CONSTRAINT DOC_CLIENT_ID_FK FOREIGN KEY (CLIENT_ID)
REFERENCES customer(ID);

ALTER TABLE Employee_info
ADD CONSTRAINT EMP_CLIENT_ID_FK FOREIGN KEY (CLIENT_ID)
REFERENCES customer(ID);

ALTER TABLE Account
ADD CONSTRAINT ACC_ID_FK FOREIGN KEY (CLIENT_ID)
REFERENCES customer(ID);

ALTER TABLE Account
ADD CONSTRAINT ACC_CUR_ID_FK FOREIGN KEY (CURRENCY_ID)
REFERENCES currency(ID);

ALTER TABLE Account
ADD CONSTRAINT ACC_BRC_FK FOREIGN KEY (BRANCH_CODE)
REFERENCES BRANCH(CODE);

ALTER TABLE CARD
ADD CONSTRAINT CA_CL_ID_FK FOREIGN KEY (CLIENT_ID)
REFERENCES customer(ID);

ALTER TABLE CARD
ADD CONSTRAINT CA_BR_FK FOREIGN KEY (BRANCH_CODE)
REFERENCES BRANCH(CODE);

ALTER TABLE CARD
ADD CONSTRAINT CA_AC_ID_FK FOREIGN KEY (ACCOUNT_ID)
REFERENCES Account(ID);

ALTER TABLE CARD
ADD CONSTRAINT CA_CA_CU_FK FOREIGN KEY (CURRENCY_ID)
REFERENCES CURRENCY(ID);


ALTER TABLE CREDIT_CONTRACTS
ADD CONSTRAINT CA_CR_CON_ID_FK FOREIGN KEY (CLIENT_ID)
REFERENCES customer(ID);

ALTER TABLE CREDIT_CONTRACTS
ADD CONSTRAINT CA_CR_GUA_ID_FK FOREIGN KEY (guarantor_client_id)
REFERENCES customer(ID);

ALTER TABLE CREDIT_CONTRACTS
ADD CONSTRAINT CA_PR_ID_FK FOREIGN KEY (product_code)
REFERENCES PRODUCT(CODE);

ALTER TABLE CREDIT_CONTRACTS
ADD CONSTRAINT CA_BR_ID_FK FOREIGN KEY (branch_code)
REFERENCES BRANCH(CODE);

ALTER TABLE CREDIT_CONTRACTS
ADD CONSTRAINT CA_CUR_ID_FK FOREIGN KEY (CURRENCY_ID)
REFERENCES CURRENCY(ID);

ALTER TABLE TRANSACTION
ADD CONSTRAINTS TR_CL_IDFK FOREIGN KEY (CLIENT_ID)
REFERENCES customer(ID);

-- Create Trigger for modified column data in the tables --
-- Trigger for amount column in transaction table. If amount modified by someone log_info table will contain with modified values
CREATE OR REPLACE TRIGGER trg_log_for_trans_amount
  AFTER Delete or UPDATE or Insert  ON transaction
 FOR EACH ROW

DECLARE
  username    varchar2(20);
  log_action varchar(50);
  v_ID number(8);

BEGIN
  -- get current login user
  SELECT USER INTO username FROM dual;
  
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  end if;
  
  IF INSERTING then
    v_ID := :new.client_id;
  ELSE
     v_ID := :old.client_id;
  end if;
  -- Insert new values into log table.
  INSERT INTO log_info
    (ID,
     Client_ID,
     Old_value,
     New_value,
     Log_date,
     Operation_type,
     Table_Name,
     Column_name,
     User_name)
  VALUES
    (seq_id.nextva l,
     v_ID,
     :OLD.amount,
     :NEW.amount,
     sysdate,
     log_action,
     'Transaction',
     'Amount',
     username);
END;

-- Trigger for customer's salary information. When salary column modified by someone trigger will run and log_info table will contain with modified values.
CREATE OR REPLACE TRIGGER trg_log_for_salary
  AFTER Delete or UPDATE or Insert  ON Employee_info
 FOR EACH ROW

DECLARE
  username    varchar2(20);
  log_action varchar(50);
  v_ID number(8);

BEGIN
  -- get current login user
  SELECT USER INTO username FROM dual;
  
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  end if;
  
   IF INSERTING then
    v_ID := :new.client_id;
  ELSE
     v_ID := :old.client_id;
  end if;
  -- Insert new values into log table.
  INSERT INTO log_info
    (ID,
     Client_ID,
     Old_value,
     New_value,
     Log_date,
     Operation_type,
     Table_Name,
     Column_name,
     User_name)
  VALUES
    (seq_id.nextva l, 
     v_ID,
     :OLD.salary,
     :NEW.salary,
     sysdate,
     log_action,
     'Employee_info',
     'Salary',
     username);
END;


