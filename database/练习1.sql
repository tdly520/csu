select CategoryID
from Products
where CategoryID in ('2', '3','4')

select CategoryID
from Products
where CategoryID between 2 and 4

select '��Ҫ����' as'��ʾ',ProductName,(UnitsOnOrder - UnitsInStock)*100 as 'Ҫ����'
from Products
where UnitsInStock < UnitsOnOrder

