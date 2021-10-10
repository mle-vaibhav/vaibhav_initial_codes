--Creating seprate DB for assignments 
CREATE DATABASE Assingment_DB

CREATE TABLE Studies
	(	PNAME VARCHAR(100)
		,INSTITUTE VARCHAR(100)
		,COURSE VARCHAR(100)
		,COURSE_FEE INT 
	)

INSERT INTO Studies
	(PNAME
	,INSTITUTE
	,COURSE
	,COURSE_FEE
	)
SELECT 'ANAND', 'SABHARI', 'PGDCA', 4500 UNION ALL
SELECT 'ALTAF', 'COIT', 'DCA', 7200 UNION ALL
SELECT 'JULIANA', 'BDPS' ,'MCA', 22000 UNION ALL
SELECT 'KAMALA', 'PRAGATHI',' DCA', 5000 UNION ALL
SELECT 'MARY', 'SABHARI', 'PGDCA', 4500 UNION ALL
SELECT 'NELSON', 'PRAGATHI', 'DAP',6200 UNION ALL
SELECT'PATRICK', 'PRAGATHI', 'DCAP', 5200 UNION ALL
SELECT'QADIR', 'APPLE', 'HDCA', 14000 UNION ALL
SELECT 'RAMESH' ,'SABHARI' ,'PGDCA', 4500 UNION ALL
SELECT 'REBECCA', 'BRILLIANT', 'DCAP', 11000 UNION ALL
SELECT 'REMITHA', 'BDPS', 'DCS', 6000 UNION ALL
SELECT 'REVATHI', 'SABHARI', 'DAP' ,5000 UNION ALL
SELECT 'VIJAYA', 'BDPS', 'DCA', 48000

SELECT * FROM Studies

CREATE TABLE Software
	(	PNAME VARCHAR(100)
		,TITLE VARCHAR(100)
		,DEVELOPEIN VARCHAR(100)
		,SCOST INT 
		,DCOST INT 
		,SOLD INT
	)
	
INSERT INTO Software
	(	PNAME
		,TITLE
		,DEVELOPEIN
		,SCOST
		,DCOST
		,SOLD
	)
SELECT 'MARY', 'README', 'CPP', 300, 1200, 84 UNION ALL
SELECT 'ANAND', 'PARACHUTES', 'BASIC', 399.95, 6000, 43 UNION ALL
SELECT 'ANAND', 'VIDEO TITLING', 'PASCAL', 7500, 16000, 9 UNION ALL
SELECT 'JULIANA', 'INVENTORY', 'COBOL', 3000, 3500, 0 UNION ALL
SELECT'KAMALA', 'PAYROLL PKG.', 'DBASE', 9000, 20000, 7 UNION ALL
SELECT 'MARY', 'FINANCIAL ACCT.', 'ORACLE', 18000, 85000, 4 UNION ALL
SELECT 'MARY', 'CODE GENERATOR', 'C', 4500, 20000, 23 UNION ALL
SELECT 'PATTRICK', 'README', 'CPP', 300, 1200, 84 UNION ALL
SELECT 'QADIR', 'BOMBS AWAY', 'ASSEMBLY', 750, 3000, 11 UNION ALL
SELECT 'QADIR', 'VACCINES', 'C', 1900, 3100, 21 UNION ALL
SELECT 'RAMESH', 'HOTEL MGMT.', 'DBASE', 13000, 35000, 4 UNION ALL
SELECT 'RAMESH', 'DEAD LEE', 'PASCAL', 599.95, 4500, 73 UNION ALL
SELECT 'REMITHA', 'PC UTILITIES', 'C', 725, 5000, 51 UNION ALL
SELECT 'REMITHA', 'TSR HELP PKG.', 'ASSEMBLY', 2500, 6000, 7 UNION ALL
SELECT 'REVATHI', 'HOSPITAL MGMT.', 'PASCAL', 1100, 75000, 2 UNION ALL
SELECT 'VIJAYA', 'TSR EDITOR', 'C', 900, 700, 6

SELECT * FROM Software


