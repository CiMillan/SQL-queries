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

/*Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?*/
/*When we look at the yearly totals, you might notice that 2013 and 2017 have much smaller totals than all other years. If we look further at the monthly data, we see that for 2013 and 2017 there is only one month of sales for each of these years (12 for 2013 and 1 for 2017). Therefore, neither of these are evenly represented. Sales have been increasing year over year, with 2016 being the largest sales to date. At this rate, we might expect 2017 to have the largest sales.*/

SELECT 
	DATE_PART('year', occurred_at) AS year,
    SUM(total_amt_usd) total_spent
FROM orders
GROUP BY DATE_PART('year', occurred_at)
ORDER BY total_spent DESC;

/*Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?*/
/*In order for this to be 'fair', we should remove the sales from 2013 and 2017. For the same reasons as discussed above.*/

SELECT 
	DATE_PART('month', occurred_at) AS month,
    SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY DATE_PART('month', occurred_at)
ORDER BY total_spent DESC;

/*Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?*/
/*Again, 2016 by far has the most amount of orders, but again 2013 and 2017 are not evenly represented to the other years in the dataset.*/

SELECT 
	DATE_PART('year', occurred_at) AS year,
    COUNT (*) total_orders
FROM orders
GROUP BY DATE_PART('year', occurred_at)
ORDER BY total_orders DESC;

/*Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?*/
/*December still has the most sales, but interestingly, November has the second most sales (but not the most dollar sales. To make a fair comparison from one month to another 2017 and 2013 data were removed.*/

SELECT 
	DATE_PART('month', occurred_at) AS month,
    COUNT (*) total_orders
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY DATE_PART('month', occurred_at)
ORDER BY total_orders DESC;

/*In which month of which year did Walmart spend the most on gloss paper in terms of dollars?*/

SELECT 
	DATE_TRUNC('month', occurred_at) AS month,
    SUM(o.gloss_amt_usd) AS gloss_total
FROM orders o
JOIN accounts a
	ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY DATE_TRUNC('month', occurred_at)
ORDER BY gloss_total DESC
LIMIT 1;

/*Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.*/

SELECT account_id, total_amt_usd,
    CASE WHEN total_amt_usd >= 3000 THEN 'Large'
    ELSE 'Small' END order_level
FROM orders;

/*Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.*/

SELECT
    CASE WHEN total < 1000 THEN 'Less than 1000'
    WHEN total > 2000 then 'At Least 2000'
    ELSE 'Between 1000 and 2000' END order_total,
    COUNT(*) AS order_count
FROM orders
GROUP BY 1
ORDER BY order_count DESC;

/*We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.*/

SELECT
	a.name, SUM(total_amt_usd) AS total_orders,
    CASE WHEN SUM(total_amt_usd) > 200000 then 'top'
    WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
    ELSE 'low' END AS level
FROM orders o
JOIN accounts a
	ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC;

/*We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.*/

SELECT
	a.name, SUM(total_amt_usd) AS total_orders,
    CASE WHEN SUM(total_amt_usd) > 200000 then 'top'
    WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
    ELSE 'low' END AS level
FROM orders o
JOIN accounts a
	ON a.id = o.account_id
WHERE occurred_at BETWEEN '2015-12-31' AND '2018-01-01'
GROUP BY 1
ORDER BY 2 DESC;

/*We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.*/

SELECT
	s.name, COUNT (o.total) AS order_total,
	CASE WHEN COUNT (o.total) > 200 THEN 'top'
    ELSE 'not' END
FROM sales_reps s
JOIN accounts a
	ON s.id = a.sales_rep_id
JOIN orders o
	ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC;

/*The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!*/

SELECT
	s.name, 
    COUNT (o.total) AS order_total,
    SUM(o.total_amt_usd) AS total_sales,
	CASE WHEN COUNT (o.total) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
    WHEN COUNT (o.total) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
    ELSE 'low' END AS level
FROM sales_reps s
JOIN accounts a
	ON s.id = a.sales_rep_id
