--- Datatypes
CREATE TABLE boolean_data(
	id_no SERIAL PRIMARY KEY,
	is_available BOOLEAN NOT NULL
);

INSERT INTO boolean_data (is_available)
VALUES (TRUE),
	   (FALSE),
	   ('true'),
	   ('false'),
	   ('y'),
	   ('n'),
	   ('yes'),
	   ('no'),
	   ('1'),
	   ('0');

SELECT * FROM boolean_data   --- all give boolean output 


--- check condition on boolean column
SELECT * FROM boolean_data
WHERE is_available = TRUE

SELECT * FROM boolean_data 
WHERE is_available = 'y'

SELECT * FROM boolean_data
WHERE is_available = '0'

SELECT * FROM boolean_data 
WHERE is_available = '1'

select * from boolean_data 
where not is_available

SELECT * FROM boolean_data 	

ALTER TABLE boolean_data 
ALTER COLUMN is_available
SET DEFAULT FALSE

Insert into boolean_data (id_no) values (11)


---CHARACTER(n) === CHAR(n) , DEFAULT VALUE 1, FIXED LEN
---CHARACTER VARRYING VARCHAR  , NO DEFAULT VALUE, NOT FIXED
---TEXT MAX CAPACITY 1 GB

select cast ('aayushi' as character(10)) as "Name";

SELECT 'Aayushi'::char(10) AS "NAME"
"Aayushi     "  -- WASTE OF SPACE  SAME FOR character(n)

SELECT 'Aayushi'::VARCHAR AS "NAME"
"Aayushi"  --NO WASTAGE

SELECT 'my name is aayushi trivedi'::VARCHAR(10) AS "NAME"
"my name is"

select 
(
  'Explanation: LOWER(actor_name): Converts the name to lowercase. ' ||
  'LENGTH(actor_name) = 5: Ensures only names with exactly 5 characters are selected. ' ||
  'If you are using PostgreSQL, it works the same way. ' ||
  'Let me know if your column or table name is different.'
)::text as "info";


CREATE TABLE table_characters(
	col_char CHAR(10),
	col_varchar VARCHAR(10),
	col_text TEXT
);

select * from table_characters 

INSERT INTO table_characters (col_char,col_varchar,col_text)
VALUES ('abc','xyz','tts')

SELECT * FROM table_characters
"abc       "
"xyz"
"tts" -- text

--- Numeric Data types , Int and Float 
--- we can do airthmatic operation on it
--- take all value except NULL

--- INTEGER 
--- smallint 2 byte
--- integer 4 byte
--- bigint 8 byte

--- SAME FOR SERIAL BUT RANGE STARTING FROM 1

--- Decimal whole number and its fraction

--- Fixed Numbers  - size variable 
    --- numeric(10,2) 99999999.99  - fixed point 

--- Floating Numbers  
    --- real               - 4 byte  - floating point  - 6-8 decimal 
	--- double precision   - 8 byte  - floating point  - 15-17  decimal

create table table_serial(
	product_id serial,
	product_name varchar(100)
);

insert into table_serial(product_name)
values('pen');

select * from table_serial;

insert into table_serial(product_name)
values('pencil');

insert into table_serial(product_name)
values('pencil2');

--Decimal
create table table_numbers(
	col_numeric numeric(20,5),
	col_real real,
	col_double double precision
);

insert into table_numbers(col_numeric, col_real, col_double)
values 
	(.9,.9,.9),
	(3.13579, 3.13579, 3.13579),
	(4.9876578231, 4.9876578231, 4.9876578231)

select * from table_numbers;

---- DATE / TIME
--- date time timestamp timestampz interval
---  4    8     

create table table_date(
	id serial primary key,
	employee_name varchar(100) not null,
	hire_date date not null,
	add_date date default current_date
);

insert into table_date(employee_name, hire_date) values
('aayushi','2020-01-01'),
('nisarg','2020-02-01');

select * from table_date;

-- get current date
select current_date;

-- get current date and time
select now();


-- Time
create table table_time(
	id serial primary key,
	class_name varchar(100) not null,
	start_time time not null,
	end_time time not null
);

