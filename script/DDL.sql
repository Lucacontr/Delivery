DROP SCHEMA IF EXISTS delivery;
CREATE SCHEMA delivery;
USE delivery;

CREATE TABLE Ristorante(
	Telefono VARCHAR(10) NOT NULL ,
    Nome VARCHAR(50) ,
	Via VARCHAR(50),
	Civico INT ,
    CAP VARCHAR(5), 
	Max_Prenotazioni INT NOT NULL,
    PRIMARY KEY(Telefono)
    );	
    
CREATE TABLE Cliente(
	Telefono VARCHAR(10) NOT NULL ,
	Nome VARCHAR(20) ,
	Cognome VARCHAR(20) ,
	EMail VARCHAR(25),
	Data_Registrazione DATE,
	Ordini_Effettuati INT DEFAULT 0,
	PRIMARY KEY(Telefono)
);
    
CREATE TABLE Ordine(
	Ristorante VARCHAR(10) NOT NULL,
	Data DATE NOT NULL ,
	Cliente VARCHAR(10) NOT NULL,
    Stato VARCHAR(20) CHECK (Stato IN ('ordinato', 'espletato','consegnato')) DEFAULT 'ordinato',
	Descrizione VARCHAR(100),
	Giornaliero INT NOT NULL DEFAULT 0,
    
    PRIMARY KEY(Giornaliero, Ristorante, Data),
    FOREIGN KEY(Ristorante) REFERENCES Ristorante(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
	FOREIGN KEY(Cliente) REFERENCES Cliente(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Tipo_Ordine(
	Ristorante VARCHAR(10) NOT NULL,
	Data DATE NOT NULL ,
    Giornaliero INT NOT NULL,
    Tipo VARCHAR(30) NOT NULL,
    
    PRIMARY KEY(Giornaliero, Ristorante, Data, Tipo),
    FOREIGN KEY(Giornaliero, Ristorante, Data) REFERENCES Ordine(Giornaliero, Ristorante, Data)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Societa_Delivery(
	P_IVA VARCHAR(11) NOT NULL PRIMARY KEY,
    AD VARCHAR(50) ,
    Nome VARCHAR(20)
    );

CREATE TABLE Servizio_Delivery_Interno(
	ID_Servizio_Delivery_Interno INT NOT NULL AUTO_INCREMENT,
    Descrizione VARCHAR(100),
    Data_Inizio DATE,
	Cadenza VARCHAR(50),
	Ristorante VARCHAR(10) NOT NULL,
    PRIMARY KEY(ID_Servizio_Delivery_Interno),
    FOREIGN KEY(Ristorante) REFERENCES Ristorante(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Servizio_Delivery_Esterno(
	ID_Servizio_Delivery_Esterno INT NOT NULL AUTO_INCREMENT,
    Descrizione VARCHAR(100),
    Data_Inizio DATE,
    Cadenza VARCHAR(50),
	Ristorante VARCHAR(10) NOT NULL,
	Societa VARCHAR(11) NOT NULL,
    PRIMARY KEY(ID_Servizio_Delivery_Esterno),
    FOREIGN KEY(Ristorante) REFERENCES Ristorante(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY(Societa) REFERENCES Societa_Delivery(P_IVA)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Veicolo(
	Targa VARCHAR(7) NOT NULL,
    Tipo_Veicolo VARCHAR(25) ,
    PRIMARY KEY(Targa)
);

CREATE TABLE Rider_Esterno(
	Telefono VARCHAR(10) NOT NULL,
    Nome VARCHAR(20),
    Cognome VARCHAR(20),
	DDN DATE,
    Stato VARCHAR(20) CHECK( Stato IN ('disponibile', 'occupato')) DEFAULT 'disponibile',
    Score_Medio DOUBLE DEFAULT 0,
    Societa_In_Servizio INT,
    Data_Inizio_Impiego DATE,
    Veicolo VARCHAR(7),
    PRIMARY KEY(Telefono),
    FOREIGN KEY(Veicolo) REFERENCES Veicolo(Targa)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Dipendente(
	Telefono VARCHAR(10) NOT NULL ,
    Nome VARCHAR(20),
    Cognome VARCHAR(20) ,
	Anni_Esperienza INT , 
	DDN DATE,
    Stato VARCHAR(20) CHECK (Stato IN ('disponibile', 'occupato')) DEFAULT 'disponibile',
	Data_Presa_Servizio DATE,
    Short_Curriculum VARCHAR(100),
    Tipo_Contratto VARCHAR(30) ,
    Servizio_Delivery_Interno INT NOT NULL,
    Veicolo VARCHAR(7),
    PRIMARY KEY(Telefono),
	FOREIGN KEY(Veicolo) REFERENCES Veicolo(Targa)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
	FOREIGN KEY(Servizio_Delivery_Interno) REFERENCES Servizio_Delivery_Interno(ID_Servizio_Delivery_Interno)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Valutazione(
	Cliente VARCHAR(10) NOT NULL,
    Rider_Esterno VARCHAR(10) NOT NULL, 
	Score DOUBLE NOT NULL,
	Data_Valutazione DATETIME NOT NULL,
    
    PRIMARY KEY(Cliente, Rider_Esterno, Data_Valutazione),
    FOREIGN KEY(Cliente) REFERENCES Cliente(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY(Rider_Esterno) REFERENCES Rider_Esterno(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Consegna_Dipendente(
	Giornaliero INT NOT NULL DEFAULT 0,
	Ristorante VARCHAR(10) NOT NULL,
	Data DATE NOT NULL,
	Dipendente VARCHAR(10) NOT NULL,
    Nome_Ricevente VARCHAR(30),
	Cognome_Ricevente VARCHAR(30),
	Telefono_Ricevente VARCHAR(10),
	Orario_Presunto DATETIME,
    Orario_Effettivo DATETIME,
    
    PRIMARY KEY(Giornaliero, Ristorante, Data, Dipendente),
    FOREIGN KEY(Giornaliero, Ristorante, Data) REFERENCES Ordine(Giornaliero, Ristorante, Data)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY(Dipendente) REFERENCES Dipendente(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Consegna_Rider_Esterno(
	Giornaliero INT NOT NULL DEFAULT 0,
	Ristorante VARCHAR(10) NOT NULL,
	Data DATE NOT NULL,
	Rider_Esterno VARCHAR(10) NOT NULL,
    Nome_Ricevente VARCHAR(30),
	Cognome_Ricevente VARCHAR(30),
	Telefono_Ricevente VARCHAR(10),
	Orario_Presunto DATETIME,
    Orario_Effettivo DATETIME,
    PRIMARY KEY(Giornaliero, Ristorante, Data, Rider_Esterno),
    FOREIGN KEY(Giornaliero, Ristorante, Data) REFERENCES Ordine(Giornaliero, Ristorante, Data)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY(Rider_Esterno) REFERENCES Rider_Esterno(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Dipendenza(
	Societa VARCHAR(11) NOT NULL,
	Rider_Esterno VARCHAR(10) NOT NULL,
	Data_Assunzione DATE,
	Quota_Oraria DOUBLE,
    PRIMARY KEY(Societa, Rider_Esterno),
    FOREIGN KEY (Societa) REFERENCES Societa_Delivery(P_IVA)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (Rider_Esterno) REFERENCES Rider_Esterno(Telefono)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TRIGGER N_Ordini_Giornaliero
BEFORE INSERT ON Ordine
FOR EACH ROW
SET new.Giornaliero= (SELECT COUNT(Giornaliero) FROM Ordine WHERE Ristorante =new.Ristorante and data=new.data)+1;

CREATE TRIGGER Numero_Ordini_Effettuati
AFTER INSERT ON Ordine
FOR EACH ROW
UPDATE Cliente SET Ordini_Effettuati= (SELECT COUNT(*) FROM Ordine WHERE Cliente=new.Cliente) WHERE Telefono=new.Cliente;

CREATE TRIGGER Numero_Societa
AFTER INSERT ON Dipendenza
FOR EACH ROW
UPDATE Rider_esterno SET Societa_In_Servizio= (SELECT COUNT(*) FROM Dipendenza WHERE Rider_Esterno=new.Rider_Esterno) WHERE Telefono=new.Rider_Esterno;

CREATE TRIGGER Score_Medio1
AFTER INSERT ON Valutazione
FOR EACH ROW
UPDATE Rider_Esterno SET Score_Medio= (SELECT AVG(Score) FROM Valutazione WHERE Rider_Esterno=new.Rider_Esterno) WHERE Telefono=new.Rider_Esterno;

CREATE TRIGGER Score_Medio2
AFTER delete ON Valutazione
FOR EACH ROW
UPDATE Rider_Esterno SET Score_Medio= (SELECT AVG(Score) FROM Valutazione WHERE Rider_Esterno=old.Rider_Esterno) WHERE Telefono=old.Rider_Esterno;

CREATE TRIGGER Score_Medio3
AFTER update ON Valutazione
FOR EACH ROW
UPDATE Rider_Esterno SET Score_Medio= (SELECT AVG(Score) FROM Valutazione WHERE Rider_Esterno=new.Rider_Esterno) WHERE Telefono=new.Rider_Esterno;

delimiter |
CREATE TRIGGER Consegna_Dipendente
AFTER INSERT ON Consegna_Dipendente
FOR EACH ROW
BEGIN
	UPDATE Ordine SET Stato='consegnato' WHERE Giornaliero=new.Giornaliero AND Data=new.Data AND Ristorante=new.Ristorante;
	UPDATE Dipendente SET Dipendente.Stato='occupato' WHERE Telefono=new.Dipendente;
END;
|

delimiter $
CREATE TRIGGER Consegna_Rider_Esterno
AFTER INSERT ON Consegna_Rider_Esterno
FOR EACH ROW
BEGIN
	UPDATE Rider_Esterno SET Rider_Esterno.Stato='occupato' WHERE Telefono=new.Rider_Esterno;
	UPDATE Ordine SET Ordine.Stato='consegnato' WHERE Giornaliero=new.Giornaliero AND Data=new.Data AND Ristorante=new.Ristorante;
END;
$

delimiter //
CREATE TRIGGER Inserimento_Orario_Consegna_Rider
AFTER UPDATE ON Consegna_Rider_Esterno
FOR EACH ROW
IF new.Orario_Effettivo IS NOT NULL
THEN BEGIN
	UPDATE Ordine SET Stato='consegnato' WHERE Giornaliero=new.Giornaliero AND Data=new.Data AND Ristorante=new.Ristorante;
	UPDATE Rider_Esterno SET Stato='disponibile' WHERE Telefono=new.Rider_Esterno;
END;
END IF;
//

delimiter !
CREATE TRIGGER Inserimento_Orario_Consegna_Dipendente
AFTER UPDATE ON Consegna_Dipendente
FOR EACH ROW
IF (new.Orario_Effettivo IS NOT NULL)
THEN BEGIN 
	UPDATE Ordine SET Stato='consegnato' WHERE Giornaliero=new.Giornaliero AND Data=new.Data AND Ristorante=new.Ristorante;
	UPDATE Dipendente SET Stato='disponibile' WHERE Telefono=new.Dipendente;
END;
END IF;
!

