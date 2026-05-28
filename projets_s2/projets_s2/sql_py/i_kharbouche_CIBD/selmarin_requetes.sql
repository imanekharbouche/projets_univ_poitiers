-- 1 Nombre de clients par ville
SELECT villeCli, COUNT(*) AS nb_clients
FROM CLIENT
GROUP BY villeCli;

-- 2 Produits les plus vendus
SELECT p.libPdt, SUM(c.qteSort) AS total_sortie
FROM PRODUIT p
JOIN CONCERNER c USING (numPdt)
GROUP BY p.libPdt
HAVING total_sortie > 100 ORDER BY SUM(c.qteSort) DESC;

--3 Montant total des ventes par année et produit
SELECT anneePrix, numPdt, SUM(ventePrix) AS total_ventes
FROM PRIX
GROUP BY anneePrix, numPdt;

--4 Consulter les prix des produits
SELECT * 
FROM PRIX 
WHERE anneePrix = 2025; 

--5 Nombre total de sorties effectuées par chaque client
SELECT c.nomCli, c.precisionCli, COUNT(s.numSort) AS nb_sorties
FROM CLIENT c
JOIN SORTIE s USING (numCli)
GROUP BY c.numCli
ORDER BY nb_sorties DESC;

--6 Total des quantités entrées par chaque saunier
SELECT s.nomSau, s.prenomSau, SUM(e.qteEnt) AS total_entrees
FROM SAUNIER s
JOIN ENTREE e USING (numSau)
GROUP BY s.numSau
ORDER BY total_entrees DESC;


--7 Vue des entrées par saunier et produit
CREATE VIEW Vue_Entrees_Produits AS
SELECT e.numSau, s.nomSau, s.prenomSau, e.numPdt, SUM(e.qteEnt) AS total_entree
FROM ENTREE e 
join SAUNIER s USING (numSau)
GROUP BY e.numSau, e.numPdt;

--8 Afficher les entrées pour un saunier
SELECT * FROM Vue_Entrees_Produits
WHERE numSau = 1;  -- Remplacer 1 par l'ID du saunier


--9 Clients sans entrée ni sortie
SELECT numCli
FROM CLIENT
WHERE numCli NOT IN (SELECT numCli FROM SORTIE)
AND numCli NOT IN (SELECT numCli FROM ENTREE);


--10 Stock actuel de chaque produit
SELECT p.libPdt,  p.stockPdt + SUM(e.qteEnt) - SUM(c.qteSort) AS stock_actuel 
FROM PRODUIT p 
LEFT JOIN ENTREE e USING (numPdt)
LEFT JOIN CONCERNER c USING (numPdt)
GROUP BY p.numPdt, p.libPdt; 