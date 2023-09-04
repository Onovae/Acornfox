--SQL QUERY and ANALYSIS USING DATA FROM PARCH & POSEY (not a real company) DATABASE. 

--Parch & Posey is a Company that sells paper and the database includes sales data for their paper. They have 50 sales reps spread accross the United States in four regions- Northwest, Southwest, West, & the Midwest. They sell three types of papers, -the regular(standard), Poster & Glossym papers.Their clients are primarily largeFortune 100 companies whom they attract by advertising on Google, Facebook and Twitter.
--Using SQL lets help PARCH & POSEY answer some tricky questions that can help enhance performance and make decisions on channels they should make the greater investments on to improve productivity and business growth.
---you can find link to dataset here https://video.udacity-data.com/topher/2020/May/5eb5533b_parch-and-posey/parch-and-posey.sql

--First lets query the database

SELECT * 
FROM orders;-- this returns all the colums in the orders table

SELECT id, account_id, occurred_at
FROM orders;-- this returns some column as selected above from the orders table.

-- Using the LIMIT Clause---

SELECT *
FROM web_events
LIMIT 100000;-- this returns the first 100000 rows of data from the web_events table'

--Lets write a query that displays all the data in the occurred_at, account_id, and channel columns of the web_events table, and limits the output to only the first 15 rows.

SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

--Using the ORDER BY Clause

SELECT *
FROM orders
ORDER BY occurred_at
LIMIT 1000;--This query would display 1000 orders sorted by occurred_at.

--Let's get some more practice using ORDER BY:
--Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

--Write a query to return the top 5 orders in terms of the largest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC -- the DESC added to the ORDER BY close returns the value in descending order. this shows the top or highest value as the ORDER BY clause will normally return valuesin an ascending order. 
LIMIT 5;

--Write a query to return the lowest 20 orders in terms of the smallest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

--ORDER BY more than one column at a time

SELECT  account_id,
        total_amt_usd
FROM orders
ORDER By total_amt_usd DESC, account_id;--This query selected account_id and total_amt_usd from the orders table, and orders the results first by total_amt_usd in descending order and then account_id

--Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

-- write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

--Compare the results of these two queries above. How are the results different when you switch the column you sort on first?
--In query #1, all of the orders for each account ID are grouped together, and then within each of those groupings, the orders appear from the greatest order amount to the least. In query #2, since you sorted by the total dollar amount first, the orders appear from greatest to least regardless of which account ID they were from. Then they are sorted by account ID next. (The secondary sorting by account ID is difficult to see here since only if there were two orders with equal total dollar amounts would there need to be any sorting by account ID.)

--Filtering with the WHERE Clause-----
--Using the WHERE statement, we can display subsets of tables based on conditions that must be met
       
	   --Using the WHERE with Numeric Data:

SELECT *
FROM orders
WHERE account_id = 4251
ORDER BY occurred_at
LIMIT 1000;-- this returns the first 1000 transactions carried out by the account_id 4251 and the time it occurred.

--Write a query that:
--Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

--Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;


--WHERE with Non-Numeric Data:

SELECT *
FROM accounts
WHERE name = 'United Technologies';--this returns all data from the account with the name United Technologies.

SELECT *
FROM accounts
WHERE name != 'United Technologies';--this returns all data from the account with names not equal United Technologies.

--Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

--working with Arithmetic Operators: Derived Columns using the Alias AS keyword:

SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
FROM orders
LIMIT 10;--Here we divide the standard paper dollar amount by the total order amount to find the standard paper percent for the order, and use the AS keyword to name this new column "std_percent.

SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty + poster_qty AS nonstandard_qty
FROM orders;

--Using the orders table:
--Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;


--Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also

SELECT id, account_id, 
poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

--Note: that you could multiply the value in Question above by 100 as below:

SELECT id, account_id, 
poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd)*100 AS post_per
FROM orders
LIMIT 10;-- this is because we could receive an error with the first solution to this question. This occurs because at least one of the values in the data could create a division by zero in our formula, to avoid dividing by zero we could multiply all by 100.

-- Using Logical Operators:
--LIKE

SELECT *
FROM accounts
WHERE website LIKE '%google%';--returns all values from the account table found in the google website.

--From the accounts table to find

--All the companies whose names start with 'C'.

SELECT name
FROM accounts
WHERE name LIKE 'C%';

--All companies whose names contain the string 'one' somewhere in the name.
SELECT name
FROM accounts
WHERE name LIKE '%one%';

--All companies whose names end with 's'.

SELECT name
FROM accounts
WHERE name LIKE '%s';

