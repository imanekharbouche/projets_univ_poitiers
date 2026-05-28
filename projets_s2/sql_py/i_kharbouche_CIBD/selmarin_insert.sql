-- SAUNIER  
INSERT INTO SAUNIER (numSau, nomSau, prenomSau, villeSau)
VALUES
(1, 'YVAN', 'Pierre', 'Ars-En-Ré'),
(2, 'PETIT', 'Marc', 'Loix');


-- PRODUIT 
INSERT INTO PRODUIT (numPdt, libPdt, stockPdt)
VALUES
(1, 'Gros sel', 2000),
(2, 'Fleur de sel', 1000);

-- CLIENT 
INSERT INTO CLIENT (numCli, nomCli, precisionCli, villeCli)
VALUES
(1, 'CAVANA', 'Marie', 'LA ROCHELLE'),
(2, 'BURLET', 'Michel', 'LAGORD'),
(3, 'PEUTOT', 'Maurice', 'LAGORD'),
(4, 'ORGEVAL', 'Centrale d\’Achats', 'SURGERES');

-- SORTIE 
INSERT INTO SORTIE (numSort, dateSort, numCli)
VALUES
('20241', '2024-07-16', 1),
('20242', '2024-07-18', 1),
('20243', '2024-08-10', 2);

-- CONCERNER 
INSERT INTO CONCERNER (numSort, numPdt, qteSort)
VALUES
('20241', 1, 300),
('20241', 2, 400),
('20242', 1, 200),
('20243', 1, 100),
('20243', 2, 500);

-- PRIX
INSERT INTO PRIX (anneePrix, numPdt, ventePrix, achatPrix)
VALUES
(2023, 1 , 280, 270),
(2023, 2 , 9500, 3900),
(2024, 1 , 290, 270),
(2024, 2 , 10000, 3800),
(2025, 1 , 300, 240),
(2025, 2 , 9000, 3500);

 
-- ENTREE 
INSERT INTO ENTREE (numEnt, dateEnt, qteEnt, numSau, numPdt)
VALUES
(20241, '2024-06-16', 1000, 1, 1),
(20242, '2024-06-18', 500, 1, 2),
(20243, '2024-07-10', 1500, 2, 2);

