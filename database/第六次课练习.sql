declare 
 @id int
 

 set @id =

exec p_customlastorderdetail'TOMSP'

create p_customlastorderdetail
begin
   select CustomerID,Produ

CREATE PROCEDURE p 
    @customerID VARCHAR(50)
AS 
BEGIN 
    SELECT TOP 2 ProductName, UnitPrice
    FROM Orders 
    INNER JOIN Products ON Orders.OrderID = OrderDetails.OrderID
    INNER JOIN iOrderDetails.ProductID = OrderProduct.ProductID
    WHERE customerID = @customerID
    ORDER BY OrderDate;
END;

exec p  'apple'

CREATE PROCEDURE p 
    @customerID VARCHAR(50)
AS 
BEGIN 
    SELECT TOP 2 ProductName,Products.UnitPrice
    FROM Orders 
    INNER JOIN OrderDetails ON (Orders.OrderID = OrderDetails.OrderID)
    INNER JOIN Products ON (OrderDetails.ProductID = Products.ProductID)
    WHERE customerID = @customerID
    ORDER BY OrderDate;
END;
exec p'TOMSP'

alter procedure p_customlastallmoney
  @customerid varchar(20),
  @begindate datetime ='1970-1-1',
  @enddate datetime='2022-1-1'
as
begin
    declare @number int
    set @number=(select count(*) from  Orders
	where @customerid= CustomerID and OrderDate between @begindate and  @enddate)
	if @number >0
	begin 
	  select sum(Unitprice*Quantity) from[Order Details]
	  where OrderID in (select OrderID from Orders where CustomerID=@customerid and OrderDate between @begindate and  @enddate)
	  return @number
	end

end
exec p_customlastallmoney'TOMSP'




ALTER PROCEDURE p 
    @customerID VARCHAR(50),
	@startdate  VARCHAR(50),
	@enddate  VARCHAR(50)
AS 
BEGIN 
DECLARE @count int
set @count = (SELECT count(*)
    FROM Orders 
    INNER JOIN OrderDetails ON (Orders.OrderID = OrderDetails.OrderID)
    INNER JOIN Products ON (OrderDetails.ProductID = Products.ProductID)
    WHERE customerID = @customerID and OrderDate BETWEEN @startdate and @enddate
    )
if @count > 0
BEGIN 
    SELECT sum(Products.UnitPrice)
    FROM Orders 
    INNER JOIN OrderDetails ON (Orders.OrderID = OrderDetails.OrderID)
    INNER JOIN Products ON (OrderDetails.ProductID = Products.ProductID)
    WHERE customerID = @customerID and OrderDate BETWEEN @startdate and @enddate
   
END 
ELSE
BEGIN 
return 0
END 
END;

exec p'TOMSP','1996-07-05 00:00:00.000','1996-07-05 00:00:00.000'