JOIN orders o
	ON a.id = o.account_id
GROUP BY 1
ORDER BY 3 DESC;


/************************SUBQUERIES**********************/


/*We want to find the average number of events for each day for each channel. The first table will provide us the number of events for each day and channel, and then we will need to average these values together using a second query.*/

SELECT channel, AVG(events) AS avg_events
FROM
	(SELECT
		DATE_TRUNC('day', occurred_at) AS day,
		channel,
		COUNT(*) AS events
	FROM web_events
	GROUP BY 1, 2) sub
GROUP BY 1
ORDER BY 2 DESC;

/*pull the first month/year combo from the orders table. And then pull the average for each type of paper in this month/year*/

SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
     (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

/*and the total amount in sales in the same month/year*/

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

/*Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/

WITH t1 AS (
	SELECT r.name AS region, s.name AS rep, SUM(o.total_amt_usd) AS total_sales
	FROM region r
	JOIN sales_reps s
		ON s.region_id = r.id
	JOIN accounts a
		ON a.sales_rep_id = s.id
	JOIN orders o
		ON a.id = o.account_id
	GROUP BY 1, 2),

    t2 AS (
	SELECT region AS region, MAX(total_sales) AS total_sales
	FROM t1  
	GROUP BY 1
	ORDER BY 2 DESC),

	t3 AS (
	SELECT r.name AS region, s.name AS rep, SUM(o.total_amt_usd) AS total_sales
	FROM region r
	JOIN sales_reps s
		ON s.region_id = r.id
	JOIN accounts a
		ON a.sales_rep_id = s.id
	JOIN orders o
		ON a.id = o.account_id
	GROUP BY 1, 2)

SELECT *
FROM t2
JOIN t3
ON t3.region = t2.region AND t3.total_sales = t2.total_sales
ORDER BY t3.total_sales DESC;

/*For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?*/

SELECT r.name, COUNT(*) AS order_count, SUM(total_amt_usd)
  FROM region r
  JOIN sales_reps s
      ON r.id = s.region_id
  JOIN accounts a
      ON a.sales_rep_id = s.id
  JOIN orders o 
      ON a.id = o.account_id
  GROUP BY 1
  ORDER BY 3 DESC
  LIMIT 1;

/*How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?*/

WITH t1 AS (
	SELECT a.name AS account, SUM(o.standard_qty) AS total_std, SUM(o.total) AS total_orders
	FROM accounts a
	JOIN orders o
	ON o.account_id = a.id
	GROUP BY 1
	ORDER BY 2 DESC),

    t2 AS (SELECT a.name AS account, SUM(o.total) AS total_orders
	FROM accounts a
	JOIN orders o 
		ON o.account_id = a.id
	GROUP BY 1
	HAVING SUM(o.total) > 
		(SELECT MAX(total_std) AS max_std
		FROM t1)
	ORDER BY 2 DESC)

SELECT COUNT(*)
FROM t2;

/*For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?*/

WITH t1 AS (
	SELECT a.name account, SUM(total_amt_usd) total_usd
	FROM orders o
	JOIN accounts a
		ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1),

	t2 AS (
	SELECT a.name account, w.channel, COUNT(*) events
	FROM accounts a
	JOIN web_events w
		ON a.id = w.account_id
	GROUP BY 1, 2)

SELECT t2.account account_name, channel, events
FROM t2
JOIN t1
ON t1.account = t2.account
ORDER BY 3 DESC;

/*What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?*/

WITH t1 AS (
	SELECT a.name account, SUM(total_amt_usd) total_orders
	FROM orders o 
	JOIN accounts a
		ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10)

SELECT AVG(total_orders)
FROM t1;

/*What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.*/

WITH t1 AS (
   SELECT AVG(o.total_amt_usd) avg_all
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id),

	t2 AS (
   SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
   FROM orders o
   GROUP BY 1
   HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))

SELECT AVG(avg_amt)
FROM t2;


/**************************************DATA CLEANING *******************************************/

/*In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table.*/

