/*use AdventureWorksDW; 
show tables; */ -- qui lavoriamo su questo datavase e lo visualizziamo

# Esercizi W6D4
-- 1.1 Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory)

/*SELECT prod.ProductKey, 
prod.EnglishProductName as Product,
prod.ListPrice,
subc.EnglishProductSubcategoryName as Subcatecory
from dimproduct as prod
LEFT JOIN dimproductsubcategory as subc
ON prod.ProductSubcategoryKey = subc.ProductSubcategoryKey
;*/

-- 1.2 Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria DimProduct, DimProductSubcategory, DimProductCategory

/*SELECT prod.ProductKey, 
prod.EnglishProductName as Product,
prod.ListPrice,
subc.EnglishProductSubcategoryName as Subcategory,
cat.EnglishProductCategoryName as category
from dimproduct as prod
LEFT JOIN dimproductsubcategory as subc
ON prod.ProductSubcategoryKey = subc.ProductSubcategoryKey
LEFT JOIN dimproductcategory as cat 
ON subc.ProductCategoryKey = cat.ProductCategoryKey;*/

-- 1.3 Esponi lʼelenco dei soli prodotti venduti DimProduct, FactResellerSales

/* SELECT prod.ProductKey,
prod.EnglishProductName as Product,
sales.OrderDate,
sales.OrderQuantity,
sales.SalesAmount
from dimproduct as prod
INNER JOIN factresellersales as sales
ON prod.ProductKey = sales.ProductKey;*/

#usando una SubQuery
/*SELECT ProductKey, EnglishProductName as Product from dimproduct as prod -- QUi prendendo tutti i nomi prodotti e Key prodotti
where ProductKey IN (Select ProductKey from factresellersales);*/ -- QUi prendendo tutti i nomi prodotti e Key prodotti VENDUTI

-- 1.4 Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1

/*SELECT ProductKey, FinishedGoodsFlag, EnglishProductName as Product from dimproduct as prod
where ProductKey NOT IN (Select ProductKey from factresellersales) and FinishedGoodsFlag = 1;*/

-- 1.5 Esponi lʼelenco delle transazioni di vendita FactResellerSales, indicando anche il nome del prodotto venduto DimProduct

/*select sales.SalesOrderNumber, sales.OrderDate, sales.OrderQuantity, sales.SalesAmount, prod.EnglishProductName as Product
from factresellersales as sales
INNER JOIN dimproduct as prod
ON sales.ProductKey = prod.ProductKey;*/

-- 2.1 Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

/*select sales.SalesOrderNumber, 
sales.OrderDate, 
sales.OrderQuantity, 
sales.SalesAmount,
cat.EnglishProductCategoryName as category, 
prod.EnglishProductName as Product
from factresellersales as sales
INNER JOIN dimproduct as prod
ON sales.ProductKey = prod.ProductKey 
LEFT JOIN dimproductsubcategory
ON prod.ProductSubcategoryKey = dimproductsubcategory.ProductSubcategoryKey
LEFT JOIN dimproductcategory as cat 
ON dimproductsubcategory.ProductCategoryKey = cat.ProductCategoryKey;*/

-- 2.2 Esplora la tabella DimReseller

/*USE AdventureWorksDW; 
SELECT dimreseller
SHOW TABLES;*/

-- 2.3 Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 

/*SELECT res.ResellerKey
res.BusinessType,
res.ResellerName,
geo.EnglishCountryRegionName
FROM dimiresseler AS res
LEFT JOIN dimgeography AS geo
ON re.GeographyKey = geo.GeographyKey*/

-- 2.4 Esponi lʼelenco delle transazioni di vendita. Esporre dei campi e indicare il nome prodotto, categoria, area geografica

/*SELECT * 
SalesOrderLineNumber,
OrderDate,
UnitPrice,
Quantity,
TotalProductCost,
EnglishProductName,
ProductSubcategoryKey,
SalesReasonName,
GeographyKey;*/ -- Complet