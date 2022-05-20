--1. Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the
--following.
SELECT c.Name, s.Name
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode


--2. Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada.
--Join them and produce a result set similar to the following.
SELECT c.Name, s.Name
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Germany', 'Canada')

-- Using Northwind Database: (Use aliases for all the Joins)
--3. List all Products that has been sold at least once in last 25 years.
SELECT p.ProductName, o.OrderDate, od.Quantity
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON p.ProductID = od.ProductID
WHERE DATEDIFF(DAY, o.OrderDate, GETDATE()) < 9125 AND od.Quantity != 0


--4. List top 5 locations (Zip Code) where the products sold most in last 25 years.
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) NumSold
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE DATEDIFF(DAY, o.OrderDate, GETDATE()) < 9125
GROUP BY o.ShipPostalCode
ORDER BY NumSold DESC



--5. List all city names and number of customers in that city.     
SELECT City, COUNT(CustomerID) AS CustomerNum
FROM Customers
GROUP BY City


--6. List city names which have more than 2 customers, and number of customers in that city
SELECT City, COUNT(CustomerID) AS CustomerNum
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >=2


--7. Display the names of all customers  along with the  count of products they bought
SELECT c.ContactName, SUM(od.Quantity) AS ProductCount
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.ContactName



--8. Display the customer ids who bought more than 100 Products with count of products.
SELECT c.ContactName, SUM(od.Quantity) AS ProductCount
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.ContactName
HAVING SUM(od.Quantity) > 100
ORDER BY ProductCount



--9. List all of the possible ways that suppliers can ship their products. Display the results as below
SELECT su.CompanyName, sh.CompanyName
FROM Suppliers su CROSS JOIN Shippers sh
ORDER BY su.CompanyName


--10. Display the products order each day. Show Order date and Product Name.
SELECT o.OrderDate, p.ProductName
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY o.OrderDate



--11. Displays pairs of employees who have the same job title.
SELECT COUNT(e.FirstName) AS dup, m.Title, m.FirstName + ' ' + m.LastName AS EmployeeName
FROM Employees e LEFT JOIN Employees m ON  e.Title = m.Title
GROUP BY m.Title, m.FirstName, m.LastName
HAVING COUNT(e.FirstName) != 1



--12. Display all the Managers who have more than 2 employees reporting to them.
SELECT m.FirstName + ' ' + m.LastName AS EmployeeName, COUNT(e.EmployeeID) AS NumReportsTo
FROM Employees e LEFT JOIN Employees m ON  e.ReportsTo = m.EmployeeID
GROUP BY e.ReportsTo, m.FirstName, m.LastName
HAVING COUNT(e.EmployeeID) > 1



--13. Display the customers and suppliers by city. The results should have the following columns
SELECT s.City, s.CompanyName AS Name, s.ContactName, 'Suppliers' AS Type
FROM Suppliers as s
UNION
SELECT c.City, c.CompanyName AS Name, c.ContactName, 'Customers' as Type
FROM Customers as c
ORDER BY city

--14. List all cities that have both Employees and Customers.
SELECT DISTINCT c.City
FROM Employees e JOIN Customers c ON e.City = c.City


--15. List all cities that have Customers but no Employee.
SELECT City
FROM Customers
WHERE City NOT IN(SELECT City FROM Employees)


--16. List all products and their total order quantities throughout all orders.
SELECT p.ProductName, SUM(Quantity) AS TotalOrderQuantities
FROM Products p LEFT JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY p.ProductName



--17. List all Customer Cities that have at least two customers.
SELECT City, COUNT(CustomerID) AS NumOfCustomer
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 1


--18. List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.City, COUNT(DISTINCT od.ProductID) AS ProductNum
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2
ORDER BY c.City


--19. List 5 most popular products, their average price, and the customer city that ordered most quantity of it.

--20. List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered
--from. (tip: join  sub-query)

--21. How do you remove the duplicates record of a table?