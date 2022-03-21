
use NorthWind;

********** seleccionar datos de customer y ordenarlo por nombre del contacto de compañia
/ alfabeticamente *****/

select * from customers
order by ContactName 


/** seleccionar datos de ordenes y ordenarlos por fecha orden descendente ***/
select*from  orders
order by OrderDate desc

/** seleccionar datos de detalle de orden  y ordenarlos por cantidad pedida ascendente***/

select*from [dbo].[Order Details]
order by Quantity

/** obtener todos los productos cuyo nombre comienzan con la letra p y tienen precio entre 10 y 120***/

select * from Products
where ProductName like 'p%'
and UnitPrice between 10 and 120;

--- obtener todos los clientes de los paises de USA, francia y españa

select count(*) from Customers
where country in('USA')

select distinct country from Customers

----- obtener productos descontiuados y sin stock que pertenecen a categorias 1,3,4,7------
select * from products
where (Discontinued = 1) and  (UnitsInStock = 0)
and (CategoryID in(1,3,4,7))

-----obtener todas las ordenes hechas por el empleado con codigo 5,2 y 7 en el año 1996
select * from Orders
where EmployeeID in (5,2,7) and 
year (OrderDate) = 1996

----- seleccionar todos los clientes con fax
Select * from Customers
where fax is not null

----seleccionar todos los clientes que no cuenten cn FAX, del pais USA
Select * from Customers
where (fax is null) and Country = 'USA'

---- seleccionar empleados que cuneten con jefe

select * from Employees
where ReportsTo is not null


----------------- seleccionar todos los campos del cliente, cuya compañia empieze con la A HASTA la d 
---- y pertenesca a FRANCE y prdenarlos por la direccion


Select * from Customers
where CompanyName like  '[A-D]%'
and Country = 'france' order by Address

------ selececcionar todos los campos del proveedor cuya compañia no comience con la letra
--- de la B a la G y pertenezca a UK ordenarlos por nombre de compañia
use Northwind
select * from Suppliers
where CompanyName not like '[B-G]%' and Country='UK'
order by CompanyName

----- 13-----seleccionar los productos discontinuados  cuytos recios estan entre 35 y 250 sin stock en almacen,
---pertenecientes alas categorias 1,3,4,7 y 8, que son distribuidos pro 2,4,6,7 y 9

select * from Products
where (discontinued = 0)  and 
(unitPrice between 35 and 250) 
and (UnitsInStock = 0) and (CategoryID in (1,3,4,7,8)) and 
(SupplierID in (2,4,6))

------------- seleccionar capos de productos discontinuados proveedores con codigos
-- 1,3,7,8,9 que tengan stock en al macen (distintos de cero) y precios entre  39 y 190 ordenados por codigo 
--- de proveedor y precio unitario de manera ascendente

select * from Products
where Discontinued=1 and
SupplierID  IN(1,3,7,8,9) and 
UnitsinStock <> 0 and 
UnitPrice between 39 and 190 
order by UnitPrice,SupplierID

------------------------ 15. selececcionar los 7 productos con precios mas caros 
-- que cuenten con stock en almacen 

select TOP 7*from Products
where Unitsinstock <> 0
order by UnitPrice desc

--16 seleccinar  los 9 productos con menos stock en almacen que pertenezcan ala categoria 3,5,8

select top 9*from Products
where CategoryID in (3,5,8)
order by UnitsInStock 


----17   seleccionar las ordenes de compra  realizadas por el empleado con codifo entre el 2 y 5 
--ademas de los clientes con codigos que comienzan con letras de la A hasta la G del 31 de julio
-- de cualquier año

select * from Orders
where EmployeeID between 2 and 5 and
CustomerID like '[A-G]%' and 
datepart (MM,OrderDate)='7' and
datepart (DD,OrderDate) ='31'


---- seleccionar las ordenes de compra realizadas por el empleado con codigo 3, de cualquier año pero
--solo de los ultimos 5 mese (agosto-diciembre)

select * from Orders
where EmployeeID = 3
and DATEPART (MM,OrderDate) in(8,9,10,11,12)


select * from Orders
where EmployeeID = 3
and DATEPART (MM,OrderDate) between 8 and 20


---- seleccionar los detalles de las ordenes de compra que tengan un monto de cantidad
----pedida entre 10 y 250

select * from [Order Details]
where Quantity between 10 and 250

----- y total
select Quantity as cantidad, UnitPrice as precio_unita,
unitprice*quantity as total from [Order Details]
where  unitprice*quantity  between 10 and 250

-----cambiar el nombre de pais de uk por el de peru en suppliers and customers

select SupplierID,Country from Suppliers
select CustomerID,country from Customers

update Suppliers
set Country = 'peru'
where country = 'UK'

