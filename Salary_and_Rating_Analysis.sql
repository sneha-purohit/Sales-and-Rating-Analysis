# DATABASE CREATION 
create database projectDB;

use projectDB;

# TABLE CREATION 
create table employee_data(
role varchar(255),
country varchar(255),
company varchar(255),
company_rating float,
job_title varchar(255),
median varchar(255),
low varchar(255),
high varchar(255),
unit varchar(255),
currency varchar(255)
);

# VIEW TABLE DATA 
select count(*) from employee_data;
select * from employee_data;



# SHOW VARIABLES LIKE 'secure_file_priv'; ---- TO VIEW THE FILE LOCATION

# IF WE WANT TO LOAD DATA THROUGH MYSQL. ELSE WE CAN UPLOAD DATA USING PYTHON 
# HERE DATA IS LOADED USING PYTHON
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cleaned_salaries.csv'
INTO TABLE employee_data
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
  role,
  country,
  company,
  @company_rating,
  job_title,
  median,
  low,
  high,
  unit,
  currency
)
SET 
  company_rating = NULLIF(@company_rating, 'Not Rated');

# DATA PREVIEW
select distinct currency, country
from employee_data;

# DATA CLEANING
update employee_data set currency=('JYP')
where country= 'Japan';

update employee_data set currency=('EEK')
where country= 'Estonia';

update employee_data set currency=('GBP')
where country= 'United Kingdom';

update employee_data set currency=('ILS')
where country= 'Israel';

update employee_data set currency=('EUR')
where country in('Austria', 'Belgium', 'Finland', 'France', 'Germany',
'Greece', 'Italy', 'Luxembourg', 'Netherlands', 'Spain', 'Ireland');

update employee_data set currency=('USD')
where country in ('India', 'Jordan', 'United States');

update employee_data set currency=('VND')
where country= 'Vietnam';

update employee_data set currency=('KRW')
where country= 'South Korea';

update employee_data set currency=('PHP')
where country= 'Philippines';

update employee_data set currency=('CNY')
where country= 'China';

update employee_data set currency=('CAD')
where country= 'Canada';

update employee_data set currency=('AUD')
where country= 'Australia';

update employee_data set currency=('BRL')
where country= 'Brazil';

update employee_data set currency=('MXN')
where country= 'Mexico';

update employee_data set currency=('NZD')
where country= 'New Zealand';

# DATA PREVIEW
select * from employee_data
where country = 'China';

# DATA CLEANING
UPDATE employee_data
SET
    low = REPLACE(low, 'NÂ¥', ''),
    median = REPLACE(median, 'NÂ¥', ''),
    high = REPLACE(high, 'NÂ¥', '')
WHERE country = 'China';

UPDATE employee_data
SET
    low = REPLACE(low, 'A$', ''),
    median = REPLACE(median, 'A$', ''),
    high = REPLACE(high, 'A$', '')
WHERE country = 'Canada';

UPDATE employee_data
SET
    low = REPLACE(low, '$', ''),
    median = REPLACE(median, '$', ''),
    high = REPLACE(high, '$', '')
WHERE country IN ('Brazil', 'Australia');

UPDATE employee_data
SET
    low = REPLACE(low, 'MX$', ''),
    median = REPLACE(median, 'MX$', ''),
    high = REPLACE(high, 'MX$', '')
WHERE country = 'Mexico';

UPDATE employee_data
SET
    low = REPLACE(low, 'NZ$', ''),
    median = REPLACE(median, 'NZ$', ''),
    high = REPLACE(high, 'NZ$', '')
WHERE country = 'New Zealand';

# RENAMING OF VALUES
UPDATE employee_data SET company = ('No Company')
WHERE company LIKE '%?%';

# ROUNDING OFF THE RATING COLUMN
UPDATE employee_data
SET company_rating = ROUND(company_rating);

# CHECKING THE DATA 
select count(*) from employee_data;

# COMPANY COUNT vs COMPANY RATING 
SELECT company_rating, COUNT(*) AS company_count
FROM employee_data
GROUP BY company_rating
ORDER BY company_rating;






