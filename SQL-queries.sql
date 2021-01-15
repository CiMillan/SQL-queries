/*writing a query that displays all the data in the occurred_at, account_id, and channel columns of the web_events table, and limits the output to only the first 15 rows.*/

SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

/*Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.*/

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

/*Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/*Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

/*Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;


/*write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order)*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

/*Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.*/

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/*Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.*/

SELECT *
FROM orders
WHERE gloss_amt_usd < 500
LIMIT 10;

/*Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table.*/

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

/*Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.*/

SELECT id, 
account_id,
standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

/*Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also.*/

SELECT id, 
account_id,
poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) * 100 AS post_percent
FROM orders
LIMIT 10;

/*All the companies whose names start with 'C'.*/

SELECT name
FROM accounts
WHERE name LIKE 'C%';

/*All companies whose names contain the string 'one' somewhere in the name.*/

SELECT name
FROM accounts
WHERE name LIKE '%one%';

/*All companies whose names end with 's'.*/

SELECT name
FROM accounts
WHERE name LIKE '%s';

/*Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.*/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/*Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.*/

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/*Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.*/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

/*Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.*/

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

/*All the companies whose names do not start with 'C'.*/

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

/*All companies whose names do not contain the string 'one' somewhere in the name.*/

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

/*All companies whose names do not end with 's'.*/

SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

/*Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.*/

SELECT standard_qty, poster_qty, gloss_qty
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

/*Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.*/

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

/*When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? */

yes, the BETWEEN operator in SQL is inclusive

/*writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29.*/

SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

/*Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.*/
/*While BETWEEN is generally inclusive of endpoints, it assumes the time is at 00:00:00 (i.e. midnight) for dates. This is the reason why we set the right-side endpoint of the period at '2017-01-01'.*/

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

/*Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.*/

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000

/*Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.*/

SELECT *
FROM orders
WHERE (gloss_qty > 1000 OR poster_qty > 1000)
	AND standard_qty = 0;

/*Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.*/

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
	AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
    AND primary_poc NOT LIKE '%eana%');

/*pulling all the data from the accounts table, and all the data from the orders table.*/

SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

/*pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.*/

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM accounts
JOIN orders
ON accounts.id = orders.account_id

/*Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*/

SELECT accounts.primary_poc, web_events.occurred_at, web_events.channel
FROM web_events
JOIN accounts
ON accounts.id = web_events.account_id
WHERE accounts.name = 'Walmart';

/*Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT r.name region, s.name rep, a.name account
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY a.name;

/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.*/

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

/*Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT r.name reg, s.name rep, a.name account
FROM accounts a
JOIN sales_reps s
	ON a.sales_rep_id = s.id
JOIN region r
	ON r.id = s.region_id
    WHERE r.name = 'Midwest'
ORDER BY account;

/*Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT r.name reg, s.name rep, a.name account
FROM accounts a
JOIN sales_reps s
	ON a.sales_rep_id = s.id
JOIN region r
	ON r.id = s.region_id
    WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

/*Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT r.name reg, s.name rep, a.name account
FROM accounts a
JOIN sales_reps s
	ON a.sales_rep_id = s.id
JOIN region r
	ON r.id = s.region_id
    WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).*/

SELECT r.name reg, a.name account, (o.total_amt_usd/(o.total + 0.01))unit_price
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
JOIN sales_reps s
	ON a.sales_rep_id = s.id
JOIN region r
	ON r.id = s.region_id
    WHERE o.standard_qty > 100;

/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/

SELECT r.name reg, a.name account, (o.total_amt_usd/(o.total + 0.01))unit_price
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
JOIN sales_reps s
	ON a.sales_rep_id = s.id
JOIN region r
	ON r.id = s.region_id
    WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/

SELECT r.name reg, a.name account, (o.total_amt_usd/(o.total + 0.01))unit_price
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
JOIN sales_reps s
	ON a.sales_rep_id = s.id
JOIN region r
	ON r.id = s.region_id
    WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

/*What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.*/

SELECT DISTINCT a.name account, w.channel channel
FROM accounts a
JOIN web_events w
	ON w.account_id = a.id
    WHERE a.id = '1001';

/*Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.*/

SELECT o.occurred_at date, a.name account, o.total total, o.total_amt_usd usd
FROM orders o
JOIN accounts a
	ON a.id = o.account_id
    WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;


/********************SQL AGREGATIONS************************/


/*Find the total amount of poster_qty paper ordered in the orders table.*/

SELECT SUM(poster_qty) AS poster
FROM orders;

/*Find the total amount of standard_qty paper ordered in the orders table.*/

SELECT SUM(standard_qty) AS standard
FROM orders;

/*Find the total dollar amount of sales using the total_amt_usd in the orders table.*/

SELECT SUM(total_amt_usd) AS total
FROM orders;

/*Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.*/

SELECT (standard_amt_usd + gloss_amt_usd) AS total_standard_gloss
FROM orders;

/*Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.*/

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS unit_price_standard
FROM orders;

/*When was the earliest order ever placed? You only need to return the date.*/

SELECT MIN(occurred_at)
FROM orders;

/*Try performing the same query as in question without using an aggregation function.*/

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

/*When did the most recent (latest) web_event occur?*/

SELECT MIN(occurred_at)
FROM web_events;

/*Try to perform the result of the previous query without using an aggregation function.*/

SELECT occurred_at
FROM web_events
ORDER BY occurred_at
LIMIT 1;

/*Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.*/

SELECT 
    AVG(standard_amt_usd) AS mean_usd_standard, 
    AVG(gloss_amt_usd) AS mean_usd_gloss, 
    AVG(poster_amt_usd) AS mean_usd_poster,
    AVG(standard_qty) AS mean_qty_standard,
    AVG(gloss_qty) AS mean_qty_gloss,
    AVG(poster_qty) AS mean_qty_poster
