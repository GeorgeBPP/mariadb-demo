/*
WIDE WORLD IMPORTERS - SQL TRAINING

This document contains a list of question that are designed to be answered
using SQL to work with data in the Wide World Importers database.

The questions get progressively more advanced. If you are struggling with
a question, or you would like to double check how we approached the
question, then there are videos available on the Hub as demonstrations.

Many of the questions are marked as "DEMO" questions. If you have never
worked with SQL before, then you may want to watch the videos for these
"DEMO" questions before attempting the others.
*/

/*
CONTENTS
-- SECTION 1 - extracting data FROM a table
-- SECTION 2 - extracting unique data FROM a table
-- SECTION 3 - filtering data with a WHERE clause
-- SECTION 4 - Filtering data with a WHERE clause: multiple conditions & missing data
-- SECTION 5 - aggregate functions.
-- SECTION 6 - creating, removing and updating tables
-- SECTION 7 - sorting data with ORDER BY
-- SECTION 8 - aggregating with GROUP BY
-- SECTION 9 - combine GROUP BY with other commands
-- SECTION 10 - working with dates
-- SECTION 11 - combining tables with JOINs
-- SECTION 12 - using JOINs with other commands
-- SECTION 13 - using sub-queries and CTEs
-- SECTION 14 - challenges!!
*/



-------------------------------------------------------------------------------------------------------
-- SECTION 1 - extracting data FROM a table
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 001
-- Use the USE command to set the WorldWideImporters database as our default.
USE WideWorldImporters;
-- You may struggle to connect to tables in your other queries if you do not run this line first!


-- DEMO: QUESTION 002
-- Use the SELECT command to extract all columns FROM the Sales.Customers table.
-- What are the columns in customer? What data types do they contain?
SELECT * FROM Sales.Customers;
-- Answer: The table has several columns, including *CustomerID*, which seems to be numeric.


-- DEMO: QUESTION 003
-- Extract the name of the customer and their web address FROM the Sales.Customers table.
-- How many records are returned? What data types do the the columns have?
SELECT CustomerName, WebsiteURL FROM Sales.Customers;
-- Answer: 751 records were returned.
-- Answer: The columns both contain text information.


-- DEMO: QUESTION 004
-- Use the TOP command to return only the first 10 records FROM Sales.Customers.
SELECT TOP 10 * FROM Sales.Customers;


-- DEMO: QUESTION 005
-- Use the COUNT command to count the number of records FROM the Sales.Customers table.
-- How many records does the table have?
SELECT COUNT(*) FROM Sales.Customers;
-- Answer: 751 records.

-------------------------------------------------------------------------------------------------------

-- QUESTION 006
-- What are the columns in the Sales.Orders table? What data types do they contain? How many records?


-- QUESTION 007
-- What are the data types for the OrderDate, Comments, and LastEditedWhen columns in Sales.Orders?


-- QUESTION 008
-- Look at the column names in both Purchasing.PurchaseOrders and Application.DeliveryMethods.
-- What columns do these tables share in common with each other?


-- QUESTION 009
-- Explore other tables in the *Application* schema. Can you find any columns which connect to the data in Sales.Customers?
-- Note: the columns may not have exactly the same column name.



-------------------------------------------------------------------------------------------------------
-- SECTION 2 - extracting unique data FROM a table
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 010
-- Extract the PreferredName column FROM Application.People.
SELECT PreferredName FROM Application.People;


-- DEMO: QUESTION 011
-- Use the DISTINCT command to extract all the distinct preferred names FROM Application.People.
SELECT DISTINCT PreferredName FROM Application.People;


-- DEMO: QUESTION 012
-- How many distinct preferred names are there in Application.People?
SELECT COUNT(DISTINCT PreferredName) FROM Application.People;
-- Answer: 935
-- Note: The answer is NOT 1199. This is the answer you get if you omit the DISTINCT keyword.
--       1199 is the number of values in the column but some people share the same name.

-------------------------------------------------------------------------------------------------------

-- QUESTION 013
-- How many distinct values for *TotalDryItems* are there in the Sales.Invoices table?


-- QUESTION 014
-- How many distinct values for *DeliveryCityID* exist in the Sales.Customers table?


-- QUESTION 015
-- Do all the cities in the Application.Cities table exist in the Sales.Customers table?



