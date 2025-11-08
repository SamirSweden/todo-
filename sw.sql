SELECT 
    count(*) as goods_count 
    , type 

FROM goods
WHERE price > 15
GROUP BY type 
HAVING count(*) < 5

-- second task 


SELECT 
    s.name as student_name 
    , sum(price) tp as total_price

FROM students s 
JOIN students_cources sc ON s.id = sc.student_id
JOIN cources c ON c.id = sc.cources_id
GROUP BY s.name
HAVING sum(price) > 10000


-- когда юзаем агрегатные функции нам нужна группировка 

-- numeric functions => ABS() , ROUND()
-- Date in Sql => GETDATE() , DATEDIFF() , CURRENT_TIMESTAMP() , DATEADD() , DAY(), MONTH(), YEAR()
--

SELECT year( getdate()) -- 2025



-- null functions 
ISNULL()
COALESCE()
NULLIF()
-- NULLIF() RARELY USED


-- convert 
-- any select statement is a table






use AdventureWorks2019
select @@VERSION

SELECT year( getdate()) -- 2025

SELECT * 
from Person.Person



select * 
from HumanResources.Employee as e
where 'Kim' in (
    select FirstName 
    from Person.Person
    where BusinessEntityID = e.BusinessEntityID
)





select * 
from HumanResources.Employee

select 
    ( select FirstName 
       from  Person.Person
       where BusinessEntityID = e.BusinessEntityID)
from HumanResources.Employee as e






SELECT *
from  (
 SELECT
    FirstName 
   ,LastName 
   from Person.Person
   ) as p
   where FirstName = 'Kim'

with PersonKim as(
    SELECT
    FirstName 
   ,LastName 
   from Person.Person
   
   where FirstName = 'Kim'
)

select LastName 
from PersonKim

 SELECT *
from  (
 SELECT
    FirstName 
   ,LastName 
   from Person.Person
   ) as p
   where FirstName = 'Kim'


WITH SampleCTE as (
    select 'Test'  as txt
)
-- SampleCTE -- virtual view

select *
from SampleCTE;




WITH 
SampleCTE as (
    select 'Test'  as txt
),

SeCTE as (
    select *  as SampleCTE
),

select *
from SeCTE;





select * 
from Production.Product

-- case чтобы сортировать  




--Теперь задача на сортировку. 
--Выведи список всех товаров из таблицы Products, отсортированный по убыванию цены (price). Нужны все столбцы.

SELECT * 
FROM Products 
ORDER BY price desc





SELECT * 
FROM workers 
WHERE name like 'A%';


SELECT email 
FROM Customers 
WHERE email like '%@gmail.com';




-- В таблице Products есть столбец product_name.
-- Нам нужно найти все товары, в названии которых (в любой части названия) встречается слово 'USB'.


SELECT product_name 
FROM  Products 
WHERE product_name like '%USB%'




select product_name  , price from Products 
case 
    case price > 1000 then price_category  'Expensive'
    case price  100 and < 1000  then price_category 'Medium'
    else 'cheap'
end as end_st



select * ,
CASE 
    case  status_code = 1 then  'Order Received'
    case status_code = 2 then 'Order Shipped'
    case status_code = 3 then 'Order Delivered'
        else 'Unknown Status'
END AS status_description 
from Orders  



select 
      employee_id,
     name ,
     salary,
     department_id ,
    case 
        when salary < 3000 then 'Low'
        when salary >= 3000 and salary  <= 7000  then 'Medium'
        when salary > 7000 then 'High'
        else 'unknown'
    end as salary_grade
from employees





select 
    employee_id,
    name , 
    salary, 
    department_id, 
    hire_date
from employees;



select * 
from employees
where name like '%Петя%';




--Найти сотрудников, у которых зарплата выше средней зарплаты по всей компании.


select * 
from employees
where salary > (
    select avg(salary) from employees
);




SELECT 
    amount,
    CASE 
        WHEN amount > 1000 THEN 'Large'
        WHEN amount >= 500  AND amount <= 1000 THEN 'Medium' 
        WHEN amount < 500 THEN 'Small'
        ELSE 'unknown'
    END AS order_category
FROM  orders;



SELECT 
    employee_id ,
    name ,
    department ,
    salary,

    CASE 
        WHEN salary > 7000 THEN 'High' 
        WHEN salary >= 3000 AND salary <= 7000 THEN 'Medium' 
        WHEN salary < 3000 THEN 'Small' 
        ELSE 'UNKNOWN'
    END AS order_category

FROM employees;


SELECT *
FROM customers
WHERE name LIKE 'A%' 




SELECT 
    o.order_id,
    o.order_date,
    c.name ,
    c.email
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id



SELECT 
    product_name,
    price 
FROM products
ORDER BY 
    price DESC  --  сортируем по цене по убыванию
    product_name ASC -- при равных ценах — по названию по алфавиту 




SELECT 
    customer_name,
    total_amount, 

    CASE 
        WHEN total_amount < 200 THEN 'Маленький заказ' 
        WHEN total_amount >= 200 AND  total_amount <  1000 THEN 'Средний заказ'
        WHEN total_amount >= 1000 THEN 'Большой заказ' 
    END AS order_size
FROM orders



-- 23.10.25





insert into Lecturers (FirstName , LastName)
select FirstName, LastName
from AdventureWorks2019.Person.Person

 







