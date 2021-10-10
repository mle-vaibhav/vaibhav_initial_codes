use my_first_db
create table employee_table
(employee_id int
,first_name varchar(100)
,last_name varchar(100)
,salary int
,[Address] varchar(500)
)
select * from employee_table

insert into employee_table
(employee_id,
first_name,
last_name,
salary,
[Address]
)
select 1,'v','t',10,'ind' union all
select 2,'d','k',12,'ind'

--updating values in the table 
select * 
from employee_table as emp 
where employee_id =1 
--value to be changed checked using above statement 
update emp 
set first_name='Vaibhav'
from employee_table as emp
where employee_id=1
--updating lastname for employee id 1
update emp
set last_name ='Tiwari'
from employee_table as emp 
where employee_id=1
--updating salary and then location 
update emp 
set salary = 10000
from employee_table as emp
where employee_id=1
update emp
set [Address] = 'India'
from employee_table as emp
where employee_id=1
select * from employee_table 
where employee_id=1
-- updating same values for employe_id 2 
select * 
from employee_table as emp
where employee_id =2
--updating
update emp 
set first_name ='Dinesh'
from employee_table as emp
where employee_id=2
update emp
set last_name='Kumar'
from employee_table as emp
where employee_id=2
update emp
set salary = 12000
from employee_table as emp
where employee_id=2
update emp 
set [Address] ='India'
from employee_table as emp
where employee_id=2

select * from employee_table
--inserting few more values in the employee_table

insert into employee_table
(employee_id,
first_name,
last_name,
salary,
[Address]
)
select 3,'Donald','Trumph',8000,'USA' union all --UNION ALL combines all the rows into single data set 
select 4,'Joe','Biden',15000,'USA' union all    -- it is similar to RBIND  in R
select 5,'Imran','Khan',3000,'Pak' union all
select 6,'Parvez','Musharaf',1000,'Pak' union all
select 7,'Amit','Shah',11000,'India'

select * from employee_table

--WE can also create schema in similar way and attach it to table and that can be find in security in object explorer
CREATE SCHEMA electronics
GO
CREATE TABLE electronics.employee --we created employee table within electronics schema 
(employeeid int
,employeefirstname varchar(100)
,employeelastname varchar(100)
,salary int
,[address] varchar(500)
)
GO
CREATE SCHEMA clothing
GO
CREATE TABLE clothing.employee --we created employee table within clothing schema 
(employeeid int
,employeefirstname varchar(100)
,employeelastname varchar(100)
,salary int
,[address] varchar(500)
)
GO
--dbo is the default schema name.
DROP TABLE employee
GO
--UNION & UNION ALL
-- UNION gives us unique values in the table 
SELECT 1,'Dinesh' UNION 
SELECT 1,'Dinesh' UNION 
SELECT 2,'Dinesh' -- it eliminated one of the '1,dinesh' because it removes duplicate rows and gives only unique values
--UNION ALL gives whatever values given to it 
SELECT 1,'Dinesh' UNION ALL
SELECT 1,'Dinesh' UNION ALL
SELECT 2,'Dinesh'
--Inserting value in employee table using VALUES instead of SELECT
INSERT INTO employee_table
(employee_id,
first_name,
last_name,
salary,
[Address]
)
VALUES(8,'Anand','Mahindra',100000,'India'), --make sure that the sequence of column_names in insert into must be
(9,'Ratan','Tata',1200000,'India')           --followed by VALUES/SELECT

select * 
from employee_table

--CONSTRAINTS 
--NOT NULL
CREATE TABLE NotNullTest
(id int NOT NULL     --whenever we add NOT NULL constraint to any col we are making it mandatory col.
,Name varchar(100)
)
INSERT INTO NotNullTest
(ID,Name)
select 1,'Ashok' --since none of the value is null query executed successfully
--inserting another value
insert into NotNullTest
(id,Name)
select 2,NUll --since we have no constraint attched to the name column and by default cols are nullable
              -- that's why name col accepted null value
insert into NotNullTest
(id,Name)
select Null,'Akbar'--this query could not be executed because we have attached NOT NULL constraint to id col
                   -- and we are tring to insert Null in not null col
insert into NotNullTest
(id,Name)
select 3,'Akbar'
select * from NotNullTest 
--every time we run a query it is freshly excecuted and values will be added to the table
--suppose we run same insert into query multiple times then same values will be added multiple times.

--UNIQUE(allows only unique values in the column,one null values is allowed in each unique col)

CREATE TABLE UniqueTest
(id int UNIQUE,
Name varchar(100)
)

INSERT INTO UniqueTest (id,Name)
SELECT 1,'Ashok'
--let's try to insert same value for id
INSERT INTO UniqueTest (id,Name)
SELECT 1,'Akbar' --since we have attached unique constraint to id col we cannot insert duplicate values in it.

insert into UniqueTest (id,Name)
select 2,'Ashok'

--unique constraint allow one null value let's check that too
insert into UniqueTest (id,Name)
select Null,'Samudragupt'	--this query will be executed only once since only one null value is allowed 
select * from UniqueTest

--PRIMARY KEY(its a combination of unique and not null constraint,this makes col unique and mandatory)

CREATE TABLE PrimaryKeyTest
(id int PRIMARY KEY
,Name varchar(100)
)
INSERT INTO PrimaryKeyTest (id,Name)
SELECT 1,'Ashok'
--Inserting duplicate value in the primary key
INSERT INTO PrimaryKeyTest (id,Name)
SELECT 1,'Akbar' --since we attched primary key costraint to id we cannot put duplicate and null value to it
--Inserting Null value to primary key col
INSERT INTO PrimaryKeyTest(id,Name)
SELECT NULL,'Amuit'
INSERT INTO PrimaryKeyTest
SELECT 2,'Samudragupt'
	select * from PrimaryKeyTest
--FOREIGN KEY
--FOREIGN KEY constraints(used only while establising relation between parent and child table)
--foreign key is a col in the child table in which values are inserted by refering to a col in parent table
--col which is refered in the parent table must be of PRIMARY KEY constraint 

CREATE TABLE ForeignKeyTest
(id int FOREIGN KEY REFERENCES PrimaryKeyTest(id) --in id col we attached foreign key constraint and to add values 
,DOB datetime                                    --it is being refered to PrimaryKeyTest table and its col id
)

--since we are referening to id col of PrimaryKeyTest in our child table values which are present in parent table will be allowed to enter
--in our case only those id which are present in PrimaryKeyTest will be allowed to be entered in ForeignKeyTest

INSERT INTO ForeignKeyTest (id,DOB)
SELECT 1,'03-04-1995' --SINCE ID 1 IS THERE IN PrimaryKeyTest IT IS ALLOWED 

INSERT INTO ForeignKeyTest (id,DOB)
SELECT 3,'01-02-1993' -- SINCE ID 3 IS NOT PRESENT IN PrimaryKeyTest THAT'S WHY IT COULD NOT BE EXECUTED

INSERT INTO ForeignKeyTest (ID,DOB)
SELECT 2,'03-03-1994'

SELECT * FROM ForeignKeyTest
-- VALUES WHICH ARE PRESENT IN THE PRIMARY KEY OF REFERENCE TABLE(PARENT) ARE ALLOWED TO BE ENTERED MULTIPPLE TIMES IN CHILD TABLE

--CHECK CONSTRAINT ( HELPS IN FEEDING VALUES OBEYING  CERTAIN CONDITION)

CREATE TABLE CheckTest
(id int,
Age int check(Age>=55)
)

INSERT INTO CheckTest (id,Age)
SELECT 1,56 --SINCE IT SATIFY THE CONDITION OF AGE>=55 IT IS EXCECUTED 

--LETS TO INSERT AGE LESS THAN 55
INSERT INTO CheckTest (id,Age)
SELECT 2,54 -- SINCE IT FAILED TO IDENTIFY THE CONDITION THE QUERY COULD NOT BE EXECUTED

INSERT INTO CheckTest (id,Age)
SELECT 2,61

-- CHECK CONSTRAINT CAN ALSO BE ADDED TO CHARACTER COL
CREATE TABLE CheckChar 
(Name varchar(100),
Age int,
isseniorcitizen varchar(100) check(isseniorcitizen IN ('Yes','No'))--THIS COL WILL ONLY ACCEPT YES OR NO
)
INSERT INTO CheckChar (Name,Age,isseniorcitizen)
SELECT 'Raghav',55,'No'

INSERT INTO CheckChar (Name,Age,isseniorcitizen)
SELECT 'Raman',61,'Yes'

INSERT INTO CheckChar (Name,Age,isseniorcitizen)
SELECT 'Rajat',26,'n' --since it is not meeting the conditon can't be excecuted 
--Note sql is not case sensitive, we can write no instead of No

--DEFAULT (When cols are left out it gives default value of null if col is nullable)
--if we want certain specific value in place of null we can use this constraint 

CREATE TABLE DefaultTest
(id int,
Name varchar(100) Default('NoNamesGiven')
)
INSERT INTO DefaultTest (id,Name)
SELECT 1,'Vinod'
SELECT * FROM DefaultTest
INSERT INTO DefaultTest (id)--SINCE HERE WE ARE NOT SPECIFIYING NAME IT WILL GIVE US DEFAULT VALUE 
SELECT 2
INSERT INTO DefaultTest (id,Name)
SELECT 2,NULL--HOWEVER WE CAN  HARD CODE NULL IN COLS WITH DEFAULT VALUES