-------------------------------------------------------------------------------------------------------
-- SECTION 3 - filtering data with a WHERE clause
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 016
-- SELECT all the columns in the Sales.Customers table for records WHERE *DeliveryCityID* is 242.
-- How many customers are in this city?
SELECT *
FROM Sales.Customers
WHERE DeliveryCityID = 242
;
-- Answer: 2 - Wingtip Toys (Akhiok, AK) and Caterina Pinto


-- DEMO: QUESTION 017
-- SELECT all the columns in the Sales.Customers table for records WHERE *CustomerName* is "Knut Svensson".
SELECT *
FROM Sales.Customers
WHERE CustomerName = 'Knut Svensson'
;

-- NOTE: In some databases, the following would not work due to case sensitive data.
--       However, this database has been encoded to allow any cases to be matched by default.
SELECT *
FROM Sales.Customers
WHERE CustomerName = 'KNUT SVENSSON'
;


-- DEMO: QUESTION 018
-- How many records are there in Sales.Customers WHERE *DeliveryMethodID* is 3? (use the COUNT command)
SELECT COUNT(*)
FROM Sales.Customers
WHERE DeliveryMethodID = 3
;
-- Answer: 751 records WHERE DeliveryMethodID is 3.

-------------------------------------------------------------------------------------------------------

-- QUESTION 019
-- How many records are there in the Sales.Orders table WHERE the *CustomerID* is 1?


-- QUESTION 020
-- Extract all delivery address information from the Sales.Customers table WHERE the CityID is 242
-- Is any of the information the same between the two customers?


-- QUESTION 021
-- Use the Application.Countries table to identify which *StateProvinceID* corresponds to Mississippi.
-- How many cities in the Application.Cities table are in Mississippi?


-- QUESTION 022
-- Use the Application.People table to investigate the preferred names of World Wide Importers employees.
-- How many different preferred names are used by employees (*IsEmployee* = 1)?


-- QUESTION 023
-- How many records are there in Sales.Invoices with a total of more than 1 dry item?


-- QUESTION 024
-- How many records in Sales.Invoices WHERE the *InvoiceDate* is from 1st January 2020 or more recently?



-------------------------------------------------------------------------------------------------------
-- SECTION 4 - Filtering data with a WHERE clause: multiple conditions & missing data
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 025
-- SELECT the CustomerName, DeliveryCityId, CreditLimit and ValidFrom columns
-- FROM the Sales.Customers table WHERE *DeliveryCityId* is 242 and *ValidFrom* is before 2020
SELECT CustomerName, DeliveryCityId, CreditLimit, ValidFrom
FROM Sales.Customers
WHERE DeliveryCityId = 242
  AND ValidFrom <= '2020-12-31 00:00:00'
;
-- Note, we need to include the time in our *ValidFrom* condition because the column uses the *datetime* data type.


-- DEMO: QUESTION 026
-- How many people in the Application.People table use either "Eva" or "Vlatka" as their preferred name?
SELECT COUNT(*)
FROM Application.People
WHERE PreferredName = 'Eva'
   OR PreferredName = 'Vlatka'
;

SELECT COUNT(*)
FROM Application.People
WHERE PreferredName IN('Eva','Vlatka')
;
-- Answer: 3 customers called either Eva or Vlatka.


-- DEMO: QUESTION 027
-- How many invoices have between 2 and 4 dry items, inclusive?
SELECT COUNT(*)
FROM Sales.Invoices
WHERE TotalDryItems BETWEEN 2 AND 4
;
-- Answer: 158,087 invoices with between 2 and 4 dry items.


-- DEMO: QUESTION 028
-- Extract all customers with the string "Wingtip" somewhere in their name.
SELECT *
FROM Sales.Customers
WHERE CustomerName LIKE '%Wingtip%'
;

SELECT *
FROM Sales.Customers
WHERE UPPER(CustomerName) LIKE '%WINGTIP%'
;

-- NOTE: If the results were case senstivie, then we can use the UPPER function to improve our search.


-- DEMO: QUESTION 029
-- SELECT the CustomerName column from the Sales.Customers table where the credit limit is missing.
SELECT CustomerName
FROM Sales.Customers
WHERE CreditLimit IS NULL
;


