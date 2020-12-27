--select A.FcustID,FItemID,FAuxPriceDiscount,FDate  FROM ICSale a 
--Inner Join ICSaleEntry    b   on a.FInterID=b.FInterID 

--select * from ICSaleEntry
--select * from dbo.ICTemplateENTRY where fid='I04'
--select * from t_Organization where fname like '%田野%'


--select A.FcustID,FItemID,MAX(FDate) FDATE  FROM ICSale a 
--Inner Join ICSaleEntry    b   on a.FInterID=b.FInterID 
--where A.FcustID=26340
--GROUP BY A.FcustID,FItemID



--select A.FcustID,B.FItemID,FAuxPriceDiscount  FROM ICSale a 
--Inner Join ICSaleEntry    b   on a.FInterID=b.FInterID 
--left Join(select A.FcustID,FItemID,MAX(FDate) FDATE  FROM ICSale a Inner Join ICSaleEntry    b   on a.FInterID=b.FInterID where A.FcustID=26340 GROUP BY A.FcustID,FItemID)
--                        C ON A.FcustID=C.FCustID AND A.FDate=C.FDate AND B.FItemID=C.FItemID
--where c.FDATE is not null and A.FcustID=26340 
--ORDER BY a.FInterID DESC 



--最新一条价格纪录，A.FcustID客户内码
select A.* FROM(    
select A.FcustID,FItemID,FAuxPriceDiscount
,row_number() over (partition by FItemID order by FDATE desc,a.FInterID desc) as group_idx    FROM ICSale a 
Inner Join ICSaleEntry    b   on a.FInterID=b.FInterID 
where A.FcustID=26340 ) A
where A.group_idx = 1


--最新一条价格纪录，A.FcustID客户内码，group_idx 最大值为复购次数，我不会处理，只会取最新购买购买价，其实需要最新购买价+复购次数
select A.FcustID,FItemID,FAuxPriceDiscount
,row_number() over (partition by FItemID order by FDATE desc,a.FInterID desc) as group_idx    FROM ICSale a 
Inner Join ICSaleEntry    b   on a.FInterID=b.FInterID 
where A.FcustID=26340

