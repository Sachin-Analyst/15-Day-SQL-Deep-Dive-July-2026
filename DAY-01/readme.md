# Day 01 -- SQL's Logical Execution Order: Why WHERE Can't See an Alias ORDER BY Can

![Day 01 Thumbnail](DAY-01-Thumbnail.png)

## Challenge

![Day 01 Challenge](DAY-01-Challenge.png)

Why does this query fail?

```sql
SELECT product_code, gross_price * 12 AS annual_revenue
FROM fact_gross_price
WHERE annual_revenue > 9000;
```

```
Error Code: 1054. Unknown column 'annual_revenue' in 'where clause'
```

But the exact same alias works fine here:

```sql
SELECT product_code, gross_price * 12 AS annual_revenue
FROM fact_gross_price
ORDER BY annual_revenue DESC;
```

Same alias, same underlying query, just moved from WHERE to ORDER BY.
Why does one fail and the other work?

## Concept Covered

-- This isn't a MySQL bug. SQL does not execute in the order it's
written on the page -- it runs in a fixed logical order:

`FROM > WHERE > GROUP BY > HAVING > SELECT > ORDER BY`

-- `annual_revenue` is an alias, and aliases are created by SELECT.
WHERE runs before SELECT in this logical order, so at the point WHERE
executes, that alias simply doesn't exist yet -- there's nothing to
compare `> 9000` against.

-- ORDER BY runs after SELECT, once the alias has already been created,
so it can reference `annual_revenue` without any issue.

-- The written order (top to bottom on the page) and the logical
execution order are two different things, and this is exactly the kind
of mismatch that produces an error some places and not others, for what
looks like the same alias used the same way.

## Example Walkthrough

Working through both versions directly in MySQL Workbench, against the
`fact_gross_price` table (product_code, fiscal_year, gross_price):

**WHERE version -- fails:**

```sql
SELECT product_code, gross_price * 12 AS annual_revenue
FROM fact_gross_price
WHERE annual_revenue > 9000;
```

Returns `Error Code: 1054. Unknown column 'annual_revenue' in 'where clause'`.

**ORDER BY version -- works:**

```sql
SELECT product_code, gross_price * 12 AS annual_revenue
FROM fact_gross_price
ORDER BY annual_revenue DESC;
```

Runs cleanly and returns every product, sorted by annual revenue
descending -- note this version has no WHERE filter at all, so it isn't
limited to products above 9000, it's simply the full result set in
descending order.

## Results

Top of the result set, sorted by annual_revenue descending:

| product_code | annual_revenue |
|-----------------|-----------------|
| A6120110205      | 10019.7744      |
| A6119110201      | 9889.0668       |
| A6120110206      | 9727.2408       |
| A6119110204      | 9687.1656       |
| A6018110101      | 9605.4924       |
| A6019110108      | 9559.9272       |
| A6119110202      | 9481.2480       |
| A6018110106      | 9451.0488       |
| A6019110107      | 9431.9016       |
| A6018110103      | 9251.7468       |
| A6119110203      | 9234.7620       |

This is a sample taken directly from the video walkthrough screenshots,
not an exported CSV -- the original query file for this day wasn't
saved during the live challenge, so this readme was reconstructed
afterward from the recorded video and its on-screen results.

## A Note on This Day

This day's queries were rebuilt from a video walkthrough rather than a
saved SQL file, since the original file wasn't kept during the live
challenge. The dataset itself is AtliQ Hardware's `fact_gross_price`
table, reused from an earlier personal project -- the query was written
quickly at the time specifically to demonstrate this concept clearly,
not preserved as the exact original challenge submission.

## Key Takeaway

SQL's written order and its logical execution order are not the same
thing, and this is the single concept that several later days in this
series build directly on -- WHERE running before SELECT creates an alias
is the same root cause behind why WHERE can't reference `Total_sales` in
Day 05, and part of why WHERE can silently defeat a LEFT JOIN in Day 06.
Knowing the real execution order, FROM, WHERE, GROUP BY, HAVING, SELECT,
ORDER BY, isn't trivia. It's the thing that explains why a query with no
typo and no obvious mistake still throws an error some of the time and
not others.

## Video Walkthrough

Watch on LinkedIn: [link]

## Files in This Folder

- DAY-01-Challenge.png -- challenge prompt
- DAY-01-Thumbnail.png -- video thumbnail
- *(No separate query file or results CSV for this day -- reconstructed from video screenshots, see note above)*