--IDENTITY CONSTRAINT
--HELPS US IN GENERATING IDENTITY FOR EVERY COLUMN AUTOMATICALL BY  THE SYSTEM 
--HERE WE NEED TO SPECIFY START VALUE AND INCREMENTAL VALUE

CREATE TABLE Identitytest
(id int identity(1,1), --here the start value is 1 which is also called seed and values will increase by 1 called increment 
Name varchar(100)
)

INSERT INTO Identitytest (Name)--here we need to specify col with identity constraint since system will take care of it
SELECT 'Ravi' union
SELECT 'Kishan'

SELECT * FROM Identitytest

--WE CANNOT ENTER VALUES IN THE COL WITH IDENTITY CONSTRAINT, TO DO SO WE NEED TO USE COMMAND 'SET INSERT_IDENTITY TABLE_NAME ON'

SET IDENTITY_INSERT Identitytest ON 
GO

INSERT INTO Identitytest (id,Name)
SELECT 5,'John' -- if we do so and again turn off the identity_insert the system will start generating identity only from hightest value
                -- this is done by the system to avoid repetiton of the value in the col with identity constraint
SET IDENTITY_INSERT Identitytest OFF
GO

INSERT INTO Identitytest (Name)
SELECT 'Rambo'
select * from Identitytest

--DATA RETRIEVAL 

SELECT * 
FROM employee_table

--SELECT IS USED TO FILTER ALL THE COLUMNS 
--WHERE IS USED TO FILTER ALL THE ROWS 

--extracting columns 
SELECT 
emp.first_name, emp.[Address]
FROM employee_table AS emp

--extracting rows
SELECT * 
FROM employee_table AS emp 
WHERE first_name ='Joe'

SELECT * 
FROM employee_table AS emp
WHERE [Address]='India'

--extracting multiple values from the table
SELECT * 
FROM employee_table AS emp
WHERE employee_id IN (1,5,7)

--EXTRACTING ROWS WITH EXCEPTION OF MENTIONED ROWS 
SELECT *
FROM employee_table AS emp
WHERE NOT [Address]  IN ('India') --FROM THUS QUERY WE GOT VALUES EXCEPT FROM INDIA 

--EXTRACTING ROWS USING CONDITIONAL STATEMENT (<,>,!=,AND,OR)
SELECT * 
FROM employee_table AS emp
WHERE employee_id > 3

SELECT * 
FROM employee_table AS emp
WHERE employee_id != 1

SELECT * 
FROM employee_table AS emp 
WHERE employee_id <= 3

SELECT * 
FROM employee_table AS emp
WHERE employee_id > 2 AND [Address]= 'India'

SELECT * 
FROM employee_table 
WHERE employee_id < 3 OR [Address] = 'USA'

SELECT * 
FROM employee_table
WHERE employee_id BETWEEN 3 AND 5

--DISTINCT (GIVES US ONLY UNIQUE VALUES FROM THE TABLE)
--if multiple columns are selected then their combination will be considered distinct or same

SELECT DISTINCT [Address]
FROM employee_table -- THIS GIVES ONLY UNIQUE VALUES FROM COLUMN ADDRESS

SELECT DISTINCT first_name, [Address]
FROM employee_table 

--TOP CLAUSE( IT WORKS AS SAMPLE FUNCTION AND NOT GIVES US TOPN VALUES FROM TABLE)

SELECT TOP 5 *
FROM employee_table
WHERE [Address]='India'

--LIKE OPERATOR 
--HELPS US IN IDENTIFYING PATTERN IN TEXT VALUES

SELECT * 
FROM employee_table
WHERE first_name LIKE '%a%'-- gives us values from first name col which has 'a' in between 

SELECT * 
FROM employee_table
WHERE last_name LIKE 't%'

--JOINS 
--THERE ARE 3 MAJOR TYPES OF JOIN
--INNER JOIN,OUTER JOIN(LEFT OUTER/RIGHT OUTER/FULL OUTER JOIN)
--CROSS JOIN

--CREATING ANOTHER TABLE FOR JOIN 

CREATE TABLE employee_dob
(employee_id int
,employee_dob datetime2
)
INSERT INTO employee_dob
(employee_id
,employee_dob)
SELECT 1,GETDATE()-7000 UNION ALL --GETDATE() WILL GIVE US TODAYS DATE AND TIME AND WE SUBSTRACED DAYS WITH IT TO GET DOB
SELECT 2,GETDATE()-6000 UNION ALL -- DATA TYPE DATETIME2 HOLDS DATE & TIME WITH MILLI SEC PRECISION
SELECT 3,GETDATE()-6788 UNION ALL
SELECT 4,GETDATE()-8968 UNION ALL
SELECT 5,GETDATE()-3424 UNION ALL
SELECT 6,GETDATE()-4365 UNION ALL
SELECT 7,GETDATE()-34345 UNION ALL
SELECT 8,GETDATE()-46456 UNION ALL
SELECT 9,GETDATE()-3455 UNION ALL
SELECT 10,GETDATE()-2434 UNION ALL
SELECT 11,GETDATE()-5647 UNION ALL
SELECT 12,GETDATE()-4564 

SELECT * FROM employee_dob
SELECT * FROM employee_table

--INNER JOIN 
--GIVES COMMON RECORD FROM BOTH THE TABLES

SELECT * 
FROM employee_table As emp
INNER JOIN employee_dob AS edob ON emp.employee_id = edob.employee_id
--WE HAVE 12 RECORDS IN EMPLOYEE.DOB TABLE BUT WE GOT ONLY VALUES UPTILL 9 BECAUSE WE 9 RECORDS IN COMMON

--WE CAN ALSO SPECIFY COLS WE WANT IN JOIN
SELECT emp.employee_id,first_name,last_name,employee_dob --we specified alias name on employee_id because it's a 
FROM employee_table AS emp                              --common col in both table to specify from which table we want it
INNER JOIN employee_dob AS edob ON edob.employee_id= emp.employee_id

-- IN SELECT SATEMENT WE SPECIFIED COL NAMES FROM BOTH TABLES AND GAVE ALIAS NAME TO COMMON COLS SO THAT OUR SYSTEM WON'T GET CONFUSED 

SELECT emp.employee_id,first_name,employee_dob
FROM employee_table AS emp 
INNER JOIN employee_dob AS edob ON edob.employee_id=emp.employee_id -- we can keep on incrementing this line if we want to create join between multiple tables

--LEFT OUTER JOIN (gives all the records from left table and only common record from right)
SELECT * 
FROM employee_table AS emp
LEFT OUTER JOIN employee_dob AS edob ON edob.employee_id= emp.employee_id
where edob.employee_dob is null -- this will give us the record that are present in left but not in right side table
--in the above query we use 'IS' and not '=' because we don't have quantity we simply have null records.

--RIGHT OUTER JOIN(gives all the records from right side table and only common from the left table )
SELECT * 
FROM employee_table AS EMP 
RIGHT OUTER JOIN employee_dob AS edob ON edob.employee_id=emp.employee_id
WHERE emp.employee_id is null -- this will gives us the values that are present in right but not in left 

--FULL OUTER JOIN(gives all the values from both right and left hand side table)

SELECT * 
FROM employee_table AS emp
FULL OUTER JOIN employee_dob as edob ON edob.employee_id=emp.employee_id
WHERE emp.employee_id IS NULL OR edob.employee_dob IS NULL

--CROSS JOIN( its a cartesian product of right and left hand side table )
--in this all the records from left will be joined with all the records from right 

select * from employee_table as emp
cross join employee_dob as edob -- here we don't have 'ON' conditon here since we need no to specify common cols
-- this join will be useful when we have months on the left table and date on the right table,
--by joining them we'll get date of each month of the day

CREATE TABLE MONTHS
(Months varchar (100))
INSERT INTO MONTHS (Months)
SELECT 'JAN' UNION ALL
SELECT 'FEB' UNION ALL
SELECT 'MAR' UNION ALL
SELECT 'APR' UNION ALL
SELECT 'MAY' UNION ALL
SELECT 'JUN' UNION ALL
SELECT 'JUL' UNION ALL
SELECT 'AUG' UNION ALL
SELECT 'SEPT'UNION ALL
SELECT 'OCT' UNION ALL
SELECT 'NOV' UNION ALL
SELECT 'DEC'

SELECT  first_name,last_name,Months FROM employee_table
CROSS JOIN MONTHS -- by using this we can keep the record of each employee throughout the year

--UPDATE & DELETE 
--MUST TAKE BACKUP BEFORE PERFORMING UPDATE OR DELETE 
-- WE CAN CREATE BACKUP BY USING SIMPLE 'INTO' COMMAND 

--BACKUP TABLE QUERY 
SELECT * 
INTO employee_backup 
FROM employee_table --WE CAN ALSO USE 'WHERE' CLAUSE IF WE DON'T WANT WHOLE DATA INSTEAD FEW RECORDS 

--BACKUP FEW ROWS ONLY 
SELECT * 
INTO employee_rowbackup
FROM employee_table
WHERE employee_id IN (3,5,7)