-- DEMO: QUESTION 030
-- SELECT the CustomerName column from the Sales.Customers table where the credit limit is not missing.
SELECT CustomerName
FROM Sales.Customers
WHERE CreditLimit IS NOT NULL
;

-------------------------------------------------------------------------------------------------------

-- QUESTION 031
-- How many customers are there with *CustomerCategoryID* = 6 and a credit limit greater than 2000?


-- QUESTION 032
-- How many customers have a credit limit between 2000 and 5000 (inclusive)?


-- QUESTION 033
-- How many people in the Application.People table whose preferred name begins with M?


-- QUESTION 034
-- How many people use a preferred name from the folling list:
-- ('Eva','Vlakta','Odessa','Bharat')?


-- QUESTION 035
-- How many people in the Application.People table whose preferred name ends with Y?


-- QUESTION 036
-- How many suppliers do not have an assigned delivery method?
-- i.e. *DeliveryMethodID* is missing



-------------------------------------------------------------------------------------------------------
-- SECTION 5 - aggregate functions
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 037
-- What is the minimum, maximum, sum, and mean of *TransactionAmount* in Sales.CustomerTransactions?
SELECT COUNT(TransactionAmount)
FROM Sales.CustomerTransactions
;
-- Answer: 304,991 transactions
SELECT MIN(TransactionAmount)
FROM Sales.CustomerTransactions
;
-- Answer: Minimum = -183,781.37
SELECT MAX(TransactionAmount)
FROM Sales.CustomerTransactions
;
-- Answer: Minimum = 38,076.50
SELECT SUM(TransactionAmount)
FROM Sales.CustomerTransactions
;
-- Answer: Total = 132,642.24
SELECT AVG(TransactionAmount)
FROM Sales.CustomerTransactions
;
-- Answer: Average = 0.434905


-- DEMO: QUESTION 038
-- Use the MIN and MAX functions to find the customers alphabetically.
SELECT MIN(CustomerName)
FROM Sales.Customers
;
-- Answer: Aakriti Byrraju is the first customer alphabetically
SELECT MAX(CustomerName)
FROM Sales.Customers
;
-- Answer: Zoltan Gero is the last customer alphabetically


-- DEMO: QUESTION 039
-- Create a single output which includes
-- the minimum, maximum, sum, and mean of *TransactionAmount* in Sales.CustomerTransactions.
-- Use aliases to give each column a sensible name.
SELECT
	COUNT(TransactionAmount) AS NumberOfTransactions,
	MIN(TransactionAmount) AS MinTranxAmount,
	MAX(TransactionAmount) AS MaxTranxAmount,
	SUM(TransactionAmount) AS TotalAmount,
	AVG(TransactionAmount) AS AvgTranxAmount
FROM Sales.CustomerTransactions
;

-------------------------------------------------------------------------------------------------------

-- QUESTION 040
-- What is the minimum, maximum, sum, and mean of quantity in Warehouse.StockItemTransactions?


-- QUESTION 041
-- Use the Warehouse.StockItemTransactions table again.
-- Create a single output which includes
-- the minimum, maximum, sum, and mean of quantity.
-- Use aliases to give each column a sensible name.


-- QUESTION 042
-- Within the Sales.CustomerTransactions table, does the amount tend to be larger
-- for transactions where TransactionTypeID is 1 or where TransactionTypeID = 3?



-------------------------------------------------------------------------------------------------------
-- SECTION 6 - creating, removing and updating tables
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 043
-- Create a table named *Table1* with a single column called *Column1*.
CREATE TABLE LearnerDB.dbo.Table1 (
	Column1 VARCHAR(250)
);


-- DEMO: QUESTION 044
-- Remove your new table.
DROP TABLE LearnerDB.dbo.Table1;


-- DEMO: QUESTION 045
-- Create a table named *Table2* with text, numeric and date columns.
CREATE TABLE LearnerDB.dbo.Table2 (
	Column1 VARCHAR(250),
	Column2 INT,
	Column3 DATE
);


-- DEMO: QUESTION 046
-- Create a table named *Table3* containing a duplicate of the Sales.Customers table from the WWI database.
SELECT *
INTO LearnerDB.dbo.Table3
FROM Sales.Customers
;
-- NOTE: Remember that we need to set the default database to WorldWideImporters using the USE command for this to work.


