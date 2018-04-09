use Northwind
 select top 5 with ties orderid, productid, quantity from [order details] order by quantity desc
 select count(*) from Employees
 select count(ReportsTo) from Employees
 select count(*) from Products where UnitPrice not BETWEEN 10 and 20
 select max(UnitPrice) from Products where UnitPrice < 20
 select max(UnitPrice), min(UnitPrice), avg(UnitPrice) from Products where QuantityPerUnit like '%bottle%'
 select * from Products where UnitPrice > (select avg(UnitPrice) from Products)
 select *, UnitPrice * Quantity * (1-Discount) as [cena] from [Order Details] where OrderID = 10250
 select sum(UnitPrice * Quantity * (1-Discount)) as [cena] from [Order Details] where OrderID = 10250
 select * from orderhist
 select OrderID, sum(quantity) as total_quantity from orderhist group by orderid
 select OrderID, max(UnitPrice) as max_price from [Order Details]  GROUP BY OrderID ORDER BY max_price
 select ShipVia, count (*) as liczba from Orders GROUP BY ShipVia
 select top 1 ShipVia, count(*) as liczba from Orders where year(ShippedDate) = 1997 GROUP BY ShipVia ORDER BY 'liczba' desc
 select OrderID, count(*) as [xxxx] from [Order Details] GROUP BY OrderID HAVING count(*) > 5
 select CustomerID, count(*) from Orders where year(ShippedDate) = 1998 GROUP BY CustomerID having count(*) > 8 ORDER BY sum(Freight) desc


--ćwiczenie 1
SELECT OrderID, sum(Quantity*UnitPrice*(1-Discount)) as "VALUE" from [Order Details] GROUP BY OrderID ORDER BY [wartosc sprzedazy] DESC
SELECT TOP 10 OrderID, sum(Quantity*UnitPrice) as "VALUE" from [Order Details] GROUP BY OrderID ORDER BY [wartosc sprzedazy] DESC
SELECT TOP 10 WITH TIES OrderID, sum(Quantity*UnitPrice) as "VALUE" from [Order Details] GROUP BY OrderID ORDER BY [wartosc sprzedazy] DESC
--Wyniki dwóch ostatnich zapytań są takie same, nie ma więc wartośći o takiej samej wartości jak w nr 10
--ćwiczenie 2
SELECT sum(Quantity) from [Order Details] where ProductID < 3
SELECT ProductID, sum(Quantity) from [Order Details] GROUP BY ProductID
SELECT OrderID, sum(Quantity*UnitPrice) from [Order Details] GROUP BY OrderID HAVING sum(Quantity)>250
--ćwiczenie 3
SELECT ProductID, OrderID, sum(Quantity) from [Order Details] GROUP BY ProductID, OrderID WITH ROLLUP ORDER BY 1,2
SELECT ProductID, OrderID, sum(Quantity) from [Order Details] GROUP BY ProductID, OrderID WITH ROLLUP HAVING ProductID=50
null oznacza tam dowolne wartości kolumny
SELECT ProductID, grouping(ProductID), OrderID, grouping(OrderID), sum(Quantity) as "total quantity" FROM [Order Details] GROUP BY ProductID, OrderID WITH CUBE ORDER BY 1,3
-- podsumowaniami są wiersze, w których występuje null,
-- wg produktu podsumowują te, w których nullem jest OrderID,
-- a wg zamówienia te, w których nullem jest ProductID

Select ProductID, OrderID, sum(quantity) AS total_quantity
FROM orderhist
GROUP BY productid, orderid
WITH ROLLUP
  ORDER BY productid, orderid

select null, null, sum(quantity) from orderhist


select ProductID, null, sum(quantity) from orderhist
GROUP BY  productid
ORDER BY productid

select ProductID, orderid, sum(quantity) from orderhist
GROUP BY  productid, orderid
ORDER BY productid, orderid


use joindb
select * from buyers
select * from produce
select * from sales

select buyer_name, sales.buyer_id, qty
  from Buyers, Sales
    where buyers.buyer_id = sales.buyer_idselect

SELECT buyer_name, s.buyer_id, qty
  from Buyers as b, Sales as s
    where b.buyer_id = s.buyer_id