CREATE TABLE Programmer 
	(	PNAME VARCHAR(100)
		,DOB DATE
		,DOJ DATE
		,GENDER VARCHAR(20)
		,PROF1 VARCHAR(100)
		,PROF2 VARCHAR(100)
		,SALARY INT 
	)





INSERT INTO Programmer
	(	PNAME
		,DOB
		,DOJ
		,GENDER
		,PROF1
		,PROF2
		,SALARY
	)
SELECT 'ANAND', '1966-12-04','1992-04-21', 'M', 'PASCAL', 'BASIC', 3200 UNION ALL
SELECT 'ALTAF', '1964-07-02','1990-11-13', 'M', 'CLIPPER', 'COBOL', 2800 UNION ALL
SELECT 'JULIANA', '1960-01-31','1990-04-21', 'F', 'COBOL', 'DBASE', 3000 UNION ALL
SELECT 'KAMALA', '1968-10-30','1992-01-02', 'F', 'C', 'DBASE', 2900 UNION ALL
SELECT 'MARY', '1970-06-24','1991-02-01', 'F', 'CPP', 'ORACLE', 4500 UNION ALL
SELECT 'NELSON','1985-09-11','1989-10-11', 'M', 'COBOL', 'DBASE', 2500 UNION ALL
SELECT 'PATTRICK','1965-11-10','1990-04-21', 'M', 'PASCAL', 'CLIPPER', 2800 UNION ALL
SELECT 'QADIR','1965-08-31','1991-04-21', 'M', 'ASSEMBLY', 'C', 3000 UNION ALL
SELECT 'RAMESH','1967-05-03','1991-02-28', 'M', 'PASCAL', 'DBASE', 3200 UNION ALL
SELECT 'REBECCA','1967-01-01', '1990-12-01', 'F', 'BASIC', 'COBOL', 2500 UNION ALL
SELECT 'REMITHA','1970-04-19', '1993-04-20', 'F', 'C', 'ASSEMBLY', 3600 UNION ALL
SELECT 'REVATHI','1969-12-02','1992-01-02', 'F','PASCAL', 'BASIC', 3700 UNION ALL
SELECT 'VIJAYA', '1965-12-14','1992-05-02', 'F', 'FOXPRO', 'C', 3500

SELECT * FROM Programmer

--Avg selling cost for packages developed in pascal(software table)

SELECT AVG(SCOST) AS avgsellingcost 
FROM Software
WHERE DEVELOPEIN='PASCAL'

--Name & Age of all programmer 

SELECT PNAME,
	DATEDIFF(YEAR,P.DOB,GETDATE()) AS age_of_programmer 
FROM Programmer AS P

--NAME OF THOSE WHO HAVE DONE DAP 

SELECT PNAME AS DAP_qualified 
FROM Studies 
WHERE COURSE= 'DAP'

--name and dob of programmer born in jan

SELECT PNAME,DOB
FROM Programmer
WHERE MONTH(DOB)= 01 

--HIGHEST NUMBER OF COPIES SOLD 
SELECT MAX(SOLD) AS max_copies_sold
FROM Software

--LOWEST COURSE FEE
SELECT MIN(COURSE_FEE) AS lowest_course_price 
FROM Studies

--programmers with pgdca 

SELECT * 
FROM Studies
WHERE COURSE='PGDCA'

--REVENUE GENERATED THRU C DEVELOMENT 
SELECT *
	,DIFFERENCE(SCOST,DCOST)*SOLD AS revenue_thru_C
FROM Software
WHERE DEVELOPEIN='C'

--SOFTWARE DEVELOPED BY RAMESH
SELECT * 
FROM Software
WHERE PNAME='RAMESH'

--STUDIES IN Sabhari
SELECT * 
FROM Studies
WHERE INSTITUTE='Sabhari'

--DETAILS OF PACKAGE WITH 2000 SALES
SELECT * 
FROM Software
WHERE SCOST>2000

--DEVELOPEMENT COST STATUS 
SELECT * 
	,IIF(SCOST*SOLD>DCOST,'RECOVERED DEVELOPEMENT COST','NOT RECOVERED') AS recovery_status
FROM Software

--COSTLIEST SOFTWARE DEVELOPED IN BASIC 
SELECT MAX(SCOST) AS costliest_basic_software
FROM Software
WHERE DEVELOPEIN='Basic'

