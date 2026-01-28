-- Duplicate schema with all data

-- 1. Lets create a sample database called 'test_schema'

create database test_schema;

-- 2. Create a table called "Songs"

create table test_schema.public.songs(
	song_id serial primary key,
	song_title varchar(100)
);

-- 3. Add some data to songs tables

insert into test_schema.public.songs (song_title) values
('Counting Stars'),
('Rolling on')

select * from songs

-- 4. Now duplicate the schema "public" with all data
pg_dump -d test_schema -h localhost -U postgres -n public > dump.sql

-- Rename public to old_schema

-- import back dumped file
-- psql -h localhost -U postgres -d test_schema -f dump.sql

SELECT * FROM information_schema.schemata;

SELECT COALESCE (c1.table_name, c2.table_name) as table_name,
	COALESCE(c1.column_name, c2.column_name) as table_column,
	c1.column_name as schema1,
	c2.column_name as schema2
FROM
(
	SELECT table_name, column_name 
	FROM information_schema.columns c 
	WHERE c.table_schema = 'public'
) c1	
FULL JOIN	
(
	SELECT table_name, column_name
	FROM information_schema.columns c 
	WHERE c.table_schema = 'hr'
)c2
ON c1.table_name = c2.table_name AND c1.column_name = c2.column_name
WHERE c1.column_name is null OR c2.column_name is null
ORDER by table_name, table_column;

--- Schema Acessess level rights 
---   - USAGE   only can see data
---   - CREATE  even modify data

GRANT USAGE ON SCHEMA hr TO "aayushi";

--- grant select 

GRANT SELECT ON ALL TABLES IN SCHEMA hr TO "aayushi";

INSERT INTO hr.employees (emp_id,name) VALUES ('7fa7c25e-dfad-4b94-b257-7c8bb81c9f9e','ABC')

SELECT * FROM employees

GRANT SELECT ON ALL TABLES IN SCHEMA public TO "aayushi";

GRANT CREATE ON SCHEMA hr TO "aayushi";