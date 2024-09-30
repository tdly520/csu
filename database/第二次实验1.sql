select R.ZGH,Q.ZGH,Q.CPH,C.CPH,R.XM,C.CPM,C.SCRQ
from XSRYB as R inner join XSQKB as Q on (R.ZGH = Q.ZGH) 
     inner join CPB as C on (Q.CPH = C.CPH)
where SCRQ > '2001-12-31'


select  max(NL)
from XSRYB as R
where ZGH in (select ZGH from XSQKB where CPH = 'P02')


select TOP 3 sum(Q.XSSL)
from XSRYB as R inner join XSQKB as Q on (R.ZGH = Q.ZGH) 
inner join CPB as C on (Q.CPH = C.CPH)
group by C.CPH
order by sum(Q.XSSL) desc    


select R.XM,R.ZGH,Q.CPH,Q.XSRQ,Q.XSSL
from XSRYB as R left outer join XSQKB as Q on (R.ZGH = Q.ZGH)


select TOP 1 CPM, SCCJ
from (
    select C.CPM, C.SCCJ, sum(Q.XSSL) as total_sales
    from XSRYB as R 
    inner join XSQKB as Q on (R.ZGH = Q.ZGH) 
    inner join CPB as C on (Q.CPH = C.CPH)
    where Q.XSRQ > '2001-01-01'
    group by C.CPM, C.SCCJ
) as sales
order by total_sales desc
