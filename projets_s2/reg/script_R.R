setwd("")

# Charger les données
train <- read.csv2("train.csv")
test <- read.csv2("test.csv")

# Exclusion des valeurs aberrantes (train)
train = train[train$Valeur.fonciere <= 335000 ,]

# Mise en place des saisons (train / test)
saison_immobiliere <- function(date) {
  mois <- as.integer(format(date, "%m"))
  
  if (mois %in% c(12, 1, 2)) {
    return("Hiver")
  } else if (mois %in% c(3, 4, 5)) {
    return("Printemps")
  } else if (mois %in% c(6, 7, 8)) {
    return("Été")
  } else if (mois %in% c(9, 10, 11)) {
    return("Automne")
  }
}

#train
#transforme la date mutation en type date
train$Date.mutation <- as.Date(train$Date.mutation)
#Ajoute une colonne saison
train$saison <- sapply(train$Date.mutation, saison_immobiliere)

#test
#transforme la date mutation en type date
test$Date.mutation <- as.Date(test$Date.mutation)
#Ajoute une colonne saison
test$saison <- sapply(test$Date.mutation, saison_immobiliere)

# Définition qui permet de calculer les modèles de régression
calculs_regression <- function(x, y) {
  # Calcul des variances et de la covariance
  varx <- mean(x^2) - mean(x)^2
  vary <- mean(y^2) - mean(y)^2
  covxy <- mean(x * y) - mean(x) * mean(y)
  
  # Calcul des coefficients de la droite de régression
  a <- covxy / varx
  b <- mean(y) - a * mean(x)
  return(c(a, b))
}

#Séparation des tableaux avec les filtres (train)
train_appartement <- subset(train, Type.local == "Appartement")
train_maison_hiver <- subset(train, Type.local == "Maison" & saison == "Hiver")
train_maison_printemps <- subset(train, Type.local == "Maison" & saison == "Printemps")
train_maison_automne <- subset(train, Type.local == "Maison" & saison == "Automne")  
train_maison_ete <- subset(train, Type.local == "Maison" & saison == "Été")  

#Séparation des tableaux avec les filtres (test)
test_appartement <- subset(test, Type.local == "Appartement")
test_maison_hiver <- subset(test, Type.local == "Maison" & saison == "Hiver")
test_maison_printemps <- subset(test, Type.local == "Maison" & saison == "Printemps")
test_maison_automne <- subset(test, Type.local == "Maison" & saison == "Automne")  
test_maison_ete <- subset(test, Type.local == "Maison" & saison == "Été") 

#Calculer a et b pour les modèles puissance (train)
equation_appartement <- calculs_regression(log(train_appartement$Surface.reelle.bati), log(train_appartement$Valeur.fonciere))
equation_maison_hiver <- calculs_regression(log(train_maison_hiver$Surface.reelle.bati), log(train_maison_hiver$Valeur.fonciere))
equation_maison_printemps <- calculs_regression(log(train_maison_printemps$Surface.reelle.bati), log(train_maison_printemps$Valeur.fonciere))
equation_maison_automne <- calculs_regression(log(train_maison_automne$Surface.reelle.bati), log(train_maison_automne$Valeur.fonciere))
equation_maison_ete <- calculs_regression(log(train_maison_ete$Surface.reelle.bati), log(train_maison_ete$Valeur.fonciere))

#Calculer la prédiction (test) y = a*x**b

test_appartement$Valeur.fonciere <- exp(equation_appartement[2]) * (test_appartement$Surface.reelle.bati^equation_appartement[1])
test_maison_hiver$Valeur.fonciere <- exp(equation_maison_hiver[2]) * (test_maison_hiver$Surface.reelle.bati^equation_maison_hiver[1])
test_maison_printemps$Valeur.fonciere <- exp(equation_maison_printemps[2]) * (test_maison_printemps$Surface.reelle.bati^equation_maison_printemps[1])
test_maison_automne$Valeur.fonciere <- exp(equation_maison_automne[2]) * (test_maison_automne$Surface.reelle.bati^equation_maison_automne[1])
test_maison_ete$Valeur.fonciere <- exp(equation_maison_ete[2]) * (test_maison_ete$Surface.reelle.bati^equation_maison_ete[1])

#Fusionner les tableaux
test_end <- rbind(test_appartement, test_maison_hiver, test_maison_printemps, test_maison_automne, test_maison_ete)

#Supprimer les colonnes inutiles
test_end <- subset(test_end, select = -c(Date.mutation, Nature.mutation, Code.postal, Commune, Code.departement, Type.local, Surface.reelle.bati, Nombre.pieces.principales, Surface.terrain, saison))

#Écrire le fichier CSV
write.csv2(test_end, file="prediction.csv", row.names = FALSE)

