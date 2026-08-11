# Day 03 -- Top-N Records with Ties (LIMIT vs Window Functions)

![Day 03 Thumbnail](DAY-03-Thumbnail.png)

## Challenge

![Day 03 Challenge](DAY-03-Challenge.png)

A dealer performance table. Manager wants the top 5 dealers by sales.

```sql
SELECT dealer, sales FROM performance ORDER BY sales DESC LIMIT 5;
```

Ships fine, until dealer #6 complains a week later. Dealer #5 and dealer #6
both posted ₹18 lakh in sales. One made the list. One didn't.

## Concept Covered

-- ORDER BY sorts the column's values. LIMIT sorts by position, not value
-- it counts 1, 2, 3, 4, 5 and stops. It has no idea row 6 is tied with row 5.

-- LIMIT counts rows, not ranks. Two dealers can post identical sales and
still get split, one in, one out, because LIMIT was only ever asked for
5 rows, not "who's tied for 5th."

-- The fix is a window function. Three options exist -- ROW_NUMBER, RANK,
DENSE_RANK -- and each handles ties differently. DENSE_RANK was used here
because it gives tied rows the same rank instead of skipping or splitting
them apart.

-- Bonus note: when two rows tie, ORDER BY doesn't guarantee which one
lands first. Without a tiebreaker column, the order depends on how the
data physically sits or how the engine sorts internally -- not something
to rely on.

## Example Walkthrough

Demonstrated using a student_marks table, ranking students by marks:

```sql
WITH CTE1 AS (
  SELECT name, marks,
         DENSE_RANK() OVER (ORDER BY marks DESC) AS rnk
  FROM student_marks
)
SELECT *
FROM CTE1
WHERE rnk BETWEEN 1 AND 5;
```

## Results

Running the DENSE_RANK query against the full student_marks table returned
14 students total, with three separate ties along the way (72, 60, and 14
marks each shared by two or more students).

Filtering to `WHERE rnk BETWEEN 1 AND 5` returned 6 rows, not 5 -- because
Prashant and Mahesh are tied at 72 marks, both at rank 5.

| Rank | Name     | Marks |
|------|----------|-------|
| 1    | ishika   | 98    |
| 2    | Ravi     | 95    |
| 3    | Raju     | 90    |
| 4    | ramesh   | 85    |
| 5    | Prashant | 72    |
| 5    | Mahesh   | 72    |

Top 5 results : [DAY-03-Top-5-results.csv](./DAY-03-Top-5-results.csv)

If `LIMIT 5` had been used instead of DENSE_RANK, Mahesh would have been cut
silently -- despite scoring exactly the same as Prashant. This is the
dealer #6 problem from the challenge, reproduced in the actual data.

## Full Ranked List (Video Reference)

The video walkthrough runs DENSE_RANK() across the entire student_marks
table (not just the top 5) to show how ranks are assigned row by row --
including all three ties in the data (72, 60, and 14 marks).

Full results: [DAY-03-Full-List-results.csv](DAY-03-Full-List-results.csv)

| Rank | Name    | Marks |
|------|---------|-------|
| 1    | ishika  | 98    |
| 2    | Ravi    | 95    |
| 3    | Raju    | 90    |
| 4    | ramesh  | 85    |
| 5    | Prashant| 72    |
| 5    | Mahesh  | 72    |
| 6    | Kiran   | 60    |
| 6    | gayatri | 60    |
| 6    | Vipul   | 60    |
| 7    | Arjun   | 33    |
| 8    | parth   | 28    |
| 9    | suresh  | 14    |
| 9    | aditya  | 14    |
| 10   | Akhil   | 7     |

Note how DENSE_RANK never skips a number even with the three-way tie at
60 marks -- rank 6 is used three times, then rank 7 continues normally
(not rank 9). That's the exact behavior that separates DENSE_RANK from
RANK.

## Applying the Concept

Same problem, same approach, applied back to the original dealer scenario:

```sql
WITH CTE1 AS (
  SELECT dealer, sales,
         DENSE_RANK() OVER (ORDER BY sales DESC) AS sales_rnk
  FROM performance
)
SELECT *
FROM CTE1
WHERE sales_rnk BETWEEN 1 AND 5;
```

## Key Takeaway

This wasn't really about ranking syntax. Think about what "top 5" actually
decides -- a discount, a scholarship, a gift. LIMIT 5 doesn't just cut off
rows. It can remove a reward someone genuinely earned.

## Video Walkthrough

Watch on LinkedIn: [Video-presentation-link](https://www.linkedin.com/posts/vishnu-ram-sachin-d-_sql-dataanalytics-codebasics-activity-7480582635006648320-We4j?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD-YjK4B1ekkuKaP0cSvVwYi6kAAiCTAQhY)
