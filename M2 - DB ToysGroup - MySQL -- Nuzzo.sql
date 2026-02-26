-- CREAMO IL DATABASE
 #Create database ToysGroup_M2;

-- ENTRAMO DEL DB
#USE ToysGroup_M2;

--  Tabella Categorie
/*CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,     -- FK verso Category
    CategoryName VARCHAR(50) NOT NULL              -- Nome prodotto, max 50 char
);

-- TABELLA Prodotti
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,       -- PK con auto-incremento
    ProductName VARCHAR(100) NOT NULL,              -- Nome prodotto, max 100 char
    CategoryID INT,                                 -- FK verso Category
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- TABELLA Regioni
CREATE TABLE Region (
    RegionID INT PRIMARY KEY AUTO_INCREMENT,         -- PK con auto-incremento
    RegionName VARCHAR(50) NOT NULL                  -- Nome regione, max 50 char
);

-- TABELLA degli Stati (Country)
CREATE TABLE Country (
    CountryID INT PRIMARY KEY AUTO_INCREMENT,   -- PK con auto-incremento
    CountryName VARCHAR(50) NOT NULL,           -- Nome stato, max 50 char
    RegionID INT,                               -- FK verso Region
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- TABELLA Vendite (Sales)
CREATE TABLE Sales (
    SalesID INT PRIMARY KEY AUTO_INCREMENT,      -- PK con auto-incremento
    OrderDate DATE NOT NULL,                     -- Data vendita
    ProductID INT,                               -- FK verso Product
    CountryID INT,                               -- FK verso Country
    Quantity INT DEFAULT 1,                      -- Quantità, base 1
    Amount DECIMAL(10, 2),                       -- Importo monetario (10 cifre, 2 decimali)
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);*/

-- INSERIMENTO DEI RECORD DEL DB

--  Inserimento record in Category
/*INSERT INTO Category (CategoryName) VALUES 
('Bikes'),
('Abbigliamento'),
('Educativi'),
('Giochi da Tavolo'),
('Modellini')
;

-- Inserimento record in Product
INSERT INTO Product (ProductName, CategoryID) VALUES 
('Bikes-100', 1),
('Bikes-200', 1),
('Bike Guanti M', 2),
('Kit di Chimica Pro', 3),
('Capitan America Lego', 5)
;-- Associa i prodotti alle categorie 

-- Inserimento record in Region
INSERT INTO Region (RegionName) VALUES  
('Europa Occidentale'),
('Europa Meridionale'),
('Europa Settentrionale'),
('Europa Orientale'),
('Europa Centrale')
;

-- Inserimento record in Country
INSERT INTO Country (CountryName, RegionID) VALUES  
('Francia', 1),    -- Europa Occidentale
('Italia', 2),     -- Europa Meridionale
('Norvegia', 3),   -- Europa Settentrionale
('Polonia', 4),    -- Europa Orientale
('Germania', 5)    -- Europa Centrale
; -- Associa gli stati alle RegionID

-- Inserimento record in Sales
INSERT INTO Sales (OrderDate, ProductID, CountryID, Quantity, Amount) VALUES  
('2026-02-10', 1, 2, 1, 450.00), -- Vendita: Bicicletta Modello 100 in Italia
('2026-02-12', 3, 1, 2, 50.00),  -- Vendita: Guanti da Bici (Taglia M) in Francia
('2026-02-15', 4, 5, 1, 85.00),  -- Vendita: Kit di Chimica Professionale in Germania
('2026-02-18', 5, 4, 3, 120.00), -- Vendita: Capitan America Lego in Polonia
('2026-02-20', 2, 3, 1, 600.00)  -- Vendita: Bicicletta Modello 200 in Norvegia
; */-- Associa SalesID a prodottiID e CountryID 
-- Amount viene calcolato come valore totale della riga (Prezzo Unitario × Quantità)

-- VERIFICA CAMBPI DEFINITI PK SIA UNIVOCI

-- Verifica Tabella Category
/*SELECT CategoryID, COUNT(*) 
FROM Category 
GROUP BY CategoryID 
HAVING COUNT(*) > 1
;

-- Verifica Tabella Product
SELECT ProductID, COUNT(*) 
FROM Product 
GROUP BY ProductID 
HAVING COUNT(*) > 1
;

-- Verifica Tabella Region
SELECT RegionID, COUNT(*) 
FROM Region 
GROUP BY RegionID 
HAVING COUNT(*) > 1
;

-- Verifica Tabella Country
SELECT CountryID, COUNT(*) 
FROM Country 
GROUP BY CountryID 
HAVING COUNT(*) > 1
;

-- Verifica Tabella Sales
SELECT SalesID, COUNT(*) 
FROM Sales 
GROUP BY SalesID 
HAVING COUNT(*) > 1
;*/

