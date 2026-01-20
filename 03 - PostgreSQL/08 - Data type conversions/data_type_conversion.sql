-- What is a type conversion?
-- two type conversion: Implicit and explicit

select * from movies;

--  1. 'Type conversion' Examples

select * from movies
where movie_id = 1

-- integer = string

select * from movies
where movie_id = '1'

-- 2. what if we want to use Explicit conversion?

select * from movies
where movie_id = integer '1'

-- Using CAST for data conversions

CAST (expression AS target_data_type);

-- 1. String to integer conversion

select 
	CAST('10' AS INTEGER);

select
	CAST('10n' AS INTEGER);
	

-- 2. String to date 

select 
	cast('2020-01-01' as date),
	cast('25-december-2024' as date);

-- 3. string to boolean

select 
	cast('true' as boolean),
	cast('false' as boolean),
	cast('T' as boolean),
	cast('F' as boolean),
	cast('0' as boolean),
	cast('1' as boolean)


-- 4. String to double

select 
	cast('14.7888' as double precision);
	
expression::type

select
	'10'::INTEGER,
	'2020-01-01'::DATE,
	'01-01-2020'::DATE

-- 5. string to timestamp

select  '2020-02-20 10:30:25.456'::TIMESTAMP;

-- with timezone
select '2020-02-20 10:23:12.432'::timestamptz;

--6. interval

select
	'10 minute'::interval,
	'4 hour'::interval,
	'1 day'::interval,
	'2 week'::interval,
	'5 years'::interval
	
-- IMPLICIT TO EXPLICIT CONVERSIONS

-- 1. Using integer and factorial

SELECT factorial(20);
SELECT factorial(20) as result;


select factorial(cast(20 as bigint)) as "result";

-- 2. Round with numeric

select round(10,4) as result;

select round(cast(10 as numeric), 4) as "result";


-- 3. CAST with text

select substr('123456', 2) as "result"


select 
	substr('123456', 4) as "Implicit",
	substr(cast('123456' as text),4) as "Explicit"


-- TABLE DATA CONVERSION

-- 	1. Lets create a table called 'ratings' with initial data as character

create table ratings(
	rating_id serial primary key,
	rating varchar(1) not null
);

select * from ratings

--2. let's insert some data

insert into ratings (rating) values
('A'),
('B'),
('C'),
('D');

select * from ratings;

-- 3. now rating want in integer

insert into ratings (rating) values
(1),
(2),
(3),
(4);

select * from ratings;

-- 4. now, we have to convert all values in the rating column into integers

select
	rating_id,
	case
		when rating~E'^\\d+$' then 
			cast (rating as integer)
		else
			0
		end as rating
from 
	ratings