SELECT * FROM employee_table
SELECT * FROM employee_backup
SELECT * FROM employee_rowbackup

--BACKUP FEW COLUMNS 
SELECT employee_id,first_name,salary,[Address]
INTO employee_colsbackup
FROM employee_table
WHERE employee_id IN (1,3,5)

SELECT * FROM employee_colsbackup


--UPDATE 

SELECT * 
FROM employee_table
WHERE employee_id = 8
 

UPDATE employee_table
SET first_name = 'Delete this row'
WHERE employee_id =8

--UPDATING WITH ALIAS NAME 

UPDATE	emp 
set last_name = 'Delete'
FROM employee_table AS emp 
WHERE employee_id =8

--DONOT FORGET TO USE WHERE CLAUSE, IF WE FORGOT THEN FOLLOWING WILL BE THE RESULT 

UPDATE emp 
SET first_name = 'error'
FROM employee_table AS emp

SELECT * FROM employee_table

--REVERTING BACK TO ORIGINAL DATA USING BACKUP

--FIRST LET'S COMPARE DATA WHICH IS UPDATED AND ITS ORIGINAL FORM

SELECT emp.employee_id,emp.first_name AS [updated_name], bak.first_name as [original_name]
FROM employee_table AS emp
INNER JOIN employee_backup AS bak ON bak.employee_id= emp.employee_id--from  this query we can compare side by original and updated

--UPDATING 
UPDATE emp
SET emp.first_name = bak.first_name 
FROM employee_table AS emp
INNER JOIN employee_backup AS bak ON bak.employee_id =emp.employee_id

--INNER JOIN IS USED WHILE REVERTING TO ORIGIAL DATA BECAUSE WE ARE USING 2 TABLE AND IN FROM ONLY 1 TABLE CAN BE SPECIFIED 

--DELETE(SYNTAX IS SIMILAR TO UPDATE)
SELECT * 
FROM employee_table
WHERE employee_id =8

DELETE emp 
FROM employee_table AS emp 
WHERE employee_id =8

DELETE emp 
FROM employee_table AS emp 
WHERE employee_id IN (3,4,5,6,7)--PERFORED THESE DELETE OPERATION SINCE MULTIPLE ENTRIES WITH SAME RECORD HAS BEEN ENTERED MULTIPLE TIMES

--taking bakup of backup 
SELECT * 
INTO employee_backupofbackup
FROM employee_backup

--DELETING SOME RECORDS FROM BACKUP OF BACKUP TABLE

DELETE bakofbak
FROM employee_backupofbackup AS bakofbak
WHERE employee_id IN (8,9,3,4,5)

--RESTORING VALUES OF BACKUP OF BACKUP TABLE FROM BACKUP TABLE 
INSERT INTO employee_backupofbackup
(employee_id,
first_name,
last_name,
salary,
[Address]
)
SELECT employee_id,    --IN THIS WAY WE RESTORE DATA WHICH HAS BEEN DELETED 
first_name,
last_name,
salary,
[Address]
FROM employee_backup
WHERE employee_id IN (8,9,3,4,5)
 
---------------------------------------------------------------------------------------------------------------
--MERGE JOIN

SELECT * FROM employee_table --SOURCE TABLE

--CREATING TARGET TABLE WITH SAME STRUCTURE AS employee_table

CREATE TABLE salaryemployeecollection--TARGET TABLE 
(employee_id int,
first_name varchar(100),
last_name varchar (100),
salary int,
[Address] varchar(500)
)
--MERGE STATEMENT 

MERGE salaryemployeecollection AS Target 
USING employee_table AS Source 
ON (Target.employee_id = Source.employee_id)-- LIKE OTHER JOINS WE NEED TO SPECIFY COMMON COLUMNS 

WHEN MATCHED AND (Target.first_name !=Source.first_name
or Target.last_name != Source.last_name or Target.Salary != Source.Salary or Target.[Address] != Source.[Address])
THEN UPDATE 
SET Target.first_name =Source.first_name,
Target.last_name = Source.last_name,
Target.Salary = Source.Salary,
Target.[Address] = Source.[Address] --UPDATE IS PERFORMED WHEN COMMON COLS MATCHES BUT VALUES IN THE TARGET DOESN'T MATCH WITH SOURCE 

WHEN NOT MATCHED BY TARGET 
THEN INSERT (employee_id,first_name,last_name,Salary,[Address])
VALUES (Source.employee_id,Source.first_name,Source.last_name,Source.Salary,Source.[Address])

WHEN NOT MATCHED BY Source 
THEN DELETE;

--WE CAN SCHEDULE THIS MERGE OPERATON ON AGENT AND NEED TO RUN IT MANUALLY
SELECT * FROM salaryemployeecollection
SELECT * FROM employee_table
--CHECKING WHETHER OUR MERGE IS WORKING OR NOT 
--WE HAVE 7 ENTRIES IN OUR EMPLOYEE TABLE INSERTING ONE MORE RECORD TO IT AND UPDATIND COUNTRY NAME 
INSERT INTO employee_table
(employee_id,
first_name,
last_name,
salary,
[Address])
SELECT 8,'Justin','Trudeau',12234,'Canada'

UPDATE emp
SET [Address] ='Pakistan'
FROM employee_table AS emp
WHERE Address ='Pak'
--we dont have above insert and update in our salaryemployeecollection table running again merge statement 

/*MERGE TARGET_TABLE_NAME AS TARGET 
USING SOURCE_TABLE_NAME AS SOURCE 
ON (TARGET.ID = SOURCE.ID)-- SPECIFYING COMMON COLUMN TO CREATE JOIN 

WHEN MATCHED AND (TARGET.FIRSTNAME != SOURCE.FIRSTNAME OR TARGET.LASTNAME != SOURCE.LASTNAME OR TARGET.ADDRESS != SOURCE.ADDRESS
OR TARGET.SALARY != SOURCE,=.SALARY)
THEN UPDATE 
SET TARGET.FIRSTNAME=SOURCE.FIRSTNAME,TARGET.LASTNAME = SOURCE.LASTNAME,TARGET.ADDRESS = SOURCE.ADDRESS,
TARGET.SALARY = SOURCE,=.SALARY

WHEN NOT MATCHED BY TARGET 
THEN INSERT (ID,FIRSTNAME,LASTNAME,SALARY,ADDRESS)
VALUES(SOURCE.ID,SOURCE.FIRSTNAME,SOURCE.LASTNAME,SOURCE.SALARY,SOURCE.ADDRESS)
WHEN NOT MATCHED BY SOURCE 
THEN DELETE;
*/


----------------------------------------------------------------------------------------------------
	--ALTER TABLE
		--WITH THIS WE CAN ALTER THE STRUCTURE OF THE TABLE.
		--BY ADDING A COL,REMOVING A COLUMN,ALTERING A COLUMN.

SELECT * FROM DefaultTest

CREATE TABLE altertabletest -- we have only two cols at the time of table creation.
(id int,
Name varchar(100)
)
INSERT INTO altertabletest
(id,Name)
SELECT 1,'Ramesh' UNION ALL
SELECT 2,'Suresh' UNION ALL
SELECT 3,'Brajesh' UNION ALL
SELECT 4,'Gajesh'UNION ALL
SELECT 5,'Rakesh'

SELECT * FROM altertabletest
--REMEMBER WE CANNOT ADD 'NOT-NULL' COLUMN IN THE TABLE BECAUSE OUR SERVER WON'T KNOW WHAT VALUE TO INSERT IN NEW COL
-- WE CAN ADD 'NOT-NULL' COL ONLY WHEN WE HAVE DEFAULT CONSTRAINT ATTACHED TO IT.

--ADDING NOT-NULL COL TO altertabletest
ALTER TABLE altertabletest
ADD Salary int NOT NULL DEFAULT(0)

-- ADDING NULLABLE COLUMN 
ALTER TABLE altertabletest --this col is nullable 
ADD [Address] varchar(500) 

--DROPPING A COLUMN 
	--WE CAN DROP A COLUMN WITHOUT CONSTRAINT DIRECTLY 
	--TO DROP A COLUMN WITH CONSTRAINT, WE FIRST NEED TO DROP THE CONSTRAINT AND THE THEN THE CO
	--SYNTYAX OF DROPPING THE CONSTRAINT IS SIMILAR TO DROPPING THE COLUMN.
	--TO DROP THE CONSTRAINT COPY CONSTRAINT NAME FROM META-DATA 

ALTER TABLE altertabletest--SINCE CONSTRAIN IS ATTACHED TO THIS COL WE CANNOT DROP IT DIRECTLY, WE NEED TO DROP CONSTRAINT FIRST
DROP COLUMN Salary

ALTER TABLE altertabletest
DROP CONSTRAINT DF__altertabl__Salar__320C68B7 --COPIED THIS FROM METADATA (ALT+F1)

ALTER TABLE altertabletest
DROP COLUMN Salary

SELECT * FROM altertabletest

--ALTER A COLUMN 
	--MAKE SURE THAT ANY ALTERATION WHICH IS TO BE MADE IN THE COLUMN MUST ME OBEYED BY THE DATA ALREADY EXISTING 