SELECT buyer_name, sales.buyer_id, qty
  FROM Buyers
    INNER JOIN Sales ON Buyers.buyer_id = Sales.buyer_id

select buyer_name, sales.buyer_id, qty
  FROM Buyers
    inner JOIN sales on buyers.buyer_id = Sales.buyer_id

SELECT buyer_name, sales.buyer_id, qty
  FROM Buyers
    LEFT OUTER JOIN Sales ON Buyers.buyer_id = Sales.buyer_id


use Northwind

SELECT productname, CompanyName
  FROM Products
    INNER JOIN Suppliers on Products.SupplierID = Products.SupplierID

SELECT DISTINCT CompanyName, OrderDate
  FROM Orders
    INNER JOIN Customers on Orders.CustomerID = Customers.CustomerID
      WHERE OrderDate > '3/1/98'


use library
select firstname, lastname, juvenile.birth_date, juvenile.adult_member_no
  from member
    inner JOIN  juvenile on member.member_no = juvenile.member_no

select distinct title.title
  from title
    INNER JOIN loan on loan.title_no = title.title_no

SELECT in_date, datediff(d, due_date, in_date) due_date, fine_paid
  from loanhist
    INNER JOIN title on loanhist.title_no = title.title_no
      WHERE title = 'Tao Teh King' and due_date < loanhist.in_date

use Northwind
SELECT ProductName, UnitPrice, CompanyName, ContactName, Suppliers.Address, City
  from Products
    INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
      where UnitPrice BETWEEN 20 and 30

SELECT ProductName, UnitsInStock
  from Products
    INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
      where CompanyName = 'Tokyo Traders'

select CompanyName, Phone
  from Suppliers
    INNER JOIN Products on Suppliers.SupplierID = Products.SupplierID
      where Products.UnitsInStock = 0

-- Dokończyć ćwiczenia w domu

use Northwind
SELECT OrderID, SUM(Quantity) as 'Quantity'
  FROM [Order Details]
    GROUP BY OrderID
      HAVING SUM(Quantity) > 250

SELECT ShipName, Quantity*UnitPrice AS "VALUE"
  FROM Orders
    INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderID

SELECT ShipName, Quantity*UnitPrice AS [VALUE]
  FROM Orders
    INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderID
      WHERE Quantity > 250 -- liczba jednostek => rozumiem, że liczba towarów, nie cena
     --WHERE Quantity*UnitPrice > 250  -- jezeli chodzi o wartosc a nie liczbę jednostek towaru

SELECT ShipName, Quantity*UnitPrice*(1-Discount) AS [VALUE], FirstName + ' ' + LastName as [Obslugujacy]
  FROM Orders
    INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderID
    INNER JOIN Employees on Orders.EmployeeID = Employees.EmployeeID
    --WHERE Quantity > 250 -- liczba jednostek => rozumiem, że liczba towarów, nie cena
  --WHERE Quantity*UnitPrice > 250  -- jezeli chodzi o wartosc a nie liczbę jednostek towaru

-- pokazuje sumę wartości towaru dla poszczególnego kupującego
SELECT ShipName, sum(Quantity*UnitPrice) AS "VALUE"
  FROM Orders
    INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderID
      GROUP BY ShipName

-- ćw 2 - join
SELECT CategoryName, SUM(Quantity) AS "Suma_jednostek"
  FROM Products
    LEFT JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
    LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID
      GROUP BY CategoryName
     -- ORDER BY ProductName

SELECT CategoryName, SUM([Order Details].UnitPrice*Quantity*(1-Discount)) AS "Wartosc"
  FROM Products
    LEFT OUTER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
    LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID
      GROUP BY CategoryName
    -- ORDER BY ProductName

SELECT CategoryName, SUM([Order Details].UnitPrice*Quantity*(1-Discount)) AS "Wartosc"
  FROM Products
    LEFT OUTER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
    LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID
      GROUP BY CategoryName
      ORDER BY [Wartosc]

SELECT CategoryName, SUM([Order Details].UnitPrice*Quantity*(1-Discount)) AS "Wartosc"
  FROM Products
    LEFT OUTER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
    LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID
      GROUP BY CategoryName
      ORDER BY SUM(Quantity)

