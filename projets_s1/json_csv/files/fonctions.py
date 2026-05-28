################################################################################
#                   SAE : Gestion de fichiers en Python                        #
#                       CREE LE : 21 Novembre 2024                             #
#                     Imane KHARBOUCHE & Théo GARDERE                          #
#                               BUT 1 SD                                       #
#                               TDA - TPB                                      #
################################################################################
# fichier : fonctions.py                                                       #
################################################################################

import re  # Importation du module pour les expressions régulières

# Fonction pour extraire une valeur à partir d'une structure de données (dictionnaire ou liste)
def obtenir_valeurs(valeur , keys, val_defaut=" "):
    while keys:  # Tant qu'il y a des clés à traiter
        key = keys.pop(0)  # On prend la première clé de la liste
        valeur = valeur.get(key, val_defaut)  # On récupère la valeur associée à cette clé, ou la valeur par défaut
        
        # Si la valeur est une chaîne, on enlève les balises HTML (si présentes)
        if isinstance(valeur, str):
            valeur = re.sub(r'<.*?>', '', valeur)
        
        # Si la valeur est une liste, on la transforme en une chaîne où les éléments sont séparés par des virgules
        elif isinstance(valeur, list):
            valeur = ', '.join(valeur)
        
        # Si la valeur est un dictionnaire contenant des coordonnées (lat, lon), on les transforme en une chaîne
        elif isinstance(valeur, dict) and 'lat' in valeur and 'lon' in valeur:
           valeur = str(valeur['lat']) + ", " + str(valeur['lon'])
    return valeur  # Retourne la valeur extraite ou la valeur par défaut si la clé n'est pas trouvée

# Fonction pour convertir une date au format "jour/mois/année" à partir d'une chaîne ISO
def obtenir_date(date):
    try:
        date_part = date.split('T')[0]  # On sépare la date de l'heure
        annee, mois, jour = date_part.split('-')  # On extrait l'année, le mois et le jour
        return str(jour) + "/" + str(mois) + "/" + str(annee)  # On retourne la date formatée "jour/mois/année"
    except ValueError:
        return date  # Si la date est mal formatée, on retourne la chaîne telle quelle

# Fonction pour extraire l'heure d'une chaîne datetime au format ISO
def obtenir_heure(heures):
    try:
        temps = heures.split('T')[1].split('+')[0]  # On extrait l'heure avant le fuseau horaire
        heure, minute, _ = temps.split(':')  # On sépare l'heure et les minutes
        return str(heure) + ":" + str(minute)  # On retourne l'heure formatée "HH:MM"
    except ValueError:
        return None  # Si une erreur se produit, on retourne None

# Fonction pour obtenir plusieurs occurrences d'événements, avec des plages horaires différentes
def obtenir_occurrences(occurrences):
    occurrences = occurrences.split(';')  # On sépare les occurrences en utilisant le point-virgule
    l_occurences = []  # Liste pour stocker les occurrences formatées
    for occ in occurrences:
        try:
            debut, fin = occ.split('_')  # On sépare la date de début et de fin
            date_debut = obtenir_date(debut)  # On récupère la date de début
            heure_debut = obtenir_heure(debut)  # On récupère l'heure de début
            date_fin = obtenir_date(fin)  # On récupère la date de fin
            heure_fin = obtenir_heure(fin)  # On récupère l'heure de fin
            # On ajoute l'occurrence formatée dans la liste
            l_occurences.append(str(date_debut) + str(heure_debut) + "-" + str(date_fin) + str(heure_fin))
        except ValueError:
            continue  # On ignore les erreurs de format, et on passe à la prochaine occurrence
    return '; '.join(l_occurences)  # On retourne toutes les occurrences sous forme de chaîne, séparées par des ";"