---Using the IN operator

SELECT *
FROM orders
WHERE account_id IN (1001,1021);--returns all values from the orders table in the id 1001 and 1021

--Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

--Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

--The NOT operator

SELECT sales_rep_id, 
       name
FROM accounts
WHERE sales_rep_id NOT IN (321500,321570)
ORDER BY sales_rep_id;

SELECT *
FROM accounts
WHERE website NOT LIKE '%com%';

--All the companies whose names do not start with 'C'.

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

--All companies whose names do not contain the string 'one' somewhere in the name.

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

--All companies whose names do not end with 's'.

SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

----Use the accounts table to find the account name, primary_poc, and sales_rep_id for account names not in  Walmart, Target, and Nordstrom.

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');


----Using the AND and BETWEEN operators----- Instead of writing :WHERE column >= 6 AND column <= 10,we can write, equivalently: WHERE column BETWEEN 6 AND 10
--for instance 
SELECT *
FROM orders
WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01'
ORDER BY occurred_at;  --instead of this we can write


SELECT *
FROM orders
WHERE occurred_at BETWEEN '2016-04-01' AND '2016-10-01'
ORDER BY occurred_at;


--Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;


--Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

--Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

--The OR operator

SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty
FROM orders
WHERE standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0;----Similar to the AND operator, the OR operator can combine multiple statements


SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty
FROM orders
WHERE (standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0)
AND occurred_at = '2016-10-01';

--Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

--Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

--Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
           AND primary_poc NOT LIKE '%eana%');
		   
		   
------Wrting JOINs statements-

   --Lets start with INNER JOINs---
--Lets write a code to join the orders table and the accounts table in the Parch $ Porsey database

SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;--this will pull all the data from only the orders tables.

--we can pick some specific column to JOIN

SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;--This query only pulls two columns, not all the information in these two tables.

SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;---this will pull all the data from both tables.

--Lets Try pulling all the data from the accounts table, and all the data from the orders table.

SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

--Lets try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.

SELECT orders.standard_qty, orders.gloss_qty, 
 orders.poster_qty,  accounts.website, 
 accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;--this can be rewritten to give same result using the Alias AS as will be shown below
		   
		--JOINing three tables---
SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id;


--Using Aliases

SELECT o.*, a.*
FROM orders o
JOIN accounts a
ON o.account_id = a.id;

--rewriting the last three codes using Alias AS

SELECT o.standard_qty, o.gloss_qty, 
 o.poster_qty,  a.website, 
 a.primary_poc
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id;----this can also be written as seen below

SELECT o.standard_qty, o.gloss_qty, 
 o.poster_qty,  a.website, 
 a.primary_poc
FROM orders o
JOIN accounts  a
ON o.account_id = a.id;---omitting the AS and just adding a space will give same result


--Provide a table for all web_events associated with the account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

--Provide a table that provides the region for each sales_rep along with their associated accounts. Our final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 0ur final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

SELECT r.name region, a.name account, 
    o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

--Using the LEFT JOIN

SELECT a.id, a.name, o.total
FROM orders o
LEFT JOIN accounts a
ON o.account_id = a.id;

---Using the RIGHT JOIN

SELECT a.id, a.name, o.total
FROM orders o
RIGHT JOIN accounts a
ON o.account_id = a.id;

--JOINs and Filtering

SELECT orders.*, accounts.*
FROM orders
LEFT JOIN accounts
ON orders.account_id = accounts.id 
WHERE accounts.sales_rep_id = 321500;

--or we can say

SELECT orders.*, accounts.*
FROM orders
LEFT JOIN accounts
ON orders.account_id = accounts.id 
AND accounts.sales_rep_id = 321500;

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. our final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name region,s.name sales_rep, a.name acct
FROM accounts a
JOIN sales_reps s 
ON a.sales_rep_id= s.id
JOIN region r
ON s.region_id = r.id
WHERE r.name='Midwest'
ORDER BY a.name;



--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. our final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name region,s.name sales_rep, a.name acct
FROM accounts a
JOIN sales_reps s 
ON a.sales_rep_id= s.id
JOIN region r
ON s.region_id = r.id
WHERE s.name = 'S%' AND  r.name='Midwest'
ORDER BY a.name;


--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. our final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name region,s.name sales_rep, a.name acct
FROM accounts a
JOIN sales_reps s 
ON a.sales_rep_id= s.id
JOIN region r
ON s.region_id = r.id
WHERE s.name = 'K%' AND  r.name='Midwest'
ORDER BY a.name;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. we should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. we should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. we should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;


