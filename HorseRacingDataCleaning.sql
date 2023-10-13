--- update race_time column to proper format---

alter table public.horse_data
alter column race_time type text;

select concat(left(race_time, 2), ':', right(race_time,2)) 
from public.horse_data;

update public.horse_data
set race_time = concat(left(race_time, 2), ':', right(race_time,2));

-----------------------------------------------------------------------------------


--- add column for furlongs ---

 add furlong column
 alter table public.horse_data
 add furlongs numeric;

select yards/220  from horse_data;

update public.horse_data
set furlongs = yards/220;

-----------------------------------------------------------------------------------


--- split out horse name and country in horse_name column ---
select split_part(horse_name, ' (', 1) horse_name,
trim(trailing ')' from split_part(horse_name, ' (', 2))
from horse_data;

alter table public.horse_data
add country text;

update public.horse_data
set country = trim(trailing ')' from split_part(horse_name, ' (', 2));

update public.horse_data
set horse_name = split_part(horse_name, ' (', 1) ;

-----------------------------------------------------------------------------------

--- rename decsp column----
alter table horse_data
rename decsp to starting_odds

-----------------------------------------------------------------------------------

--- rename trv column----
alter table horse_data
rename trv to total_race_value;

-----------------------------------------------------------------------------------

--- create rating grouping column ---
select rating, case 
when rating < 60 then '<60'
when rating <= 70 then '60-70'
when rating <= 80 then '70-80'
when rating <= 90 then '80-90'
when rating <= 100 then '90-100'
else '100+' end rating_grouping
from horse_data
order by 1 desc;

alter table public.horse_data
add rating_grouping text;

update public.horse_data
set rating_grouping = case 
when rating < 60 then '<60'
when rating <= 70 then '60-70'
when rating <= 80 then '70-80'
when rating <= 90 then '80-90'
when rating <= 100 then '90-100'
else '100+' end ;

