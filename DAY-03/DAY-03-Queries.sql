SELECT student_id,name, marks 
FROM student_marks
ORDER BY marks DESC;


15:05:52	SELECT student_id,name, marks  FROM student_marks ORDER BY marks DESC LIMIT 0, 50000	14 row(s) returned	0.000 sec / 0.000 sec





SELECT name, marks 
FROM student_marks
ORDER BY marks DESC
LIMIT 5;


ORDER BY SORT BY COLUMN VALUES 
LIMIT SORTS BY COLUMN POSITIONS 


220 Ishika 98    > 1
120 Ravi   95    > 2
145 Raju   90    > 3
190 Ramesh  85   > 4
114 Prashant 72  > 5





WITH CTE1 AS (
  SELECT name, marks,
         DENSE_RANK() OVER (ORDER BY marks DESC) AS rnk
  FROM student_marks
)

SELECT *
FROM CTE1
WHERE rnk BETWEEN 1 AND 5;

WITH CTE1 AS (
  SELECT dealer, sales,
         DENSE_RANK() OVER (ORDER BY sales DESC) AS sales_rnk
  FROM performance
)
SELECT *
FROM CTE1
WHERE sales_rnk BETWEEN 1 AND 5
   