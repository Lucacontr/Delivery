USE delivery;

INSERT INTO Ristorante(Telefono, Nome, Via, Civico, CAP, Max_Prenotazioni) VALUES
('0828323537', 'Black Pearl Pub', 'Umberto Nobile', 13, 84025, 54),
('0828364555', 'Paninoteca da Gino', 'ApolloXI', 20, 84025, 24),
('0828364556', 'Paninoteca da Zaccaria', 'ApolloXI', 38, 84025, 20),
('0828364546', 'Franco\'s Pizza', 'Caduti di Bruxelles', 18, 84025, 10),
('0828657899', 'Ristorante da Giuseppe', 'Unione Sovietica', 44, 84025, 50);

INSERT INTO Cliente(Telefono, Nome, Cognome, EMail, Data_Registrazione) VALUES
('3332343546', 'Luca', 'Contrasto', 'lc@gmail.com', SYSDATE()),
('3434565776',' Giacomo', 'Cubicciotti', 'gc@gmail.com', SYSDATE()),
('3274567583', 'Giuseppe', 'Verdi', 'gv@gmail.com', SYSDATE()),
('3923456756', 'Dario', 'Lampa', 'dl@gmail.com', SYSDATE()),
('3456789876', 'Mario', 'Rossi', 'mr@gmail.com', SYSDATE());

INSERT INTO Servizio_Delivery_Interno(Descrizione, Data_Inizio, Cadenza, Ristorante) VALUES
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Giornaliera', '0828323537'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Settimanale', '0828323537'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Giornaliera', '0828364555'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Mensile', '0828364555'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Giornaliera', '0828657899'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Mensile', '0828657899');

INSERT INTO Veicolo(Targa, Tipo_Veicolo) VALUES
('AA123BB', 'Automobile'),
('AC678FG', 'Motociclo'),
('GB456GG', 'Automobile'), 
('FA173PB', 'Automobile'),
('CB678FH', 'Motociclo'),
('GA789TG', 'Automobile'), 
('AH136BJ', 'Automobile'),
('GA681FB', 'Motociclo'),
('EW891HK', 'Automobile'), 
('BN810LM', 'Motociclo');

