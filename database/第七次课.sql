---�������Ļ����﷨
create trigger <trigger_name,sysname,trig_test>
on <table_name,sysname,pubs.dbo.sales>
for delete,insert, update
as
begin


end


select title_id,title,price
into aaa
from titles

select * from aaa


create trigger t_insert_aaa
on aaa
for insert 
as
begin
   print'fuck you'
end
insert aaa values('ID1111','BOOK 2',20)

create trigger t_update_aaa
on aaa
for update 
as
begin
   print'fuck you'
end
update aaa set price=price+1

create trigger t_insert_aaa_2
on aaa
for insert 
as
begin
   print'fuck you!!!'
end
insert aaa values('ID222','BOOK 2',20)



----��ȡ��ֵ���Ĵ�����
��ʱ��

inserted updated deleted

alter trigger t_insert_aaa_i_konw
on AAA
for insert
as
begin
  declare @inserted_title varchar(20),
          @inserted_price int
  set @inserted_title=(select title from inserted)
  set @inserted_price=(select price from inserted)

  print'������'
  +@inserted_title+'and price'+cast(@inserted_price as varchar(19))
end

insert aaa values('ID3333','BOOK 3',10)

select * from aaa


----�����һ�м�¼���޸ļ۸���ԭ�ۺ��޸ĺ�۸�
alter trigger t_update_2
on aaa
for update
as
begin
   declare @updated_price int,
   @price int,
   @titleid1 varchar (20)
   set @titleid1=(select title_id from inserted)
   set @updated_price=(select price from inserted )
  set  @price =(select price from deleted where title_id=@titleid1)
  
     print'ԭ��'
  +cast(@price as varchar(19))+'����'+cast(@updated_price as varchar(19))
end
update aaa set price =1000
where title_id='BU1111'


---------
select * from titles
select * from sales

ÿ����һ�����ۼ�¼���͸���shuzongxiaoliang
create trigger t_update_titles_ytdsales
on sales
for insert
as
begin
  declare @titleid_2 varchar (100),@qtd2 int
  set @titleid_2=(select title_id from  inserted)
  set @qtd2=(select qty from inserted)
  update titles set ytd_sales=ytd_sales+@qtd2
  where title_id=@titleid_2
end
insert sales values ('6380','6666','2004-1-1',1000,'Net 60','P2222')

ÿ����һ����,������һ��Ǯ��titleauthors��royaltper
select *from titleauthor

create trigger t_update_titleauthrs_royaltper
on sales
for insert
as
begin
    declare  @titleid4 varchar(100),@qty4 int
	
	set @titleid4=(select title_id from inserted)
    set @qty4=(select qty from inserted)
	
	update titleauthor set royaltyper=royaltyper+@qty4 where title_id =@titleid4
end


insert sales values ('6380','6666','2004-1-1',1000,'Net 60','P2222')