--packages develped in DBASE 
SELECT *
FROM Software
WHERE DEVELOPEIN='DBASE'

--15 STUDIED IN Pragathi
SELECT * 
FROM STUDIES
WHERE INSTITUTE ='Pragathi'

--16 PAID BETWEEN 5K TO 10K FOR COURSE 
SELECT * 
FROM Studies
WHERE COURSE_FEE BETWEEN 5000 AND 10000

--17 AVG COURSE FEE
SELECT AVG(COURSE_FEE) AS avg_fee
FROM Studies

--18 KNOWS C 
SELECT * 
FROM Programmer
WHERE PROF1='C' OR PROF2='C'

--19 KNOWS PASCAL OR COBOL

SELECT *
FROM Programmer
WHERE PROF1='COBOL' OR PROF2='PASCAL'

--20 DON'T KNOW PASCAL OR C 
SELECT * 
FROM Programmer
WHERE PROF1 !='PASCAL' AND PROF2 !='C'

--21 OLDEST MALE PROGRAMMER 

DECLARE @oldest_male date = (SELECT MIN(DOB) FROM Programmer WHERE GENDER='M')
SELECT * 
FROM Programmer
WHERE DOB = @oldest_male 
--CROSSS CHECKING MANUALLY
SELECT * 
		,DATEDIFF(YEAR,DOB,GETDATE()) AS age
FROM Programmer --ABOVE CODE CORRECTLY GOT US OLDEST MALE EMPLOYEE

--22 AVG age of female programmer 
SELECT AVG(YEAR(GETDATE())-YEAR(DOB)) AS avg_female_age FROM Programmer
WHERE GENDER='F'

--23 NAME AND EXPERIENCE 
SELECT PNAME
	, DATEDIFF(YEAR,DOJ,GETDATE()) AS experiece 
FROM Programmer
ORDER BY experiece DESC

--24 PROGRAMMER BORN IN CURRENT MONTH
SELECT * 
	,MONTH(DOB) AS [MONTH]
FROM Programmer
WHERE MONTH(DOB) = MONTH(GETDATE())

--25 COUNT OF FEMALE PROGRAMMER 
SELECT COUNT(PNAME) total_female
FROM Programmer
WHERE GENDER='F'

--26 languages studied by male programmer 
SELECT PROF1,PROF2
FROM Programmer
WHERE GENDER='M'

--27 AVG SALARY 
SELECT AVG(SALARY) AS avg_salary
FROM Programmer

--28 COUNT OF PEOPLE EARING BETWEEN 2000 AND 4000
SELECT COUNT(PNAME) AS earn_2000_to_4000
FROM Programmer
WHERE SALARY BETWEEN 2000 AND 4000

--29 who don't know  Clipper, COBOL or PASCAL. 

SELECT * 
FROM Programmer
WHERE PROF1 !='Clipper' AND PROF1 !='COBOL' AND  PROF1 !='PASCAL' AND  
	PROF2 !='Clipper' AND PROF2 !='COBOL' AND  PROF2 !='PASCAL' 

--30 cost of package developed by each programmer 

SELECT PNAME	
	,SUM(DCOST) AS development_cost 
FROM Software
GROUP BY PNAME
ORDER BY development_cost DESC

--31 SALES VALUES OF PACKAGE DEVELOPED BY EACH PROGRAMMER 

SELECT PNAME
	,SUM(SCOST) AS sales_cost
FROM Software
GROUP BY PNAME
ORDER BY sales_cost DESC

--32 PACKAGES SOLD BY EACH PROGRAMMER 

SELECT PNAME 
	,SUM(SOLD) AS packages_sold
FROM Software
GROUP BY PNAME
ORDER BY packages_sold DESC

--33 PACKAGE DEVELOPED BY EACH PROGRAMMER LANGUAGE WISE
SELECT PNAME,DEVELOPEIN
	,SUM(SCOST) AS SALECOST_PERLANG_PEREMPLOYEE
FROM Software
GROUP BY PNAME,DEVELOPEIN
ORDER BY SALECOST_PERLANG_PEREMPLOYEE DESC

