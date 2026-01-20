-- convert integer into string

select
	to_char(
		100870,
		'9,99999'
	); 

-- let's view movie release data in DD-MM-YYYY format

select
	release_date,
	TO_CHAR(release_date, 'DD-MM-YYYY'),
	TO_CHAR(release_date, 'Dy, MM, YYYY')
from movies;

-- converting timestamp literal to a string

select 
	TO_CHAR(
		timestamp '2020-01-01 10:30:45',
		'HH24:MI:SS'
	);

-- Adding currency symbol to say movie revenues
select * from movies_revenues

select 
	movie_id,
	revenues_domestic,
	TO_CHAR(revenues_domestic, '$999D99')
from movies_revenues;

-- TO_NUMBER

-- convert a string to a number

select TO_NUMBER(
	'1456.76',
	'9999.'
);

select TO_NUMBER(
	'10,654.78-',
	'99G999D99S'
);

-- formating

select to_number(
	'$1,423.65',
	'L9G999D99'
);

select to_number(
	'1,234,546.89',
	'9G999g999'
)

select to_number(
	'1,234,432.88',
	'9G999g999D99'
);

-- converting say money number

select
	to_number(
		'1,987,288.87',
		'L9G999g999.99'
	);


-- string to date

select TO_DATE(
	'2020/10/22',
	'YYYY/MM/DD'
)

select TO_DATE(
	'022199',
	'MMDDYY'
);

SELECT TO_DATE(
	'March 07, 1999',
	'Month DD, YYYY'
);

-- Error Handling

select TO_DATE(
	'2020/10/30',
	'YYYY/MM/DD'
);


-- To timestamp

select to_timestamp(
	'2020-10-28 10:30:23',
	'YYYY-MM-DD HH:MI:SS'
)

-- It skip spaces

select
	to_timestamp('2020     may', 'YYYY MON');

-- minimal erro is checking!!

select 
	to_timestamp('2020-01-01 22:8:00', 'YYYY-MM-DD HH24:MI:SS');