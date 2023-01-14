-- CREATE TABLE BILLBOARD
create table public."Billboard" (
"date" date null,
"rank" int4 null ,
 song varchar(300) null,
 artist varchar(300) null,
"last-week" int4 null,
"peak-rank" int4 null,
"weeks-on-board" int4 null

);

-- SELECT ALL RECORDS
select count(*) from "Billboard" b 

-- SELECT ALL RECORDS FROM ADELE GROUPING BY ARTIST AND SONG AND ORDERING BY MOST APPEARS IN BILLBOARD'S HOT SONGS 
select 
b.artist,
b.song,
count(*) as "#song"
from "Billboard" b 
where b.artist = 'Adele'
group by artist, song
order by "#song" desc

-- SELECT ALL RECORDS FROM ADELE AND SELENA GOMEZ GROUPING BY ARTIST AND SONG AND ORDERING BY MOST APPEARS IN BILLBOARD'S HOT SONGS 
select 
b.artist,
b.song,
count(*) as "#song"
from "Billboard" b 
where b.artist in ('Adele','Selena Gomez')
group by artist, song
order by "#song" desc


 -- #CTE 
 with artists as (
 select 
	 b.artist
     , count(*) as qtd_artist
  from "Billboard" b
  group by b.artist
  order by b.artist
 )
 , songs as (
 select b.song
     , count(*) as qtd_song
  from "Billboard" b
  group by b.song
  order by b.song
 )
 select distinct bbd.artist
      , art.qtd_artist 
      , bbd.song 
      , sng.qtd_song 
    from "Billboard" bbd
    left join artists art on bbd.artist = art.artist  
 	left join songs sng on bbd.song = sng.song 
    order by bbd.artist, bbd.song