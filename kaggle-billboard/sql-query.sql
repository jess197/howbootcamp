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