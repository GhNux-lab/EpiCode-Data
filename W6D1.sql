#use AdventureWorksDW;

#es. 1.1-4
/*select 
ProductKey As ID_Prodoct,
ProductAlternateKey As ID2_Product,
EnglishProductName As Product_name,
Color,
StandardCost As Cost,
FinishedGoodsFlag As Finisched_Product
From dimproduct  #qui stiamo selezionando le colonne ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag. la /AS per nominare le colonne 
Where FinishedGoodsFlag =1 */ #prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.

#es. 1.5
/* SELECT 
ProductKey As ID_Prodoct,
ModelName,
EnglishProductName As Product_name,
StandardCost As Costo_Stand,
ListPrice
From dimproduct
WHERE ProductAlternateKey LIKE "FR%" OR ProductAlternateKey Like "bk%" */ #ProductAlternateKey comincia con FR oppure BK. 

#es. 2.1
/*SELECT 
ProductKey As ID_Prodoct,
ModelName,
EnglishProductName As Product_name,
StandardCost As Costo_Stand,
ListPrice
(ListePrice - StandardCost) As Markup
From dimproduct
WHERE ProductAlternateKey LIKE "FR%" OR ProductAlternateKey Like "bk%"  #ProductAlternateKey comincia con FR oppure BK. */

#es. 2.2
/* SELECT
ProductKey As ID_Prodoct,
EnglishProductName As Product_name,
ListPrice
FinishedGoodsFlag
From dimproduct
WHERE ListPrice between 1000 AND 2000 AND FinishedGoodsFlag =1 */ #Devono essere dai 1000 ai 2000 e finiti quindi 1

#es. 2.4
/* select 
EmployeeKey,
FirstName,
SalesPersonFlag,
Where SalesPersonFlag LiKE =1
from dimemployee */

#es. 2.5
/* SELECT OrderDate, ProductKey, SalesAmount - TotalProductCost AS PROFITTO
FROM factresellersales
WHERE OrderDate >= '2020-01-01' AND ProductKey IN (597,598,477,214) */
