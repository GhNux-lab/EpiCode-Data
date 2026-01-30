CREATE DATABASE FireStore;
USE FireStore; -- specifichiamo il database da usare

-- CREAZIONE TABELLE

-- Tabella Clienti 
CREATE TABLE Clienti_ID (
    ID_Pax INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    Cap VARCHAR(5),
    Via VARCHAR(50),
    Citta VARCHAR(50)
);

-- Tabella Categoria 
CREATE TABLE Categoria (
    Categoria INT PRIMARY KEY,
    Nome_categoria VARCHAR(50)
);

-- Tabella Venditore 
CREATE TABLE Venditore (
    ID_Venditore INT PRIMARY KEY,
    Nome_venditore VARCHAR(50),
    Luogo_vendita VARCHAR(50)
);

-- Tabella Nome Prodotto 
CREATE TABLE Nome_Prodotto (
    ID_Prodotto INT PRIMARY KEY,
    Nome_Prodotto VARCHAR(50),
    Prezzo_Uni DECIMAL(10,2),
    Categoria INT,
    FOREIGN KEY (Categoria) REFERENCES Categoria(Categoria)
);

-- Tabella Ordine (Interazione Finale) 
CREATE TABLE Ordine (
    Nr_Ordine INT PRIMARY KEY,
    Data_ordine DATE,
    Quantita INT,
    Prodotto_ID INT,
    Prezzo_Uni DECIMAL(10,2),
    Prezzo_Tot DECIMAL(10,2),
    ID_Venditore INT,
    ID_Pax INT,
    FOREIGN KEY (Prodotto_ID) REFERENCES Nome_Prodotto(ID_Prodotto),
    FOREIGN KEY (ID_Venditore) REFERENCES Venditore(ID_Venditore),
    FOREIGN KEY (ID_Pax) REFERENCES Clienti_ID(ID_Pax)
);

-- INSERIMENTO DATI 

-- Data Clienti 
INSERT INTO Clienti_ID VALUES (1, 'Anna', 'Currò', '90100', 'Via Medici', 'Torrenova'), (2, 'Giovanni', 'Caruso', '98076', 'Via Roma', 'Roma'), (3, 'Anna', 'Todaro', '91300', 'Via Belgio', 'Bologna');

-- Data Categorie 
INSERT INTO Categoria VALUES (18, 'Estintore Polvere'), (28, 'Estintore Schiuma'), (27, 'Estintore CO2'), (31, 'Anello');

-- Data Venditori 
INSERT INTO Venditore VALUES (4875, 'Luigi', 'Torino'), (2026, 'Giovanni', 'Padova'), (1543, 'Luca', 'Milano');

-- Data Prodotti 
INSERT INTO Nome_Prodotto VALUES (3, 'Estintore Jolly', 20.00, 18), (75, 'Manichetta KK', 60.00, 28), (20, 'Fire CO2', 40.00, 27), (5, 'Anello Top', 5.00, 31);

-- Data Ordini (Nota: la data è nel formato SQL YYYY-MM-DD) 
INSERT INTO Ordine VALUES (25, '2016-10-20', 1, 3, 20.00, 20.00, 4875, 1), (17, '2016-10-20', 3, 75, 60.00, 180.00, 2026, 2), (21, '2016-10-20', 1, 20, 40.00, 40.00, 4875, 1);