ALTER TABLE altertabletest
ALTER COLUMN NAME VARCHAR(110) NOT NULL--HERE WE ALTERED COLUMN 'NAME' WHICH EARLIER ACCEPTED 100 CHARATERS NOW ACCEPTS 100 AND IT NOT NULLABLE


--------------------------------------
--TEMPORARY TABLES.
	--LOCAL TEMP TABLES #
	--GLOBAL TEMP TABLES ##
	--TEMP TABLE CAN BE CREATED USING SYNTAX SIMILAR TO NORMAL TABLES AND INSERT VALUES IN SAME WAY.

CREATE TABLE #first_local_temptable --THIS TABLE IS AVAILABLE IN THIS SESSION ONLY, IF WE CLOSE THE SESSION THE TABLE WILL BE DELETED BY SQL
(id int,
Name varchar(100)
)

INSERT INTO #first_local_temptable
(id,Name)
SELECT 1,'John' UNION ALL
SELECT 2,'Jacob' UNION ALL
SELECT 3,'Jack' UNION ALL
SELECT 4,'Jackel'

SELECT * FROM #first_local_temptable

--GLOBAL TEMP TABLE ##
	--THIS TABLE CAN BE ACCESSED IN ALL THE SESSIONS AND ALL THE USERS WHO HAVE ACCESS TO THE DB
	--CREATED IN THE SAME WAYS AS LOCAL TEMP TABLE WITH THE DIFFERENCE OF ## BEFOR TABLE NAME 

CREATE TABLE ##first_global_temptable
(id int,
Name Varchar(100)
)

INSERT INTO ##first_global_temptable --like temp this table too will be deleted automatically once the parent session is closed
(id,Name)
SELECT 1,'Modi' UNION ALL
SELECT 2,'Shah' UNION ALL
SELECT 3,'Rajnath' UNION ALL
SELECT 4,'Sitharaman' 

--we can created join between local and global temp tables 
SELECT * FROM #first_local_temptable AS LT
INNER JOIN ##first_global_temptable AS GT ON LT.id= GT.id

--TABLE VARIABLE 
	-- IT IS SIMILAR TO THE VARIABLES USED IN OTHER LANGUAGE TO STORE THE VALUES 
	--WE NEED TO USE @ SYMBOL BEFORE VARIABLE NAME.
	--SCOPE OF VARIBALE IS INTSIDE THE QUERY WHERE IT IS CREATED 

DECLARE @ID INT --THIS 3 LINES OF QUERY MUST BE EXECUTED TO TOGETHER TO BRING IT IN SAME SCOPE
SET @ID = 5
SELECT @ID AS id --if we execute any of the lines seprately this not work.
--above is int variable 
DECLARE @name varchar(100) = 'Vaibhav' --varchar variable 
SELECT @name AS Name

DECLARE @table_variable TABLE  --THIS IS HOW A TABLE VARIABLE IS CREATED.
(id int,
Name varchar(100)
)
INSERT INTO @table_variable
(id,Name)
SELECT 1,'TABLE VARIBLE' UNION ALL --ALL LINES MUST BE EXECUTED AT ONCE OTHERWISE VARIBALE WILL NOT WORK
SELECT 2,'IS CREATED'UNION ALL
SELECT 3,'LIKE THIS'
SELECT * FROM @table_variable
--TABLES VARIABLES ARE RARELY USED, USE ONLY WHEN WE HAVE SMALL AMOUNT OF DATA 
--WE CAN ALSO CREATE JOIN IN THIS TOO BUT NEED TO EXECUTE IT FROM DECLARE TO JOIN STATEMENT
SELECT * FROM @table_variable AS tv
INNER JOIN #first_local_temptable AS lt ON lt.id=tv.id

-----------------------------------------------------------
	--FUNCTIONS
		--IT IS A SET OF SQL QUERY WHICH ACCEPTS QUERY AND GIVE RESULTS 
		--FUNCTIONS CAN'T BE USED TO INSERT/UPDATE/DELETE DATA FROM TABLE

--SYETEN DEFIEND FUNCTION 
	--SCALAR FUNCTION:- RETURNS SINGLE VALUE OR SINGLE CELL VALUE FROM TABLE \
		--DATETIME FUNCTION :- THIS FUN HELPS US IN BUILDING DATE RANGE	MATRIX 
			--WE NEED NOT TO PROVIDE INPUT IN DATE-TIME FN 

SELECT GETDATE()--THIS WILL RETURN CURRENT SERVER DATE-TIME. 
SELECT GETUTCDATE()--THIS GIVE UNIVERSAL TIME CO-ORDINATED DATE
SELECT GETDATE()+2 --THIS WILL ADD TWO DAYS TO CURRENT SERVER DATE TIME
SELECT GETDATE()-2 --THIS WILL DEDUCT TWO DAYS TO CURRENT SERVER DATE TIME
SELECT DATEADD(hour,2,GETDATE())--THIS WILL ADD 2HRS TO OUR CURRENT SERVER DATE-TIME.
SELECT DATEADD(hour,-2,GETDATE())--THIS WILL DEDUCT 2HRS TO OUR CURRENT SERVER DATE-TIME.
SELECT DATEADD(month,3,GETDATE())--THIS WILL ADD 2 MONTHS TO OUR CURRENT DATE 
SELECT DATEADD(year,1,GETDATE())--THIS WILL ADD ONE YEAR TO OUR CURRENT SERVER DATE 
SELECT YEAR(GETDATE()) --THIS WILL GIVEE YEAR OF SPECIFIED DATE.
SELECT MONTH(GETDATE())--RETURNS MONTH OF SPECIFIED DATE
SELECT DATEPART(day,GETDATE())--RETURNS THE DAY PART OF THE CURRENT DATE OR SPECIFIED DATE 
SELECT DATEPART(month,GETDATE())--RETURNS THE MONTH PART OF THE CURRENT DATE OR SPECIDIED DATE 
SELECT DATEPART(minute,GETDATE())--RETURNS THE SEC PART OF THE CURRENT DATE OR SPECIDIED DATE 
SELECT DATEPART(hour,GETDATE())--RETURNS THE HOUR PART OF THE CURRENT DATE OR SPECIDIED DATE 
SELECT DATEDIFF(hour,GETDATE(),GETDATE()+4) --THIS WILL RETURN THE DIFFERENCE IN HOURS BETWEEN TWO SPECIFIED DATE.
SELECT DATEDIFF(day,GETDATE(),GETDATE()+4)

--WE CAN USE DATEDIFF TO CALCULATE THE AGE OF THE PEOPLE DYNAMICALLY.
SELECT * FROM employee_dob

SELECT *
,DATEDIFF(year,edob.employee_dob,GETDATE()) AS Age_in_years --this is how we can create new col and calculate current age dynamically
FROM employee_dob AS edob 

SELECT *
,YEAR(edob.employee_dob) AS year_of_birth --in this way we can make use of functions in our query 
FROM employee_dob as edob

--filtering using functions 
SELECT * 
FROM employee_dob as edob
WHERE YEAR(edob.employee_dob) >=2000

--FILTERING PEOPLE BORN MARCH AND SEPT 
SELECT * 
FROM employee_dob as edob
WHERE MONTH(edob.employee_dob) BETWEEN 3 AND 9

--FILTERING PEOPLE WHO ARE BORN IN THE CURRENT MONTH 
SELECT * 
,MONTH(edob.employee_dob) as [month] --this is optional 
FROM employee_dob AS edob
WHERE MONTH(edob.employee_dob) = MONTH(GETDATE())

--CONVERTING INTEGER INTO STRING 
	--WE CAN CONCATENATE TWO VALUES OF SAME DATA-TYPE.(INT WITH INT,CHAR WITH CHAR)

SELECT '21'+'21' --HERE 21 IS TREATED AS CHAR THOUGH IT IS A INT SINCE IT IS INSIDE '' IT IS TREATED AS CHAR 
SELECT 'ROYAL' + ' ' + 'ENFIELD'--SINCE THEY ALL ARE OF SAME DATA TYPE THEY WERE CONCATENATED 
SELECT 'CHHATTISGARH' + 04 -- THIS CAN'T BE EXECUTED SINCE BOTH BELONG TO DIFFERENT DATA TYPE.

SELECT 'CHHATTISGARH ' + CONVERT(varchar,04) --convert function is used to covert one data-type to another 
SELECT 'CHHATTISGARH ' + CAST(04 AS varchar) --convert function is used to covert one data-type to another 

SELECT * FROM UniqueTest
--HERE ONE OF THE ID VALUE IS NULL WE CANNOT EXTRACT NULL VALUE BY SAYING'WHERE ID = NULL'
--WE CAN USE 'WHERE ID IS NULL' BUT THIS WILL GIVE US ONLY ONE ROW AND NOT THE OTHER ROWS.
--SO WE USE 'IS NULL' FUNCTION 

SELECT * 
FROM UniqueTest
WHERE ID = NULL--THIS WON'T GIVE ANYTHING BECAUSE NULL CAN'T BE COMPARED 

SELECT * 
FROM UniqueTest
WHERE id IS NULL -- THIS GIVES US ONLY ONE ROW AND WE CANNOT GET OTHER ROWS 

--TO GET MULTLIPLE ROWS ALONG WITH THE ROWS HAVING NULL VALUE USE 'IS NULL' FUNCTION 