-- DEMO: QUESTION 047
-- Create a table named *Table4* containing only customers with names beginning with M.
SELECT *
INTO LearnerDB.dbo.Table4
FROM Sales.Customers
WHERE CustomerName LIKE 'M%'
;


-- DEMO: QUESTION 048
-- Add more records to Table4 to also include all customers with names beginning with W.
INSERT INTO LearnerDB.dbo.Table4
SELECT *
FROM Sales.Customers
WHERE CustomerName LIKE 'W%'
;


-- DEMO: QUESTION 049
-- We are going to create a new customer category for all the Wingtip Toys customers...
-- Change the *CustomerCategoryID* to 99 for any customers whose name starts with "Wingtip Toys".
UPDATE LearnerDB.dbo.Table4
SET CustomerCategoryID = 99
WHERE CustomerName LIKE 'Wingtip Toys%'
;
-- NOTE: Many databases have safeguards in-built to ensure that you don't change all the data accidentally.
--       For example, it may not be possible to run an update statement without a WHERE clause.

-------------------------------------------------------------------------------------------------------

-- QUESTION 050
-- Create a table named *Table5* with columns in the following formats:
-- DECIMAL(8,2), INT, VARCHAR(10), CHAR(10), TIMESTAMP


-- QUESTION 051
-- Create a table containing people named in the list ('Eva','Vlakta','Odessa','Bharat').


-- QUESTION 052
-- Add to the table you created for Question 051
-- any people who are marked as *IsSalesPerson* = 1 in Application.People


-- QUESTION 053
-- Change *IsSalesPerson* to 1 for all people in your new table who are not currently flagged that way.


-- QUESTION 054
-- Remove the table you created with *IsSalesPerson* = 1 from the database.



-------------------------------------------------------------------------------------------------------
-- SECTION 7 - sorting data with ORDER BY
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 055
-- Use the ORDER BY command to sort customers alphabetically by name.
-- Which are the first 3 names alphabetically?
SELECT CustomerName
FROM Sales.Customers
ORDER BY CustomerName
;
-- Answer: Aakriti Byrraju, Aarti Kommineni, Aasaajyoeti Bhogireddy


-- DEMO: QUESTION 056
-- Sort the records in Sales.CustomerTransactions FROM the largest amount to the least.
-- What is the size of the 5th largest transaction?
SELECT *
FROM Sales.CustomerTransactions
ORDER BY TransactionAmount DESC
;
-- Answer: 34776.00 is the 5th largest transaction amount.


-- DEMO: QUESTION 057
-- Output 1 record for the customer whose first name comes first alphabetically.
SELECT TOP 1 *
FROM Sales.Customers
ORDER BY CustomerName
;

-------------------------------------------------------------------------------------------------------

-- QUESTION 058
-- What are the first 3 countries in the World Wide Importers database alphabetically?


-- QUESTION 059
-- Extract data for the top 15 transactions in Warehouse.StockItemTransactions
-- when ordered by their quantity, in descending order.
-- Only output the StockItemTransactionID, TransactionOccurredWhen, and Quantity columns.


-- QUESTION 060
-- First sort all transactions in Warehouse.StockItemTransactions by SupplierID.
-- But also sort by quantity, in descending order, to break any ties.


-- QUESTION 060
-- First sort all transactions in Warehouse.StockItemTransactions by SupplierID.
-- But also sort by quantity, in descending order, to break any ties.
-- Remove any missing SupplierIDs from your results.


-- QUESTION 061
-- Which StockItemTransactionID is listed first if you repeat the Question 060
-- but convert Quantity into text data before sorting?
-- You can use CAST(column AS VARCHAR(10)) to achieve this conversion.


-- QUESTION 062
-- What are the first 3 state provinces alphabetically within the "Great Lakes" sales territory?



-------------------------------------------------------------------------------------------------------
-- SECTION 8 - aggregating with GROUP BY
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 063
-- Aggregate the data in the Sales.Customers table, by *CustomerCategoryID*.
-- Create a column with the number of records for each *CustomerCategoryID*.
-- Which category is most common?
SELECT
	CustomerCategoryID,
	COUNT(*) AS frequency
FROM Sales.Customers
GROUP BY CustomerCategoryID
;
-- Answer: Category 3 is most common.


-- DEMO: QUESTION 064
-- Create a table summarising the average transaction amount for each customer.
-- Output one row for each *CustomerID*.
SELECT
	CustomerID,
	AVG(TransactionAmount) AS AvgTranxAmount
