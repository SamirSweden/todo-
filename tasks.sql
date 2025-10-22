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

