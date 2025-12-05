-- My 2025 Top Songs
select replace(
         replace(url,'https://www.youtube.com','youtu.be'),
         '/watch?v=','/') as url,
       visit_count as 👀,
       substr(rtrim(title,' - YouTube'),0,70) as title
  from moz_places
 where last_visit_date > (strftime('%s','2025-01-01')*1000000)
   and url like '%you%be%v=%'
 order by visit_count desc
 limit 100;