--cw 3
SELECT Suppliers.CompanyName, COUNT(Orders.OrderID)--, COUNT(Products.ProductID)
  FROM Suppliers
    LEFT JOIN Products ON Suppliers.SupplierID = Products.SupplierID
    INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
    INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
    WHERE YEAR(ShippedDate) = 1997
    GROUP BY Suppliers.CompanyName

SELECT TOP 1 Suppliers.CompanyName, COUNT(Orders.OrderID) AS [val]--, COUNT(Products.ProductID)
  FROM Suppliers
    LEFT JOIN Products ON Suppliers.SupplierID = Products.SupplierID
    INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
    INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
    WHERE YEAR(ShippedDate) = 1997
    GROUP BY Suppliers.CompanyName
    ORDER BY [val] DESC

SELECT TOP 1 FirstName + ' ' + LastName AS [Pracownik]--, COUNT(OrderID)
  FROM Employees
    INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
    WHERE YEAR(OrderDate) = 1997
      GROUP BY FirstName + ' ' + LastName
      ORDER BY COUNT(OrderID) DESC

--ćw 4
SELECT FirstName + ' ' + LastName AS [Pracownik], SUM(UnitPrice*Quantity*(1-Discount)) AS "Value"
  FROM Employees
    LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
    LEFT JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
    GROUP BY FirstName + ' ' + LastName

SELECT TOP 1 FirstName + ' ' + LastName AS [Pracownik]--, SUM(UnitPrice*Quantity*(1-Discount)) as [Value]
  FROM Orders
    INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderID
    INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
    WHERE YEAR(OrderDate) = 1997
    GROUP BY FirstName + ' ' + LastName
    ORDER BY SUM(UnitPrice*Quantity*(1-Discount)) DESC

SELECT FirstName + ' ' + LastName AS [Pracownik], SUM(UnitPrice*Quantity*(1-Discount)) AS "Value"
  FROM Employees
    LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
    INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
    WHERE isnull(ReportsTo,0) > 0
    GROUP BY FirstName + ' ' + LastName

SELECT firstname, LastName, reportsto from Employees

SELECT Orders.EmployeeID, FirstName, LastName, SUM(UnitPrice*Quantity*(1-Discount)) AS "Value"
  FROM Employees
    LEFT JOIN Orders ON Orders.EmployeeID = Employees.ReportsTo
    INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
--WHERE isnull(ReportsTo,0) = 0
  GROUP BY


----------
SELECT CategoryName, SUM(Quantity)
  FROM Categories
    LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
    INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
      GROUP BY CategoryName

SELECT [Order Details].OrderID, SUM(Quantity) AS "Quantity", ShipName
  FROM Orders
    INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
      GROUP BY [Order Details].OrderID, ShipName

SELECT [Order Details].OrderID, SUM(Quantity) AS "Quantity", ShipName
  FROM Orders
    INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
      GROUP BY [Order Details].OrderID, ShipName
        HAVING SUM(Quantity) > 250

SELECT ShipName, ProductName
  FROM Orders
    LEFT JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
    LEFT JOIN Products ON [Order Details].ProductID = Products.ProductID
    ORDER BY ShipName

SELECT ShipName, ISNULL([Order Details].UnitPrice*Quantity*(1-Discount),0) AS VALUE
  FROM Orders
    LEFT JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
    LEFT JOIN Products ON [Order Details].ProductID = Products.ProductID
    ORDER BY [VALUE]

use library
SELECT DISTINCT firstname + ' ' + lastname--, member.member_no
  FROM member
  LEFT JOIN loanhist ON loanhist.member_no = member.member_no
  LEFT JOIN loan ON member.member_no = loan.member_no
  WHERE loanhist.member_no IS NULL  and loan.member_no IS NULL --isnull(loanhist.member_no,0) = 0 and isnull(loan.member_no,0) = 0


use Northwind
SELECT orderid, CustomerID
  FROM Orders AS or1
  WHERE 20 < (SELECT Quantity FROM [Order Details] AS od WHERE or1.OrderID = od.OrderID AND od.ProductID = 23)

SELECT Orders.OrderID, CustomerID
  FROM Orders
  INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
  WHERE ProductID = 23 and  Quantity > 20

--podaj wszystkie produkty,
-- których cena jest większa niż średnia cena produktów tej samej kategorii

