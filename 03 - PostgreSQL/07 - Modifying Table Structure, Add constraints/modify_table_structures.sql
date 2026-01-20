-- Database: mydata

-- DROP DATABASE IF EXISTS mydata;

CREATE DATABASE mydata
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- Create database
create table persons(
	person_id serial primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null
);

-- Adding column
alter table persons
add column age int not null;

select * from persons;

alter table persons
add column nationality varchar(20),
add column email varchar(100) unique;

-- Renaming Table
alter table persons 
rename to users;

-- Rename Column
alter table persons 
rename column age to person_age;

-- Drop a column
alter table persons 
drop column person_age;

alter table persons
add column age varchar(10);

-- Change column data type
alter table persons
alter column age type int
using age::integer;

select * from persons

alter table persons
alter column age type varchar(20);

-- set default values of column
alter table persons
add column is_enable varchar(1);

alter table persons
alter column is_enable set default 'Y';

insert into persons(first_name, last_name, nationality, age)
values ('Aayushi', 'Trivedi', 'Indian', '21');

select * from persons

create table web_links(
	link_id serial primary key,
	link_url varchar(255) not null,
	link_target varchar(20)
);

select * from web_links;

insert into web_links (link_url, link_target) 
values ('https://www.amazon.com','_blank');

-- Adding unique constraint
alter table web_links
add constraint unique_web_url unique (link_url);

-- set a column to accept only defined allowed values
alter table web_links
add column is_enable varchar(2);

insert into web_links (link_url, link_target, is_enable) 
values ('https://www.CITI.com', '_blank', 'q');

update web_links
set is_enable = 'Y' 
where link_id = 4;

alter table web_links
add check (is_enable IN ('Y', 'N'));

update web_links
set is_enable = 'N'
where link_id = 2

select * from web_links;