--34 EACH LANGUAGE DCOST,SCOST AND AVG COST PER COPY
SELECT DEVELOPEIN AS SOFTWARE
	,AVG(DCOST) AS AVGDEVELOP_COST,AVG(SCOST) AS AVGSELLINGCOST
FROM Software
GROUP BY DEVELOPEIN

--35 name of programmer with costliest and cheapest packages developed 
SELECT PNAME
	,MAX(DCOST) AS COSTLIEST_PACKAGE,MIN(DCOST) AS CHEAPEST_PACKAGE
FROM Software 
GROUP BY PNAME

--36 Name of institute and courses and avg fees
SELECT INSTITUTE
	,COUNT(INSTITUTE) AS COURSE_OFFERED, AVG(COURSE_FEE) AS AVG_FEE
FROM Studies
GROUP BY INSTITUTE

--38 Name and gender of employee

SELECT PNAME,GENDER
	,DATEDIFF(YEAR,DOB,GETDATE()) AS Age
FROM Programmer
ORDER BY Age DESC

--39 Name and package of programmer 
SELECT Pname,Salary 
	,DATEDIFF(YEAR,DOJ,GETDATE()) AS years_exprience 
FROM Programmer
ORDER BY years_exprience DESC

--40 the Number of Packages in Each Language Except C and C++
SELECT DEVELOPEIN
	,COUNT(TITLE) AS numberofpackage
FROM Software
WHERE DEVELOPEIN!='C' AND DEVELOPEIN!='CPP'
GROUP BY DEVELOPEIN

--41  the Number of Packages in Each Language for which Development Cost is
--less than 1000

SELECT DEVELOPEIN 
	,COUNT(TITLE) AS numberofpackage
FROM Software
WHERE DCOST < 1000
GROUP BY DEVELOPEIN

--42 AVG Difference between SCOST, DCOST for Each Package
SELECT TITLE
	,AVG(DCOST-SCOST) AS avg_difference
FROM Software
GROUP BY TITLE

--43 the total SCOST, DCOST and amount to Be Recovered for each 
--Programmer for Those Whose Cost has not yet been Recovered. 

SELECT PNAME
	,SUM(SCOST) AS totalScost, SUM(DCOST) AS totalDcost
FROM Software
WHERE (DCOST-SCOST)>0
GROUP BY PNAME

--44 Display Highest, Lowest and Average Salaries for those earning more than 2000.

SELECT 
	MAX(Salary) AS highestsalary, MIN(Salary) AS lowestsalary, AVG(Salary) AS avgsalary 
FROM Programmer
WHERE SALARY>2000

--45 Highest Paid C Programmers

SELECT PNAME,PROF1,PROF2
		,MAX(SALARY) AS Highestearning 
	FROM Programmer
	WHERE PROF1='C' OR PROF2='C'
	GROUP BY PNAME,PROF1,PROF2
	ORDER BY Highestearning DESC

--46 Highest Paid Female COBOL Programmer

SELECT PNAME,PROF1,PROF2,GENDER
	,MAX(Salary) AS Highestpaidcobol_developer
FROM Programmer
WHERE GENDER='F' AND ( PROF1='COBOL' OR PROF2='COBOL')
GROUP BY PNAME,PROF1,PROF2,GENDER

--47 Display the names of the highest paid programmers for each Language.
SELECT PROF1,MAX(SALARY)
FROM Programmer
GROUP BY PROF1

--48 least experienced programmer 

SELECT PNAME
	,DATEDIFF(YEAR,DOJ,GETDATE()) AS YEAR_OF_EXP
FROM Programmer
ORDER BY YEAR_OF_EXP 


--49 Who is the most experienced male programmer knowing PASCAL.
SELECT PNAME,MIN(DATEDIFF(YEAR,DOJ,GETDATE())) AS YEAR_EXP
FROM Programmer 
WHERE PROF1='PASCAL' OR PROF2='PASCAL'
GROUP BY PNAME
ORDER BY YEAR_EXP DESC
--CHECKING HOW MUCH IS THE MAX EXPERIENCE WITH VARIABLE 
DECLARE @highexpinpascal int = (SELECT MAX(DATEDIFF(YEAR,DOJ,GETDATE())) FROM Programmer WHERE PROF1='PASCAL' OR PROF2='PASCAL')
SELECT @highexpinpascal

