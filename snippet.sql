SELECT site,
  MAX(CASE m WHEN 1 THEN n ELSE 0 END ) 1月,  -- max important!!
  MAX(CASE m WHEN 2 THEN n ELSE 0 END ) 2月,
  MAX(CASE m WHEN 3 THEN n ELSE 0 END ) 3月,
  MAX(CASE m WHEN 4 THEN n ELSE 0 END ) 4月,
  MAX(CASE m WHEN 5 THEN n ELSE 0 END ) 5月,
  MAX(CASE m WHEN 6 THEN n ELSE 0 END ) 6月,
  MAX(CASE m WHEN 7 THEN n ELSE 0 END ) 7月,
  MAX(CASE m WHEN 8 THEN n ELSE 0 END ) 8月,
  MAX(CASE m WHEN 9 THEN n ELSE 0 END ) 9月,
  MAX(CASE m WHEN 10 THEN n ELSE 0 END ) 10月,
  MAX(CASE m WHEN 11 THEN n ELSE 0 END ) 11月,
  MAX(CASE m WHEN 12 THEN n ELSE 0 END ) 12月
  
/*
  IF(site=T.site and T.m=1,T.n,0) as 1月,
  IF(site=T.site and T.m=2,T.n,0) as 2月,
  IF(site=T.site and T.m=3,T.n,0) as 3月,
  IF(site=T.site and T.m=4,T.n,0) as 4月,
  IF(site=T.site and T.m=5,T.n,0) as 5月,
  IF(site=T.site and T.m=6,T.n,0) as 6月,
  IF(site=T.site and T.m=7,T.n,0) as 7月,
  IF(site=T.site and T.m=8,T.n,0) as 8月,
  IF(site=T.site and T.m=9,T.n,0) as 9月,
  IF(site=T.site and T.m=10,T.n,0) as 10月,
  IF(site=T.site and T.m=11,T.n,0) as 11月,
  IF(site=T.site and T.m=12,T.n,0) as 12月
 */
 

 from (
SELECT site,month(input_date) as m,count(*) as n from car_info_t  where site in 
(1,3,4,7,124,6,139,11,8,9,134,144,107,5,136,103,120,110,117,156,102,101,114,137,126,158,142,157,113,118,129)
and input_date >= '2016-01-01' and input_date < '2017-01-01' 
GROUP BY site,month(input_date)
order by site,month(input_date)
) as T

-- where site in (1,3,4,7,124,6,139,11,8,9,134,144,107,5,136,103,120,110,117,156,102,101,114,137,126,158,142,157,113,118,129)
GROUP BY site -- important!!
order by site


-- ORDER BY id ASC  limit 1

-- SELECT * from data_info_t  ORDER BY id ASC limit 1


-- 去重
create table dust 
SELECT * from car_info_t  where site in 
(1,3,4,7,124,6,139,11,8,9,134,144,107,5,136,103,120,110,117,156,102,101,114,137,126,158,142,157,113,118,129)
and input_date >= '2016-01-01' and input_date < '2017-01-01' 
GROUP BY city,title,site,input_date,price

-- 写文件

into outfile '/tmp/abc0717_new1.xls'
 CHARACTER SET gbk
 