SELECT ProductName, CategoryName, UnitPrice
FROM Products
  INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
  HAVING UnitPrice > AVG(UnitPrice)
  GROUP BY CategoryName


SELECT DISTINCT CompanyName, Phone, CategoryName from Customers
  RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
  RIGHT JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
  RIGHT JOIN Products ON [Order Details].ProductID = Products.ProductID
  RIGHT JOIN Categories ON Products.CategoryID = Categories.CategoryID
                           and CategoryName != 'Confections'-- and
WHERE CategoryName IS NULL
GROUP BY CompanyName,Phone,CategoryName--, CategoryName



use Northwind
SELECT  DISTINCT Customers.CompanyName, Shippers.CompanyName, Customers.Phone
  FROM Customers
    INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    INNER JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
    WHERE YEAR(Orders.ShippedDate) = 1997 AND Shippers.CompanyName = 'United Package'
    ORDER BY 1

SELECT  CompanyName, Phone
  FROM Customers
  WHERE CustomerID IN (SELECT CustomerID
                      FROM Orders
                      WHERE YEAR(ShippedDate) = 1997 and ShipVia = (SELECT ShipperID
                                                                    FROM Shippers
                                                                    WHERE CompanyName = 'United Package'))


SELECT  CompanyName, Phone
  FROM Customers
  WHERE CustomerID IN (SELECT CustomerID
                      FROM Orders
                      WHERE YEAR(ShippedDate) = 1997 and ShipVia = (SELECT ShipperID
                                                                    FROM Shippers
                                                                    WHERE CompanyName = 'United Package'))

SELECT DISTINCT Customers.CompanyName, Customers.Phone, CategoryName
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName != 'Confections'


use library
SELECT member.member_no, firstname, lastname, adult.street + ' ' + adult.city, count(loan.member_no), count(loanhist.member_no)
FROM member
LEFT JOIN adult ON member.member_no = adult.member_no
LEFT JOIN loan ON member.member_no = loan.member_no
LEFT JOIN loanhist ON member.member_no = loanhist.member_no
GROUP BY member.member_no, firstname, lastname, adult.street + ' ' + adult.city

SELECT isnull( juvenile.adult_member_no,-1), firstname, lastname, adult.street + ' ' + adult.city, count(loan.member_no) + count(loanhist.member_no)
FROM member
LEFT JOIN adult ON member.member_no = adult.member_no
LEFT JOIN loan ON member.member_no = loan.member_no
LEFT JOIN loanhist ON member.member_no = loanhist.member_no
LEFT JOIN juvenile ON member.member_no = juvenile.member_no
GROUP BY member.member_no, juvenile.adult_member_no, firstname, lastname, adult.street + ' ' + adult.city


SELECT member.member_no, firstname, lastname, loan.member_no, loanhist.member_no
FROM member
LEFT JOIN loan ON member.member_no = loan.member_no
LEFT JOIN loanhist ON member.member_no = loanhist.member_no
WHERE loan.member_no IS NULL AND loanhist.member_no IS NULL
ORDER BY member.member_no

SELECT member_no, firstname, lastname
FROM member
WHERE member_no IN (SELECT member_no FROM member
                    EXCEPT Select member_no FROM loanhist
                    EXCEPT SELECT member_no FROM loan)

use Northwind
SELECT * FROM Categories

SELECT DISTINCT CompanyName, Phone FROM Customers
EXCEPT
SELECT DISTINCT CompanyName, Phone FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Confections'


SELECT CompanyName, Phone From Customers
EXCEPT
SELECT CompanyName, Phone FROM Customers  WHERE CustomerID IN
    (SELECT CustomerID FROM Orders WHERE OrderID IN
            (SELECT OrderID FROM [Order Details] where ProductID IN
                  (SELECT ProductID FROM Products WHERE CategoryID =
                          (SELECT CategoryID FROM Categories WHERE CategoryName = 'Confections'))))

--cw 2.1 bez podzapytania
SELECT ProductName, COUNT([Order Details].OrderID)
FROM Products
  LEFT JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName

--cw 2.1 podzapytanie
SELECT (SELECT ProductName FROM Products WHERE [Order Details].ProductID = Products.ProductID) AS ProductName, count(ProductID) FROM [Order Details]
GROUP BY ProductID


