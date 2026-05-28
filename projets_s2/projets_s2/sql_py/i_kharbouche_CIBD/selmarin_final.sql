-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 12, 2025 at 04:53 PM
-- Server version: 8.0.35
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `selmarin`
--

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT`
--

CREATE TABLE `CLIENT` (
  `numCli` int NOT NULL,
  `nomCli` varchar(50) NOT NULL,
  `precisionCli` varchar(255) NOT NULL,
  `villeCli` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CLIENT`
--

INSERT INTO `CLIENT` (`numCli`, `nomCli`, `precisionCli`, `villeCli`) VALUES
(1, 'CAVANA', 'Marie', 'LA ROCHELLE'),
(2, 'BURLET', 'Michel', 'LAGORD'),
(3, 'PEUTOT', 'Maurice', 'LAGORD'),
(4, 'ORGEVAL', 'Centrale d’Achats', 'SURGERES'),
(5, 'SICAAP', 'Centrale d\'Achats', 'FONTCOUVERTE'),
(6, 'GIE DE L\'AUNIS', 'Centrale d\'Achats', 'VOUHE'),
(7, 'EVEILLE', 'Johann', 'LA ROCHELLE'),
(8, 'BARBOTTIN', 'Olivier', 'MEURSAC'),
(9, 'UNION DES PRODUCTEURS DE LA MER', 'Centrale d\'Achats', 'RIVEDOUX'),
(10, 'LIDL', 'Centrale d\'Achats', 'PUILBOREAU'),
(11, 'CARREFOUR', 'Centrale d\'Achats', 'LA ROCHELLE'),
(12, 'imane', 'kharbouche', 'niort');

-- --------------------------------------------------------

--
-- Table structure for table `CONCERNER`
--

