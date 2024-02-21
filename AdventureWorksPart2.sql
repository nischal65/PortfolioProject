/*Selecting duplicate values from a column without SELECT DISTINCT*/

  SELECT 
       [JobTitle]

  FROM [AdventureWorks2022].[HumanResources].[Employee];


/*Selecting duplicate values from a column without SELECT DISTINCT, sorted*/

  SELECT 
       [JobTitle]

  FROM [AdventureWorks2022].[HumanResources].[Employee]

  ORDER BY 1;


/*Selecting unique column values with SELECT DISTINCT*/


  SELECT DISTINCT
       [JobTitle]

  FROM [AdventureWorks2022].[HumanResources].[Employee]

  ORDER BY 1;

  /*
Exercise 1:

Produce a list of the unique person types in the "Person.Person" table, sorted in ascending order.
*/
SELECT DISTINCT
      [PersonType]

FROM [AdventureWorks2022].[Person].[Person]

ORDER BY 1;


/*Using SELECT DISTINCT across multiple columns*/


  SELECT DISTINCT
       [FirstName]
      ,[LastName]
  FROM [AdventureWorks2022].[Person].[Person]

  ORDER BY 2,1;
  --ORDER BY 2,1

  /*
Exercise 2:

Produce a list of the unique full names in the "Person.Person" table - 
including first name, middle name, and last name. 
Only include names that have a value for middle name.

The output should be sorted by last name and then by first name, in ascending order.
*/

SELECT DISTINCT
       [FirstName]
	  ,[MiddleName]
	  ,[LastName]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [MiddleName] IS NOT NULL

ORDER BY 3, 1;


/*String concatenation: first and last name*/

SELECT 
       [FirstName]
      ,[LastName]
      ,[Full Name] = [FirstName] + ' ' + [LastName]
	  
FROM [AdventureWorks2022].[Person].[Person];

/*
Exercise 1:

Select a derived column from the "Person.Person" table - aliased as "Person Title" - 
that consists of the person's first name, followed by a space, followed by their last name, 
followed by a hyphen (-), followed by the person type.
*/

SELECT
      [Person Title] = [FirstName] + ' ' + [LastName] + '-' + [PersonType]


FROM [AdventureWorks2022].[Person].[Person];

/*Multiplication - Commission YTD*/

SELECT 
	  [CommissionPct],
	  [SalesYTD],
	   [CommissionYTD] = [CommissionPct] * [SalesYTD]

  FROM [AdventureWorks2022].[Sales].[SalesPerson];

  /*
Exercise 3:

Select all rows from the "HumanResources.EmployeePayHistory" table where "SalariedFlag" = 0. 
Include the following columns in your output:

 - BusinessEntityID
 - Rate
 - Amount Per Paycheck - This is a derived column you will calculate - assuming a 40 hour work week - using the employee pay rate from the "Rate" column, and pay frequency from the "PayFrequency" column.
*/

SELECT [BusinessEntityID]
      ,[Rate]
	  ,[Amount Per Paycheck] = ([Rate] * 40) * [PayFrequency]

FROM [AdventureWorks2022].[HumanResources].[EmployeePayHistory]

ORDER BY [Amount Per Paycheck] DESC;


/*Addition - Income YTD*/

SELECT 
	  [CommissionPct],
	  [SalesYTD],
	  [Bonus],
	  [CommissionYTD] = [CommissionPct] * [SalesYTD],
	  [IncomeYTD] = ([CommissionPct] * [SalesYTD]) + [Bonus]

  FROM [AdventureWorks2022].[Sales].[SalesPerson];

  /*
Exercise 2:

Select all rows from the "HumanResources.Employee" table where "SalariedFlag" = 0. 
Include the following columns in your output:

 - BusinessEntityID
 - VacationHours
 - SickLeaveHours
 - Total Time Off - This is a derived column you will calculate by adding vacation hours and sick leave hours
*/

SELECT [BusinessEntityID]
      ,[VacationHours]
      ,[SickLeaveHours]
	  ,[TotalTimeOff] = [VacationHours] + [SickLeaveHours]

