use AdventureWorks2019


select * 
from Sales.SalesOrderHeader


select *
from Person.Person



select 
	soh.SalesPersonID,
	p.FirstName,
	p.LastName,
	sum( soh.TotalDue ) as total_sales
from Sales.SalesOrderHeader as soh 
join Person.Person  as p
	on soh.SalesPersonID = p.BusinessEntityID
group by 
	soh.SalesPersonID,
	p.FirstName,
	p.LastName



select *
from Production.Product 
 

select *
from Production.ProductSubcategory

select 
	ps.Name as SubCategory, 
	p.ProductID
from Production.Product as p
	inner join Production.ProductSubcategory as ps
on p.ProductSubcategoryID = ps.ProductSubcategoryID

-- нужно обьединить их 



-- left outer join -> below

select *
from Production.Product 
 

select *
from Production.ProductSubcategory

select 
	coalesce( ps.Name , 'No category ' ) as SubCategory,
	p.Name as ProductName,
	ps.Name as SubCategory 
from Production.Product as p
	left  join Production.ProductSubcategory as ps
on p.ProductSubcategoryID = ps.ProductSubcategoryID



select 
	coalesce( ps.Name , 'No category ' ) as SubCategory,
	p.Name as ProductName,
	ps.Name as SubCategory 
from Production.ProductSubcategory as ps 
	right  join Production.Product as p
on p.ProductSubcategoryID = ps.ProductSubcategoryID



select *
from Sales.SalesTerritory

-- cross join 
select *
from Sales.SalesPerson


select *
from Sales.SalesPerson 
cross join Sales.SalesTerritory  







select * 
from Sales.SalesOrderDetail


select 
	sod.ProductID, 
	p.Name,
	sum (UnitPrice * OrderQty) as tp
from Sales.SalesOrderDetail as sod
inner join Production.Product as p
on sod.ProductID = p.ProductID
group by sod.ProductID , p.Name
order by tp desc