--What are the different channels used by account id 1001? our final table should have only 2 columns: account name and the different channels. we can try SELECT DISTINCT to narrow down the results to only the unique values.

SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';


--Find all the orders that occurred in 2015. our final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

---NULLs and Aggregation

SELECT *
FROM accounts
WHERE primary_poc = NULL;--this returns zero values to show that there are no NULLs in the column -primary_poc


SELECT *
FROM accounts
WHERE primary_poc IS NOT NULL;--this confirms the earlier code where there are no NULLs

--First Aggregation - COUNT

SELECT COUNT(*)
FROM accounts;--this returns the count of all rows in the accounts table

--or we could have just as easily chosen a column to drop into the aggregation function:

SELECT COUNT(accounts.id)
FROM accounts;

SELECT COUNT(*)
FROM orders
WHERE occurred_at >= '2016-12-01'
AND occurred_at < '2017-01-01';

--or we can add an Alias

SELECT COUNT(*) AS order_count
FROM orders
WHERE occurred_at >= '2016-12-01'
AND occurred_at < '2017-01-01';

--Using COUNT & NULLs
--COUNT does not consider rows that have NULL values. 

SELECT COUNT(*)
FROM accounts
WHERE primary_poc IS NULL;--No NULL values

SELECT COUNT(*)
FROM accounts
WHERE primary_poc IS NOT NULL;

--Using the SUM aggregate

SELECT SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders;

---Find the total amount of poster_qty paper ordered in the orders table.

SELECT SUM(poster_qty) AS total_poster_sales
FROM orders;

--Find the total amount of standard_qty paper ordered in the orders table.

SELECT SUM(standard_qty) AS total_standard_sales
FROM orders;

--Find the total dollar amount of sales using the total_amt_usd in the orders table.

SELECT SUM(total_amt_usd) AS total_dollar_sales
FROM orders;

--Find the total amount for each individual order that was spent on standard and gloss paper in the orders table. This should give a dollar amount for each order in the table, hence the solution did not use an aggregate

SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

--Find the standard_amt_usd per unit of standard_qty paper. our solution should use both aggregation and a mathematical operator.

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;--Though the price/standard_qty paper varies from one order to the next. I would like this ratio across all of the sales made in the orders table.Notice, this solution used both an aggregate and our mathematical operators

--Using MIN & MAX

SELECT MIN(standard_qty) AS standard_min,
       MIN(gloss_qty) AS gloss_min,
       MIN(poster_qty) AS poster_min,
       MAX(standard_qty) AS standard_max,
       MAX(gloss_qty) AS gloss_max,
       MAX(poster_qty) AS poster_max
FROM   orders;-- shows the MIN and MAX qty ordered from the three papers. shows that the higest qty ordered was from the standard paper. this could inform the managers decition to produce more of the standard paper all things been equal'

--Using the AVG

SELECT AVG(standard_qty) AS standard_avg,
       AVG(gloss_qty) AS gloss_avg,
       AVG(poster_qty) AS poster_avg
FROM orders;

--When was the earliest order ever placed? You only need to return the date.

SELECT MIN(occurred_at) 
FROM orders;

--Lets Try performing the same query as in question 1 without using an aggregation function.

SELECT occurred_at 
FROM orders 
ORDER BY occurred_at
LIMIT 1;

--When did the most recent (latest) web_event occur?

SELECT MAX(occurred_at)
FROM web_events;

--Try to perform the result of the previous query without using an aggregation function.

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;


--Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. our final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
        AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
        AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM  orders;

--we might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?