FROM orders;

/*Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders? Note, this is more advanced than the topics we have covered thus far to build a general solution, but we can hard code a solution in the following way.*/
/*ince there are 6912 orders - we want the average of the 3457 and 3456 order amounts when ordered. This is the average of 2483.16 and 2482.55. This gives the median of 2482.855. This obviously isn't an ideal way to compute. If we obtain new orders, we would have to change the limit. SQL didn't even calculate the median for us. The above used a SUBQUERY, but you could use any method to find the two necessary values, and then you just need the average of them.*/

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

/*Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.*/

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

/*Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.*/

SELECT a.name, SUM(total_amt_usd) total_orders_usd
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_orders_usd DESC;

/*Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.*/

SELECT a.name, w.occurred_at, w.channel
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
ORDER BY occurred_at DESC
LIMIT 1;

/*Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.*/

SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel;

/*Who was the primary contact associated with the earliest web_event?*/

SELECT w.occurred_at, a.primary_poc
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

/*Who was the primary contact associated with the earliest web_event?*/

SELECT w.occurred_at, a.primary_poc
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

/*What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.*/

SELECT a.name, MIN(o.total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

/*Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.*/

SELECT r.name, COUNT(s) reps
FROM sales_reps s
JOIN region r
	ON r.id = s.region_id
GROUP BY r.name
ORDER BY reps;

/*For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.*/

SELECT 
	a.name,
    AVG(o.standard_qty) avg_stand,
    AVG(o.gloss_qty) avg_gloss,
    AVG(o.poster_qty) avg_post
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
ORDER BY a.name;

/*For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.*/

SELECT 
	a.name,
    AVG(o.standard_amt_usd) avg_usd_stand,
    AVG(o.gloss_amt_usd) avg_usd_gloss,
    AVG(o.poster_amt_usd) avg_usd_post
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
ORDER BY a.name;

/*Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.*/

SELECT s.name, w.channel, COUNT(*) num_events
FROM sales_reps s
JOIN accounts a
	ON s.id = a.sales_rep_id
JOIN web_events w
	ON w.account_id = a.id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

/*Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.*/

SELECT r.name, w.channel, COUNT(*) num_events
FROM region r
JOIN sales_reps s
	ON r.id = s.region_id
JOIN accounts a
	ON s.id = a.sales_rep_id
JOIN web_events w
	ON w.account_id = a.id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

/*Use DISTINCT to test if there are any accounts associated with more than one region.*/
/*The below two queries have the same number of resulting rows (351), so we know that every account is associated with only one region. If each account was associated with more than one region, the first query should have returned more rows than the second query.*/

SELECT
	r.name AS region,
    a.name AS account,
    r.id AS region_id,
    a.id AS account_id
FROM accounts a
JOIN sales_reps s
	ON s.id = a.sales_rep_id
JOIN region r
	ON s.region_id = r.id

SELECT DISTINCT id, name
FROM accounts;

/*Have any sales reps worked on more than one account?*/
/*Actually all of the sales reps have worked on more than one account. The fewest number of accounts any sales rep works on is 3. There are 50 sales reps, and they all have more than one account. Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query.*/

SELECT s.name rep_name, s.id rep_id, COUNT(*) num_accounts
FROM sales_reps s
JOIN accounts a
	ON a.sales_rep_id = s.id
GROUP BY rep_name, rep_id
ORDER BY num_accounts DESC;

SELECT DISTINCT id, name
FROM sales_reps;

/*How many of the sales reps have more than 5 accounts that they manage?*/

SELECT s.name, COUNT(*) num_accounts
FROM sales_reps s
JOIN accounts a
	ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

/*How many accounts have more than 20 orders?*/

SELECT a.name, COUNT(*) num_orders
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
GROUP BY a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

/*Which account has the most orders?*/

SELECT a.name, COUNT(*) num_orders
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
GROUP BY a.name
ORDER BY num_orders DESC
LIMIT 1;

/*Which accounts spent more than 30,000 usd total across all orders?*/

SELECT a.name, SUM(O.total_amt_usd) total_spent
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(total_amt_usd) > '30000'
ORDER BY total_spent DESC;

/*Which accounts spent less than 1,000 usd total across all orders?*/

SELECT a.name, SUM(O.total_amt_usd) total_spent
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(total_amt_usd) < '1000'
ORDER BY total_spent;

/*Which account has spent the most with us?*/

SELECT a.name, SUM(O.total_amt_usd) total_spent
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_spent DESC
LIMIT 1;

/*Which account has spent the least with us?*/

SELECT a.name, SUM(O.total_amt_usd) total_spent
FROM orders o
JOIN accounts a
	ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_spent
LIMIT 1;

/*Which accounts used facebook as a channel to contact customers more than 6 times?*/

SELECT a.name, w.channel, COUNT(*) events_num
FROM web_events w
JOIN accounts a
	ON w.account_id = a.id
GROUP BY a.name, w.channel
HAVING w.channel = 'facebook' AND COUNT(*) > 6
ORDER BY events_num;

/*Which account used facebook most as a channel?*/

SELECT a.name, w.channel, COUNT(*) events_num
FROM web_events w
JOIN accounts a
	ON w.account_id = a.id
WHERE w.channel = 'facebook'
GROUP BY a.name, w.channel
ORDER BY events_num DESC
LIMIT 1;

/*Which channel was most frequently used by most accounts?*/

SELECT a.name, w.channel, COUNT(*) events_num
FROM web_events w
JOIN accounts a
	ON w.account_id = a.id
GROUP BY a.name, w.channel
ORDER BY events_num DESC;







































