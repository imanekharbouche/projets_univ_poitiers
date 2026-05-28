import csv
import json
from fonctions import obtenir_valeurs, obtenir_date, obtenir_heure

# Chemins des fichiers JSON et CSV dans le même répertoire que le script Python
file_path_json = 'que-faire-a-paris-.json'
file_path_csv = 'que-faire-a-paris.csv'

# Essai pour vérifier l'existence du fichier JSON
try:
    with open(file_path_json, 'r', encoding='utf-8') as fichierjson: 
        print("Données chargées !")
        contenu = json.load(fichierjson)

    with open(file_path_csv, mode='w', newline='', encoding='utf-8-sig') as fichiercsv:
        ecritCSV = csv.writer(fichiercsv, delimiter=";")
        
        # En-têtes du CSV
        ecritCSV.writerow([
            "ID", "URL", "Titre", "Chapeau", "Description", "Mots clés", "Date de début", "Heure de début", 
            "Date de fin", "Heure de Fin", "Nom du lieu", "Adresse du lieu", "Code Postal", "Ville", 
            "Coordonnées géographiques", "Accès PMR", "Accès mal voyant", "Accès mal entendant", "Transport", 
            "Nom de contact", "Téléphone de contact", "Email de contact", "Url de contact", 
            "Type d’accès", "Détail du prix", "URL de l’image de couverture"
        ])

        # Liste des événements dans le JSON
        for evenement in contenu:
            ligne = [
                obtenir_valeurs(evenement, ["id"]),
                obtenir_valeurs(evenement, ["url"]),
                obtenir_valeurs(evenement, ["title"]),
                obtenir_valeurs(evenement, ["lead_text"]),
                obtenir_valeurs(evenement, ["description"]),
                obtenir_valeurs(evenement, ["tags"]),
                obtenir_date(obtenir_valeurs(evenement, ["date_start"])),
                obtenir_heure(obtenir_valeurs(evenement, ["date_start"])),
                obtenir_date(obtenir_valeurs(evenement, ["date_end"])),
                obtenir_heure(obtenir_valeurs(evenement, ["date_end"])),
                obtenir_valeurs(evenement, ["address_name"]),
                obtenir_valeurs(evenement, ["address_street"]),
                obtenir_valeurs(evenement, ["address_zipcode"]),
                obtenir_valeurs(evenement, ["address_city"]),
                obtenir_valeurs(evenement, ["lat_lon"]),
                obtenir_valeurs(evenement, ["pmr"]),
                obtenir_valeurs(evenement, ["blind"]),
                obtenir_valeurs(evenement, ["deaf"]),
                obtenir_valeurs(evenement, ["transport"]),
                obtenir_valeurs(evenement, ["contact_name"]),
                obtenir_valeurs(evenement, ["contact_phone"]),
                obtenir_valeurs(evenement, ["contact_mail"]),
                obtenir_valeurs(evenement, ["contact_url"]),
                obtenir_valeurs(evenement, ["access_type"]),
                obtenir_valeurs(evenement, ["price_detail"]),
                obtenir_valeurs(evenement, ["cover_url"])
            ]
            # Vérification avant d'écrire
            print(f"Écriture de la ligne : {ligne}")
            ecritCSV.writerow(ligne)

    print("  processus terminé  ")

except FileNotFoundError:
    print("Le fichier n'a pas été trouvé. Chemin a reverifier")
except json.JSONDecodeError:
    print("Problème du décodage du fichier JSON.")
except Exception :
    print("Erreur ")
