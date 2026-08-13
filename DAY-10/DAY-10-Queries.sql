
SELECT * FROM random_tables.expenses;

-- Database employee
SELECT * FROM employees;

-- Problem Query 
SELECT * FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT * FROM employees;

SELECT AVG(salary) FROM employees;

-- Fix Query using Subquery 

SELECT *
    FROM employees e1 
    WHERE e1.salary > (
		SELECT AVG(e2.salary) FROM employees e2
        WHERE e2.department = e1.department)
        ORDER BY e1.employee_id;

-- examples

SELECT AVG(e1.salary) FROM employees e1
WHERE e1.department = "Sales";

SELECT e1.salary FROM employees e1
WHERE e1.department = "Sales";

SELECT * FROM employees; 


-- Bonus: this style of subquery re run for every row
-- On a million row table, what is the performance risk?


EXPLAIN ANALYZE 
SELECT *
    FROM employees e1 
    WHERE e1.salary > (
		SELECT AVG(e2.salary) FROM employees e2
        WHERE e2.department = e1.department)
        ORDER BY e1.employee_id;
 930


EXPLAIN ANALYZE 
WITH dept_avg AS(
SELECT emp.department , AVG(emp.salary)  as dept_avg_salary
FROM employees emp
GROUP BY emp.department)

SELECT 
e2.employee_id, 
e2.name,
e2.department , 
e2.salary 
FROM employees e2
JOIN dept_avg da
ON da.department = e2.department
WHERE e2.salary > da.dept_avg_salary
ORDER BY e2.employee_id;

95

WITH dept_avg AS(
SELECT emp.department , AVG(emp.salary) as dept_avg_salary
FROM employees emp
GROUP BY emp.department)

SELECT e2.employee_id, e2.name, e2.department , e2.salary 
FROM employees e2
JOIN dept_avg da
ON da.department = e2.department
WHERE e2.salary > da.dept_avg_salary
ORDER BY e2.employee_id;