FROM Sales.CustomerTransactions
GROUP BY CustomerID
;


-- DEMO: QUESTION 065
-- Aggregate the Application.People table by *IsEmployee* and *IsPermittedToLogon*.
-- Create a column showing the total number of records for each combination.
-- Also create a column showing the first *FullName* alphabetically for each combination.
SELECT
	IsEmployee,
	IsPermittedToLogon,
	COUNT(*) AS Frequency,
	MIN(FullName) AS FirstNameAlphabetically
FROM Application.People
GROUP BY
	IsEmployee,
	IsPermittedToLogon
;
-- Looks like Eva Muirden is the only employee not allowed to log on!
-- Perhaps she is on a disciplinary.

-------------------------------------------------------------------------------------------------------

-- QUESTION 066
-- Aggregate the data in the Application.StateProvinces, by SalesTerritory.
-- Create a column with the number of records for each SalesTerritory.


-- QUESTION 067
-- Create a table showing the most recent order
-- for each salesperson in the Sales.Orders table.


-- QUESTION 068
-- Create a table based on the Sales.Customers table which shows
-- the number of customers whose name begins with each letter of the alphabet
-- Each record in the output should correspond to a different letter.
-- This should require using the SUBSTRING function.



-------------------------------------------------------------------------------------------------------
-- SECTION 9 - combine GROUP BY with other commands
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 069
-- Which CustomerID has made the most transactions?
SELECT
	CustomerID,
	COUNT(*) AS TotalTransactions
FROM Sales.CustomerTransactions
GROUP BY CustomerID
ORDER BY COUNT(*) DESC
;
-- Answer: Customer ID 1 (66,858 transactions!)


-- DEMO: QUESTION 070
-- How much did that customer spend in total?
SELECT
	CustomerID,
	COUNT(*) AS TotalTransactions,
	SUM(TransactionAmount) AS TotalTranxAmount
FROM Sales.CustomerTransactions
GROUP BY CustomerID
ORDER BY COUNT(*) DESC
;
-- Answer: 34319.11


-- DEMO: QUESTION 071
-- List the customers who have spent more than 3000 in total.
-- How many customers have spent more than 3000?
SELECT
	CustomerID,
	COUNT(*) AS TotalTransactions,
	SUM(TransactionAmount) AS TotalTranxAmount
FROM Sales.CustomerTransactions
GROUP BY CustomerID
HAVING SUM(TransactionAmount) > 3000
;
-- Answer: 6 customers

-------------------------------------------------------------------------------------------------------

-- QUESTION 072
-- Create a table which lists each customer_id,
-- alongside their maximum payment in the payment table.
-- Order this list according to those maximum payments.


-- QUESTION 073
-- Which CustomerID has the highest average transaction amount?


-- QUESTION 074
-- List the customer_ids with an average transaction amount more than 5.
-- How many records are returned?


-- QUESTION 075
-- Which *CustomerCategoryID* tends to have the highest credit limit?
-- Which *CustomerCategoryID* has the customer with the absolute highest credit limit?


-- QUESTION 076
-- How many cities are home to more than one customer?


-- QUESTION 077
-- What is the most common starting letter of all the customer names? Second most common?
-- Each record in the output should correspond to a different letter.
-- This should require using the SUBSTRING function.


-- QUESTION 078
-- What is the name of the customer who accounts for the second most transactions in the Sales.CustomerTransactions table?
-- This may require multiple steps and exploring multiple different tables.



-------------------------------------------------------------------------------------------------------
-- SECTION 10 - working with dates
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 079
-- Which day of the year features the most highest total sales in the Sales.CustomerTransactions table?
SELECT
	DATEPART(weekday, TransactionDate) as DayOfTheWeek,
	SUM(TransactionAmount) AS TotalAmount
FROM Sales.CustomerTransactions
GROUP BY DATEPART(weekday, TransactionDate)
ORDER BY SUM(TransactionAmount) DESC
;
-- Answer: 2 = Tuesday


-- DEMO: QUESTION 080
-- List the records in the Sales.CustomerTransactions table which were first updated in the year 2020.
-- Use the *LastEditedWhen* column.
SELECT
	*