FROM [AdventureWorks2022].[HumanResources].[Employee]

WHERE [SalariedFlag] = 0

ORDER BY [TotalTimeOff];



/*Subtraction - Sales Delta Year Over Year*/

SELECT 
       [SalesYTD]
      ,[SalesLastYear]
	  ,[Difference] = [SalesLastYear] - [SalesYTD]


  FROM [AdventureWorks2022].[Sales].[SalesPerson];


/*Division - Bonus Fairness*/

SELECT 
       [SalesYTD]
      ,[Bonus]
	  ,[Bonus %] = ([Bonus] / [SalesYTD]) * 100


  FROM [AdventureWorks2022].[Sales].[SalesPerson]

  ORDER BY 3;


/*Division - Handling Whole Numbers*/

SELECT 
       [SafetyStockLevel]
      ,[ReorderPoint]
      ,[ReorderPoint % SafetyStockLevel] = [ReorderPoint] / [SafetyStockLevel]
      ,[ReorderPoint % SafetyStockLevel FIXED] = [ReorderPoint] / ([SafetyStockLevel] * 1.0)

  FROM [AdventureWorks2022].[Production].[Product];


  /*LEFT Function*/

SELECT
	  [PhoneNumber],
      [Area Code] = LEFT([PhoneNumber], 3)
FROM [AdventureWorks2022].[Person].[PersonPhone]

WHERE [PhoneNumber] NOT LIKE '%(%';


/*RIGHT Function*/

SELECT 
      [AccountNumber],
      [Last 6] = RIGHT([AccountNumber], 6)

  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader];

  /*
Exercise 1:

Select the following columns (all rows) from the "Sales.CreditCard" table:

 - CardNumber
 - Last Four Digits - a derived column with just the last four digits of the credit card number
*/

SELECT 
        [CardNumber]
	   ,[Last Four Digits] = RIGHT([CardNumber], 4)

FROM [AdventureWorks2022].[Sales].[CreditCard];



/*LEN Function*/

SELECT
	  [PhoneNumber],
	  [Phone Number Length] = LEN([PhoneNumber])

 FROM [AdventureWorks2022].[Person].[PersonPhone]

WHERE LEN([PhoneNumber]) <= 12;


/*
Exercise 3:

Select the "FirstName" and "LastName" columns from the "Person.Person" table. 
Only include rows where the length of the last name is greater than or equal to 10 characters.
*/

SELECT 
		[FirstName]
       ,[LastName]

FROM [AdventureWorks2022].[Person].[Person]

WHERE LEN([LastName]) >= 10;


/*
Bonus:

Sort the output of Exercise 3 by the length of the last name in descending order. 
HINT - you can re-use the expression in your WHERE clause in your ORDER BY, even though it isn't included in the SELECT list!
*/

SELECT 
		[FirstName]
       ,[LastName]

FROM [AdventureWorks2022].[Person].[Person]

WHERE LEN([LastName]) >= 10

ORDER BY LEN([LastName]) DESC;


/*Changing Email Domains With REPLACE*/

SELECT 
      [EmailAddress],
	  [Modified Email Address] = REPLACE([EmailAddress], 'adventure-works', 'hotmail')

FROM [AdventureWorks2022].[Person].[EmailAddress];

/*
Exercise 2:

Select the following columns (all rows) from the "Production.ProductReview" table:

 - ReviewerName
 - Comments
 - Cleaned Comments - a derived column in which all commas from the "Comments" field have been replaced with empty strings
*/

SELECT 
       [ReviewerName]
      ,[Comments]
      ,[Cleaned Comments] = REPLACE([Comments], ',','')

FROM [AdventureWorks2022].[Production].[ProductReview];


/*Combining LEN and LEFT to extract a variable number of characters from the beginning of a string*/

SELECT [EmailAddress]
	  ,[User Name Length] = LEN([EmailAddress]) - 20
	  ,[User Name] = LEFT([EmailAddress], LEN([EmailAddress]) - 20)
FROM [AdventureWorks2022].[Person].[EmailAddress];


/*Padding IDs to 10 characters with leading zeros*/

