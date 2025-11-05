--- LIBRARY MANAGEMENT SYSTEM PROJECT -----
CREATE DATABASE LIBRARY_PROJECT_2;
USE LIBRARY_PROJECT_2;
CREATE TABLE BRANCH
(
 branch_id VARCHAR(10) PRIMARY KEY,
 manager_id VARCHAR(10),
 branch_address VARCHAR(55),
 contact_no VARCHAR(15)
 );
 SHOW TABLES;
 drop table employees;
 
 CREATE TABLE EMPLOYEES
 (
 emp_id VARCHAR(10) primary key,
 emp_name VARCHAR(25),
 position VARCHAR(25),
 salary INT,
 branch_id VARCHAR(20)  -- Foriegn key
 );
 
 CREATE TABLE BOOKS
 (
 isbn VARCHAR(20) PRIMARY KEY,
 book_title VARCHAR (75),
 category VARCHAR(10),
 rental_price FLOAT,
 status VARCHAR(15),
 author VARCHAR(35),
 publisher VARCHAR(55)
 );
 
 
 CREATE TABLE MEMBERS
 (
  member_id VARCHAR(15) PRIMARY KEY,
  member_name VARCHAR(25),
  member_address VARCHAR(75),
  reg_date DATE
  );
  
  CREATE TABLE ISSUED_STATUS
  (
    issued_id VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(10), -- Foriegn Key
    issued_book_name VARCHAR(75),
    issued_date DATE,
    issued_book_isbn VARCHAR(25),  -- Foriegn key	
    issued_emp_id VARCHAR(10) -- Foriegn key
);

CREATE TABLE RETURN_STATUS
(
  return_id VARCHAR(10) PRIMARY KEY,
  issued_id VARCHAR(10),
  return_book_name VARCHAR(75),
  return_date DATE,
  return_book_isbn VARCHAR(20)
);


----- ADDING FORIEGN KEYS

ALTER TABLE ISSUED_STATUS
ADD CONSTRAINT FK_MEMBERS
FOREIGN KEY (ISSUED_MEMBER_ID)
REFERENCES MEMBERS(MEMBER_ID);

ALTER TABLE ISSUED_STATUS
ADD CONSTRAINT FK_BOOKS
FOREIGN KEY (ISSUED_BOOK_ISBN)
REFERENCES BOOKS(ISBN);

ALTER TABLE ISSUED_STATUS
ADD CONSTRAINT FK_employees
FOREIGN KEY (issued_emp_id)
REFERENCES EMPLOYEES(emp_id);

ALTER TABLE employees
ADD CONSTRAINT FK_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

ALTER TABLE return_status
ADD CONSTRAINT FK_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_stauts(issued_id);




