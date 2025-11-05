SELECT * FROM BOOKS;
SELECT * FROM BRANCH;
SELECT * FROM EMPLOYEES;
SELECT * FROM ISSUED_STATUS;
SELECT * FROM RETURN_STATUS;
SELECT * FROM MEMBERS;
------------- PROJECT TASK--------------------
---- 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO BOOKS VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

----- 2: Update an Existing Member's Address
UPDATE MEMBERS
 SET 
MEMBER_ADDRESS= '125 OAK ST' WHERE 
MEMBER_ADDRESS='123 Main St';

 --- 3.Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
 
 DELETE FROM ISSUED_STATUS WHERE ISSUED_ID='IS121';
 
 ---- 4.Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
 
SELECT * FROM EMPLOYEES WHERE EMP_ID='E101';

----- 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT  COUNT(*) AS ISSUED ,
  ISSUED_EMP_ID 
FROM 
  ISSUED_STATUS GROUP BY 
  ISSUED_EMP_ID HAVING COUNT(*)>1;
  
------- 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

CREATE TABLE BOOK_ISSUED_CNT AS 
SELECT B.ISBN, B.BOOK_TITLE,COUNT(IST.ISSUED_ID) as ISSUED_COUNT
FROM ISSUED_STATUS AS IST
JOIN BOOKS AS B
ON IST.ISSUED_BOOK_ISBN=B.ISBN
GROUP BY B.ISBN, B.BOOK_TITLE;

SELECT * FROM BOOK_ISSUED_CNT;

---------------- Data Analysis & Findings ----------------

---- 7. Retrieve All Books in a Specific Category

SELECT * FROM BOOKS WHERE CATEGORY='FICTION';

---- 8: Find Total Rental Income by Category
SELECT 
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM 
issued_status as ist
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY 1;

---- 9.List Members Who Registered in the Last 700 Days?

SELECT *FROM MEMBERS
WHERE REG_DATE >= CURDATE() - INTERVAL 700 DAY;

---- 10.LIST EMPLOYEES WITH THEIR BRANCH MANAGER NAME AND THERE BRACH DETAILS?

SELECT E1.*,E2.EMP_NAME,B1.BRANCH_ID,B1.MANAGER_ID FROM
 EMPLOYEES AS E1
JOIN BRANCH AS B1 ON
E1.BRANCH_ID=B1.BRANCH_ID
JOIN 
EMPLOYEES AS E2
ON B1.MANAGER_ID=E2.EMP_ID;

---- 11. CREATE A TABLE OF BOOKS WITH A RENTAL PRICE ABOVE A CERTAIN THRESHOLD 7 USD?

CREATE TABLE BOOKS_PRICE_GREATERTHAN_7
AS
SELECT * FROM BOOKS WHERE RENTAL_PRICE>7;

SELECT * FROM  BOOKS_PRICE_GREATERTHAN_7;

---- 12. RETRIEVE THE BOOKS WHICH ARE NOT RETURNED YET?

SELECT IST.ISSUED_ID,IST.ISSUED_BOOK_NAME,IST.ISSUED_DATE FROM 
ISSUED_STATUS AS IST
LEFT JOIN
RETURN_STATUS AS RST
ON
IST.ISSUED_ID=RST.ISSUED_ID
WHERE RST.RETURN_ID IS NULL;

SELECT * FROM BRANCH;
SELECT * FROM BOOKS;
SELECT * FROM EMPLOYEES;
SELECT * FROM ISSUED_STATUS;
SELECT * FROM RETURN_STATUS;
SELECT * FROM MEMBERS;

--- 13: Identify Members with Overdue Books
--- Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

-- ISSUED STATUS == MEMBERS == BOOKS == RETURN_STATUS

SELECT IST.ISSUED_MEMBER_ID,
M.MEMBER_NAME,
B.BOOK_TITLE,
IST.ISSUED_DATE,
RST.RETURN_DATE,
CURDATE()-IST.ISSUED_DATE AS OVER_DUE_DAYS
 FROM ISSUED_STATUS AS IST JOIN
MEMBERS AS M ON IST.ISSUED_MEMBER_ID = M.MEMBER_ID
JOIN 
BOOKS AS B ON B.ISBN=IST.ISSUED_BOOK_ISBN
LEFT JOIN
RETURN_STATUS AS RST ON
RST.ISSUED_ID = IST.ISSUED_ID
WHERE RST.RETURN_DATE IS NULL AND
(CURDATE() - IST.ISSUED_DATE)> 30 ORDER BY OVER_DUE_DAYS;