SELECT * 
FROM UniqueTest
WHERE ISNULL(id,0) <2 -- in this way we other values along with null
--is null function returns the first not null values, and if there is null value that will be replaced by 0



--AGGREGATE FUNCTION 
	--THIS FUNCTIONS OPERATE ON A COLLECTION VALUES AND RETURNS A SINGLE VALUE 

SELECT MAX(Salary) as maximum_salary 
from employee_table

SELECT MIN(Salary) AS minimum_salary 
FROM employee_table
WHERE employee_id >5

SELECT AVG(Salary) AS avg_salary_india 
FROM employee_table
WHERE [Address]='India'


--USER DEFINED FUNCTION
	--Scalar valued function:-This kind of function gives us single value output
	--Table valued function:- ouput is in tabular form
		--Single line table values function
		--multiline table valued function 

--SCALAR VALUED FUNCTION 

CREATE OR ALTER FUNCTION fn_getemployeefullname
(	@firstname varchar(50)
	,@lastname varchar(50)
)
RETURNS varchar(101)  -- IT IS 'RETURNS'
AS 
	BEGIN
	RETURN ('Mr '+TRIM(@firstname) + ' ' + TRIM(@lastname)) --IT IS 'RETURN'
END

--HOW TO CALL SCALAR VALUED FUNCTION,
--WHENEVER WE CALL SCALAR VALUED FUNCTION WE NEED TO SPECIFIY SCHEMA NAME.***
--BY SPECIFYING SCHEMA NAME SYSTEM LOOKS FOR USER DEFINED FUNCTION INSTEAD OF SYSTEM DEFINED FUCNTION

SELECT dbo.fn_getemployeefullname('Joe','Biden')
SELECT dbo.fn_getemployeefullname('Narendra','Modi') 
SELECT *,
dbo.fn_getemployeefullname(first_name,last_name) AS full_name
FROM employee_table

--CREATING ANOTHER SCALAR VALUED FUNCTION 

CREATE OR ALTER FUNCTION fn_addnumbes
(	@number1 int,
	@number2 int
)
RETURNS int 
AS
BEGIN 
	RETURN (ISNULL(@number1,0)+ISNULL(@number2,0))
END
--WE USED 'ISNULL' BECAUSE ANYTHING ADDDED TO NULL WILL GIVE NULL, SO WE TRIED TO REPLACE NULL WITH 0
--'IS NULL' GIVES FIRST NOT NULL VALUE, IN CASE IT FINDS NULL WILL RETURN ITS SECOND PARAMETER 

--CALLING OUT THE fn_addnumbes
SELECT dbo.fn_addnumbes(4,7)
SELECT dbo.fn_addnumbes(NULL,0) -- here 'isnull' function replaced null value with 0

--USING SCALAR VALUED FUNCTION IN SELECT STATEMENT 
SELECT employee_id,first_name,last_name,
	dbo.fn_getemployeefullname(first_name,last_name) AS full_name 
FROM employee_table AS emp 


--TABLE VALUED FUNCTIO 
	--SINGLE LINE TABLE VALUED FUNCTION:- THE VALUE OF THE TABLE SHOULD BE DERIVED FROM SIGLE SELECT STATEMENT 

CREATE OR ALTER FUNCTION fn_getemployeedetails
(	@employeeid int
)
RETURNS TABLE  --HERE WE SPECIFIED TABLE THIS LINE WILL TELL US THIS IS SINGLE VALUED OR TABLE VALUED 
AS			   --HERE WE DIDN'T SPECIFY BEGIN 
RETURN(SELECT dbo.fn_getemployeefullname(first_name,last_name) AS full_name,
				Salary,[Address],employee_dob
				FROM employee_table AS emp 
				INNER JOIN employee_dob AS edob ON edob.employee_id=emp.employee_id
				WHERE emp.employee_id=@employeeid
				)
--CALLING-OUT TABLE VALUED FUCNTION 
SELECT * FROM fn_getemployeedetails(3)

--MULTILINE TABLE VALUED FUNCTION 
	--WE CALL IT MULTI-LINE BECAUSE WE HAVE MULTIPLE LINES OF SQL QUERY HERE
	--HERE WE NEED TO SPECIFY TABLE STRUCTURE UNLIKE SINGLE LINE TABLE VALUED FN.
	--REST OTHER THINGS ARE SIMILAR 

CREATE OR ALTER FUNCTION fn_getemployeedetailsML
(	@employee_id int )
RETURNS @emp TABLE     --in multi-valued table function we need to specify table structure which we want in output
	(employee_id int,
	full_name varchar(101),
	Salary int,
	[Address] varchar(500)
	)
AS 
BEGIN 
INSERT INTO @emp  --once created we need to insert value in them from our choice of base table 
(employee_id,full_name,Salary,[Address])
SELECT emp.employee_id,dbo.fn_getemployeefullname(first_name,last_name),Salary,[Address]
FROM employee_table AS emp
WHERE emp.employee_id != @employee_id --to get the whole table except mentioned id

UPDATE @emp
SET Salary = 5500
WHERE employee_id IN (4,5)

DELETE FROM @emp
WHERE employee_id IN (1,3)

INSERT INTO @emp
SELECT 13,'Jacinda Ardern',13350,'New-Zealand'

	RETURN
END

--CALLING OUT THE FUNCTIONS
SELECT * FROM fn_getemployeedetailsML(1)

SELECT * 
FROM employee_table AS emp 
INNER JOIN fn_getemployeedetailsML(3) AS MLF ON MLF.employee_id=emp.employee_id
--CASE STATEMENT 
	--IT IS A CONDITIONAL STATEMENT USED AT THE TIME OF DATA RETRIEVAL
	--IN THIS WE USE MODULUS OPERATOR '%' WHICH GIVES US REMAINDER AFTER THE DIVISION 

--BUILINDING SALARY GRADE USING CASE STATEMENT IN EMOPLOYEE TABLE 

SELECT *
	,CASE WHEN Salary<=2000 THEN '0 TO 2000'
		WHEN Salary> 2000 AND Salary<=4000 THEN '2000 TO 4000'
		WHEN Salary>4000 AND Salary<=6000 THEN '4000 TO 6000'
		ELSE '>8000' END AS Salary_grade 
FROM employee_table

--IIF STATEMENT
	-- IT IS ALSO AN CONDITIONAL STATEMENT WHICH ACCEPTS 3 PARAMETER, CONDITION,OUTPUT WHEN TRUE, OUTPUT WHEN FALSE

SELECT *
	,IIF(employee_id<5,'id is less than 5','id is greater than 5')
FROM employee_table  -- THIS ACCEPTS ONLY ONE CONDITION 

--PROGRAM FLOW OF QUERY EXECUTION 
	--IF STATEMENT:- IT CONTROLS PROGRAM FLOW AND EXCEUTES FIRST CONDITION WHEN FIND IT TRUE
	-- IT MOVES TO SECOND STATEMENT ONLY WHEN THE PREVIOUS CONDITION IS FALSE 

IF(1=2)
	PRINT('FIRST CONDITION IS TRUE')
ELSE
	PRINT('CONDITION WAS FALSE')

--WE USE 'BEGIN AND END' WITH 'IF CONDITON' ONLY WHEN WE WANT TO EXECUTE MORE THAN 1 SQL QUERY INSIDE CONDITION 
IF(1=2)
BEGIN 
	SELECT 'FIRST' --WE HAVE 2 SQL STATEMENT THAT'S WHY WE USED BEGIN AND END 
	SELECT 'SECOND'
END 

IF NOT EXISTS(SELECT * FROM employee_table WHERE employee_id=5)
	INSERT INTO employee_table(employee_id,
							   first_name)
	SELECT 5,'Nirmala'
ELSE 
	PRINT('Record already exists') -- SELECT 'Record already exists

-------------------------------------------------------------------------------------------------------------------

--WHEN WE WANT TO COPY DATA FROM ANOTHER DATABASE 
	--IT HAS SIMILAR COMMAND AS WE HAVE FOR TAKING BACKUP FROM ONE TABLE TO ANOTHER IN SAME DB.
	--WHEN WE WANT TO COPY DATA FROM ANY OTHER DATABASE/SERVER SIMPLY SPECIFY DB_NAME/SERVER_NAME AND DB_NAME 
	--IF FROM STATEMENT 

	--COPYING DATA FROM ANOTHER TABLE 
/* SELECT * 
	INTO NEW_TABLE NAME 
	FROM DB_NAME.SCHEMA_NAME.TABLE_NAME  --THIS IS CALLED 3 NAME QUALIFIER 
JUST PREFIX SERVER NAME WHEN WE WANT TO COPY DATA FROM ANYOTHER DATABASE.
WHEN COPYING WITHIN SAME DB AND SERVER WE JUST NEED TABLE NAME IN FROM STATEMENT 
*/

--ORDER BY 
	--ARRANGES OUR DATA IN ASCENDING OR DESCENDING ORDER AS PER SPECIFIED COL
	-- BY DEFAULT IT ARRANGES IN ASCENDING ORDER 
	--WE CAN APPLY SORTING ORDER IN MORE THAN ONE COL, IN THIS PREFERENCE WOULD BE GIVEN TO FIRST COL
	-- WHEN THERE IS A TIE IN THE FIRST COL VALUES ONLY THEN 2ND COL WILL BE REFERED