--cw 2.2 bez podzapytania
SELECT ProductName,Products.UnitPrice, AVG(([Order Details].UnitPrice*(1-Discount)))
FROM Products
LEFT JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
--LEFT JOIN Orders ON [Order Details].OrderID = Orders.OrderID
GROUP BY ProductName, Products.UnitPrice

SELECT * FROM [Order Details]

SELECT ProductID, UnitPrice,
    (UnitPrice * (1-Discount) * [Order Details].Quantity)/SUM(Quantity)
FROM [Order Details]
GROUP BY ProductID, UnitPrice, (UnitPrice * (1-Discount) * [Order Details].Quantity)

SELECT CategoryName, AVG(Products.UnitPrice)
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryName

SELECT ProductID FROM Categories
FULL JOIN Products ON Categories.CategoryID = Products.CategoryID

SELECT DISTINCT A.ProductName,  A.UnitPrice--, B.UnitPrice-AVG(B.UnitPrice)
FROM Products A, Products B


--3.1
SELECT A.ProductName, A.UnitPrice,
  (SUM(B.UnitPrice)+A.UnitPrice)/(COUNT(B.UnitPrice)+1) Srednia, (((SUM(B.UnitPrice)+A.UnitPrice)/(COUNT(B.UnitPrice)+1))-A.UnitPrice) AS Roznica
FROM Products A, Products B
WHERE A.ProductID <> B.ProductID
GROUP BY A.ProductName, A.UnitPrice

SELECT A.ProductName, A.UnitPrice,
  (SUM(B.UnitPrice)+A.UnitPrice)/(COUNT(B.UnitPrice)+1) Srednia, ((SUM(B.UnitPrice)+A.UnitPrice)/(COUNT(B.UnitPrice)+1))-A.UnitPrice
FROM Products A
INNER JOIN Products B ON A.ProductID <> B.ProductID
GROUP BY A.ProductName, A.UnitPrice


SELECT A.ProductName, A.UnitPrice
FROM Products A, Products B
WHERE A.ProductID <> B.ProductID
GROUP BY A.ProductName, A.UnitPrice
HAVING (SUM(B.UnitPrice)+A.UnitPrice)/(COUNT(B.UnitPrice)+1) > A.UnitPrice

SELECT A.ProductName, A.UnitPrice
FROM Products A
INNER JOIN Products B ON A.ProductID <> B.ProductID
GROUP BY A.ProductName, A.UnitPrice
HAVING (SUM(B.UnitPrice)+A.UnitPrice)/(COUNT(B.UnitPrice)+1) > A.UnitPrice

--cw 2
SELECT A.ProductName, A.UnitPrice
FROM Products A
CROSS JOIN Products B
GROUP BY A.ProductName, A.UnitPrice
HAVING AVG(B.UnitPrice) > A.UnitPrice



SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice < (SELECT )

--cw 3.1
SELECT A.ProductName, A.UnitPrice, AVG(B.UnitPrice), A.UnitPrice - AVG(B.UnitPrice)
FROM Products A
CROSS JOIN Products B
GROUP BY A.ProductName, A.UnitPrice

--cw 3.2
SELECT A.ProductName, CategoryName, A.UnitPrice, AVG(B.UnitPrice), A.UnitPrice - AVG(B.UnitPrice)
FROM Products A
  INNER JOIN Categories ON A.CategoryID = Categories.CategoryID
  INNER JOIN Products B ON Categories.CategoryID = B.CategoryID
GROUP BY A.ProductName, CategoryName, A.UnitPrice
ORDER BY CategoryName

SELECT ProductName, CategoryName, UnitPrice, (SELECT )
FROM Products


--cw 4.1
SELECT [Order Details].OrderID, SUM(UnitPrice*Quantity*(1-Discount))+ (Freight)
FROM [Order Details]
INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE Orders.OrderID = 10249
GROUP BY [Order Details].OrderID, Freight

SELECT OrderID, SUM(UnitPrice*Quantity*(1-Discount)) + (SELECT SUM(Freight) FROM Orders WHERE OrderID = 10250)
FROM [Order Details]
WHERE OrderID = 10250
GROUP BY OrderID

--cw 4.2
SELECT Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount))+Freight
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY Orders.OrderID, Freight

