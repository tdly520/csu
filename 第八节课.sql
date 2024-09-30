---游标----
--查询每本商业书籍在1993年总销量
select * from titles where type='business'
BU1111
BU2075
BU7832
select sum(qty) from sales where title_id='BU1111' and ord_date between '1993-1-1'and '1993-12-31'
select sum(qty) from sales where title_id='BU2075' and ord_date between '1993-1-1'and '1993-12-31'
select sum(qty) from sales where title_id='BU7832' and ord_date between '1993-1-1'and '1993-12-31'


declare @myid varchar(10),@mytitle varchar(100),@myprice money,@myqty int

declare mycursor cursor for 
select title_id,title,price from titles where type='business'

open mycursor
fetch next from mycursor into @myid ,@mytitle ,@myprice

while @@FETCH_STATUS=0
begin
    set @myqty=(select sum(qty) from sales where title_id=@myid and ord_date between '1993-1-1'and '1993-12-31')
	print'book:'+@mytitle+'在1993年销量是：'+cast(@myqty as varchar(10))
	fetch next from mycursor into @myid ,@mytitle ,@myprice
    
end

close mycursor
DEALLOCATE mycursor


select * from customers

select * from orders where customerid='GREAL'order by orderdate desc
11061
select sum(unitprice*quantity) from[Order Details]where orderid='11061'


alter procedure p_tttt
  @mycountry varchar(20)
as
begin
declare @myid varchar(10),@mycustomerid varchar(100),@mysum money,@mydate datetime

create table #tempcursor(
    [customerid][varchar](80) collate chinese_prc_ci_as not null,
	[orderdate][DATETIME],
	[sum][money]) on [primary]
	




declare mycursor cursor for 
select customerid from Customers where Country=@mycountry

open mycursor
fetch next from mycursor into @mycustomerid

while @@FETCH_STATUS=0
begin
    set @myid  =(select top  1 orderid from orders where customerid=@mycustomerid order by orderdate desc)
	set @mydate  =(select top  1 orderdate from orders where customerid=@mycustomerid order by orderdate desc)
    set @mysum=(select sum(unitprice*quantity) from[Order Details]where orderid=@myid)
	insert into #tempcursor values(@myid,@mydate,@mysum)
	fetch next from mycursor into @mycustomerid
    
end
select * from #tempcursor
drop table #tempcursor
close mycursor
DEALLOCATE mycursor

end
exec p_tttt @mycountry='UK'