select* from Suppliers

update Customers
set Country = 'peru'
where country = 'UK'

select* from Customers
--------------------cambiar el nombre de categoria 5 por jugetes------------
select* from Categories

update Categories
set CategoryName = 'toys'
where CategoryName = 'Grains/cereals'

---------------------------cambiar y colocar el numerod de fax 0 alos nulos

select fax,CustomerID from Customers
where fax is null
update Customers
set Fax = '0'
where fax is null 


-------------------cambiar nombre y apellido del empleado de codigo 6

select * from Employees
where EmployeeID = 6

update Employees
set LastName = 'nappi',
    firstname = 'paola'
where EmployeeID = 6

------------------------------------------------ delete

---eliminar la orden de compra 10255
select*from [Order Details]
where OrderID=10255
delete from [Order Details]
where OrderID = 10255


select*from Orders
where OrderID=10255


-- eliminar los productos discontinuados 

select * from Products
where Discontinued = 1
select * from [Order Details]

delete from [Order Details]
where ProductID in (5,9,17,24,28,29,42,53)--insertamos el codigo de productoID que aparece en el select de arriba

delete from Products
where Discontinued = 1

-------- INNER JOIN --- https://www.youtube.com/watch?v=RXLZ6rugwBM-------
-------parte 4
---- mostrar el codigo de la orden de compra,fecha de la orden de compra , 
--- el codigo del producto,el nombre del producto y la cantidad

select * from Products ---productname,product id
select * from orders--orderid,orderdate
select * from [Order Details]--quantitu

select od.[OrderID], o.[OrderDate],p.[ProductID],[ProductName],[Quantity]
from [Order Details] as od inner join Orders as o 
on od.orderid=o.Orderid
inner join Products as p 
on p.ProductID=od.ProductID


----- mostrar codigo de categoria, nombre de categoria,(de catgorias) cod.producto,nombreproducto,precio de productos
-----
select  c.[CategoryID],[CategoryName],[ProductID],[ProductName],[UnitPrice] 
from Products as p inner join Categories as c
on p.CategoryID=c.CategoryID

-------------mostrar numero de la orden,fecha de la orden,codigo del producto,
--- cantidad,precio y flete de la orden

select*from Orders
select*from [Order Details]
select*from Products
select od.OrderID,o.OrderDate,od.[ProductID],p.[ProductName],[Quantity],p.[UnitPrice],o.[Freight] 
from [dbo].[Order Details] as od inner join products as p
on od.productID=p.productID
inner join orders as o
on o.orderID=od.orderID
where od.ProductID=4  ------ojo pendiente

select*from od

---------mostrar codigo,nombre,ciudad y pais porveedir,codigo,nombre
---precio,stock del producto

select s.[SupplierID],s.[ContactName],s.[Country],s.[City],[ProductID],[ProductName],[UnitPrice],[UnitsInStock]
from products as p inner join Suppliers as s
on p.SupplierID =s.SupplierID
where UnitPrice between 6 and 21

---------mostrar numero de la orden,fecha,nombre del producto,nombre de la categoria,nombre del proveedor
select od.[OrderID],o.[OrderDate],p.[ProductName],c.[CategoryName],s.[ContactName] 
from [Order Details] as od 
inner join orders as o on od.OrderID= o.OrderID
inner join Products as p on od.ProductID=p.ProductID
inner join Categories as c on c.CategoryID=p.CategoryID
inner join Suppliers as s on s.SupplierID=p.SupplierID
where ProductName='chang';



------------------------------------------ ejericicos de funciones de cadena---------------
-----------https://www.youtube.com/watch?v=dtf_t2OcpUo---------------------------------
use Northwind;
select*from[dbo].[Employees]

----mostrar la inicial del nombre de cada empleado
select left(Firstname,1) as nombres,* from Employees

--mostrar en una sola columna el nombre completo del empleaado

select concat(LastName,' ' ,FirstName) as nombre_completo ,* from Employees

---mostrar columna nombre de empleado en mayuscula

select upper(FirstName) as [nombres ayuscula ] ,* from Employees

--- p en minuscula

select lower(FirstName) as [nombres minuscula ] ,* from Employees

----mostrar posicion de palabra sales en title para cada empleado

----mostrar ventas lugar de sales en el camppo title
select replace(Title,'sales','') as ventas_to,* from Employees

---agregar codigo DV-01 antrs del nombre del empleado

select stuff(FirstName,1,0,'dv-10 ') as perro,* from Employees

----mostrar titlecourtesy al reverso
-------------------- sacar el promedio de Unitprice
select * from Products
select avg(Unitprice) from [dbo].[Products]


select ROUND(Extension,1) as chicle,*from Employees

select * from Employees;