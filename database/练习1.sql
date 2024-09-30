select CategoryID
from Products
where CategoryID in ('2', '3','4')

select CategoryID
from Products
where CategoryID between 2 and 4

select '需要进货' as'提示',ProductName,(UnitsOnOrder - UnitsInStock)*100 as '要进货'
from Products
where UnitsInStock < UnitsOnOrder