FROM Sales.CustomerTransactions
WHERE LastEditedWhen >= '2020-01-01 00:00:00'
ORDER BY LastEditedWhen
;
-- OR
SELECT
	*
FROM Sales.CustomerTransactions
WHERE DATEPART(year, LastEditedWhen) >= 2020
ORDER BY LastEditedWhen
;

-------------------------------------------------------------------------------------------------------

-- QUESTION 081
-- How many records in the Purchasing.PurchaseOrders table were edited between 1300 and 1400?



-------------------------------------------------------------------------------------------------------
-- SECTION 11 - combining tables with JOINs
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 082
-- Join the *CityName* column FROM Application.Cities onto the Sales.Customers table.
SELECT
	Cities.CityName,
	Customers.*
FROM Sales.Customers
LEFT JOIN Application.Cities ON Customers.DeliveryCityID = Cities.CityID
;


-- DEMO: QUESTION 083
-- Join the StateProvinceName column onto the customer table.
SELECT
	StateProvinces.StateProvinceName,
	Cities.CityName,
	Customers.*
FROM Sales.Customers
LEFT JOIN Application.Cities ON Customers.DeliveryCityID = Cities.CityID
LEFT JOIN Application.StateProvinces ON Cities.StateProvinceID = StateProvinces.StateProvinceID
;


-- DEMO: QUESTION 084
-- Join country onto the address table.
SELECT
	Countries.CountryName,
	StateProvinces.StateProvinceName,
	Cities.CityName,
	Customers.*
FROM Sales.Customers
LEFT JOIN Application.Cities ON Customers.DeliveryCityID = Cities.CityID
LEFT JOIN Application.StateProvinces ON Cities.StateProvinceID = StateProvinces.StateProvinceID
LEFT JOIN Application.Countries ON StateProvinces.CountryID = Countries.CountryID
;


-- DEMO: QUESTION 085
-- Join country onto the address table using aliases for each table
SELECT
	cn.CountryName,
	sp.StateProvinceName,
	ct.CityName,
	cu.*
FROM Sales.Customers cu
LEFT JOIN Application.Cities ct ON cu.DeliveryCityID = ct.CityID
LEFT JOIN Application.StateProvinces sp ON ct.StateProvinceID = sp.StateProvinceID
LEFT JOIN Application.Countries cn ON sp.CountryID = cn.CountryID
;

-------------------------------------------------------------------------------------------------------

-- QUESTION 086
-- Join the name of the payment method onto the Sales.CustomerTransactions table.


-- QUESTION 087
-- Join the name of the payment method onto the Sales.CustomerTransactions table...
-- along with the DeliveryInstructions from the Sales.Invoices table.


-- QUESTION 088
-- Create a list of all combinations of customer name and the sales persons for each of their invoices.
-- You can use Sales.Invoices as the base table but the final result should only include columns
-- about CustomerIDs, customer names, PeopleIDs, and people names.



-------------------------------------------------------------------------------------------------------
-- SECTION 12 - using JOINs with other commands
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 089
-- What are the names of the 10 customers who have spent the most in the Sales.CustomerTransactions table?
SELECT
	cust.CustomerName,
	SUM(ctran.TransactionAmount) AS TotalSpend
FROM Sales.CustomerTransactions ctran
LEFT JOIN Sales.Customers cust ON ctran.CustomerID = cust.CustomerID
GROUP BY
	cust.CustomerName
ORDER BY SUM(ctran.TransactionAmount) DESC
;
-- Answer: Wingtip Toys (Head Office), Tailspin Toys (Head Office), Liidia Lepp, Som Mukherjee, Pari Hosseini, Ajitaab Pakalapati, Kashi Singh, Bhaavan Rai, Aruna Cheema, Flynn Moresby

-- -----------------------------------------------------------------------------------------------------

-- QUESTION 090
-- Produce a summary showing the number of customers per *CustomerCategoryName*.
-- Your output should show the number of customers in each category and the number of different cities the customers are from.


-- QUESTION 091
-- What are the names of the cities with more than 1 customer?


-- QUESTION 092
-- What is the name of the States/Provinces with the customers who have spent the highest amount in total since April 1st 2021?
-- You should include the *StateProvinceID*, the *StateProvinceName*, and the *SalesTerritory* in your result.
-- You should report both the total transaction amount and the total tax.


-- QUESTION 093
-- What is the name of the sales person responsible for the most customer transactions
-- where the person doing the packing was "Taj Shand".


