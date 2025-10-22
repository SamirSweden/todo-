USE AdventureWorks2019;

-- 22.10.2025
-- <example with view>
select * 
from HumanResources.Employee

create view vSingleEmployees as 


select * 
from HumanResources.Employee
where MaritalStatus = 'S'


select *
from AdventureWorks2019.HumanResources.Employee
select * 
from vSingleEmployees
-- </example with view>


create synonym Workers for HumanResources.Employee
select * 
from Workers



SELECT TOP 10 *
FROM [Person].[Person]; -- Обязательно в квадратных скобках

SELECT * FROM sys.databases  -- check what db exists already 

SELECT * FROM sys.database_files


CREATE DATABASE Hospital

ALTER DATABASE Hospital MODIFY NAME =  Hospital25 -- change name of db

DROP DATABASE Hospital25; -- remove db


TRUNCATE TABLE Lectures

CREATE SEQUENCE item_counter 
AS INT 
START WITH 10
INCREMENT BY 10

SELECT NEXT VALUE FOR item_counter;








