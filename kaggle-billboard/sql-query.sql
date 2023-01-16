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


WITH cte_billboard AS (
	SELECT DISTINCT 
			 b.artist 
		   , b.song
		   , row_number() over(order by artist,song) as row_number
           , row_number() over(partition by artist order by artist, song) as row_number_artist
	   FROM public."Billboard" b 
	order by b.artist 
	  , b.song 
)
select * 
  from cte_billboard
where "row_number_artist" = 1; 
    

WITH cte_billboard AS (
	SELECT DISTINCT 
			 b.artist 
		   , b.song
	   FROM public."Billboard" b 
	order by b.artist 
	  , b.song 
)
select * 
   -- , row_number() over(order by artist,song) as row_number
   -- , row_number() over(partition by artist order by artist, song) as row_number_artist
    , rank() over(partition by artist order by artist,song) as "rank"
   -- , lag(song, 1) over(partition by artist order by artist,song) as "lag_song"
   -- , lead(song, 1) over(partition by artist order by artist,song) as "lead_song"
    , first_value(song) over(partition by artist order by artist,song) as "first_song"
    , last_value(song) over(partition by artist order by artist,song range between unbounded preceding and unbounded following) as "last_song"
  from cte_billboard; 

-- VIEW ARTIST with deduplication
create view vw_artist as (
with cte_dedup_artist as ( 
 select b."date"
      , b."rank"
      , b.artist
      , row_number() over(partition by artist order by artist, "date") as dedup
  from tb_artist b 
  order by b.artist, b."date"
  ) 
  select b."date"
       , b."rank"
       , b.artist
    from cte_dedup_artist as b 
    where b.dedup = 1
);

-- CREATE TABLE tb_artist 

create table tb_artist as (
select b."date"
      , b."rank"
      , b.artist
      , b.song
  from public."Billboard" b
  where b.artist = 'AC/DC'
  order by b.artist, b.song, b."date"

);


insert into tb_artist (
select b."date"
      , b."rank"
      , b.artist
      , b.song
  from public."Billboard" b
  where b.artist like 'Adele%'
  order by b.artist, b.song ,b."date"
);



-- VIEW SONG    
create view vw_song as (
with cte_dedup_artist as ( 
 select b."date"
      , b."rank"
      , b.artist
      , b.song
      , row_number() over(partition by artist,song order by artist, song,"date") as dedup
  from tb_artist b 
  order by b.artist, b.song, b."date"
  ) 
  select b."date"
       , b."rank"
       , b.artist
       , b.song
    from cte_dedup_artist as b 
    where b.dedup = 1
);