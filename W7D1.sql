-- 1.1 Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria.



-- 1.2 Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.

/* select salesordernumber, 
salesorderlinenumber,
count(*) as conteggiocomb
from factresellersales
group by salesordernumber, 
salesorderlinenumber
order by conteggiocomb desc; */

-- 1.3 Conta il numero transazioni SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020

/*select productkey, 
count(productkey) AS conteggio 
from dimproduct
group by productkey
order by conteggio DESC; */

-- 1.4 Calcola il fatturato totale,la quantità totale venduta di FactResellerSales.SalesAmount.alter

/*select productkey, 
count(productkey) AS conteggio 
from dimproduct
group by productkey
order by conteggio DESC; */

-- 1.4.2 il prezzo medio di vendita FactResellerSales.UnitPrice ) per prodotto DimProduct) a partire dal 1 Gennaio 2020.

/*select productkey, 
count(productkey) AS conteggio 
from dimproduct
group by productkey
order by conteggio DESC; */
/*select count(salesorderlinenumber)
from factresellersales
where orderdate > '2020-01-01';*/

--  1.4.3 Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 

/*select sum(sales.salesamount) as VenditeTotali,
sum(sales.orderquantity) as QuantitaTotali,
avg(sales.unitprice) as PrezzoMedio,
product.englishproductname as NomeProdotto
from dimproduct as product 
left join factresellersales as sales 
on product.productkey = sales.productkey 
where sales.orderdate >= '2020-01-01'
group by NomeProdotto*/

-- 2.1 Calcola il fatturato totale FactResellerSales.SalesAmount) e la quantità totale venduta FactResellerSales.OrderQuantity) per Categoria prodotto DimProductCategory)
--  Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta

/*select sum(sales.salesamount) as FatturatoTotale,
sum(sales.orderquantity) as QuantitaTotale,
cat.englishproductcategoryname as NomeCategoria
from dimproduct as product 
left join factresellersales as sales 
on product.productkey = sales.productkey 
left join dimproductsubcategory as subc 
on product.productsubcategorykey = subc.productsubcategorykey 
left join dimproductcategory as cat
on subc.productcategorykey = cat.productcategorykey
group by NomeCategoria*/

-- 2.2 Calcola il fatturato totale per area città DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
-- Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.

/*select sum(sales.salesamount) as Fatturato,
geo.city
from dimgeography as geo
left join dimreseller as reseller
on geo.geographykey = reseller.geographykey
left join factresellersales as sales
on reseller.resellerkey = sales.resellerkey 
group by geo.city
having Fatturato > 60000
order by Fatturato DESC; */

