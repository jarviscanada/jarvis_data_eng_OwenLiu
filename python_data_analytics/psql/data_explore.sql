-- Show table schema 
\d+ retail;

-- Show first 10 rows
SELECT * FROM retail limit 10;

-- Check # of records
SELECT COUNT(*) FROM retail;

-- number of clients (e.g. unique client ID)
SELECT COUNT(DISTINCT customer_id) AS "count"
FROM retail;

-- invoice date range (e.g. max/min dates)
SELECT MAX(invoice_date) AS "max", MIN(invoice_date) AS "min"
FROM retail;

-- Q5: number of SKU/merchants (e.g. unique stock code)
SELECT COUNT(DISTINCT stock_code) AS "count"
FROM retail;

-- Q6 Calculate average invoice amount excluding invoices with a negative amount
-- (e.g. canceled orders have negative amount)
SELECT AVG(A.total) AS "avg"
FROM (
      SELECT R.invoice_no AS "id", SUM(R.quantity * R.unit_price) AS "total"
      FROM retail R
      GROUP BY id
      HAVING SUM(R.quantity * R.unit_price) > 0
     ) AS A
     ;

--Q7: Calculate total revenue (e.g. sum of unit_price * quantity)
SELECT SUM(quantity * unit_price) AS "sum"
FROM retail;

--Q8: Calculate total revenue by YYYYMM
SELECT to_char(invoice_date, 'yyyy-mm') AS yyyymm, SUM(quantity * unit_price)
FROM retail
GROUP BY yyyymm
ORDER BY yyyymm;