SELECT 
      [NationalIDNumber],
	  [ID Length] = LEN([NationalIDNumber]),
	  [Padded ID] = RIGHT('0000000000' + [NationalIDNumber], 10)

FROM [AdventureWorks2022].[HumanResources].[Employee];



/*Replacing commmas and periods in a string*/
SELECT [Description],
      [No Commas] = REPLACE([Description], ',', ''),
	  [No Commas Or Periods] = REPLACE(REPLACE([Description], ',', ''), '.', '')

FROM [AdventureWorks2022].[Production].[ProductDescription];


/*Current date and time with GETDATE()*/

SELECT [Current Timestamp] =  GETDATE();

/*Adding an "as of" column with GETDATE()*/

SELECT 
	   [As of Date] = GetDate()
      ,[BusinessEntityID]
      ,[NationalIDNumber]
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[HumanResources].[Employee]
  ;

/*Creating a custom date with DATEFROMPARTS*/

SELECT [Custom Date] = DATEFROMPARTS(2020, 1,1);


/*Using dates in criteria*/

SELECT 
       [Order Year] = YEAR([OrderDate])
      ,[SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

  WHERE [OrderDate] < DATEFROMPARTS(2014, 1,1);
  --WHERE [OrderDate] >= DATEFROMPARTS(2014, 1,1)
  --WHERE [OrderDate] BETWEEN DATEFROMPARTS(2013, 1,1) AND DATEFROMPARTS(2013, 12, 31)
  --WHERE YEAR([OrderDate]) = 2013


/*Dynamically selecting the first day of the current month*/

SELECT [First Of Month] = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1);


/*Simple date math with GETDATE*/

SELECT GETDATE()
SELECT GETDATE() - 7;

/*Determining prior month BOM and EOM with DATEADD*/

SELECT 
      [Current Date] = GETDATE(),
	  [First Of Month] = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1),
	  [Last Day Previous Month] = DATEADD(DAY, -1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)),
	  [First Day Previous Month] = DATEADD(MONTH, -1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1));


/*Calculating elapsed time with DATEDIFF*/

SELECT 
       [OrderDate]
      ,[ShipDate]
	  ,[Elapsed Days] = DATEDIFF(DAY, [OrderDate], [ShipDate])

FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderHeader];

/*
Exercise 1:

Use date math in conjunction with GETDATE to calculate what date is 100 days from now.
*/

SELECT GETDATE() + 100
;

/*
Exercise 2:

Use DATEADD to calculate what date is 6 months from now.
*/

SELECT DATEADD(MONTH, 6, GETDATE());


/*
Exercise 3:

Use DATEDIFF to select all rows from the "Sales.SalesOrderHeader" table 
where the order date is 7 or less days before 12/25/2013. 
Note that it is possible for DATEDIFF to output a negative number 
if the "end" date is prior to your "start" date, 
so you may want to use BETWEEN instead of <= in your criteria.

You may select all columns via the SELECT * shorthand.
*/

SELECT
*

FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

WHERE DATEDIFF(DAY, [OrderDate], DATEFROMPARTS(2013,12,25)) BETWEEN 0 AND 7;


/*
Bonus:

Modify your query from Exercise 3 to work for ANY year, not just 2013. 
HINT - instead of hardcoding the year in your DATEFROMPARTS function, 
you will probably want to calculate the year based on the order date.
*/

SELECT *

FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

WHERE DATEDIFF(DAY, [OrderDate], DATEFROMPARTS(YEAR([OrderDate]),12,25)) BETWEEN 0 AND 7;


/*Integer division*/

SELECT 3 / 2;

/*Implicit conversion from integer type to decimal type*/

SELECT 3 / (2 * 1.0);


/*Converting decimal data to integer data with CAST*/

SELECT 
       [TotalDue]
       ,[Total Due Truncated] = CAST([TotalDue] AS INT)

FROM [AdventureWorks2022].[Sales].[SalesOrderHeader];


/*Converting datetimes to dates*/

SELECT GETDATE() - 2222;

SELECT CAST(GETDATE() - 2222 AS DATE);