--MAKING FEW SALARY SAME 
SELECT *
	FROM employee_table
	WHERE employee_id IN (5,6)
--UPDATING SALARY FOR ID 5,6 
UPDATE employee_table
SET salary =5500
WHERE employee_id=5

UPDATE employee_table
SET salary=5500
WHERE employee_id=6
--RUNNING ORDER BY ON 2 COLS 
SELECT *
FROM employee_table
ORDER BY salary DESC, employee_id DESC  -- WE CAN ALSO SPECIFY COL NUMBER IN PLACE OF COL NAME

--DISTINCT CLAUSE 
	--FETCH US DISTINCT RECORDS 
	--WE CAN APPLY DISTINCT IN MULTIPLE COLS, IN THAT CASE IT WILL LOOK FOR WHOLE ROW TO DECIDE WHETHER IT DISTINCT OR NOT 
SELECT [ADDRESS]
FROM employee_table
--USING DISTINCT
SELECT DISTINCT [ADDRESS]
FROM employee_table
--MULTI COL 
SELECT DISTINCT SALARY,first_name
FROM employee_table

--GETTING TOP 2 HIGHEST SALARY 
SELECT DISTINCT TOP 2 SALARY,first_name
FROM employee_table
ORDER BY salary DESC

--GROUP BY 
	--IT HELPS GROUP DATA BASED ON	CERTAIN VALUES.
	--ALL THE NON AGGREGATED COL IN THE SELECT CLAUSE SHOULD BE IN THE GROUP BY CLAUSE 

CREATE TABLE poupulation 
	(Country varchar(100)
	,City varchar(100)
	,Town varchar(100)
	,[Population] int
	)

INSERT INTO poupulation
	(Country,
	City,
	Town,
	Population
	)
SELECT 'C1','CT1','T1',100 UNION ALL
SELECT 'C1','CT1','T2',14 UNION ALL
SELECT 'C1','CT2','T3',54 UNION ALL
SELECT 'C1','CT2','T4',65 UNION ALL
SELECT 'C2','CT3','T5',33 UNION ALL
SELECT 'C2','CT3','T6',43 UNION ALL
SELECT 'C2','CT4','T7',65 UNION ALL
SELECT 'C2','CT4','T8',43

SELECT * FROM poupulation

SELECT SUM(POPULATION) AS total_population
FROM poupulation

--population based on each country 
SELECT country,SUM(POPULATION) As Population_per_country 
FROM poupulation
GROUP BY country

--Population based on each city
SELECT City, sum(Population) As city_population 
FROM poupulation
GROUP BY City

--IF WE WANT TO FILTER OUR DATA, USE WHERE CLAUSE BEFORE GROUP BY CLAUSE 
SELECT City, sum(Population) As city_population 
FROM poupulation
WHERE City != 'CT3'
GROUP BY City

--HAVING CLAUSE 
	-- IF WE WANT TO FILTER DATA BASED ON AGGREGATION AFTER GROUP BY WE CAN USE HAVING 
	--WE CAN USE IT ONLY WITH GROUP BY 
	--AGGREGATE DATA CAN'T BE FILTERED USING WHERE CLAUSE
SELECT City, SUM(Population) AS city_population 
FROM poupulation
GROUP BY City
HAVING SUM(Population) <120


--FINDING DUPLICATES OR REPETITIVE DATA 
SELECT [Address], COUNT(employee_id) AS countofemployee
FROM employee_table
GROUP BY[Address]

--UNION AND UNION ALL
	--THIS CAN ALSO BE USED TO COMBINE DIFFERENT TABLES ROW-WISE.
	--TO RUN UNION AND UNION ALL THE TABLES MUST HAVE SAME NUMBER OF COLS OF SAME DATA TYPE
	--TILL NOW WE HAVE USED IT TO THEM TO FEED DATA IN A TABLE AND SHOW ALL DATA AS SINGLE DATA SET 
	
--THIS IS HOW WE CAN USE UNION AND UNION ALL TO COMBINE DATA FROM DIFFERENT TABLE 

SELECT employee_id,first_name FROM employee_table 
UNION
SELECT * FROM primarykeytest
UNION 
SELECT * FROM uniquetest

--EXCEPT OPERATOR 
	--RETURN ALL THE RECORD PRESENT IN FIRST SELECT BUT MISSNG IN SECOND.
	--WILL GIVE ALL THE VALUES FROM TABLE 1 EXCEPT THOSE VALUES WHICH ARE PRESENT IN 2ND TABLE.
	--2ND TABLE HERE IS JUST FOR REFERENCE. TO SKIP THE VALUES IN O/P FROM 1ST TABLE PRESENT IN BOTH 
	--TABLES NEED TO SATIFY THE SAME CONDITON AS THOSE OF UNION AND UNION ALL.

UPDATE DefaultTest
SET id=3
WHERE NAME IS NULL

SELECT * FROM DefaultTest --THIS GIVE ALL THE VALUES IN TABLE 1 SINCE NO VALUES ARE COMMON IN BOTH TABLE
EXCEPT 
SELECT * FROM PrimaryKeyTest

--RANKING
	--HEPLS US IN ASSIGNING RANK TO EACH OF THE ROWS BASED ON CERTAIN VALUES.
	--TYPES_OF_RANK
		--SIMILAR TO ONE WE HAVE IN TABLEAU 
		--ROW_NUMBER(NORMAL RANK):- WILL ASSIGN UNIQUE RANK TO EACH ROW
		--RANK(ASSIGNS THE EARLY SAME RANK TO COMMON VALUES AND SKIP THE NEXT RANK)
		--RANK DENSE(ASSIGN THE SAME RANK TO COMMON VALUES BUT WILL NOT SKIP ANY RANK)

CREATE TABLE Ranking 
	(Country varchar(100),
	City varchar(100),
	[Population] int
	)

INSERT INTO Ranking
	(Country
	,City
	,Population
	)
SELECT 'A','Z',34 UNION ALL
SELECT 'A','Y',23 UNION ALL
SELECT 'A','X',45 UNION ALL
SELECT 'A','W',34 UNION ALL
SELECT 'A','V',34 UNION ALL
SELECT 'B','U',67 UNION ALL
SELECT 'B','T',56 UNION ALL
SELECT 'B','S',67 UNION ALL
SELECT 'B','R',45 

--RANKING ABOVE TABLE

SELECT *
	,ROW_NUMBER()OVER(ORDER BY Population DESC) AS Rnk_value --OVER IS TO TELL SQL OVER WHICH COL WE WANT TO RANK
FROM Ranking                                                 --BEFORE RANKING WE NEED TO SORT OUR COL USING ORDER BY 

--RANK_DENSE 
SELECT *
	,DENSE_RANK()OVER(ORDER BY Population DESC) AS Rnk_value -- THIS RANK FN WILL ASSIGN SAME RANK TO SAME VALUES BUT WILL NOT SKIP THE NEXT RANK
FROM Ranking

--RANK
SELECT *
	,RANK()OVER(ORDER BY Population) AS Rnk_value --THIS RANK FN WILL ASSIGN THE EARLY RANK TO SAME VALUE AND 
	FROM Ranking                                  --SKIP THE NEXT RANK 


--ORDER BY COMBINED WITH PARTITION BY 
	--IF WE WISH TO RANK DATA BASED ON COUNTRY WE NEED TO USE PARTITION BY 

SELECT *
	,ROW_NUMBER()OVER(PARTITION BY Country ORDER BY Population DESC) AS Rnk_value
FROM Ranking

--RANK WITH PARTITON BY 

SELECT *
	,RANK()OVER(PARTITION BY Country ORDER BY Population DESC) AS Rnk_value
FROM Ranking

--RANK_DENSE WITH PARTITION BY

SELECT *
	,DENSE_RANK()OVER(PARTITION BY Country ORDER BY Population DESC) AS Rnk_Value
FROM Ranking

--SUB-QUERY 
	--SELECT STATEMENT WITHIN SELECT STATEMENT IS CALLED SUB-QUERY 
	--TO GET 3RD HIGHEST POPULATION COUNTRY 
SELECT * FROM 
	(SELECT * 
			,DENSE_RANK()OVER(ORDER BY Population DESC) AS Rnk_Value 
	FROM Ranking
	) AS x  --HERE WE DERIVED TABLE AS PER OUR NEED, IN DERIVED TABLE WE MUST HAVE ALIAS NAME 
WHERE Rnk_Value = 3

--TO GET 4TH HIGHEST SALARY FROM EMPLOYEE_TABLE

SELECT * FROM 
		(SELECT * 
			,RANK()OVER(ORDER BY Salary DESC) AS Rnk_value 
		FROM employee_table
		) AS X  
WHERE Rnk_value= 4

----------------------------------------------------------------------------------------------------------------
--INDEXES 
	--clustered index:-holds all the information in the leaf node,can have only one clustered index per table.
	--Non-Clustered index:- it doesn't hold all the information of that record,can have multiple index of this type in the table	
	--WHILE CREATING INDEX WE NEED TO SPECIFY THE TABLE AND THE COL ON WHICH WE WANT TO CREATE INDEX 