SELECT *
FROM (SELECT total_amt_usd
   FROM orders
   ORDER BY total_amt_usd
   LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;---Since there are 6912 orders - we want the average of the 3457 and 3456 order amounts when ordered. This is the average of 2483.16 and 2482.55. This gives the median of 2482.855. This obviously isn't an ideal way to compute. If we obtain new orders, we would have to change the limit. SQL didn't even calculate the median for us. The above used a SUBQUERY, but you could use any method to find the two necessary values, and then you just need the average of them.

--Using the GROUP BY Clause

SELECT account_id,
       SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders
GROUP BY account_id
ORDER BY account_id;
--Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

--Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;

--Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;

--Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel;

--Who was the primary contact associated with the earliest web_event?

SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

--What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;--Sort of strange we have a bunch of orders with no dollars. We might want to look into that

--Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from the fewest reps to most reps.

SELECT r.name region_name, COUNT(s.name) sales_rep_count
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
GROUP BY r.name
ORDER BY sales_rep_count;

--We can GROUP BY multiple columns at once,

SELECT account_id,
       channel,
       COUNT(id) as events
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id, channel;

SELECT account_id,
       channel,
       COUNT(id) as events
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id, channel DESC;

SELECT account_id,
       channel,
       COUNT(id) as events
FROM web_events
WHERE channel  LIKE 'direct%'
GROUP BY account_id, channel
ORDER BY account_id, events;


--For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

SELECT a.name, AVG(o.standard_qty) avg_stand, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

--For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT a.name, AVG(o.standard_amt_usd) avg_stand, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

--Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

--Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

--Using the DISTINCT

SELECT DISTINCT account_id,
       channel
FROM web_events
ORDER BY account_id;--this returns the unique rows for all columns written in the SELECT statement.

--Use DISTINCT to test if there are any accounts associated with more than one region.

SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;--First we use this query see if any account if associated with more than one region

--then we use the DISTINCT clause for confirmation

SELECT DISTINCT id, name
FROM accounts;--the two queries above have the same number of resulting rows (351), so we know that every account is associated with only one region. If each account was associated with more than one region, the first query should have returned more rows than the second query.

--Have any sales reps worked on more than one account?

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

SELECT DISTINCT id, name
FROM sales_reps;--Actually, all of the sales reps have worked on more than one account. The fewest number of accounts any sales rep works on is 3. There are 50 sales reps, and they all have more than one account. Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query.

--Using the HAVING Clause. HAVING is the “clean” way to filter a query that has been aggregated insteasd of using the WHERE clause

SELECT account_id,
       SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
GROUP BY 1
HAVING SUM(total_amt_usd) >= 250000;

--How many of the sales reps have more than 5 accounts that they manage?

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;--and technically, we can get this using a SUBQUERY as shown below. This same logic can be used for the other queries, but this will not be shown.

SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts) AS Table1;

--How many accounts have more than 20 orders?

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

--Which account has the most orders?

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

--Which accounts spent more than 30,000 usd total across all orders?

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;


--Which accounts spent less than 1,000 usd total across all orders?

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;

--Which account has spent the most with us?

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

--Which account has spent the least with us?

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

--Which accounts used facebook as a channel to contact customers more than 6 times?

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;


--Which account used facebook most as a channel?

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;--Note: This query above only works if there are no ties for the account that used facebook the most. It is a best practice to use a larger limit number first such as 3 or 5 to see if there are ties before using LIMIT 1


--Which channel was most frequently used by most accounts?

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;--All of the top 10 are direct.

--Using the DATE Functions
--DATE_TRUNC allows you to truncate your date to a particular part of your date-time column.
--DATE_PART can be useful for pulling a specific portion of a date, but notice pulling month or day of the week (dow) means that you are no longer keeping the years in order.

SELECT DATE_PART('dow',occurred_at) AS day_of_week,
       account_id,
       occurred_at,
       total
FROM orders;



SELECT DATE_PART('dow',occurred_at) AS day_of_week,
       SUM(total) AS total_qty
FROM orders
GROUP BY 1;

--Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?

SELECT DATE_PART('year', occurred_at) ord_year,  SUM(total_amt_usd) total_spent
 FROM orders
 GROUP BY 1
 ORDER BY 2 DESC;--When we look at the yearly totals, you might notice that 2013 and 2017 have much smaller totals than all other years. If we look further at the monthly data, we see that for 2013 and 2017 there is only one month of sales for each of these years (12 for 2013 and 1 for 2017). Therefore, neither of these is evenly represented. Sales have been increasing year over year, with 2016 being the largest sales to date. At this rate, we might expect 2017 to have the largest sales.

---Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
      --In order for this to be 'fair', we should remove the sales from 2013 and 2017. For the same reasons as discussed above.

SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;--The greatest sales amounts occur in December (12).

---Which year did Parch & Posey have the greatest sales in terms of the total number of orders? Are all years evenly represented by the dataset?

SELECT DATE_PART('year', occurred_at) ord_year,  COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;--Again, 2016 by far has the most amount of orders, but again 2013 and 2017 are not evenly represented to the other years in the dataset.