/*Using converted dates in the WHERE clause*/

SELECT 
       [OrderDate]
      
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

--WHERE [OrderDate] >= (GETDATE() - 2222)
WHERE [OrderDate] >= CAST(GETDATE() - 2222 AS DATE)

ORDER BY 1;


/*Casting a string as an int*/

SELECT CAST('123' AS INT);


/*Casting a string as date*/

SELECT CAST('2020-01-01' AS DATE);

/*
Exercise 1:

Calculate yesterday's date dynamically via GETDATE. 
Convert the value to a DATE datatype, such that it has no timestamp component.
*/

SELECT CAST(GETDATE()-1 AS DATE);


/*
Exercise 2:

Calculate the number of days between the current date and the end of the current year via DATEDIFF. 
Use the CAST function to create the end-of-year date.
*/

SELECT DATEDIFF(DAY, GETDATE(), CAST('2020-12-31' AS DATE));


/*
Exercise 3

Select all rows from the "Person.Person" table where the middle name is not NULL, AND either the title is not NULL OR the suffix is not NULL. Include the following columns:

 - Title
 - FirstName
 - MiddleName
 - LastName
 - Suffix
 - PersonID: a derived column created by combining the person type, a hyphen(-), 
	and the business entity ID, in that order.

HINT - you will need to convert the business entity ID to a VARCHAR 
in order for the concatenation to work. You do not necessarily need to specify the length - 
simply specifying VARCHAR (as opposed to, say, VARCHAR(100)) will work fine.
*/

SELECT
       [Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
	  ,[PersonID] = [PersonType] + '-' + CAST([BusinessEntityID] AS VARCHAR)

FROM [AdventureWorks2022].[Person].[Person]

WHERE [MiddleName] IS NOT NULL AND
	([Title] IS NOT NULL OR [Suffix] IS NOT NULL);


	/*Creating default text values with ISNULL*/

SELECT  
       [Title]
	  ,[Modified Title] = ISNULL([Title], 'No Title')
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]

FROM [AdventureWorks2022].[Person].[Person];


/*Handling NULLs in inequalities with ISNULL*/

SELECT 
       [SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      ,[SalesLastYear]

FROM [AdventureWorks2022].[Sales].[SalesPerson]

WHERE ISNULL([SalesQuota], 0) != 250000;

/*
Exercise 1:

Select all rows from the "Production.Product" table where the weight is less than 10 pounds. 
Make sure to include NULL values in your output, and use ISNULL to accomplish this.

Include the following columns in your output:

 - Name
 - Color
*/

SELECT
       [Name]
      ,[Color]

FROM [AdventureWorks2022].[Production].[Product]

WHERE ISNULL([Weight],0) < 10;


/*
Exercise 2:

Modify the "Color" field of your query from Exercise 1 such that 
NULL values are replaced with the word "None".
*/

SELECT
       [Name]
      ,[Color] = ISNULL([Color],'None')

FROM [AdventureWorks2022].[Production].[Product]

WHERE ISNULL([Weight],0) < 10;


/*UNION-ing similar data from different tables*/

SELECT 
	  [Order Type] = 'Customer Order',
	  [Order ID] = [SalesOrderID],
      [OrderDate],
	TotalDue

FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

WHERE YEAR([OrderDate]) = 2013

UNION

SELECT
	   [Order Type] = 'Vendor Order',
	   [Order ID] = [PurchaseOrderID],
       [OrderDate],
	TotalDue

FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderHeader]

WHERE YEAR([OrderDate]) = 2013;


/*UNION vs. UNION ALL*/


--UNION (no duplicates)
SELECT 
      [OrderDate]

FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

WHERE YEAR([OrderDate]) = 2013

UNION

SELECT
       [OrderDate]
	TotalDue

FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderHeader]

WHERE YEAR([OrderDate]) = 2013;


--UNION ALL (allows duplicates)
SELECT 
      [OrderDate]

FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

WHERE YEAR([OrderDate]) = 2013

UNION ALL

SELECT
       [OrderDate]
	TotalDue

FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderHeader]

