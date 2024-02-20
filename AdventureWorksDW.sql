/* WHAT IS TOTAL SALES? */

SELECT Sum(S.SalesAmount) as TotalSales
  FROM [AdventureWorksDW2022].[dbo].[FactInternetSales] S ;

/* WHAT IS TOTAL PROFIT? */
Select Sum(s.SalesAmount-s.TotalProductCost) as TotalProfit
from FactInternetSales S;

/* WHAT IS THE TOTAL COST AMOUNT */
Select Sum(s.TotalProductCost) as TotalCost
From FactInternetSales s;

/*What is the sales per year*/ ---Used AlternateDatekey
Select Year(d.FullDateAlternateKey) as SalesYear
from FactInternetSales S
Join DimDate d on S.OrderDateKey=d.DateKey
Group By Year(d.FullDateAlternateKey)
Order By SalesYear;

/* WHAT IS THE AVERAGE SALES PER CUSTOMER? */
Select C.CustomerKey, C.CustomerAlternateKey,
Avg(S.SalesAmount) AS AverageSalesPerCustomer
from FactInternetSales S
JOIN DimCustomer C on S.CustomerKey=C.CustomerKey
Group By C.CustomerKey, C.CustomerAlternateKey
Order By AverageSalesPerCustomer;

/*What is the number of Product in each Category */

Select PC.EnglishProductCategoryName, Count(P.ProductKey) AS NumberofProducts
FROM DimProduct P 
JOIN DimProductCategory PC on P.ProductKey =PC.ProductCategoryKey
Group BY PC.EnglishProductCategoryName
order by NumberofProducts DESC;

/*top 10 customers with highest purchase*/

SELECT TOP 10 C.CustomerKey, C.CustomerAlternateKey, SUM(S.SalesAmount) AS TotalPurchaseAmount
FROM FactInternetSales S 
JOIN DimCustomer C on S.CustomerKey=C.CustomerKey
GROUP BY C.CustomerKey, C.CustomerAlternateKey
order by TotalPurchaseAmount desc;

/*Top 10 customer with highest order*/

SELECT TOP 10 C.CustomerKey, C.CustomerAlternateKey, SUM(S.SalesOrderLineNumber) AS TotalOrders
FROM FactInternetSales S 
JOIN DimCustomer C on S.CustomerKey=C.CustomerKey
GROUP BY C.CustomerKey, C.CustomerAlternateKey
order by TotalOrders desc;

/*TOP 10 EMPLOYEE WITH HIGHEST SALE*/ ----NOT DONE
Select Top 10 E.EmployeeKey, E.EmployeeNationalIDAlternateKey
From FactInternetSales S
JOIN DimEmployee E ON S.EMPL=E.


/*TOP 10 MOST SOLD PRODUCT */

SELECT TOP 10 P.ProductKey, P.ProductAlternateKey, P.EnglishProductName AS ProductName,
sum(S.SalesAmount) as TotalSales
FROM FactInternetSales S 
JOIN DimProduct P ON S.ProductKey=P.ProductKey 
Group by P.ProductKey, P.ProductAlternateKey, P.EnglishProductName
Order by TotalSales Desc;


/*What is the total Customer? */

Select Count(CustomerKey) as TotalCustomers
from (
Select CustomerKey
From DimCustomer
gROUP BY CustomerKey )
AS UniqueCustomers;
---OR WE COULD USE DISTINCT FUNCTION 
Select count(distinct CustomerKey) AS TotalCustomers
from DimCustomer;

/* What is the total transaction? */
Select Count(*) as TotalTransactions
From FactInternetSales;

/*Distribution of Order*/
Select S.CustomerKey, Count(*) as OrderCount
From FactInternetSales S
Group BY CustomerKey
Order by OrderCount desc;

/*Ranking the customers by sales */

SELECT CustomerKey, CustomerAlternateKey, TotalSales, 
Rank() Over (order by TotalSales Desc) as SalesRank
from (SELECT C.CustomerKey, C.CustomerAlternateKey, SUM(S.SalesAmount) AS TotalSales
FROM FactInternetSales S 
JOIN DimCustomer C on S.CustomerKey=C.CustomerKey
GROUP BY C.CustomerKey, C.CustomerAlternateKey) as CustomerSales 
order by SalesRank ;



