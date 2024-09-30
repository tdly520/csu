



create procedure  p_second
   @inputtitlename varchar(20)
as 
begin 
   select title,price,pub_name
   from titles,publishers
   where titles.pub_id=publishers.pub_id
        and titles.title like '$'+@inputtitlename+'$'
end

exec p_second'computer'
exec p_second @inputtitlename='cooking'

alter procedure p_second
  @inputtitlename varchar(20),
  @inputminprice int,
  @inputmaxprice int
as
begin
    
	declare @control int 
	set @control=(select count(*) from titles ,publishers
  
   where titles.pub_id=publishers.pub_id
        and titles.title like '$'+@inputtitlename+'$'
		and price between @inputminprice and @inputmaxprice)
   if @control >0
   begin
      select title,price,pub_name
   from titles,publishers
   where titles.pub_id=publishers.pub_id
        and titles.title like '$'+@inputtitlename+'$'
		and price between @inputminprice and @inputmaxprice
   return @control
	end
	else
	begin
	  
	  return 0
	  print'真的哈也没'
	  select top 3 title,price,pub_name
	  from titles,publishers
	  where titles.pub_id=publishers.pub_id
	  order by ytd_sales
	  return 0
	end

end
exec p_second 'computer',20,30

declare 
  @getreturn int
exec @getreturn =p_second 'computer',20,30
select @getreturn