WHERE YEAR([OrderDate]) = 2013;


/*
Exercise 1:

Write a query that selects all rows from the "Purchasing.PurchaseOrderDetail" table 
where the line total is greater than $10,000. Include the following columns in your output:

 - PurchaseOrderID
 - PurchaseOrderDetailID
 - OrderQty
 - LineTotal
*/

SELECT [PurchaseOrderID]
      ,[PurchaseOrderDetailID]
      ,[OrderQty]
      ,[LineTotal]
FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderDetail]

WHERE [LineTotal] > 10000;


/*
Exercise 2:

Write a similar query that selects all rows from the "Sales.SalesOrderDetail" table where 
the line total is greater than $10,000. Include the following columns in your output:

 - SalesOrderID
 - SalesOrderDetailID
 - OrderQty
 - LineTotal
*/

SELECT [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[OrderQty]
      ,[LineTotal]
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]

WHERE [LineTotal] > 10000;


/*
Exercise 3:

Combine the rows from your Exercise 1 and Exercise 2 queries by "stacking" them vertically. 
Make sure the similar fields from each table align. 
Alias the first two columns as "OrderID" and "OrderDetailID", respectively.
*/

SELECT [OrderID] = [PurchaseOrderID]
      ,[OrderDetailID] = [PurchaseOrderDetailID]
      ,[OrderQty]
      ,[LineTotal]
FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderDetail]

WHERE [LineTotal] > 10000

UNION

SELECT [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[OrderQty]
      ,[LineTotal]
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]

WHERE [LineTotal] > 10000;


/*
Exercise 4:

Add the following derived fields to your query; 
remember , you'll need to add them to both components of your query.
Sort the output of your query by line total in descending order.

 - "RunDate" - displays the current date
 - "OrderType" - this should display the string "Purchase" for purchase orders, 
	and "Sale" for sales orders.
*/

SELECT [OrderID] = [PurchaseOrderID]
      ,[OrderDetailID] = [PurchaseOrderDetailID]
      ,[OrderQty]
      ,[LineTotal]
	  ,[RunDate] = GETDATE()
	  ,[OrderType] = 'Purchase'
FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderDetail]

WHERE [LineTotal] > 10000

UNION

SELECT [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[OrderQty]
      ,[LineTotal]
	  ,[RunDate] = GETDATE()
	  ,[OrderType] = 'Sale'
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]

WHERE [LineTotal] > 10000

ORDER BY 4 DESC;



/*Basic CASE Statement*/

SELECT
[First Case] = 
	CASE
		WHEN 1 = 2 THEN 'A'
		WHEN 3 > 2 THEN 'B'
		WHEN 3 < 5 THEN 'C'
		ELSE 'D'
	END;


/*Applying the CASE Statement to categorizing job titles*/

SELECT [JobTitle],
[Job Category] = 
	CASE
		WHEN [JobTitle] LIKE '%Production%' THEN 'Production'
		WHEN [JobTitle] LIKE '%Officer%' THEN 'Management'
		WHEN [JobTitle] LIKE '%Manager%' THEN 'Management'
		WHEN [JobTitle] LIKE '%President%' THEN 'Management'
		ELSE 'Other'
	END

  FROM [AdventureWorks2022].[HumanResources].[Employee];


/*Applying the CASE statement to aging buckets*/

SELECT 
      [OrderDate],
	  [Current Date] = CAST('07-31-2013' AS DATE),
	  [Elapsed Days] = DATEDIFF(DAY, [OrderDate], CAST('07-31-2013' AS DATE)),
	  [Aging Bucket] =
		CASE
			WHEN DATEDIFF(DAY, [OrderDate], CAST('07-31-2013' AS DATE)) < 10 THEN '< 10 Days'
			WHEN DATEDIFF(DAY, [OrderDate], CAST('07-31-2013' AS DATE)) BETWEEN 10 AND 19 THEN '10-19 Days'
			ELSE '20+ Days'
		END

FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

WHERE [OrderDate] BETWEEN CAST('07-01-2013' AS DATE) AND CAST('07-31-2013' AS DATE);