-- QUESTION 094
-- What is the name of the sales person responsible for the most customer transactions
-- where the salesperson did their own packing.


-- QUESTION 094
-- Which sales person is responsible for selling to the most distinct customers who are not Wingtip or Tailspin franchises?



-------------------------------------------------------------------------------------------------------
-- SECTION 13 - using sub-queries and CTEs
-------------------------------------------------------------------------------------------------------

-- DEMO: QUESTION 095
-- Using a sub-query, write a query to return the average, minimum, and maximum
-- number of distinct customers in each State/Province.
-- For example, the average State/Province has M distinct customers; the maximum distinct customers a State/Province has is N; etc.
-- Your result should include the name of each State/Province.
SELECT
	AVG(x.DistinctCustomers) AS Avg_DistinctCustomers,
	MIN(x.DistinctCustomers) AS Min_DistinctCustomers,
	MAX(x.DistinctCustomers) AS Max_DistinctCustomers
FROM (
	SELECT
		sp.StateProvinceName,
		COUNT(DISTINCT cust.CustomerID) AS DistinctCustomers
	FROM Sales.Customers cust
	LEFT JOIN Application.Cities ct ON cust.DeliveryCityID = ct.CityID
	LEFT JOIN Application.StateProvinces sp ON ct.StateProvinceID = sp.StateProvinceID
	GROUP BY sp.StateProvinceName
) x
;
-- Answer: Average = 15; Minimum = 1; Maximum = 54


-- DEMO: QUESTION 096
-- Using a CTE, write a query to return the average, minimum, and maximum
-- number of distinct customers in each State/Province.
-- For example, the average State/Province has M distinct customers; the maximum distinct customers a State/Province has is N; etc.
-- Your result should include the name of each State/Province.
WITH
DistinctCustomersPerStateProvince AS (
	SELECT
		sp.StateProvinceName,
		COUNT(DISTINCT cust.CustomerID) AS DistinctCustomers
	FROM Sales.Customers cust
	LEFT JOIN Application.Cities ct ON cust.DeliveryCityID = ct.CityID
	LEFT JOIN Application.StateProvinces sp ON ct.StateProvinceID = sp.StateProvinceID
	GROUP BY sp.StateProvinceName
)
SELECT
	AVG(DistinctCustomers) AS Avg_DistinctCustomers,
	MIN(DistinctCustomers) AS Min_DistinctCustomers,
	MAX(DistinctCustomers) AS Max_DistinctCustomers
FROM DistinctCustomersPerStateProvince
;
-- Answer: Average = 15; Minimum = 1; Maximum = 54

-------------------------------------------------------------------------------------------------------

-- QUESTION 097
-- Using a sub-query, find the amount of the total amount spent by each customer
-- on the most recent date when they made a transaction.
-- The final table should have columns named *CustomerID*, *MostRecentDate*, *TotalTranxAmount*


-- QUESTION 098
-- Using a CTE, find the amount of the total amount spent by each customer
-- on the most recent date when they made a transaction.
-- The final table should have columns named *CustomerID*, *MostRecentDate*, *TotalTranxAmount*



-------------------------------------------------------------------------------------------------------
-- SECTION 14 - challenges!!
-------------------------------------------------------------------------------------------------------

-- QUESTION 099
-- The sales manager for Wide World Importers has come to you with a specific request.
-- A member of the sales team, Taj Shand, is asking for a higher annual bonus on the basis
-- of their contribution to overall sales, especially in the priority sales territories.
-- The sales manager has asked you to calculate the proportion of transactions that
-- Taj Shand (sales person) is responsible for in each Sales Territory.
-- You may need to use the CAST function to ensure that your "percentage" column has the correct data format.


-- QUESTION 100
-- Energy prices have risen and Wide World Importers need to consider
-- whether to continue offering chilled items, as the chiller units
-- require large amounts of energy to maintain at the correct temperature.
-- What will the impact be on profit if WWI stops selling chilled items?
-- What is the value (at cost price) of the stock in the warehouse
-- that will no longer be sold?
-- The Wingtip organsiation have said that they would be willing to
-- subsidise the energy costs to continue receiving chilled items, but
-- only if they get exclusivity (i.e. all other customers would not receive
-- chilled items). How would this affect the analysis?