--50 Which Language is known by only one Programmer

; with cte_all_languages_known([all_languages]) AS 
	(SELECT PROF1 FROM Programmer UNION ALL
	SELECT PROF2 FROM Programmer
	),cte_unique_languages([unique_language]) AS 
	(SELECT [all_languages]
	FROM cte_all_languages_known
	GROUP BY [all_languages]
	HAVING COUNT(*)=1
	)
SELECT * 
	,DATEDIFF(YEAR,DOB,GETDATE()) AS age 
FROM Programmer
WHERE PROF1 IN (SELECT [unique_language] FROM cte_unique_languages)
	OR PROF2 IN (SELECT [unique_language] FROM cte_unique_languages)

--51 Who is the Above Programmer Referred in 50?

;WITH cte_all_language(all_language) AS 
	(SELECT PROF1 FROM Programmer UNION ALL
	SELECT PROF2 FROM Programmer
	),cte_unique_language([unique_language]) AS 
	(SELECT all_language FROM cte_all_language
	GROUP BY all_language
	HAVING COUNT(*) =1
	)
SELECT * 
	,DATEDIFF(YEAR,DOB,GETDATE()) AS Age
FROM Programmer
WHERE PROF1 IN (SELECT [unique_language] FROM cte_unique_language)
	OR PROF2 IN(SELECT [unique_language] FROM cte_unique_language)


--52 the Youngest Programmer knowing DBASE?
;WITH cte_age(Pname,prof1,prof2,Age) AS
	(SELECT PNAME,PROF1,PROF2,MIN(DATEDIFF(YEAR,DOB,GETDATE())) 
	FROM Programmer
	WHERE PROF1='DBASE' OR PROF2='DBASE')
SELECT *
FROM cte_age

-- 52 Who is the Youngest Programmer knowing DBASE? 
SELECT DATEDIFF(YEAR,DOB,GETDATE()) AS Age,PNAME,PROF1,PROF2 
FROM Programmer
WHERE DATEDIFF(YEAR,DOB,GETDATE())= (SELECT MIN(DATEDIFF(YEAR,DOB,GETDATE())) FROM Programmer) AND
PROF1 LIKE 'DBASE' OR PROF2 LIKE 'DBASE'
ORDER BY Age DESC

--53 Which Female Programmer earning more than 3000 does not know C, C++, 
--ORACLE or DBASE? 

SELECT PNAME,PROF1,PROF2,SALARY
FROM Programmer
WHERE NOT PROF1 IN ('C','CPP','ORCALE','DBASE') AND NOT PROF2 IN ('C','CPP','ORCALE','DBASE') AND SALARY>3000
AND GENDER='F'

--54 Which Institute has most number of Students?

SELECT INSTITUTE, COUNT(INSTITUTE) AS numberofstudents 
FROM Studies
GROUP BY INSTITUTE
ORDER BY numberofstudents DESC

--55 COSTLIEST COURSE 

SELECT MAX(COURSE_FEE) AS Highest_fee, COURSE
FROM Studies
GROUP BY COURSE
ORDER BY Highest_fee DESC

--56 Which course has been done by the most of the Students?
SELECT COURSE, COUNT(COURSE) AS Number_of_students
FROM Studies
GROUP BY COURSE
ORDER BY Number_of_students DESC

--57 Which Institute conducts costliest course

SELECT INSTITUTE,COURSE,MAX(COURSE_FEE) AS highest_fee
FROM Studies
GROUP BY INSTITUTE,COURSE
ORDER BY highest_fee DESC


--58  Display the names of the courses whose fees are within 1000 (+ or -) of the 
--Average Fee



--60 Which package has the Highest Development cost

SELECT MAX(DCOST) AS highestdevcost,TITLE
FROM Software
GROUP BY TITLE
ORDER BY highestdevcost DESC

--61 Which course has below AVG number of Students?

--62 Which Package has the lowest selling cost?

SELECT TITLE,SCOST 
FROM Software
WHERE SCOST IN (SELECT MIN(SCOST) FROM Software)







































































































































































































































