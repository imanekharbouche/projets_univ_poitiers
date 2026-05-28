CREATE TABLE SAUNIER(
   numSau INT,
   nomSau VARCHAR(50) NOT NULL,
   prenomSau VARCHAR(50) NOT NULL,
   villeSau VARCHAR(50) NOT NULL,
   PRIMARY KEY(numSau)
)ENGINE = InnoDB; 

CREATE TABLE PRODUIT(
   numPdt INT,
   libPdt VARCHAR(255) NOT NULL,
   stockPdt INT NOT NULL,
   PRIMARY KEY(numPdt), 
   UNIQUE (libPdt)
)ENGINE = InnoDB; 

CREATE TABLE CLIENT(
   numCli INT,
   nomCli VARCHAR(50) NOT NULL,
   precisionCli VARCHAR(255) NOT NULL,
   villeCli VARCHAR(50) NOT NULL,
   PRIMARY KEY(numCli),
   UNIQUE (nomCli, villeCli)
)ENGINE = InnoDB; 

CREATE TABLE SORTIE(
   numSort VARCHAR(50),
   dateSort DATETIME NOT NULL,
   numCli INT NOT NULL,
   PRIMARY KEY(numSort),
   FOREIGN KEY(numCli) REFERENCES CLIENT(numCli)
)ENGINE = InnoDB; 

CREATE TABLE PRIX(
   anneePrix INT,
   numPdt INT,  
   achatPrix DECIMAL(15,2) NOT NULL,
   ventePrix DECIMAL(15,2) NOT NULL,
   PRIMARY KEY(anneePrix, numPdt),  
   FOREIGN KEY (numPdt) REFERENCES PRODUIT(numPdt)  
) ENGINE = InnoDB;
 

CREATE TABLE ENTREE(
   numEnt INT,
   dateEnt DATETIME NOT NULL,
   qteEnt INT NOT NULL,
   numPdt INT NOT NULL,
   numSau INT NOT NULL,
   PRIMARY KEY(numEnt),
   FOREIGN KEY(numSau) REFERENCES SAUNIER(numSau),
   FOREIGN KEY(numPdt) REFERENCES PRODUIT(numPdt)
)ENGINE = InnoDB; 


CREATE TABLE CONCERNER(
   numSort VARCHAR(50),
   numPdt INT,
   qteSort INT NOT NULL,
   PRIMARY KEY(numPdt, numSort),
   FOREIGN KEY(numPdt) REFERENCES PRODUIT(numPdt),
   FOREIGN KEY(numSort) REFERENCES SORTIE(numSort)
)ENGINE = InnoDB; 
 