SELECT RIGHT(website, 3) AS domain, COUNT(*) AS total
FROM accounts
GROUP BY 1
ORDER BY 2;

/*There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).*/

SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*) AS total
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/*Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?*/

WITH t1 AS (
	SELECT CASE WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 0 ELSE 1 END AS num,
    CASE WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 1 ELSE 0 END AS letter
  	FROM accounts) 

SELECT SUM(num) AS total_num, SUM(letter) AS total_letter
FROM t1;

/*Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?*/

WITH t1 AS (
	SELECT CASE WHEN LEFT(UPPER(name), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 0 ELSE 1 END AS other,
    CASE WHEN LEFT(UPPER(name), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 1 ELSE 0 END AS vowel
  	FROM accounts) 

SELECT SUM(other) AS total_other, SUM(vowel) AS total_vowel
FROM t1;

/*Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.*/

SELECT primary_poc, 
	POSITION(' ' IN primary_poc) AS space_position,
    LEFT(primary_poc, POSITION(' ' IN primary_poc) - 1) AS first_name,
    RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) AS last_name
FROM accounts;

/*Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.*/

SELECT name,
	POSITION(' ' IN name) AS space_position,
    LEFT(name, POSITION(' ' IN name) - 1) AS first_name,
    RIGHT(name, LENGTH(name) - POSITION(' ' IN name)) AS last_name
FROM sales_reps;

/*Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.*/

WITH t1 AS (
	SELECT name, primary_poc,
	POSITION(' ' IN primary_poc) as space_position,
    LEFT(primary_poc, POSITION(' ' IN primary_poc) - 1) AS first_name,
    RIGHT(primary_poc, LENGTH(primary_poc) -POSITION(' ' IN primary_poc)) AS last_name
FROM accounts)
          
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com') AS email
FROM t1;

/*You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, and put every letter lowercase.*/

WITH t1 AS (
	SELECT name, primary_poc,
	POSITION(' ' IN primary_poc) as space_position,
    LEFT(primary_poc, POSITION(' ' IN primary_poc) - 1) AS first_name,
    RIGHT(primary_poc, LENGTH(primary_poc) -POSITION(' ' IN primary_poc)) AS last_name
FROM accounts)
          
SELECT first_name, last_name, CONCAT(LOWER(first_name), '.', LOWER(last_name), '@', REPLACE(LOWER(name), ' ', ''), '.com') AS email
FROM t1;

/*We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.*/

WITH t1 AS (
	SELECT name, primary_poc,
	POSITION(' ' IN primary_poc) as space_position,
    LEFT(primary_poc, POSITION(' ' IN primary_poc) - 1) AS first_name,
    RIGHT(primary_poc, LENGTH(primary_poc) -POSITION(' ' IN primary_poc)) AS last_name
FROM accounts)
          
SELECT first_name, last_name, CONCAT(LOWER(first_name), '.', LOWER(last_name), '@', REPLACE(LOWER(name), ' ', ''), '.com') AS email,
CONCAT(LOWER(LEFT(first_name, 1)) || LOWER(RIGHT(first_name, 1)) || LOWER(LEFT(last_name, 1)) || LOWER(RIGHT(last_name, 1)) || LENGTH(first_name) || LENGTH(last_name) || UPPER(REPLACE(name, ' ', ''))) AS password
FROM t1;

/*Put the date in the correct format*/

SELECT date orig_date, 
(SUBSTR(date, 7, 4) || '-' || SUBSTR(date, 1, 2) || '-' || SUBSTR(date, 4, 2))::date new_date
FROM sf_crime_data
LIMIT 10;

/*Run the query entered below in the SQL workspace to notice the row with missing data.*/

SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL; 

/*Use COALESCE to fill in the accounts.id column with the account.id for the NULL value for the table in 1.*/

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*Use COALESCE to fill in the orders.account_id column with the account.id for the NULL value for the table in 1.*/

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*Use COALESCE to fill in each of the qty and usd columns with 0 for the table in 1.*/

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*Run the query in 1 with the WHERE removed and COUNT the number of ids.*/

SELECT COUNT(*)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

/*Run the query in 5, but with the COALESCE function used in questions 2 through 4.*/

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;


/*******************************************************WINDOW FUNCTIONS***************************************/

/*create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.*/

SELECT standard_amt_usd,
SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders;

/*Now, modify your query from the previous quiz to include partitions. Still create a running total of standard_amt_usd (in the orders table) over order time, but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. Your final table should have three columns: One with the amount being added for each row, one for the truncated date, and a final column with the running total within each year.*/

SELECT standard_amt_usd,
DATE_TRUNC('year', occurred_at) AS year,
SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders;

/*Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. Your final table should have these four columns.*/

SELECT id,
	account_id,
    total,
    RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders;

/*The ORDER BY clause is one of two clauses integral to window functions. The ORDER and PARTITION define what is referred to as the “window”—the ordered subset of data over which calculations are made. Removing ORDER BY just leaves an unordered partition; in our query's case, each column's value is simply an aggregation (e.g., sum, count, average, minimum, or maximum) of all the standard_qty values in its respective account_id.*/

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id) AS max_std_qty
FROM orders

