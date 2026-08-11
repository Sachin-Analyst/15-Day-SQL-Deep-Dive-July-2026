# Day 04 -- GROUP BY, Silent Aggregation Bugs, and Why MySQL Doesn't Warn You

![Day 04 Thumbnail](DAY-04-Thumbnail.png)

## Challenge

![Day 04 Challenge](DAY-04-Challenge.png)

```sql
SELECT city, product, SUM(sales) FROM orders GROUP BY city;
```

MySQL runs this without complaint and shows one product per city. Looks
fine. Postgres, SQL Server, and BigQuery all refuse it outright -- product
must appear in the GROUP BY clause.

A dataset was built to test this properly: five cities, three categories,
two distinct products per category, every product ordered twice. Running
the query above, Chennai showed "Laptop, 107830." But Chennai actually
sells six different products, not one.

## Concept Covered

-- SUM(sales) is always correct. It genuinely adds every row in the group.

-- product isn't aggregated and isn't grouped. SQL has no rule for picking
one product to represent six.

-- It isn't picking the top seller either. Hyderabad showed "Mouse" with
3900, while Headphones in the same city sold for 9800 -- a bigger number
that never appeared.

-- MySQL just grabs whichever row it scans first and labels the total
with it. No error, no warning -- just a quietly wrong label sitting next
to a correct sum.

## Example Walkthrough

The fix: group by every non-aggregated column that's actually selected.

```sql
SELECT city, product, SUM(sales) AS Total_sales
FROM orders
WHERE city = "Chennai"
GROUP BY city, product WITH ROLLUP;
```

Full query file: [DAY-04-Queries.sql](DAY-04-Queries.sql)

## Results

**Broken query** (`GROUP BY city` only) -- Chennai collapses to a single,
misleading row:

| City    | Product | Total_sales |
|---------|---------|-------------|
| Chennai | Laptop  | 107830      |

**Fixed query** (`GROUP BY city, product WITH ROLLUP`), run against the
full dataset of 11 cities -- every product gets its own honest row, and
ROLLUP automatically appends a subtotal row per city (product = NULL) plus
one grand total row at the very end (city = NULL, product = NULL).

Chennai's slice of the output:

| City    | Product   | Total_sales |
|---------|-----------|-------------|
| Chennai | Biscuits  | 330         |
| Chennai | Jeans     | 4300        |
| Chennai | Laptop    | 98000       |
| Chennai | Mouse     | 1050        |
| Chennai | Rice Bag  | 1650        |
| Chennai | T-Shirt   | 2500        |
| Chennai | **NULL**  | **107830**  |

That NULL row isn't a bug -- it's ROLLUP's built-in subtotal marker,
automatically summing every product above it for that city.

Full output across all 11 cities: [DAY-04-results.csv](DAY-04-results.csv)

Grand total (final row, city = NULL, product = NULL): **1,274,485**

Same total sales figure the query was always producing correctly -- what
was wrong before was only the product label sitting next to it, silently
misrepresenting six rows as one.

## Applying the Concept

Bonus question: totals are needed per city AND per city+category. Can one
GROUP BY give both?

```sql
SELECT city, category, SUM(sales) AS Total_sales
FROM orders
GROUP BY city, category WITH ROLLUP;
```

One GROUP BY gives an answer, but it doesn't fully match the requirement.
The textbook fix is GROUPING SETS, which produces both aggregation levels
in a single result set -- but that feature only exists from MySQL 8.0.31
onward, and this challenge ran on MySQL 8.0.28. So the actual fix used was
WITH ROLLUP instead: same two levels of totals, plus one extra grand total
row added on top.

Chennai's slice of this second query:

| City    | Category    | Total_sales |
|---------|-------------|-------------|
| Chennai | Clothing    | 6800        |
| Chennai | Electronics | 99050       |
| Chennai | Groceries   | 1980        |
| Chennai | **NULL**    | **107830**  |

Full output across all 11 cities: [DAY-04-Bonus-results.csv](DAY-04-Bonus-results.csv)

The grand total row here (city = NULL, category = NULL) is also
**1,274,485** -- identical to the grand total from the city+product
version above. Two completely different groupings of the same data,
landing on the exact same number. That match is the real confirmation
that both ROLLUP queries are correct, not just plausible.

## Key Takeaway

This wasn't really about syntax. It's that a query running without an
error doesn't mean it answered the question correctly. MySQL didn't
protect against this mistake -- it just stayed quiet while returning a
technically-valid, practically-wrong result.

## Video Walkthrough

Watch on LinkedIn: [link]

## Files in This Folder

- [DAY-04-Queries.sql](DAY-04-Queries.sql) -- full query file
- [DAY-04-results.csv](DAY-04-results.csv) -- city + product ROLLUP output, all 11 cities
- [DAY-04-Bonus-results.csv](DAY-04-Bonus-results.csv) -- city + category ROLLUP output, all 11 cities
- DAY-04-Challenge.png -- challenge prompt
- DAY-04-Thumbnail.png -- video thumbnail
