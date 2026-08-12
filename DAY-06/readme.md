SQL 15-Day Deep Dive, Day 6 of 15

You want every customer, including the ones who never ordered. LEFT JOIN is built exactly for this - keep everybody, matched or not.

SELECT c.customer, o.order_id, o.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'delivered';

Run it. Every customer with zero orders - silently gone. No error. No warning. LEFT JOIN never got touched. It just stopped behaving like one.

-- As discussed in Day 2 null logic
NULL isn't "no." It's SQL saying I don't know. WHERE only asks yes/no questions - it can't act on a question it can't answer.

 A customer with a pending or cancelled order gets a real FALSE - genuine no, fair drop. A customer with no order at all gets UNKNOWN - never got a fair test to begin with. Same missing row on screen. Different reason underneath.

Fix - move the condition into AND instead of WHERE:

SELECT c.customer, o.order_id, o.status
FROM customers c
LEFT JOIN orders o on c.customer_id = o.customer_id 
AND o.status = 'delivered';

Here in the query we get the result , both customers who ordered and not ordered

Bonus question today - my LEFT JOIN produces 152 rows, not 144. 144 real orders, plus 8 NULL placeholder rows - one per customer who never ordered.
 
Filter on order_date, those 8 drop guaranteed. The other 144 each get a real yes/no based on their actual date.

121 Rows customers survived based on my database

I rebuilt this on my Day 5 database - added customer_id, status, and order_date to orders, and a new customers table (customer_id, customer, city, region). 20 customers, 12 with real orders, 8 with none - so today's NULLs are real, not simulated.

Answer query for today's challenge based on my understanding

 SELECT c.customer, o.order_id, o.status
 FROM customers c
 LEFT JOIN orders o ON c.customer_id = o.customer_id
AND o.status = 'delivered';
