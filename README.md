# 15-Day-SQL-Deep-Dive-July-2026

Welcome to my "SQL 15-Day Deep Dive" Challenge project. This repository documents a 15-day SQL query-debugging series where each day tackles one concept (ties, NULLs, JOIN fan-outs, window functions, execution order) and rebuilds the fix against a real, hands-on example. Unlike a single fixed dataset, this challenge was concept-first: each day's answer is a pattern that applies to any table with the same shape, demonstrated using self-built test data and, at scale, Codebasics' AtliQ Hardware production dataset.

---

## Table of Contents
- [Introduction](#introduction)
- [Challenge Result](#challenge-result)
- [Project Description](#project-description)
- [Folder Structure](#folder-structure)
- [Key Features](#key-features)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Introduction
---
*Project Title:* SQL 15-Day Deep Dive Challenge
*Created By:* [Sachin-Analyst](https://github.com/Sachin-Analyst)
*Tools Used:* MySQL, MySQL Workbench
*Focus Areas:* NULL Logic, Joins, Window Functions, Subqueries vs CTEs, GROUP BY / HAVING, Query Plan Interpretation
*Challenge By:* Codebasics

---

## Challenge Result

This was my first time participating in a challenge in this format.

- **Completed:** 13 of 15 days (86.7%)
- **Best streak:** 12 days
- Every day includes a full readme writeup, the query file, real query output, and a LinkedIn video walkthrough

---

## Project Description
This repository contains the daily body of work from the "SQL 15-Day Deep Dive" challenge.

Each day starts with a query that looks reasonable and often runs without any error, but returns a wrong or misleading result because of a specific SQL misunderstanding: LIMIT breaking on a tie, WHERE silently defeating a LEFT JOIN, a JOIN fan-out inflating a SUM, NULL poisoning a NOT IN, and so on. Rather than working against one shared table for all 15 days, each day's fix is demonstrated against whatever dataset best fit the concept: a small self-built table when the point was the logic itself, or Codebasics' AtliQ Hardware dataset when the point was proving the same logic holds at real production scale.

---

## Folder Structure

| Day | Folder | Focus |
|---|---|---|
| 01 | [DAY-01](./DAY-01) | SQL's logical execution order (FROM > WHERE > GROUP BY > HAVING > SELECT) *(readme pending, video reconstruction in progress)* |
| 02 | [DAY-02](./DAY-02) | NULL as an unknown value, not a "no": three-valued logic basics *(readme pending, video reconstruction in progress)* |
| 03 | [DAY-03](./DAY-03) | Top-N records with ties: why LIMIT isn't tie-safe, fixed with DENSE_RANK |
| 04 | [DAY-04](./DAY-04) | GROUP BY's silent aggregation bug across SQL engines, fixed with WITH ROLLUP |
| 05 | [DAY-05](./DAY-05) | WHERE vs HAVING: SQL's written clause order vs its real execution order |
| 06 | [DAY-06](./DAY-06) | How a WHERE clause silently turns a LEFT JOIN back into an INNER JOIN |
| 07 | [DAY-07](./DAY-07) | JOIN fan-out silently inflating a SUM, and why COUNT(DISTINCT) matters too |
| 08 | [DAY-08](./DAY-08) | NULL breaking NOT IN into a silent zero-row result, plus the three shapes a subquery can take |
| 09 | [DAY-09](./DAY-09) | CTEs vs nested subqueries: same execution, readable top to bottom |
| 10 | [DAY-10](./DAY-10) | Correlated subquery vs CTE, measured with EXPLAIN ANALYZE: correct isn't always efficient |
| 11 | [DAY-11](./DAY-11) | Pivoting rows into columns with CASE, tested at scale on 335 real products |
| 12 | [DAY-12](./DAY-12) | Row-level percent of total without collapsing rows, using a window function |
| 13 | [DAY-13](./DAY-13) | ROW_NUMBER vs RANK vs DENSE_RANK: same tie, three different answers |
| 14 | [DAY-14](./DAY-14) | *readme pending, video reconstruction in progress* |
| 15 | [DAY-15](./DAY-15) | Finale: second-highest salary and duplicate emails, two classic interview questions |

---

## Key Features
- *Concept-First Debugging*: each day isolates one SQL misunderstanding, not just one broken query
- *Self-Built Test Data*: most days use small, purpose-built datasets designed to expose the exact trap being taught
- *Real-Scale Validation*: select days re-test the same concept against Codebasics' AtliQ Hardware production dataset
- *Fix Queries*: validated MySQL queries with a before/after comparison and real output
- *Video Walkthroughs*: each completed day links to a LinkedIn video presentation explaining the concept live
- *Plain-Language Explanations*: reasoning and analogies behind each fix, not just corrected syntax

## Installation
To explore or modify this project:
1. *Clone the repository:*
```bash
   git clone https://github.com/Sachin-Analyst/15-Day-SQL-Deep-Dive-July-2026.git
```
   - Open terminal and run the command
2. *Download and Open MySQL Workbench* (or any MySQL client)
   - All queries in this series were written and tested in MySQL
3. *Explore Resources*
   - Open any `DAY-XX` folder to review the challenge, the concept, the fix query, and real results for that day

---

## Usage
### What You Can Explore
- The exact concept or business question each day is built around
- The problem query that looks reasonable but returns a wrong or misleading result, and why
- The fix query with full reasoning
- Real query output and, where relevant, EXPLAIN ANALYZE performance comparisons
- The LinkedIn video walkthrough for each completed day

----

# Note!
Most datasets used in this challenge are small, self-built tables created specifically to demonstrate each day's concept; these are included as CSV files in their respective day folders. Select days additionally use the AtliQ Hardware dataset (gdb023), provided by Codebasics as part of their broader dataset library; that production dataset is not included in this repository and should be sourced from Codebasics directly.

----

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