/*create and use an alias to shorten the following query (which is different than the one in Derek's previous video) that has multiple window functions. Name the alias account_year_window, which is more descriptive than main_window in the example above.*/

SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS count_total_amt_usd,
       AVG(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS min_total_amt_usd,
       MAX(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS max_total_amt_usd
FROM orders

/*same as*/

SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at));

/*Modify Derek's query from the previous video in the SQL Explorer below to perform this analysis. You'll need to use occurred_at and total_amt_usd in the orders table along with LEAD to do so. In your query results, there should be four columns: occurred_at, total_amt_usd, lead, and lead_difference.*/

SELECT account_id,
       standard_sum,
       LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead,
       standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) - standard_sum AS lead_difference
FROM (
SELECT account_id,
       SUM(standard_qty) AS standard_sum
  FROM orders 
 GROUP BY 1
 ) sub

 /*modified*/

 SELECT occurred_at,
	total_sum,
    LEAD(total_sum) OVER (ORDER BY occurred_at) AS lead,
    LEAD(total_sum) OVER (ORDER BY occurred_at) - total_sum AS lead_diff
FROM (
  SELECT occurred_at, SUM(total_amt_usd) AS total_sum
  FROM orders
  GROUP BY 1) sub

  /*Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased, and one of four levels in a standard_quartile column.*/

SELECT
       account_id,
       occurred_at,
       standard_qty,
       NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
FROM orders 
ORDER BY account_id DESC;

/*Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of gloss_qty paper purchased, and one of two levels in a gloss_half column.*/

SELECT
       account_id,
       occurred_at,
       gloss_qty,
       NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_half
FROM orders 
ORDER BY account_id DESC

/*Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased, and one of 100 levels in a total_percentile column.*/

SELECT account_id,
	occurred_at,
    total_amt_usd,
    NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS percentil
FROM orders
ORDER BY account_id DESC;

/*you want to see:

each account who has a sales rep and each sales rep that has an account (all of the columns in these returned rows will be full)
but also each account that does not have a sales rep and each sales rep that does not have an account (some of the columns in these returned rows will be empty)
This type of question is rare, but FULL OUTER JOIN is perfect for it. In the following SQL Explorer, write a query with FULL OUTER JOIN to fit the above described Parch & Posey scenario (selecting all of the columns in both of the relevant tables, accounts and sales_reps) then answer the subsequent multiple choice quiz.*/

SELECT *
  FROM accounts a
 FULL JOIN sales_reps s ON a.sales_rep_id = s.id
 ORDER BY sales_rep_id;

 /*If unmatched rows existed (they don't for this query), you could isolate them by adding the following line to the end of the query:*/

 SELECT *
  FROM accounts
 FULL JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
 WHERE accounts.sales_rep_id IS NULL OR sales_reps.id IS NULL;

 










































