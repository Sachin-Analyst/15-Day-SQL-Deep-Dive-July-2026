# 15-Day SQL Deep Dive Challenge

I just finished a 15-day SQL Deep Dive Challenge with Codebasics, led by Dhaval Patel, Hemanand Vadivel, and Naveen S. This repo is where I'm putting the whole journey together. One SQL concept a day. Real queries, real databases, real learning out in the open.

**Author:** Sachin (Vishnu Ram Sachin D)

**LinkedIn:** [vishnu-ram-sachin-d] (https://www.linkedin.com/in/vishnu-ram-sachin-d)

**GitHub:** [Sachin-Analyst](https://github.com/Sachin-Analyst)

---

## Why I did this

I'm a Data Analyst in the making. SQL is one of the core skills I lean on daily, along with Power BI and Excel. This challenge pushed me to go deeper than just knowing the syntax. Each day picked apart one specific behavior or trap in SQL, the kind of thing that looks simple until you actually hit it in a real query.

## How each day worked

Same process, 15 times in a row:
1. Understand the day's problem or question
2. Find ways to connect this problem
3. Write and test the query
4. Capture the output
5. Turn it into content: video script, Video presentation record , LinkedIn caption, Discord message, thumbnail

Consistency was the real challenge here, not just the SQL.

## What's inside each day

```
Day01/
├── requirements.md     -> the day's problem statement
├── query.sql           -> the clean SQL solution
├── results.csv         -> what the query actually returned
├── video_script.md     -> script for that day's video
└── notes.md            -> concept explanation, learnings, links
```

Thumbnails for every day live together in `/assets/thumbnails`, named `Day01_thumbnail.png` through `Day15_thumbnail.png`.

## Databases I worked with

| Database | What it was for |
|---|---|
| `gdb09072026` | My main working database, built up day by day starting Day 4. Named after the day I created it, so the name stays even as the schema grows. |
| `employee` | Created on Day 10. 30 rows, 5 departments. Used for correlated subquery practice. |
| `gdb023` (AtliQ Hardware) | Codebasics' sample database. Used on Days 12 to 14 for window functions. |

Schema references are in [`/databases`](./databases).

## The 15 days

| Day | Topic | Folder |
|---|---|---|
| 1 | Alias and execution order behavior | [Day01](./Day01) |
| 2 | TBD | [Day02](./Day02) |
| 3 | TBD | [Day03](./Day03) |
| 4 | Setting up gdb09072026 + NULL handling | [Day04](./Day04) |
| 5 | TBD | [Day05](./Day05) |
| 6 | WHERE vs HAVING | [Day06](./Day06) |
| 7 | LEFT JOIN traps | [Day07](./Day07) |
| 8 | Fan-out and JOIN inflation | [Day08](./Day08) |
| 9 | CTEs vs subqueries | [Day09](./Day09) |
| 10 | Correlated subqueries + EXPLAIN ANALYZE | [Day10](./Day10) |
| 11 | NOT IN with NULLs | [Day11](./Day11) |
| 12 | Window functions I: SUM OVER, running totals | [Day12](./Day12) |
| 13 | Window functions II: moving averages | [Day13](./Day13) |
| 14 | CASE-based pivoting + ROW_NUMBER, RANK, DENSE_RANK | [Day14](./Day14) |
| 15 | Second-highest salary + duplicate email detection | [Day15](./Day15) |

Days marked TBD still need their real topic filled in.

## Repo structure

```
15-Day-SQL-Deep-Dive-Challenge/
├── Day01 .. Day15/
│   ├── requirements.md
│   ├── query.sql
│   ├── results.csv
│   ├── video_script.md
│   └── notes.md
├── databases/            # schema references
├── assets/
│   └── thumbnails/       # Day01_thumbnail.png .. Day15_thumbnail.png
└── README.md
```

## This ties into my other work

I run two content series on LinkedIn:
- **Creativity Clicks**, where I explain data concepts through analogies
- **On Meaning**, reflective essays on growth and identity

On Meaning · Creativity Clicks — Growing 1% every day.

## Thanks

To Dhaval Patel, Hemanand Vadivel, and Naveen S for building this challenge and pushing the Codebasics community to learn out loud.
