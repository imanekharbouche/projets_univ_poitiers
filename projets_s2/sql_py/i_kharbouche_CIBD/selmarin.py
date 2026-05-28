#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Créé le Lun Mar 24 10:03:20 2025

@auteur : imanekharbouche
"""

# Importation des bibliothèques nécessaires
from openpyxl import load_workbook  # Pour lire les fichiers Excel
import mysql.connector  # Pour se connecter à MySQL
import datetime  # Pour gérer les dates et heures

# Définition des fichiers Excel à traiter
f_selmarin = "sel_marin_2023.xlsx"


###############################################################################
# Connexion à la base de données
# Configuration pour MAMP, mais cette section est commentée
"""
params = {
    'user': 'root',
    'password': 'root',
    'host': 'localhost',
    'unix_socket': '/Applications/MAMP/tmp/mysql/mysql.sock',
    'database': 'selmarin',
    'raise_on_warnings': True
}
"""
# Paramètres pour EasyPHP (utilisé ici)
params = {"host":"localhost","user":"root","password":"","database":"selmarin"} 

###############################################################################

# Fonction pour lire les données d'un fichier Excel
def lire_donnees_excel(nom_fichier, nom_feuille):
    donnees = []
    classeur = load_workbook(nom_fichier)  # Chargement du fichier Excel
    feuille = classeur[nom_feuille]  # Sélection de la feuille spécifique
    # Lecture des données ligne par ligne à partir de la deuxième ligne
    for ligne in feuille.iter_rows(min_row=2, values_only=True):
        if ligne[0] is not None:  # Vérifie que la première colonne n'est pas vide
            donnees.append(ligne)  # Ajoute la ligne aux données
    return donnees

# Fonction pour insérer des données dans la table SAUNIER
def saunier(): 
    donnees_sau = lire_donnees_excel(f_selmarin, "SAUNIER")  # Lecture des données de la feuille "SAUNIER"
    db = mysql.connector.connect(**params)  # Connexion à la base de données
    c = db.cursor()  # Création d'un curseur pour exécuter les requêtes
    count = 0  # Compteur pour le nombre d'insertions réussies
    for ligne in donnees_sau:
        try:
            # Vérifie si l'enregistrement existe déjà
            c.execute("SELECT numSau FROM SAUNIER WHERE numSau = %s", (ligne[0],))
            if c.fetchone():
                print("ligne existe")  # Si l'enregistrement existe, passe à la suivante
            else:
                # Insère l'enregistrement dans la table SAUNIER
                c.execute("INSERT INTO SAUNIER VALUES (%s, %s, %s, %s)", (ligne[0], ligne[1], ligne[2], ligne[3]))
                count += 1  # Incrémentation du compteur
        except:
            print("Erreur insertion SAUNIER")  # Gestion des erreurs
    db.commit()  # Valide les modifications dans la base de données
    print("SAUNIER - Lignes insérées :", count)  # Affiche le nombre de lignes insérées

# Fonction pour insérer des données dans la table CLIENT
def client(): 
    donnees_cli = lire_donnees_excel(f_selmarin, "CLIENT")  # Lecture des données de la feuille "CLIENT"
    db = mysql.connector.connect(**params)  # Connexion à la base de données
    c = db.cursor()  # Création d'un curseur pour exécuter les requêtes
    count = 0  # Compteur pour le nombre d'insertions réussies
    for ligne in donnees_cli:
        try:
            # Vérifie si l'enregistrement existe déjà
            c.execute("SELECT numCli FROM CLIENT WHERE numCli = %s", (ligne[0],))
            if c.fetchone():
                print("ligne existe")  # Si l'enregistrement existe, passe à la suivante
            else:
                # Insère l'enregistrement dans la table CLIENT
                c.execute("INSERT INTO CLIENT VALUES (%s, %s, %s, %s)", (ligne[0], ligne[1], ligne[2], ligne[3]))
                count += 1  # Incrémentation du compteur
        except:
            print("Erreur insertion CLIENT")  # Gestion des erreurs
    db.commit()  # Valide les modifications dans la base de données
    print("CLIENT - Lignes insérées :", count)  # Affiche le nombre de lignes insérées

# Fonction pour insérer des données dans la table ENTREE
def entree(): 
    donnees_ent = lire_donnees_excel(f_selmarin, "ENTREE")  # Lecture des données de la feuille "ENTREE"
    db = mysql.connector.connect(**params)  # Connexion à la base de données
    c = db.cursor()  # Création d'un curseur pour exécuter les requêtes
    count = 0  # Compteur pour le nombre d'insertions réussies
    for ligne in donnees_ent:
        d = ligne[1]  # Récupère la date de la ligne
        if not isinstance(d, datetime.datetime):  # Si la date n'est pas au bon format, essaie de la convertir
            try:
                d = datetime.datetime.strptime(str(d), "%Y-%m-%d %H:%M:%S")
            except:
                d = datetime.datetime.now()  # Si la conversion échoue, utilise la date actuelle
        try:
            # Vérifie si l'enregistrement existe déjà
            c.execute("SELECT numEnt FROM ENTREE WHERE numEnt = %s", (ligne[0],))
            if c.fetchone():
                print("ligne existe")  # Si l'enregistrement existe, passe à la suivante
            else:
                # Insère l'enregistrement dans la table ENTREE
                c.execute("INSERT INTO ENTREE VALUES (%s, %s, %s, %s, %s)", (ligne[0], d, ligne[2], ligne[3], ligne[4]))
                count += 1  # Incrémentation du compteur
        except:
            print("Erreur insertion ENTREE")  # Gestion des erreurs
    db.commit()  # Valide les modifications dans la base de données
    print("ENTREE - Lignes insérées :", count)  # Affiche le nombre de lignes insérées

# Fonction pour insérer des données dans les tables SORTIE et CONCERNER
def sc(): 
    donnees_sort = lire_donnees_excel(f_selmarin, "SORTIE")  # Lecture des données de la feuille "SORTIE"
    db = mysql.connector.connect(**params)  # Connexion à la base de données
    c = db.cursor()  # Création d'un curseur pour exécuter les requêtes
    count_sortie = 0  # Compteur pour le nombre d'insertions dans SORTIE
    count_concerner = 0  # Compteur pour le nombre d'insertions dans CONCERNER
    for ligne in donnees_sort:
        d = ligne[1]  # Récupère la date de la ligne
        if not isinstance(d, datetime.datetime):  # Si la date n'est pas au bon format, essaie de la convertir
            try:
                d = datetime.datetime.strptime(str(d), "%Y-%m-%d %H:%M:%S")
            except:
                d = datetime.datetime.now()  # Si la conversion échoue, utilise la date actuelle
        try:
            # Vérifie si l'enregistrement existe déjà dans la table SORTIE
            c.execute("SELECT numSort FROM SORTIE WHERE numSort = %s", (ligne[0],))
            if c.fetchone():
                print("ligne existe")  # Si l'enregistrement existe, passe à la suivante
            else:
                # Insère l'enregistrement dans la table SORTIE
                c.execute("INSERT INTO SORTIE VALUES (%s, %s, %s)", (ligne[0], d, ligne[2]))
                count_sortie += 1  # Incrémentation du compteur SORTIE
            # Vérifie si l'enregistrement existe déjà dans la table CONCERNER
            c.execute("SELECT * FROM CONCERNER WHERE numSort = %s AND numPdt = %s", (ligne[0], ligne[3]))
            if c.fetchone():
                print("ligne existe")  # Si l'enregistrement existe, passe à la suivante
            else:
                # Insère l'enregistrement dans la table CONCERNER
                c.execute("INSERT INTO CONCERNER VALUES (%s, %s, %s)", (ligne[0], ligne[3], ligne[4]))
                count_concerner += 1  # Incrémentation du compteur CONCERNER
        except:
            print("Erreur insertion SORTIE ou CONCERNER")  # Gestion des erreurs
    db.commit()  # Valide les modifications dans la base de données
    print("SORTIE - Lignes insérées :", count_sortie)  # Affiche le nombre de lignes insérées dans SORTIE
    print("CONCERNER - Lignes insérées :", count_concerner)  # Affiche le nombre de lignes insérées dans CONCERNER

# Exécution des fonctions pour insérer les données dans les différentes tables
str(saunier())
str(client())
str(entree())
str(sc())