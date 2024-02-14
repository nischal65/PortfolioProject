--Exercise 1:

--Select the first 3,000 rows from the Person.Person table. 
--Display only the Title, LastName, and FirstName columns, in that order.


SELECT TOP (3000) Title,LastName,FirstName
  FROM AdventureWorks2022.Person.Person;


--Exercise 2:

--Select the first 500 rows from the Sales.SalesOrderHeader table.
--Display only the OrderDate, DueDate, ShipDate, and TotalDue columns, in that order.



SELECT TOP (500) OrderDate, DueDate, ShipDate, TotalDue
  FROM AdventureWorks2022.Sales.SalesOrderHeader;


--Exercise 3:

--Select the first 100 rows from the Sales.SalesPerson table.
--Display only the SalesLastYear and SalesYTD columns, in that order.


SELECT TOP (100) SalesLastYear, SalesYTD
  FROM AdventureWorks2022.Sales.SalesPerson;
  
  
   --Aliasing a column name in SQL
/*
Modify the query in the “Aliasing Columns – Example Code.sql” file 
such that all column names in the query output have spaces between the words.
*/
SELECT [Organization Level] = [OrganizationLevel],JobTitle,HireDate, VacationHours  
FROM AdventureWorks2022.HumanResources.Employee; 

--Exercise 2:
/*
Write a query that outputs the “Name” and “ListPrice” fields from the “Production.Product” table. 
These column names in the query output should read “Product Name” and “List Price $$”, respectively.
*/

SELECT 
       [Product Name] = [Name]
      ,[List Price $$] = [ListPrice]

FROM AdventureWorks2022.Production.Product;


--Exercise 3:
/*
Write a query that outputs the “PurchaseOrderID”, “OrderQty”, and “LineTotal” fields 
from the “Purchasing.PurchaseOrderDetail” table. 
“PurchaseOrderID” should be renamed to “OrderID”, and “OrderQty” to “OrderQuantity”. 
“LineTotal” can remain unchanged.
*/

SELECT 
       [OrderID] = [PurchaseOrderID]
      ,[OrderQuantity] = [OrderQty]
      ,LineTotal
FROM AdventureWorks2022.Purchasing.PurchaseOrderDetail;

/*Selecting a literal value*/

--Exercise 1
/*
Write a query that selects your first name and age.
Name the columns “First Name”, and “Age”, respectively.
*/

SELECT 
[Name] = 'Travis',
[Age] = 29; --Age shown may not actually be real age :-)


--Exercise 2:
/*
Write a query that outputs:
•	All columns from the Sales.SalesOrderHeader table EXCEPT “rowguid” and “ModifiedDate”.
•	A column called “Query Run By” that outputs your first name. 
    This should be the first column in the query output.
The query should only output the top 5000 rows from the table.
*/

SELECT TOP (5000) [Query Run By] = 'Travis', SalesOrderID, 
RevisionNumber, OrderDate,DueDate, 
ShipDate, Status, OnlineOrderFlag, 
SalesOrderNumber,PurchaseOrderNumber,
AccountNumber,CustomerID, SalesPersonID,
TerritoryID, BillToAddressID, ShipToAddressID,
ShipMethodID,CreditCardID ,CreditCardApprovalCode,
CurrencyRateID, SubTotal, TaxAmt, Freight, TotalDue, Comment
FROM AdventureWorks2022.Sales.SalesOrderHeader;


/*Applying criteria to a text field*/

--Exercise 1:
/*
Select any rows from the “Person.Person” table where the value in the “FirstName” column is “Pilar”.
Include all columns EXCEPT “BusinessEntityID”, “rowguid”, AND “ModifiedDate” in your output.
*/


