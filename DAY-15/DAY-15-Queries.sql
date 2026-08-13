
# Requirement ---- 1
--- Find the second-highest salary in the employees table.

SELECT * FROM employee.employees
ORDER BY salary DESC;


-- Problem Query 

SELECT salary FROM employees 
ORDER BY salary DESC 
LIMIT 1,1;


-- Fix Query
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);


# Requirement ----- 2 
--- Find duplicate emails in the users table.
SELECT * FROM users;

-- Problem Query #1
SELECT email, COUNT(*) 
FROM users
WHERE COUNT(*) > 1
GROUP BY email;

15:46:57	SELECT email, COUNT(*)  FROM users WHERE COUNT(*) > 1 GROUP BY email LIMIT 0, 50000	
Error Code: 1111. Invalid use of group function	0.000 sec


-- Problem Query #2
SELECT * FROM employee.users;

SELECT email, COUNT(*)
FROM users
WHERE (SELECT COUNT(*) > 1 FROM users )
GROUP BY email;

-- (SELECT COUNT(*) FROM users)  >  just counts all rows in the table  >  6
-- 6 > 1  >  TRUE

SELECT email, COUNT(*) AS occurrences
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