CREATE TABLE `CONCERNER` (
  `numSort` varchar(50) NOT NULL,
  `numPdt` int NOT NULL,
  `qteSort` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CONCERNER`
--

INSERT INTO `CONCERNER` (`numSort`, `numPdt`, `qteSort`) VALUES
('20231', 1, 500),
('202310', 1, 700),
('202311', 1, 200),
('202313', 1, 500),
('202315', 1, 100),
('202316', 1, 350),
('202318', 1, 100),
('202319', 1, 300),
('202320', 1, 400),
('202322', 1, 200),
('202323', 1, 400),
('202324', 1, 150),
('202325', 1, 300),
('202327', 1, 600),
('202328', 1, 400),
('202329', 1, 300),
('202330', 1, 100),
('202331', 1, 500),
('202332', 1, 200),
('202333', 1, 200),
('202335', 1, 200),
('202337', 1, 300),
('202339', 1, 200),
('20234', 1, 250),
('202340', 1, 300),
('202341', 1, 200),
('202342', 1, 650),
('202344', 1, 500),
('202345', 1, 300),
('202347', 1, 100),
('202348', 1, 700),
('202349', 1, 300),
('20235', 1, 150),
('202351', 1, 300),
('202352', 1, 400),
('202354', 1, 300),
('202355', 1, 400),
('202357', 1, 200),
('202358', 1, 300),
('202359', 1, 400),
('202360', 1, 200),
('20237', 1, 500),
('20241', 1, 300),
('20242', 1, 200),
('20243', 1, 100),
('20231', 2, 500),
('202310', 2, 450),
('202312', 2, 200),
('202314', 2, 100),
('202316', 2, 400),
('202317', 2, 500),
('20232', 2, 200),
('202320', 2, 300),
('202321', 2, 400),
('202325', 2, 300),
('202326', 2, 300),
('202328', 2, 500),
('20233', 2, 300),
('202331', 2, 500),
('202334', 2, 1000),
('202336', 2, 200),
('202337', 2, 600),
('202338', 2, 200),
('20234', 2, 200),
('202343', 2, 400),
('202344', 2, 200),
('202346', 2, 100),
('202348', 2, 1000),
('202350', 2, 300),
('202353', 2, 700),
('202356', 2, 400),
('202358', 2, 300),
('202359', 2, 400),
('20236', 2, 100),
('202361', 2, 300),
('20237', 2, 500),
('20238', 2, 200),
('20239', 2, 200),
('20241', 2, 400),
('20243', 2, 500);

-- --------------------------------------------------------

--
-- Table structure for table `ENTREE`
--

CREATE TABLE `ENTREE` (
  `numEnt` int NOT NULL,
  `dateEnt` datetime NOT NULL,
  `qteEnt` int NOT NULL,
  `numPdt` int NOT NULL,
  `numSau` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ENTREE`
--

INSERT INTO `ENTREE` (`numEnt`, `dateEnt`, `qteEnt`, `numPdt`, `numSau`) VALUES
(20231, '2023-01-04 00:00:00', 2000, 1, 1),
(20232, '2023-01-04 00:00:00', 3000, 2, 1),
(20233, '2023-01-09 00:00:00', 2000, 1, 4),
(20234, '2023-01-09 00:00:00', 2000, 2, 4),
(20235, '2023-02-02 00:00:00', 4000, 1, 3),
(20236, '2023-02-05 00:00:00', 3000, 2, 2),
(20237, '2023-03-01 00:00:00', 1000, 1, 4),
(20238, '2023-03-01 00:00:00', 4000, 2, 4),
(20239, '2023-05-07 00:00:00', 3000, 1, 1),
(20241, '2024-06-16 00:00:00', 1000, 1, 1),
(20242, '2024-06-18 00:00:00', 500, 2, 1),
(20243, '2024-07-10 00:00:00', 1500, 2, 2),
(202310, '2023-06-08 00:00:00', 3000, 1, 1),
(202311, '2023-06-08 00:00:00', 3000, 2, 1),
(202312, '2023-06-29 00:00:00', 2000, 1, 3),
(202313, '2023-07-01 00:00:00', 1000, 2, 2),
(202314, '2023-08-07 00:00:00', 3000, 1, 4),
(202315, '2023-08-07 00:00:00', 2000, 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `PRIX`
--

CREATE TABLE `PRIX` (
  `anneePrix` int NOT NULL,
  `numPdt` int NOT NULL,
  `achatPrix` decimal(15,2) NOT NULL,
  `ventePrix` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `PRIX`
--

INSERT INTO `PRIX` (`anneePrix`, `numPdt`, `achatPrix`, `ventePrix`) VALUES
(2023, 1, 270.00, 280.00),
(2023, 2, 3900.00, 9500.00),
(2024, 1, 270.00, 290.00),
(2024, 2, 3800.00, 10000.00),
(2025, 1, 240.00, 300.00),
(2025, 2, 3500.00, 9000.00);

-- --------------------------------------------------------

--
-- Table structure for table `PRODUIT`
--

CREATE TABLE `PRODUIT` (
  `numPdt` int NOT NULL,
  `libPdt` varchar(255) NOT NULL,
  `stockPdt` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `PRODUIT`
--

INSERT INTO `PRODUIT` (`numPdt`, `libPdt`, `stockPdt`) VALUES
(1, 'Gros sel', 2000),
(2, 'Fleur de sel', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `SAUNIER`
--

CREATE TABLE `SAUNIER` (
  `numSau` int NOT NULL,
  `nomSau` varchar(50) NOT NULL,
  `prenomSau` varchar(50) NOT NULL,
  `villeSau` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `SAUNIER`
--

INSERT INTO `SAUNIER` (`numSau`, `nomSau`, `prenomSau`, `villeSau`) VALUES
(1, 'YVAN', 'Pierre', 'Ars-En-Ré'),
(2, 'PETIT', 'Marc', 'Loix'),
(3, 'CARBRAC', 'Léonie', 'Rivedoux'),
(4, 'TARDIVEL', 'Thierry', 'La Couarde');

-- --------------------------------------------------------

--
-- Table structure for table `SORTIE`
--

CREATE TABLE `SORTIE` (
  `numSort` varchar(50) NOT NULL,
  `dateSort` datetime NOT NULL,
  `numCli` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `SORTIE`
--

INSERT INTO `SORTIE` (`numSort`, `dateSort`, `numCli`) VALUES
('20231', '2023-01-05 00:00:00', 10),
('202310', '2023-02-14 00:00:00', 10),
('202311', '2023-02-14 00:00:00', 3),
('202312', '2023-02-16 00:00:00', 10),
('202313', '2023-02-28 00:00:00', 9),
('202314', '2023-03-08 00:00:00', 1),
('202315', '2023-03-09 00:00:00', 2),
('202316', '2023-03-10 00:00:00', 10),
('202317', '2023-03-19 00:00:00', 7),
('202318', '2023-03-22 00:00:00', 1),
('202319', '2023-03-23 00:00:00', 10),
('20232', '2023-01-06 00:00:00', 2),
('202320', '2023-03-23 00:00:00', 10),
('202321', '2023-04-04 00:00:00', 11),
('202322', '2023-04-06 00:00:00', 11),
('202323', '2023-04-17 00:00:00', 10),
('202324', '2023-04-20 00:00:00', 1),
('202325', '2023-04-29 00:00:00', 11),
('202326', '2023-05-02 00:00:00', 3),
('202327', '2023-05-04 00:00:00', 7),
('202328', '2023-05-22 00:00:00', 11),
('202329', '2023-06-03 00:00:00', 10),
('20233', '2023-01-06 00:00:00', 5),
('202330', '2023-06-03 00:00:00', 1),
('202331', '2023-06-04 00:00:00', 11),
('202332', '2023-06-05 00:00:00', 6),
('202333', '2023-06-06 00:00:00', 7),
('202334', '2023-06-07 00:00:00', 8),
('202335', '2023-06-09 00:00:00', 2),
('202336', '2023-06-30 00:00:00', 5),
('202337', '2023-07-01 00:00:00', 10),
('202338', '2023-07-01 00:00:00', 9),
('202339', '2023-07-02 00:00:00', 11),
('20234', '2023-01-06 00:00:00', 11),
('202340', '2023-07-13 00:00:00', 5),
('202341', '2023-07-24 00:00:00', 7),
('202342', '2023-08-05 00:00:00', 10),
('202343', '2023-08-06 00:00:00', 10),
('202344', '2023-08-06 00:00:00', 11),
('202345', '2023-09-02 00:00:00', 5),
('202346', '2023-09-08 00:00:00', 1),
('202347', '2023-09-19 00:00:00', 7),
('202348', '2023-10-10 00:00:00', 11),
('202349', '2023-10-11 00:00:00', 4),
('20235', '2023-01-09 00:00:00', 2),
('202350', '2023-11-02 00:00:00', 9),
('202351', '2023-11-13 00:00:00', 11),
('202352', '2023-11-14 00:00:00', 10),
('202353', '2023-11-15 00:00:00', 10),
('202354', '2023-11-15 00:00:00', 4),
('202355', '2023-11-15 00:00:00', 6),
('202356', '2023-12-08 00:00:00', 11),
('202357', '2023-12-11 00:00:00', 4),
('202358', '2023-12-20 00:00:00', 10),
('202359', '2023-12-21 00:00:00', 11),
('20236', '2023-01-09 00:00:00', 3),
('202360', '2023-12-22 00:00:00', 6),
('202361', '2023-12-23 00:00:00', 2),
('20237', '2023-01-12 00:00:00', 11),
('20238', '2023-01-12 00:00:00', 6),
('20239', '2023-01-23 00:00:00', 1),
('20241', '2024-07-16 00:00:00', 1),
('20242', '2024-07-18 00:00:00', 1),
('20243', '2024-08-10 00:00:00', 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vue_entrees_produits`
-- (See below for the actual view)
--
CREATE TABLE `vue_entrees_produits` (
`numSau` int
,`nomSau` varchar(50)
,`prenomSau` varchar(50)
,`numPdt` int
,`total_entree` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Structure for view `vue_entrees_produits`
--
DROP TABLE IF EXISTS `vue_entrees_produits`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vue_entrees_produits`  AS SELECT `e`.`numSau` AS `numSau`, `s`.`nomSau` AS `nomSau`, `s`.`prenomSau` AS `prenomSau`, `e`.`numPdt` AS `numPdt`, sum(`e`.`qteEnt`) AS `total_entree` FROM (`entree` `e` join `saunier` `s` on((`e`.`numSau` = `s`.`numSau`))) GROUP BY `e`.`numSau`, `e`.`numPdt` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CLIENT`
--
ALTER TABLE `CLIENT`
  ADD PRIMARY KEY (`numCli`),
  ADD UNIQUE KEY `nomCli` (`nomCli`,`villeCli`);

--
-- Indexes for table `CONCERNER`
--
ALTER TABLE `CONCERNER`
  ADD PRIMARY KEY (`numPdt`,`numSort`),
  ADD KEY `numSort` (`numSort`);

--
-- Indexes for table `ENTREE`
--
ALTER TABLE `ENTREE`
  ADD PRIMARY KEY (`numEnt`),
  ADD KEY `numSau` (`numSau`),
  ADD KEY `numPdt` (`numPdt`);

--
-- Indexes for table `PRIX`
--
ALTER TABLE `PRIX`
  ADD PRIMARY KEY (`anneePrix`,`numPdt`),
  ADD KEY `numPdt` (`numPdt`);

--
-- Indexes for table `PRODUIT`
--
ALTER TABLE `PRODUIT`
  ADD PRIMARY KEY (`numPdt`),
  ADD UNIQUE KEY `libPdt` (`libPdt`);

--
-- Indexes for table `SAUNIER`
--
ALTER TABLE `SAUNIER`
  ADD PRIMARY KEY (`numSau`);

--
-- Indexes for table `SORTIE`
--
ALTER TABLE `SORTIE`
  ADD PRIMARY KEY (`numSort`),
  ADD KEY `numCli` (`numCli`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CONCERNER`
--
ALTER TABLE `CONCERNER`
  ADD CONSTRAINT `concerner_ibfk_1` FOREIGN KEY (`numPdt`) REFERENCES `PRODUIT` (`numPdt`),
  ADD CONSTRAINT `concerner_ibfk_2` FOREIGN KEY (`numSort`) REFERENCES `SORTIE` (`numSort`);

--
-- Constraints for table `ENTREE`
--
ALTER TABLE `ENTREE`
  ADD CONSTRAINT `entree_ibfk_1` FOREIGN KEY (`numSau`) REFERENCES `SAUNIER` (`numSau`),
  ADD CONSTRAINT `entree_ibfk_2` FOREIGN KEY (`numPdt`) REFERENCES `PRODUIT` (`numPdt`);

--
-- Constraints for table `PRIX`
--
ALTER TABLE `PRIX`
  ADD CONSTRAINT `prix_ibfk_1` FOREIGN KEY (`numPdt`) REFERENCES `PRODUIT` (`numPdt`);

--
-- Constraints for table `SORTIE`
--
ALTER TABLE `SORTIE`
  ADD CONSTRAINT `sortie_ibfk_1` FOREIGN KEY (`numCli`) REFERENCES `CLIENT` (`numCli`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