SELECT [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [FirstName] = 'Pilar'
;

--Exercise 2:
/*
Select any rows from the “Purchasing.Vendor” table 
where the value in the “Name” column is “Northwind Traders”. 
Include all columns EXCEPT “BusinessEntityID” and “ModifiedDate” in your output.
*/


SELECT [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]

FROM [AdventureWorks2022].[Purchasing].[Vendor]

WHERE [Name] = 'Northwind Traders';

/*Applying criteria to a numeric field*/


--Exercise 3:
/*
Modify your query from Exercise 2 by commenting out the WHERE statement,
and then adding a new criterion that filters for preferred vendors only – 
that is to say, where the value in the “PreferredVendorStatus” column is 1.
*/


SELECT
       [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]

FROM [AdventureWorks2022].[Purchasing].[Vendor]

--WHERE [Name] = 'Northwind Traders'
WHERE [PreferredVendorStatus] = 1;

SELECT 
	   [BusinessEntityID]
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

WHERE [SalariedFlag] = 0;


/*Inequality example*/

SELECT [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[rowguid]
      ,[ModifiedDate]
	  
FROM [AdventureWorks2022].[Sales].[SalesPerson]

WHERE [SalesQuota] != 250000;

/*
Exercise 1:
Select any records from the “Person.Person” where the person type is not equal to “IN”.
Do not include the “BusinessEntityID” and “rowguid” fields in your output.
*/

SELECT 
       [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[ModifiedDate]

FROM [AdventureWorks2022].[Person].[Person]

WHERE PersonType != 'IN';



/*Using IS NULL*/

SELECT [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[rowguid]
      ,[ModifiedDate]
	  
FROM [AdventureWorks2022].[Sales].[SalesPerson]

WHERE [SalesQuota] IS NULL;

/*
Exercise 2:
Select all people from the “Person.Person” who do NOT have a middle name listed.
Do not include the “BusinessEntityID” and “rowguid” fields in your output.
*/

SELECT 
       [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[ModifiedDate]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [MiddleName] IS NULL;


/*Using IS NOT NULL*/

SELECT [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[rowguid]
      ,[ModifiedDate]
	  
FROM [AdventureWorks2022].[Sales].[SalesPerson]

WHERE [SalesQuota] IS NOT NULL;


/*
Exercise 3:
Select all people from the “Person.Person” who have a “Title”.
Do not include the “BusinessEntityID” and “rowguid” fields in your output.
*/

SELECT 
       [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[ModifiedDate]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [Title] IS NOT NULL;


/*Combining inequalities and NULLs*/

SELECT [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[rowguid]
      ,[ModifiedDate]
	  
FROM [AdventureWorks2022].[Sales].[SalesPerson]

WHERE [SalesQuota] != 250000 OR [SalesQuota] IS NULL;


/*
Excercise 4
Select all people from the “Person.Person” who do NOT have a title of “Mr.”. 
Make sure to include NULL values in your result.
*/


SELECT 
       [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[ModifiedDate]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [Title] != 'Mr.' OR [Title] IS NULL;


/*Example with AND*/

SELECT [BusinessEntityID]
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

  WHERE [JobTitle] = 'Sales Representative'
  AND [MaritalStatus] = 'S';


  /*
Exercise 1:

Select all people from the “Person.Person” table with a first name of “Laura” 
and a last name of “Norman”. Include only the following columns in your output:

•	PersonType
•	Title
•	FirstName
•	LastName

*/

SELECT 
       [PersonType]
      ,[Title]
      ,[FirstName]
      ,[LastName]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [FirstName] = 'Laura'
	AND [LastName] = 'Norman';



/*Example with OR*/


  SELECT
       [BusinessEntityID]
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

  WHERE [JobTitle] = 'Sales Representative'
  OR [MaritalStatus] = 'S';

  
	/*
Exercise 2:

Modify your query from Exercise 1 as follows:

Change your criteria to only look for records where the person type is either “SP” OR “EM”.
*/

SELECT 
       [PersonType]
      ,[Title]
      ,[FirstName]
      ,[LastName]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [PersonType] = 'SP'
	OR [PersonType] = 'EM'
	OR [PersonType] = 'VC';


/*Example with IN*/


  SELECT
       [BusinessEntityID]
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

  WHERE [JobTitle] IN('Senior Tool Designer', 'Research and Development Engineer', 'Senior Design Engineer');

  /*
Exercise 3:

Streamline your WHERE statement from Exercise 2 by utilizing the IN keyword.
*/

SELECT 
       [PersonType]
      ,[Title]
      ,[FirstName]
      ,[LastName]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [PersonType] IN('SP', 'EM', 'VC');

/* Use of Parantheses*/

/*
Exercise 1:

Select all rows from the "HumanResources.Employee" table where gender = "F", 
AND the job title is either "Network Manager" or "Application Specialist". 
Select all columns using the "SELECT *" shortcut.
*/

SELECT
*

FROM [AdventureWorks2022].[HumanResources].[Employee]

WHERE [Gender] = 'F'
	AND ([JobTitle] = 'Network Manager' OR [JobTitle] = 'Application Specialist');


/*
Exercise 2:

Streamline your query from Exercise 1 by using an IN statement to replace the OR. 
Try running the modified query without parentheses to see if it still works.
*/

SELECT
*

FROM [AdventureWorks2022].[HumanResources].[Employee]

WHERE [Gender] = 'F'
	AND [JobTitle] IN('Network Manager','Application Specialist');


/*
Exercise 3:

Select all rows from the "Person.Person" table where person type = "EM", 
AND there is a NULL value in either the "Title" or "MiddleName" fields. 
Include the following fields in your query:

 - PersonType (aliased as "Person Type")

 - Title

 - FirstName (aliased as "First Name")

 - MiddleName (aliased as "Middle Name")

 - LastName (aliased as "Last Name")

 - Suffix
*/

SELECT
       [Person Type] = [PersonType]
      ,[Title]
      ,[First Name] = [FirstName]
      ,[Middle Name] = [MiddleName]
      ,[Last Name] = [LastName]
      ,[Suffix]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [PersonType] = 'EM'
	AND ([Title] IS NULL OR [MiddleName] IS NULL);

/*
BONUS:

Modify your query from Exercise 3 such that you are now selecting all rows 
where person type is either "EM" or "SP" AND there is a NULL value 
in either the "Title", "MiddleName", or "Suffix" fields.
*/

SELECT
       [Person Type] = [PersonType]
      ,[Title]
      ,[First Name] = [FirstName]
      ,[Middle Name] = [MiddleName]
      ,[Last Name] = [LastName]
      ,[Suffix]

FROM [AdventureWorks2022].[Person].[Person]

WHERE [PersonType] IN('EM','SP')
	AND ([Title] IS NULL OR [MiddleName] IS NULL OR [Suffix] IS NULL);



	/*Open-ended inequalities with >, <, >=, and <=*/

	SELECT TOP (1000) [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[SalesPerson]

  WHERE [SalesQuota] < 250000;
  --WHERE [SalesQuota] > 250000
  --WHERE [SalesQuota] <= 250000
  --WHERE [SalesQuota] >= 250000


  /*
Exercise 1:

Select all rows from the "Purchasing.PurchaseOrderHeader" table 
where the total due amount is greater than $50,000 and the freight amount is less than $1,000. 
Include the following columns in your output:

 - OrderDate
 - SubTotal
 - TaxAmt
 - Freight
 - TotalDue
*/

SELECT
       [OrderDate]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]

FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderHeader]

WHERE [TotalDue] > 50000
	AND [Freight] < 1000;

/*
Exercise 2:

Using the BETWEEN keyword, modify your query from Exercise 1 such that 
you are now pulling in all rows where the subtotal amount is between $10,000 and $30,000.
*/

SELECT
       [OrderDate]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]

FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderHeader]

WHERE [SubTotal] BETWEEN 10000 AND 30000;


/*Using the % wildcard*/

/*
Exercise 1:

Select all rows from the Person.Person table where 
the first name is abbreviated with a period/dot at the end - for example, "A.".

Select all columns via the "SELECT *" shortcut.
*/

SELECT
*
  
FROM [AdventureWorks2022].[Person].[Person]

WHERE [FirstName] LIKE '%.';

/*Pattern matching with brackets*/

SELECT [BusinessEntityID]
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

  WHERE [JobTitle] LIKE '%[0-9]%';


/*Using NOT LIKE with brackets*/

SELECT [BusinessEntityID]
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

  WHERE [JobTitle] NOT LIKE '%[0-9]%';

  /*
Exercise 3:

Select all rows from the Person.Person table where the first name 
does NOT include a vowel (a, e, i, o, or u). 
HINT - you do NOT need to use OR to accomplish this; try using a wildcard with brackets ([ ]) instead.

You may select all columns via the "SELECT *" shortcut.
*/

SELECT
*
  
FROM [AdventureWorks2022].[Person].[Person]

WHERE [FirstName] NOT LIKE '%[aeiou]%';


/*ORDER BY DESC*/
SELECT [SalesOrderID]
      ,[OrderDate]
      ,[TotalDue]

  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

  WHERE [TotalDue] > 10000

  ORDER BY [TotalDue] DESC;


  /*ORDER BY ASC*/
SELECT [SalesOrderID]
      ,[OrderDate]
      ,[TotalDue]

  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

  WHERE [TotalDue] > 10000

  ORDER BY [TotalDue] ASC; --Alternately, just use ORDER BY [TotalDue] here


/*ORDER BY referencing column alias*/
SELECT [SalesOrderID]
      ,[OrderDate]
      ,[Total Amount Due] = [TotalDue]

  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

  WHERE [TotalDue] > 10000

  ORDER BY [Total Amount Due] DESC;


/*ORDER BY referencing column position*/
SELECT [SalesOrderID]
      ,[OrderDate]
      ,[Total Amount Due] = [TotalDue]

  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

  WHERE [TotalDue] > 10000

  ORDER BY 3 DESC;



/*ORDER BY First Name ONLY*/

SELECT [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Person].[Person]

  ORDER BY [FirstName];



/*ORDER BY First Name and Last Name*/

SELECT [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Person].[Person]

  ORDER BY [FirstName], [LastName];