SELECT OrderID, SUM(UnitPrice*Quantity*(1-Discount)) + (SELECT SUM(Freight) FROM Orders WHERE [Order Details].OrderID = Orders.OrderID)
FROM [Order Details]
GROUP BY OrderID

--cw 4.3
SELECT Address
FROM Customers

EXCEPT

SELECT DISTINCT Address
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(ShippedDate) = 1997

SELECT Address
FROM Customers

EXCEPT

SELECT DISTINCT Address
FROM Customers
WHERE CustomerID IN (SELECT DISTINCT Orders.CustomerID FROM Orders WHERE YEAR(ShippedDate) = 1997)

--cw 4.4
SELECT DISTINCT ProductName, COUNT(CustomerID)
FROM Products
  INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
  INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
GROUP BY  ProductName
HAVING COUNT(CustomerID)>1
ORDER BY ProductName

SELECT  *
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
--WHERE ProductName='Aniseed Syrup'
--GROUP BY ProductName
--ORDER BY ProductName

SELECT ProductID, count(CustomerID) as ilosc_klientow
FROM [order details]
INNER JOIN Orders ON Orders.OrderID=[order details].OrderID
GROUP BY ProductID
HAVING count(CustomerID)>1
ORDER BY 1

SELECT SUM(UnitPrice*Quantity*(1-Discount) + Freight)--, SUM(Freight),[Order Details].OrderID
FROM Employees
INNER JOIN Orders B ON Employees.EmployeeID = B.EmployeeID
INNER JOIN [Order Details] ON B.OrderID = [Order Details].OrderID

WHERE B.EmployeeID = 1
--GROUP BY [Order Details].OrderID
ORDER BY 1

SELECT SUM(Freight)
FROM Orders
WHERE EmployeeID = 1

SELECT Employees.FirstName, Employees.LastName, SUM(Quantity*UnitPrice*(1-Discount)) +
(SELECT SUM(Freight) FROM Orders A WHERE A.EmployeeID = C.EmployeeID)
FROM [Order Details] B
  INNER JOIN Orders C ON B.OrderID = C.OrderID
  INNER JOIN Employees ON C.EmployeeID = Employees.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName, C.EmployeeID
ORDER BY C.EmployeeID


SELECT Employees.FirstName, Employees.LastName, SUM(Quantity*UnitPrice*(1-Discount)) +
(SELECT SUM(Freight) FROM Orders A WHERE A.EmployeeID = C.EmployeeID)
FROM [Order Details] B
  INNER JOIN Orders C ON B.OrderID = C.OrderID
  INNER JOIN Employees ON C.EmployeeID = Employees.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName, C.EmployeeID
ORDER BY C.EmployeeID

SELECT Orders.OrderID, Freight, EmployeeID, UnitPrice*Quantity*(1-Discount) as [VALUE] FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID

SELECT DISTINCT Orders.EmployeeID,SUM(Freight)/count(Orders.OrderID) + SUM(UnitPrice*Quantity*(1-Discount)) as [VALUE]
FROM Orders
  INNER JOIN [Order Details] B ON
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Orders.EmployeeID = 1
GROUP BY Orders.EmployeeID

SELECT Orders.EmployeeID + ' ' + CONVERT(VARCHAR(5),[Order Details].OrderID)
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID






SELECT Employees.FirstName, Employees.LastName, SUM(Quantity*UnitPrice*(1-Discount)) + MAX(A.Freight)
FROM [Order Details] B
  INNER JOIN Orders C ON B.OrderID = C.OrderID
  INNER JOIN Employees ON C.EmployeeID = Employees.EmployeeID

  INNER JOIN Orders A ON Employees.EmployeeID = A.EmployeeID --

GROUP BY Employees.FirstName, Employees.LastName, A.Freight
ORDER BY 1

SELECT DISTINCT E.EmployeeID, [Order Details].OrderID, SUM(Quantity*UnitPrice*(1-Discount)), SUM(Freight)
FROM Employees E
INNER JOIN Orders A ON E.EmployeeID = A.EmployeeID

--INNER JOIN Orders B ON E.EmployeeID = B.EmployeeID

LEFT JOIN [Order Details] ON A.OrderID = [Order Details].OrderID
GROUP BY E.EmployeeID, [Order Details].OrderID

ORDER BY 1