CREATE CLUSTERED INDEX IX_CI_employee_id ON employee_table(employee_id) --clustered index
CREATE NONCLUSTERED INDEX IX_NCI_employee_id ON employee_table(employee_id) --NONCLUSTERED INDER 

--SEE META-DATA TO CHECK WHETHER WE HAVE INDEX IN THE TABLE OR NOT 
--ONCE CREATED INDEX WE CAN RETRIVE DATA FROM TABLE IN SAME WAY WE DID EARLIER, 
--MAKE SURE TO SPECIFY COL IN WHICH INDEX IS CREATED IN WHERE CLAUSE.
--WHENEVER A DATA IS FEED ON THE TABLE AFTER THE INDEX HAS BEEN CREATED THOSE NEW DATA WILL NOT BE INCLUDED IN THE
--INDEX. TO INCLUDE THEM WE NEED TO DROP THE INDEX AND RECRETE IT 


--DROPPING INDEX 
ALTER TABLE employee_table
DROP INDEX IX_NCI_employee_id


------------------------------------------------------------------------------------------------------------------
                                      --STORED PROCEDURE 
			   
			   --IT IS BLOCK OR BATCH OF SQL STATEMENT,THEY ARE EXECUTED TOGETHER IN A SPECIFIC SEQUENCE 
			   --TO SERVE DEFINITE BUSINESS PURPOSE. SP CAN BE REUSED WHEN REQUIRED

CREATE OR ALTER PROCEDURE CSP_getdata
AS 
BEGIN
	SELECT * 
	FROM employee_table --WE CAN SPECIFY ANY TYPE OPERTION HERE AND THAT WILL BE STORED IN THE PROCEDURE 
END 
--EXCECUTING SP 
EXEC CSP_getdata

--ALTERING SP TO REMOVE OR ADD COLUMNS 
CREATE OR ALTER PROCEDURE CSP_getdata
AS 
BEGIN 
	SELECT employee_id,first_name,last_name,[Address]
	FROM employee_table
END

EXEC  CSP_getdata


--ADDING PARAMETER 
CREATE OR ALTER PROCEDURE CSP_getdata
(	@employee_id int --=0 --, ASSIGNING DEFAULT VALUES TO IT MAKES IT OPTIONAL 
)
AS 
BEGIN
	SELECT emp.employee_id,first_Name,[Address],employee_dob
	FROM employee_table AS emp
	LEFT OUTER JOIN employee_dob AS edob ON edob.employee_id= emp.employee_id
	WHERE emp.employee_id= @employee_id --OR @employee_id=0 
END 

EXEC CSP_getdata @employee_id=4 -- WE MUST PROVIDE PARAMETER TO GET VALUES AND RUN SP
                                --WE ALSO HAVE A OPTION OF NOT PROVIDING PARAMETER VALUE AND GET DEFAULT RESULT 
								--THAT CAN BE DONE BY ASSIGNING DEFAULT VALUE TO OUR INPUT PARAMETER 


--ADDING MULTIPLE PARAMETER AND USING USER DEFINED FUNCTION INSIDE SP 
CREATE OR ALTER PROCEDURE CSP_getdata
(	@employee_id int =0, --optional parameter 
	@Address varchar(100)--mandatory parameter 
	)
AS
BEGIN 
	SELECT employee_id,dbo.fn_getemployeefullname(first_name,last_name) AS full_name,
			Address
	FROM employee_table
	WHERE (employee_id=@employee_id OR @employee_id=0 ) AND Address=@Address
END 

EXEC CSP_getdata @Address='India',@employee_id=9


-------------------------------------------VIEWS--------------------------------------------------------
--IT IS CREATED WHEN WE WANT TO SHARE ONLY SPECIFIC DATA FROM OUR TABLE 
--VIEWS ARE NOT TABLE IT IS JUST A QUERY ON TOP OF TABLE WHICH RESTRICTS DATA FROM VIEWING 

CREATE OR ALTER VIEW VW_getemployeedetail
AS
SELECT * FROM employee_table --HERE WE CAN SPECIFY WHICH COL AND ROWS TO BE RESTRICTED 
                              --WE DID NOT SPECIFY HERE ANY INFO FROM EMPLOYEE TABLE.

--RETRIVING DATA FROM VIEW
SELECT * FROM VW_getemployeedetail

--CREATING VIEW WTIH SPECIFIC INFO 
CREATE OR ALTER VIEW VW_getemployeedata
AS 
SELECT employee_id,first_name,last_name,[Address] --HERE WE ARE SHARING SPECIFIC INFO ONLY OF THOSE EMPLOYEE HAVING ID >4
FROM employee_table
WHERE employee_id>4

SELECT * FROM VW_getemployeedata

--CREATING VIEWS FROM MULTIPLE TABLE WITH THE HELP OF JOIN 

CREATE OR ALTER VIEW get_employeedata 
AS 
SELECT emp.employee_id,first_name,employee_dob,[Address]
FROM employee_table AS emp 
INNER JOIN employee_dob AS edob ON emp.employee_id=edob.employee_id
WHERE emp.employee_id>3

SELECT * FROM get_employeedata

--WE CAN ALSO FILTER VIEWS USING WHERE AND JOIN VIEWS WITH ANY EXISTING PHYSICAL TABLE 

SELECT * 
FROM get_employeedata
WHERE employee_id>5

--creating join with views
SELECT * 
FROM get_employeedata ged
INNER JOIN UniqueTest AS ut ON UT.id=ged.employee_id  

--ORPHAN VIEW
--VIEW FOR THE BASE TABLE OR THE BASE TABLE COL HAS BEEN ALTERED OR DELETED IS CALLED AN ORPHAN VIEW 
--TO PREVENT SUCH SCENARIO AND TO NOT MAKE OUR VIEW ORPHAN, WE 'SCHEMABIND' OUR VIEW 
--SCHEMABINDG BINDS OUR VIEWS TO THE DEPENDENT PHYSICAL COLUMN AND TABLES IN THE VIEW A
--SCHEMABINDING IS ONLY APPLICABLE FOR THE COLUMNS THAT ARE BINDED IN THE VIEW 
--SCHEMABINDING WILL PREVENT ANY QUERY WHICH IS TRYING TO ALTER THE COL/TABLE USED IN VIEW 

SELECT *  --creating backup for employee_table 
INTO employee_backup
FROM employee_table

CREATE OR ALTER VIEW VW_getemployeebackupdata 
WITH SCHEMABINDING 
AS SELECT employee_id,first_name,[Address]
FROM dbo.employee_backup  --since here our view is created with schemabinding, we can't alter or remove col used in view 

--trying remove schemabind col 
ALTER TABLE employee_backup
DROP COLUMN [Address] --THIS WILL THROW AN ERROR SINCE IT IS SCHEMABINDED 

--DML OPERATION ON VIEWS (INSERT/UPDATE/DELETE)
--we can perform DML operation on view but those changes will be reflected in base table too
--To perform dml operation we have following 2 conditions 
	--there must be only one table in the view i.e there should not be any join in the view
	--All the not-null col must be included in the view since if do not include them in view we can't assign/alter 
	-- values, that will be assumed by our system as null and ultimately our query will fail since that col in not-nullable


--INSERTING VALUES USING VIEW 


INSERT INTO VW_getemployeebackupdata(employee_id,first_name,[Address])
SELECT 10,'Tom','USA'

SELECT * FROM employee_backup

--DELETING USING VIEW 
DELETE FROM VW_getemployeebackupdata
WHERE first_name ='Justin'

--IN SIMILAR WAY WE CAN PERFORM UPDATE TOO




----------------------------------TRANSACTIONS------------------------------------------------------

--Transactions are used when multiple update,insert and delete operations are perfromed 
--When the changes to one table are required the other data table to be be kept consistent 
--When we are working on modifying data across two or more concurrent  DB

BEGIN TRANSACTION   --starting point of transaction 
	UPDATE e        --here sql query begins
	SET  e.last_name ='Sharma' --WE CAN HAVE N NUMBER OF UPDATE,INSERT AND DELETE WITHIN THIS TRANSACTION 
	FROM employee_table AS e 
	WHERE employee_id =1

	ROLLBACK TRANSACTION
	COMMIT TRANSACTION 

--DIRTY READ:- When we read data without committing transaction is called dirty read.

--we can't read uncommited transaction in other query window because of transacton isolation level.

--TRANSACTION ISOLATION LEVEL(Retrival of data)
	--The default transaction isolation level in sql server is 'read uncommited' in the same query window 
	--The default transaction isolation level in sql server is 'read committed' in different query window 

-- we can manually set transaction islodation level using following query 
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED/UNCOMMITTED
--GO


--We can also automate commit/rollback transaction by using 'error/exception handling'
--By using error/exception handling we need to manually rollback/commit transaction 


--ERROR/EXCEPTION HANDLING 
	--TRY,CATCH block to handle errors.
	--Try block has all the sql query that needs to be executed 
	--catch block hits when there are any error from the sql query 

BEGIN TRY
	SELECT 'Dinesh' + 5 --all our sql operation goes here 
	SELECT 1/0          --if any error found on first statement then try block wouldn't execute later queries 
END TRY                 --The moment try block finds error catch block will be hit 
BEGIN CATCH 
	PRINT 'Catch block is hit'

	DECLARE @errormessage varchar(1000) --here we'll get error for first select only and not for the 2nd one 
	set @errormessage = ERROR_MESSAGE() --that is because 2nd select wasn't even executed
	SELECT @errormessage
