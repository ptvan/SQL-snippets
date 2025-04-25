-- show a table's columns and their types
DESCRIBE table;

-- count the number of rows in a table;
SELECT COUNT(*) FROM table;

-- aggregate using GROUP BY
SELECT cyl, gear, MEAN(mpg) AS mean_mpg 
FROM mtcars 
GROUP BY cyl, gear 
ORDER BY cyl ASC, gear DESC;

