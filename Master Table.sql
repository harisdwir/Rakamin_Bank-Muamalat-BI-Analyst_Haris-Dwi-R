 --PERFORM THIS QUERY TO CREATE A DATAMART FOR FURTHER DATA ANALYSIS
-- USE COMMON TABLE EXPRESSION TO IMPROVE CODE READABILITY AND QUERYING PERFORMANCE
/* SINCE BIG QUERY DOESN'T ALLOW USING CREATE TABLE COMMAND WITHIN A QUERY THAT INCLUDE CTE DIRECTLY,
EXPORT THE RESULT INTO NEW TABLE USING SAVE RESULTS MENU
*/

WITH master_table AS (
  SELECT
  O.Date AS order_date,
  PC.CategoryName AS category_name,
  P.ProdName AS product_name,
  P.Price AS product_price,
  O.Quantity AS order_qty,
  (P.Price * O.Quantity) AS total_sales,
  C.CustomerEmail AS cust_email,
  C.CustomerCity AS cust_city
  FROM
  `bi-analyst1.BI_Analyst.Customers` AS C
  RIGHT JOIN
  `bi-analyst1.BI_Analyst.Orders` AS O
  ON
  C.CustomerID = O.CustomerID
  LEFT JOIN
  `bi-analyst1.BI_Analyst.Products` AS P
  ON
  O.ProdNumber = P.ProdNumber
  RIGHT JOIN
  `bi-analyst1.BI_Analyst.ProductCategory` AS PC
  ON
  P.Category = PC.CategoryID
)

SELECT * FROM master_table;