insert into table_time(class_name, start_time, end_time) values
('math','08:00:00','09:00:00'),
('chemistry','09:01:00','10:00:00');

select * from table_time;

-- get current time with precision
select current_time(5);

-- Use local time
select current_time,localtime;
select localtime, localtime(4);

-- Arithmetic Ops
select time '12:00' - time '04:00' as result;

-- Using interval
select current_time, current_time + interval '+2 hours' as result;	

-- Time Stamp and Time stampz
create table table_time_tz(
	ts timestamp,
	tstz timestamptz
);

insert into table_time_tz(ts, tstz) values
('2020-02-22 10:10:10-07', '2020-02-22 10:10:10-07');


select * from table_time_tz;

-- Get current timezone
show timezone;

-- Change timezone
set timezone = 'America/New_York';

-- Get timestamp
select current_timestamp;
set timezone = 'Asia/Calcutta';

-- Current time of day
select timeofday();

-- Using timezone() function to convert time based on a time zone
select timezone('Asia/Singapore','2020-01-01 00:00:00')
select timezone('America/New_York','2020-01-01 00:00:00')
select timezone('Asia/Calcutta','2020-01-01 00:00:00')


-- UUID
-- Enable uuid extension
create extension  if not exists "uuid-ossp";

select uuid_generate_v1();
"7c8a9c7c-6dd5-11f0-8904-4b2b0bf47157"

create table table_uuid(
	product_id uuid default uuid_generate_v1(),
	product_name varchar(100) not null 
);

insert into table_uuid (product_name) values ('12345');

select * from table_uuid;

-- change default uuid value
alter table table_uuid
alter column product_id
set default uuid_generate_v4();

-- Array
create table table_array(
	id serial,
	name varchar(100),
	phones text []
);

select * from table_array;

insert into table_array (name, phones)
values ('Beena', ARRAY ['1234567891','9155434567']);

insert into table_array (name, phones)
values ('Swati', ARRAY ['6576363783','2657384618']);

select * from table_array;

select phones[1] from table_array;

select name from table_array 
where phones[2] = '2657384618';

--- hstore

CREATE EXTENSION IF NOT EXISTS "hstore";

CREATE TABLE library1(
	book_id SERIAL,
	book_info hstore
);

INSERT INTO library1 (book_info)
VALUES ('
			"book_name" => "xyz",
			"author_name" => "zxy",
			"price" => "100"
'),('
			"book_name" => "abc",
			"author_name" => "cba",
			"price" => "200"
');

SELECT * FROM library1

SELECT book_info->'book_name' as Book_name,
book_info->'price' as price
FROM library1

--- JSON
--- we have normal JSON and JSONB for binary data
--- JSON supports white spaces and identation but not JSONB
--- JSONB supports fast searching and indexing 

CREATE TABLE json(
	id serial primary key,
	docs JSON
);

INSERT INTO json(docs)
VALUES 
	('[1,2,3,4,5]'),
	('[2,3,4,5,6]'),
	('{"Key" : "Value"}')

SELECT * FROM json

SELECT * FROM json
WHERE docs @> '2'    --- not working cause we have data type JSON its working in JSONB

ALTER TABLE json
ALTER COLUMN docs TYPE JSONB;

SELECT * FROM json
WHERE docs @> '{"Key":"Value"}'   

CREATE INDEX ON json USING GIN (docs jsonb_path_ops );

--- NETWORK ADRESSES
--- cidr -> ipv4 and ipv6 networks
--- inet -> ipv4 and ipv6 with host 
--- macaddr  -> mac adresses
--- macaddr8  -> mac adresses EUI-64 format 

create table table_netaddr(
	id serial primary key,
	ip inet
);

insert into table_netaddr (ip) values
('4.35.221.243'),
('4.152.207.126'),
('4.152.207.238'),
('4.249.111.162'),
('12.1.223.132'),
('12.8.192.60');

select * from table_netaddr;

select ip,set_masklen(ip,24) as inet_24
from table_netaddr

select 
	ip, 
	set_masklen(ip::cidr, 24) as cidr_24,
	set_masklen(ip::cidr, 27) as cidr_27,
	set_masklen(ip::cidr, 28) as cidr_28
from table_netaddr;