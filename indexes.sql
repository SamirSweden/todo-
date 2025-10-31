use AdventureWorks2019 



-- dml (data manipulation language)
-- includes select , insert , update , delete 

-- Transaction - creates staging area for the up-coming changes 

-- insert into 


select * from Lecturers


begin transaction 
insert into Lecturers values ('john', 'smith', null , null, null )


rollback -- remove 






insert into Lecturers (FirstName , LastName)
select FirstName, LastName
from AdventureWorks2019.Person.Person








SELECT * 
FROM sys.indexes 
where name = 'idxPersonFirstName';

CREATE NONCLUSTERED INDEX idxPersonFirstName 
ON Person.Person (FirstName);


-- non-clustered index 
-- separate data-structure
-- non-unique


SELECT %%physclo%%, *
FROM Person.Person


create unique index dxFirstName 
	on Person.Person(Title , FirstName , LastName , Suffix)



