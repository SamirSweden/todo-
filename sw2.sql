use AdventureWorks2019 



-- dml (data manipulation language)
-- includes select , insert , update , delete 

-- Transaction - creates staging area for the up-coming changes 


-- insert into 

INSERT  INTO users (id, firstname, lastname, gender, email, dateofbirth, currentaddressid)
VALUES  (127, 'Vera', 'Horton', 'female', 'vera.horton@example.com', '1975-01-08', 1127),
        (127, 'Vera', 'Horton', 'female', 'vera.horton@example.com', '1975-01-08', 1127),
        (127, 'Vera', 'Horton', 'female', 'vera.horton@example.com', '1975-01-08', 1127),
        (127, 'Vera', 'Horton', 'female', 'vera.horton@example.com', '1975-01-08', 1127),
        (127, 'Vera', 'Horton', 'female', 'vera.horton@example.com', '1975-01-08', 1127)



insert into Lecturers (FirstName , LastName)
select FirstName, LastName
from AdventureWorks2019.Person.Person

-- DELETE FROM <TABLE NAME>
-- WHERE condition_clause 



--delete 
DELETE FROM Lecturers
WHERE FirstName = 'John' and LastName = 'Smith'


delete from Lecturers 
where FirstName in(
    select FirstName 
    from AdventureWorks2019.Person.Person
    WHERE FirstName = 'mr'
)



--update 


update users 


select * from Lecturers




update Lecturers 
set 
    FirstName = FirstName + '' + LastName
    WHERE FirstName = 'Angel'










    