END CATCH 

--linking TRY/CATCH block with transaction to automate commit and rollback 

BEGIN TRY
	BEGIN TRANSACTION
	--1  --HERE WE CAN HAVE ANY SQL QUERY TO EXECUTE THE TRANSACTION 
	--2
	--3
	COMMIT TRANSACTION 
END TRY 
BEGIN CATCH
	ROLLBACK TRANSACTION 
END CATCH 

--WE HAVE STORED-PROCEDURE WITHIN IT WE CAN HAVE TRY/CATCH BLOCK AND TRANSACTION AS WELL IN THE FOLLOWING WAY 


CREATE OR ALTER PROCEDURE Sp_name
AS 
BEGIN 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	BEGIN TRY 
		BEGIN TRANSACTION 
			UPDATE employee_table
			SET last_name ='Sharma'
			WHERE employee_id=1      --WE CAN PERFORM N NUMBER OF OPERATIONS WITH TRANSACTION AND ACROSS MULTIPLE TABLES & DB

			Delete FROM employee_table
			WHERE first_name ='Justin'

			INSERT INTO employee_table(employee_id,first_name,last_name,salary,Address)
			SELECT 10,'Justin','Trudeau',34555,'Canada'

			INSERT INTO UniqueTest(id,Name)
			SELECT 3,'Xi'
			
			UPDATE employee_table
			SET employee_id=1/0
			WHERE employee_id=1

			COMMIT TRANSACTION
			SELECT 'Transaction completed'

	END TRY 
	BEGIN CATCH 
		ROLLBACK TRANSACTION 
		SELECT 'Transaction rolledback'
	END CATCH
END

EXEC Sp_name




-----------------------------------CTE(COMMMON TABLE EXPRESSION)-----------------------------------------------
--CTE is just a temporary storage for the data to be stored and used only once in their lifetime.
--Scope of CTE is only till the first SELECT inside the same batch after the CTE is created.
-- IT IS VERY SIMILAR TO THE TEMP TABLES AND TABLE VARIABLES 

;WITH cte_employee(first_name,last_name,Address,DOB)
AS 
(
	SELECT e.first_name,e.last_name,e.[Address],dob.employee_dob
	FROM employee_table AS e 
	INNER JOIN employee_dob AS dob ON dob.employee_id=e.employee_id
	WHERE Address='India'
)
SELECT * FROM cte_employee AS x --WE MUST HAVE SELECT AFTER CTE CREATION SINCE IT HAS SCOPE TILL FIRST SELECT STATEMENT IN THE SAME BATCH
INNER JOIN  employee_table AS Y ON Y.first_name=X.first_name --WE CAN THESE QUERIES IN THE BATCH 



-----------------------------------------TRIGGERS---------------------------------------------------------

--Triggers are used to keep record of changes made in tables and data-base 
--Trigger is one or more SQL statements that are executed in response to a certain action on the table.
--It is triggered on DML operation on table(INSert,Update,Delete)
--Triggers are automatically fired and we need not to trigger them manually 

--DML OPERATION
	--While DML operation 2 following two things happens 
	--Actual insert/update/delete 
	--Trigger if exists 

--TYPES OF TRIGGER 
	--After Triggers(For Triggers)
		--The trigger is fired after the operation(insert,update,delete) is completed.
		--AFTER INSERT, AFTER UPDATE, AFTER DELETE

	--INSTEAD OF TRIGGER 
		--The trigger is fired instead of actual DML operation 

--AFTER TRIGGER 
	--Trigger is fired only after the completion of insert,update,delete operation

--AFTER INSERT 

--creatting table for the trigger test

CREATE TABLE Aftertriggertest
(	id int,
	Name varchar(100)
)

--CREATING TRIGGER AND ATTACHING IT TO TABLE FOR AFTER INSERT 

CREATE TRIGGER trg_Afterinsert 
ON dbo.Aftertriggertest
FOR INSERT 
AS 
	PRINT 'The trigger is fired'
go	

INSERT INTO Aftertriggertest
	(id,Name)
SELECT 1,'Indigo'

SELECT * FROM Aftertriggertest


--IN this way we'll not gonna know who updated,what data updated and when it was updated.
--To have all these details we need to create table call it a audit table and link it with magic table 
--Magic tables are only for triggers 
	--There are 2 types of magic table 
		--inserted 
		--deleted 
			--INSERTED:-Data is in inserted table 
			--DELETE:- data is in deleted table.
			--UPDATED:- It is a combination of both insert and delete, so both tables have data 
		--The structure of magic table depends upon the structure of table on which operation is performed 

--creating table for audit 

CREATE TABLE Audit 
	(
	id int,
	Name varchar(100),
	ModifiedDate datetime DEFAULT(getdate()),
	modifieduser varchar(200),
	Operation varchar(100)
	)

--AFTER INSERT 
--Now combinig Trigger,Audit table and Magic table 

CREATE OR ALTER TRIGGER trg_Afterinsert
ON Aftertriggertest
FOR INSERT 
AS 
	SELECT 'The trigger is fired'
	
	INSERT INTO Audit(id,Name,modifieduser,Operation)  --linked audit table with trigger which is created on table Aftertriggertest
	SELECT ID,NAME,SYSTEM_USER,'INSERT'
	FROM inserted    --magic table 
GO

--THE ABOVE CODE WILL INSERT VALUE IN BASE TABLE ON WHICH TRIGGER IS CREATED 
--ALSO IT WILL RECORD VALUE IN AUDIT TABLE WHICH IS LINKED WITH TRIGGER AND GETTING INSERT FROM INSERT MAGIC TABLE 
-- THIS WILL HOLD RECORD ONLY FOR INSERT.

INSERT INTO Aftertriggertest(id,Name)
SELECT 2,'john'

--checking values in base table 
SELECT * FROM Aftertriggertest
--checking values in AUDIT table LINKED WITH MAGIC TABLE 
SELECT * FROM Audit

--inserting multiple values in table 
INSERT INTO Aftertriggertest(id,Name)
SELECT 3,'Ricky' UNION ALL
SELECT 4,'BRET' UNION ALL
SELECT 5,'Jacob'  --ALL THIS INSERT OPERATION WILL HAVE BE RECORDED IN OUR AUDIT TABLE 

--AFTER DELETE
--Now creating trigger for 'after delete' operation linking it with audit table and feeding it from magic table 

CREATE OR ALTER TRIGGER Afterdelete --name of trigger 
ON dbo.Aftertriggertest     --the table on which trigger is created 
FOR DELETE 
AS
	SELECT 'The trigger is fired'
	INSERT INTO Audit(id,Name,modifieduser,Operation)
	SELECT ID,NAME,SYSTEM_USER,'DELETED'
	FROM deleted  -- MAGIC TABLE 
go

--deleteing values from Aftertriggertest and checking whether it is  recorded or not 
DELETE FROM Aftertriggertest
WHERE ID=4

SELECT * FROM Aftertriggertest
SELECT * FROM Audit

--AFTER UPDATE 
	--IT IS A COMBINATION OF BOTH DELETE AND INSERT SO WE NEED TO LINK OUR AUDIT TABLE WITH BOTH INSERT AND DELETE

CREATE OR ALTER TRIGGER trg_afterupdate 
ON dbo.Aftertriggertest
FOR UPDATE 
AS 
	SELECT 'The trigger is fired'
	INSERT INTO Audit(ID,NAME,modifieduser,Operation)
	SELECT ID,NAME,SYSTEM_USER,'DELETED OLD RECORD'
	FROM deleted 

	INSERT INTO Audit(ID,Name,modifieduser,Operation)
	SELECT ID,NAME,SYSTEM_USER,'Updated old record'
	FROM inserted
G0

SELECT * FROM Aftertriggertest

UPDATE Aftertriggertest
SET NAME ='Pointing'
WHERE ID= 3

--CHECKING AUDIT TABLE 
SELECT * FROM Audit

--INSTEAD OF TRIGGERS
	-- THESE ARE HARDLY USED AND HAS SAME SYNTAX AS THAT OF AFTER TRIGGER 
	--WHILE SPECIFYING OPERATION  USE KEY WORD 'INSTEAD OF INSERT/UPDATE/DELETE' WITH FOR 


------------------------------------------SUBQUERIES--------------------------------------------

SELECT * FROM 
(	SELECT *,
		DENSE_RANK() OVER(ORDER BY Salary DESC) AS Rnk_value
		FROM employee_table
)AS X
WHERE Rnk_value=4

--GET EMPLOYEE DETAILS WHO EARN MORE THAN AVG SALARY

SELECT * 
FROM employee_table
WHERE salary >(SELECT AVG(Salary) FROM employee_table)--THIS IS CALLED CO-RELATED SUBSQUERY 

-- WE CAN EASILY REPLACE CO-RELATED SUBSQUERY WITH VARIABLE 

DECLARE @Avgsalary int = (SELECT AVG(Salary) FROM employee_table)
SELECT * 
FROM employee_table
WHERE salary>@Avgsalary




















































































































			
























































































































































































	




































































































































							   






































































































































































































































































































































































 


























































































 

  















