-- Elenco delle transazioni  - Ho scritto la query richiesta, creando anche una vista
/*CREATE OR REPLACE VIEW View_Dettaglio_Vendite AS
SELECT 
    S.SalesID AS Codice_Documento,
    S.OrderDate AS Data_Vendita,
    P.ProductName AS Nome_Prodotto,
    C.CategoryName AS Categoria_Prodotto,
    Co.CountryName AS Nome_Stato,
    R.RegionName AS Nome_Regione, -- qui diamo un nomignolo al campo
    -- Calcolo del campo booleano (1 = True, 0 = False)
    CASE 
        WHEN DATEDIFF(CURDATE(), S.OrderDate) > 180 THEN TRUE 
        ELSE FALSE 
    END AS Piu_di_180_Giorni
FROM Sales S
JOIN Product P ON S.ProductID = P.ProductID
JOIN Category C ON P.CategoryID = C.CategoryID
JOIN Country Co ON S.CountryID = Co.CountryID
JOIN Region R ON Co.RegionID = R.RegionID
;*/

-- l’elenco dei prodotti che hanno venduto sup media
/*CREATE OR REPLACE VIEW View_Prodotti_Top_Vendite AS
SELECT 
    ProductID AS Codice_Prodotto, 
    SUM(Quantity) AS Totale_Venduto
FROM Sales
WHERE YEAR(OrderDate) = (SELECT YEAR(MAX(OrderDate)) FROM Sales)
GROUP BY ProductID
HAVING -- Filtra i prodotti con vendite totali superiori alla media dell'anno
    SUM(Quantity) > (
        SELECT AVG(Quantity)
        FROM Sales
        WHERE YEAR(OrderDate) = (SELECT YEAR(MAX(OrderDate)) FROM Sales)
    );*/
    
   -- Elenco dei soli prodotti venduti x anno
/*CREATE OR REPLACE VIEW View_FatTot_Anno AS 
    SELECT 
    P.ProductName AS Nome_Prodotto,
    YEAR(S.OrderDate) AS Anno, -- estrae l'anno dalla data completa
    SUM(S.Amount) AS Fatturato_Totale -- ricavo totale
FROM Sales S
JOIN Product P ON S.ProductID = P.ProductID -- mostrati solo i prodotti venduti
GROUP BY P.ProductName, 
    YEAR(S.OrderDate) 
ORDER BY Anno DESC, 
    Fatturato_Totale DESC
    ;*/
    
-- Fatturato totale per stato per anno
/*CREATE OR REPLACE VIEW View_Fatturato_Stato_Anno AS
SELECT 
    C.CountryName AS Stato,
    YEAR(S.OrderDate) AS Anno,
    SUM(S.Amount) AS Fatturato_Totale
FROM Sales S
JOIN Country C ON S.CountryID = C.CountryID
GROUP BY C.CountryName, 
    YEAR(S.OrderDate)
    ; */
    

-- "frequenza" di richiesta del mercato
/*Create view View_Quantita_Totale_Richiesta AS
SELECT 
    C.CategoryName AS Categoria,
    SUM(S.Quantity) AS Quantita_Totale_Richiesta
FROM Sales S
JOIN Product P ON S.ProductID = P.ProductID
JOIN Category C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName
ORDER BY Quantita_Totale_Richiesta DESC
LIMIT 1
;*/

-- Per verificare quali prodotti risultano invenduti, anche qui creando una View - Proposta in due modi
-- Proposta 1
/*CREATE VIEW Prodotti_Invenduti AS
SELECT 
    P.ProductID, 
    P.ProductName
FROM Product P
LEFT JOIN Sales S ON P.ProductID = S.ProductID
WHERE S.ProductID IS NULL
; */

-- Proposta 2
/*SELECT 
    ProductID, 
    ProductName
FROM Product
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM Sales)
;*/

-- vista sui prodotti con nominativo prodotto
/*CREATE VIEW View_Prodotti_Anagrafica AS
SELECT 
    P.ProductID AS Codice_Prodotto, 
    P.ProductName AS Nome_Prodotto, 
    C.CategoryName AS Nome_Categoria
FROM Product P
JOIN Category C ON P.CategoryID = C.CategoryID
;*/

-- Creazione VIew per le informazioni geografiche
/*CREATE OR REPLACE VIEW View_Anagrafica_Geografica AS
SELECT 
    C.CountryID AS Codice_Stato,
    C.CountryName AS Nome_Stato,
    R.RegionName AS Nome_Regione
FROM Country C
JOIN Region R ON C.RegionID = R.RegionID
;*/

-- FINE