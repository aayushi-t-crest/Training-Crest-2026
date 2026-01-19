CREATE TABLE customers(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);

SELECT * FROM CUSTOMERS;

INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Adam', 'Waheed','test@test.com', 12);

SELECT * FROM CUSTOMERS;

INSERT INTO customers(first_name, last_name)
VALUES
('ADNAN', 'WAHEED'),
('JOHN', 'ADAMS'),
('LIIN','ABE');

SELECT * FROM CUSTOMERS;

INSERT INTO customers(first_name)
VALUES
('Bill''0 Sullivan');

SELECT * FROM CUSTOMERS;

-- After the insert, lets return all rows
INSERT INTO customers(first_name)
VALUES ('JOSH') RETURNING *;

-- After the insert, return a single column value
INSERT INTO customers(first_name)
VALUES ('JOSH') RETURNING first_name;


-- Update single column
UPDATE customers
SET email = 'a@b.com'
WHERE customer_id = 1

SELECT * FROM CUSTOMERS;

-- Update multiple columns
UPDATE customers
SET
email = 'a4@test.com',
age = 22
WHERE customer_id = 1

-- Use RETURNING to get updated row
UPDATE customers
SET
email='xyz@gmail.com'
WHERE
customer_id = 3
RETURNING *;

-- UPDATE ALL RECORDS IN A TABLE

-- Update with no WHERE clause

SELECT * FROM customers;

UPDATE customers
SET is_enable = 'Y'


-- DELETE RECORDS FROM A TABLE

--To delete records based on a condition

DELETE FROM customers
WHERE customer_id = 7

DELETE FROM customers;

SELECT * FROM customers;

-- create sample table

CREATE TABLE t_tags(
	id serial PRIMARY KEY, 
	tag text UNIQUE,
	update_date TIMESTAMP DEFAULT NOW()
);

-- insert some sample data

INSERT INTO t_tags(tag) 
VALUES
('Pen'),
('Pencils');

-- views the data

SELECT * FROM t_tags;

-- Lets insert a record, on conflict do nothing

INSERT INTO t_tags (tag)
VALUES ('Pen')
ON CONFLICT (tag) 
DO
	NOTHING


SELECT * FROM t_tags;

-- Lets insert a record, on conflict set new values

INSERT INTO t_tags (tag)
VALUES ('Pen')
ON CONFLICT (tag)
DO
	UPDATE SET 
		tag = EXCLUDED.tag || 1,
		update_date  = NOW();


SELECT * FROM t_tags;
	