INSERT INTO Dipendente(Telefono, Nome, Cognome, Anni_Esperienza, DDN, Tipo_Contratto, Data_Presa_Servizio, Short_Curriculum, Servizio_Delivery_Interno) VALUES
('3458778999', 'Guido', 'Bianchi', 12, '1980-01-12', 'Determinato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '1'),
('3338778999', 'Francesco', 'Bianchi', 3, '1970-12-15', 'Determinato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '2'),
('3278778999', 'Christian', 'Esposito', 4, '1998-10-09', 'Determinato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '3'),
('3928778999', 'Massimo', 'Rossi', 2, '1971-12-12', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '4'),
('3459867874', 'Luca', 'Rossi', 1, '1972-12-11', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '5'),
('3279867874', 'Giacomo', 'Rossi', 1, '1973-01-10', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '1'),
('3339867874', 'Felice', 'Rossi', 2, '1974-12-06', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '2'),
('3929867874', 'Rocco', 'Rossi', 3, '1975-08-07', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '3'),
('3920011223', 'Simone', 'Rossi', 4, '1976-12-18', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '4'),
('3450011223', 'Giuseppe', 'Rossi', 2, '1975-04-06', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '5'),
('3330011223', 'Alessio', 'Rossi', 5, '1980-06-06', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '6'),
('3270011223', 'Mario', 'Rossi', 3, '1990-03-09', 'Indeterminato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet', '1');

INSERT INTO Dipendente(Telefono, Nome, Cognome, Anni_Esperienza, DDN, Tipo_Contratto, Data_Presa_Servizio, Short_Curriculum, Servizio_Delivery_Interno, Veicolo) VALUES
('3274565555', 'Vincenzo', 'Neri', 2, '2000-05-17', 'Determinato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', '1', 'AA123BB'),
('3454565555', 'Facondo', 'Pirozzi', 4, '2000-12-18', 'Determinato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', '2', 'GB456GG'),
('3334565555', 'Adelmo', 'Romani', 3, '2000-01-12', 'Determinato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', '3', 'AC678FG'),
('3924565555', 'Fabio', 'Doraconti', 2, '1999-12-03', 'Determinato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', '5', 'FA173PB'),
('3334585555', 'Ilaria', 'Schiavoni', 3, '2000-03-15', 'Determinato', SYSDATE(), 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', '4', 'GB456GG');

INSERT INTO Societa_Delivery(P_IVA, AD, Nome) VALUES
('49714630750', 'Giudo Guidi', 'ConsegnaG'),
('62582580338', 'Samuele Bianchi', 'SociCons'),
('29402140890', 'Lello Chianti', 'ChantiCons'),
('65679780869', 'Vittorio Buoi', 'BuoiTuoi'),
('39537450965', 'Damiano Neri', 'NeriDa'),
('13022581006', 'Alessandro Di Bassi', 'DiBassiAle'),
('63043830866', 'Gerry Cala', 'GerryCons'),
('31662390298', 'Enrico Papi', 'PapiCo'),
('12593750792', 'Pippo Baudo', 'BPCons'),
('12593750793', 'Flavio Insinna', 'Food Delivery'),
('67959021212', 'Teo Teocoli', 'TeoTeoCons');

INSERT INTO Servizio_Delivery_Esterno(Descrizione, Data_Inizio, Cadenza, Ristorante, Societa) VALUES
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Giornaliera', '0828657899', '49714630750'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Settimanale', '0828364555', '65679780869'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Giornaliera', '0828364555', '12593750792'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Settimanale', '0828323537', '63043830866'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Mensile', '0828364556', '12593750793'),
('Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci', SYSDATE(), 'Mensile', '0828657899', '62582580338');

INSERT INTO Rider_Esterno(Telefono, Nome, Cognome, DDN, Data_Inizio_Impiego, Veicolo) VALUES
('3478907113', 'Dante', 'Alighieri', '1988-05-04', SYSDATE(), 'BN810LM'),
('3331523000', 'Roberto', 'Giacobbo', '1978-01-10', SYSDATE(), 'AH136BJ'),
('3391583562', 'Franco', 'Spacco', '1999-02-08', SYSDATE(), 'EW891HK'),
('3266545222', 'Danilo', 'Gallinari', '1989-09-01', SYSDATE(), 'GA681FB'),
('3487885994', 'Nella', 'Milano', '1975-11-22', SYSDATE(), 'GA789TG');

INSERT INTO Rider_Esterno(Telefono, Nome, Cognome, DDN, Data_Inizio_Impiego) VALUES
('3584562113', 'Adelmo', 'Romani', '1988-12-15', '2015-11-25'),
('3362555412', 'Felicita', 'Folliero', '1956-02-06', '2020-02-23'),
('3561234568', 'Dino', 'Pugliesi', '1955-05-06', '2011-02-10'),
('3652301225', 'Frediana', 'Loduca', '1988-06-05', '2013-12-10'),
('3578560116', 'Isaia', 'Russo', '1975-04-05', '2016-01-23'),
('3564120336', 'Michele', 'Ricci', '1965-06-04', '2012-02-25'),
('3658512220', 'Pierino', 'Boni', '1947-03-14', '2011-06-03'),
('3335625447', 'Gabriele', 'Toscano', '1995-06-23', '2011-05-06'),
('3351423669', 'Santa', 'Manfrin', '1988-06-05', '2015-08-22'),
('3566419762', 'Romilda', 'Trevisan', '1993-11-11', '2020-12-01');

INSERT INTO Valutazione(Cliente, Rider_Esterno, Score, Data_Valutazione) VALUES 
('3274567583', '3478907113', 1, sysdate()),
('3434565776', '3331523000', 8, sysdate()),
('3332343546', '3391583562', 5, sysdate()),
('3923456756', '3266545222', 8, sysdate()),
('3274567583', '3266545222', 1, sysdate()),
('3456789876', '3487885994', 9, sysdate());

INSERT INTO Dipendenza(Societa, Rider_Esterno, Data_Assunzione, Quota_Oraria) VALUES
('29402140890', '3362555412', SYSDATE(), '1.50'),
('49714630750', '3652301225', SYSDATE(), '2'),
('62582580338', '3335625447', SYSDATE(), '6'),
('13022581006', '3335625447', SYSDATE(), '5'),
('12593750792', '3652301225', SYSDATE(), '2.50'),
('39537450965', '3335625447', SYSDATE(), '3');

INSERT INTO Ordine(Ristorante, Data, Cliente, Descrizione) VALUES
('0828323537', SYSDATE(), '3332343546', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828323537', SYSDATE(), '3434565776', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828323537', SYSDATE(), '3274567583', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828323537', SYSDATE(), '3332343546', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828657899', SYSDATE(), '3923456756', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828657899', SYSDATE(), '3274567583', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci' ),
('0828364555', SYSDATE(), '3923456756', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828364555', SYSDATE(), '3332343546', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828364555', SYSDATE(), '3923456756', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828364555', SYSDATE(), '3332343546', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828657899', SYSDATE(), '3274567583', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci' ),
('0828364555', SYSDATE(), '3923456756', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828364555', SYSDATE(), '3332343546', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828364555', SYSDATE(), '3923456756', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci'),
('0828364555', SYSDATE(), '3332343546', 'Lorem ipsum dolor sit amet, consectetur adipisci Lorem ipsum dolor sit amet, consectetur adipisci');

INSERT INTO Tipo_Ordine(Ristorante, Data, Giornaliero, Tipo)VALUES
('0828364555', SYSDATE(), 1, 'primo'),
('0828364555', SYSDATE(), 1, 'secondo'),
('0828364555', SYSDATE(), 1, 'pizza');

INSERT INTO Consegna_Dipendente(Giornaliero, Data, Ristorante, Dipendente, Nome_Ricevente, Cognome_Ricevente, Telefono_Ricevente) VALUES
(4, SYSDATE(), '0828323537', '3274565555', 'Giuseppe', 'Verdi', '3325412665');

INSERT INTO Consegna_Rider_Esterno(Giornaliero, Data, Ristorante, Rider_Esterno, Nome_Ricevente, Cognome_Ricevente, Telefono_Ricevente) VALUES
(1, SYSDATE(), '0828323537', '3584562113', 'Lello', 'Limoni', '3325412665'),
(1, SYSDATE(), '0828657899', '3362555412', 'Luca', 'Contrasto', '3332343546'),
(2, SYSDATE(), '0828657899', '3561234568', 'Giacomo', 'Cubicciotti', '3434565776'),
(2, SYSDATE(), '0828323537', '3652301225', 'Michele', 'Sgorbi', '3336541225'),
(1, SYSDATE(), '0828364555', '3564120336', 'Vittorio', 'Misuli', '3254102998'),
(2, SYSDATE(), '0828364555', '3335625447', 'Francesco', 'Polodi', '3271003667'),
(3, SYSDATE(), '0828323537', '3566419762', 'Mario', 'Rossi', '3456789876');

#Verifica funzionamento trigger Inserimento_Orario_Consegna_Rider
UPDATE Consegna_Rider_Esterno
SET Orario_Effettivo=SYSDATE()
WHERE Rider_Esterno='3584562113';

#Verifica funzionamento trigger Inserimento_Orario_Consegna_Dipendente
UPDATE Consegna_Dipendente
SET Orario_Effettivo=SYSDATE()
WHERE Dipendente='3274565555';