---Which month did Parch & Posey have the greatest sales in terms of the total number of orders? Are all months evenly represented by the dataset?
--December still has the most sales, but interestingly, November has the second most sales (but not the most dollar sales. To make a fair comparison from one month to another 2017 and 2013 data were removed.


--In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o 
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--The CASE Statements

SELECT id,
       account_id,
       occurred_at,
       channel,
       CASE WHEN channel = 'facebook' THEN 'yes' END AS is_facebook
FROM web_events
ORDER BY occurred_at;


SELECT id,
       account_id,
       occurred_at,
       channel,
       CASE WHEN channel = 'facebook' THEN 'yes' ELSE 'no' END AS is_facebook
FROM web_events
ORDER BY occurred_at;


SELECT id,
       account_id,
       occurred_at,
       channel,
       CASE WHEN channel = 'facebook' OR channel = 'direct' THEN 'yes' 
       ELSE 'no' END AS is_facebook
FROM web_events
ORDER BY occurred_at;


SELECT account_id,
       occurred_at,
       total,
       CASE WHEN total > 500 THEN 'Over 500'
            WHEN total > 300 THEN '301 - 500'
            WHEN total > 100 THEN '101 - 300'
            ELSE '100 or under' END AS total_group
FROM orders;


SELECT account_id,
       occurred_at,
       total,
       CASE WHEN total > 500 THEN 'Over 500'
            WHEN total > 300 AND total <= 500 THEN '301 - 500'
            WHEN total > 100 AND total <=300 THEN '101 - 300'
            ELSE '100 or under' END AS total_group
FROM orders;


--CASE & Aggregations

SELECT CASE WHEN total > 500 THEN 'OVer 500'
            ELSE '500 or under' END AS total_group,
            COUNT(*) AS order_count
FROM orders
GROUP BY 1;



--Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.

SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;


--We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top-level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.

SELECT a.name, SUM(total_amt_usd) total_spent, 
  CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
  WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
  ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY 2 DESC;


--We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.

SELECT a.name, SUM(total_amt_usd) total_spent, 
  CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
  WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
  ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31' 
GROUP BY 1
ORDER BY 2 DESC;


---Using Subqueries:-----
--Lets Find the number of events that occur for each day for each channel.

SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
         FROM web_events 
         GROUP BY 1,2) sub
GROUP BY channel;


--Nested Subqueries

SELECT *
FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
 (SELECT DATE_TRUNC('month',MIN(occurred_at)) AS min_month
  FROM orders)
ORDER BY occurred_at;


---------DATA CLEANING WITH SQL----------


--Using the CONCAT, LEFT, RIGHT, and SUBSTR


---Suppose the company wants to assess the performance of all the sales representatives. Each sales representative is assigned to work in a particular region. To make it easier to understand for the HR team, display the concatenated sales_reps.id, ‘_’ (underscore), and region.name as EMP_ID_REGION for each sales representative.

SELECT CONCAT(SALES_REPS.ID, '_', REGION.NAME) EMP_ID_REGION, SALES_REPS.NAME
FROM SALES_REPS
JOIN REGION
ON SALES_REPS.REGION_ID = REGION_ID;



--From the accounts table, display the name of the client, the coordinate as concatenated (latitude, longitude), email id of the primary point of contact as <first letter of the primary_poc><last letter of the primary_poc>@<extracted name and domain from the website>.

SELECT NAME, CONCAT(LAT, ', ', LONG) COORDINATE, CONCAT(LEFT(PRIMARY_POC, 1), RIGHT(PRIMARY_POC, 1), '@', SUBSTR(WEBSITE, 5)) EMAIL
FROM ACCOUNTS;



--From the web_events table, display the concatenated value of account_id, '_' , channel, '_', count of web events of the particular channel.

WITH T1 AS (
 SELECT ACCOUNT_ID, CHANNEL, COUNT(*) 
 FROM WEB_EVENTS
 GROUP BY ACCOUNT_ID, CHANNEL
 ORDER BY ACCOUNT_ID
)
SELECT CONCAT(T1.ACCOUNT_ID, '_', T1.CHANNEL, '_', COUNT)
FROM T1;

---Advanced cleaning functions-----

----POSITION & STRPOS---

---Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.

SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, 
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;


---Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name column

SELECT LEFT(name, STRPOS(name, ' ') -1 ) first_name, 
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;

---Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;

---You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise, your solution should be just as in question 1. Some helpful documentation is here.

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ', ''), '.com')
FROM  t1;


---We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.


WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;



------SQL Window Functions-----
------Creating a Running Total Using Window Functions----

---Create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.

SELECT standard_amt_usd,
       SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders;


-----Creating a Partitioned Running Total Using Window Functions---

---Now, lets modify your query from the previous quiz to include partitions. Still create a running total of standard_amt_usd (in the orders table) over order time, but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable.
----our final table should have three columns:One with the amount being added for each row, One for the truncated date, and final column with the running total within each year.

SELECT standard_amt_usd,
       DATE_TRUNC('year', occurred_at) as year,
       SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders;

