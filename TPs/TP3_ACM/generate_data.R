# =============================================================
# Génération d'une ENQUÊTE sur les pratiques numériques (TP3 ACM)
# Master GAMMA / BA / LMAD — Esprit School of Business
# Produit `enquete_numerique.csv` (300 individus × 9 variables qualitatives)
# =============================================================

set.seed(42)
n <- 300

# Profils latents : 4 archétypes générant les corrélations
#   1. Jeune urbain hyper-connecté        (40%)
#   2. Adulte actif moyennement connecté  (30%)
#   3. Senior rural peu connecté          (20%)
#   4. Adolescent / jeune étudiant        (10%)
type <- sample(c("JU", "AAM", "SR", "AE"),
               size = n, replace = TRUE,
               prob = c(0.40, 0.30, 0.20, 0.10))

# Helper : tirage selon une distribution
draw <- function(modalites, probs) sample(modalites, 1, prob = probs)

# Variables conditionnées au profil
sexe <- vector("character", n)
age  <- vector("character", n)
habitat <- vector("character", n)
internet <- vector("character", n)
reseaux <- vector("character", n)
streaming <- vector("character", n)
achats <- vector("character", n)
diplome <- vector("character", n)
prof <- vector("character", n)

for (i in seq_len(n)) {
  t <- type[i]
  sexe[i] <- sample(c("H","F"), 1, prob = c(0.49, 0.51))

  if (t == "JU") {
    age[i]      <- draw(c("18-29","30-49","50-64","65+"), c(0.65,0.30,0.05,0.00))
    habitat[i]  <- draw(c("Rural","PetiteVille","GrandeVille","Metropole"), c(0.05,0.10,0.30,0.55))
    internet[i] <- draw(c("Quotidien","SouventParSemaine","Mensuel","RareJamais"), c(0.92,0.06,0.01,0.01))
    reseaux[i]  <- draw(c("Quotidien","Hebdomadaire","Mensuel","Jamais"), c(0.85,0.10,0.03,0.02))
    streaming[i]<- draw(c("Quotidien","Souvent","Parfois","Jamais"), c(0.70,0.20,0.08,0.02))
    achats[i]   <- draw(c("PlusieursParMois","Mensuel","Rare","Jamais"), c(0.50,0.35,0.12,0.03))
    diplome[i]  <- draw(c("Sans","Bac","BacPlus3","BacPlus5"), c(0.05,0.20,0.45,0.30))
    prof[i]     <- draw(c("Cadre","ProfInt","Employe","Ouvrier","Inactif"), c(0.30,0.25,0.25,0.10,0.10))
  } else if (t == "AAM") {
    age[i]      <- draw(c("18-29","30-49","50-64","65+"), c(0.10,0.55,0.30,0.05))
    habitat[i]  <- draw(c("Rural","PetiteVille","GrandeVille","Metropole"), c(0.15,0.30,0.30,0.25))
    internet[i] <- draw(c("Quotidien","SouventParSemaine","Mensuel","RareJamais"), c(0.55,0.30,0.10,0.05))
    reseaux[i]  <- draw(c("Quotidien","Hebdomadaire","Mensuel","Jamais"), c(0.40,0.30,0.18,0.12))
    streaming[i]<- draw(c("Quotidien","Souvent","Parfois","Jamais"), c(0.30,0.40,0.20,0.10))
    achats[i]   <- draw(c("PlusieursParMois","Mensuel","Rare","Jamais"), c(0.20,0.40,0.30,0.10))
    diplome[i]  <- draw(c("Sans","Bac","BacPlus3","BacPlus5"), c(0.15,0.35,0.35,0.15))
    prof[i]     <- draw(c("Cadre","ProfInt","Employe","Ouvrier","Inactif"), c(0.20,0.30,0.30,0.15,0.05))
  } else if (t == "SR") {
    age[i]      <- draw(c("18-29","30-49","50-64","65+"), c(0.02,0.10,0.40,0.48))
    habitat[i]  <- draw(c("Rural","PetiteVille","GrandeVille","Metropole"), c(0.55,0.30,0.10,0.05))
    internet[i] <- draw(c("Quotidien","SouventParSemaine","Mensuel","RareJamais"), c(0.10,0.20,0.35,0.35))
    reseaux[i]  <- draw(c("Quotidien","Hebdomadaire","Mensuel","Jamais"), c(0.05,0.10,0.20,0.65))
    streaming[i]<- draw(c("Quotidien","Souvent","Parfois","Jamais"), c(0.05,0.15,0.25,0.55))
    achats[i]   <- draw(c("PlusieursParMois","Mensuel","Rare","Jamais"), c(0.02,0.10,0.30,0.58))
    diplome[i]  <- draw(c("Sans","Bac","BacPlus3","BacPlus5"), c(0.55,0.30,0.10,0.05))
    prof[i]     <- draw(c("Cadre","ProfInt","Employe","Ouvrier","Inactif"), c(0.05,0.10,0.20,0.20,0.45))
  } else { # AE
    age[i]      <- draw(c("18-29","30-49","50-64","65+"), c(1.00,0.00,0.00,0.00))
    habitat[i]  <- draw(c("Rural","PetiteVille","GrandeVille","Metropole"), c(0.10,0.25,0.35,0.30))
    internet[i] <- draw(c("Quotidien","SouventParSemaine","Mensuel","RareJamais"), c(0.95,0.05,0.00,0.00))
    reseaux[i]  <- draw(c("Quotidien","Hebdomadaire","Mensuel","Jamais"), c(0.95,0.04,0.01,0.00))
    streaming[i]<- draw(c("Quotidien","Souvent","Parfois","Jamais"), c(0.80,0.15,0.04,0.01))
    achats[i]   <- draw(c("PlusieursParMois","Mensuel","Rare","Jamais"), c(0.35,0.30,0.25,0.10))
    diplome[i]  <- draw(c("Sans","Bac","BacPlus3","BacPlus5"), c(0.20,0.55,0.20,0.05))
    prof[i]     <- draw(c("Cadre","ProfInt","Employe","Ouvrier","Inactif"), c(0.02,0.05,0.10,0.05,0.78))
  }
}

df <- data.frame(
  ID = sprintf("ind_%03d", seq_len(n)),
  Sexe = factor(sexe),
  Age = factor(age, levels = c("18-29","30-49","50-64","65+")),
  Habitat = factor(habitat, levels = c("Rural","PetiteVille","GrandeVille","Metropole")),
  Internet = factor(internet, levels = c("Quotidien","SouventParSemaine","Mensuel","RareJamais")),
  Reseaux = factor(reseaux, levels = c("Quotidien","Hebdomadaire","Mensuel","Jamais")),
  Streaming = factor(streaming, levels = c("Quotidien","Souvent","Parfois","Jamais")),
  Achats = factor(achats, levels = c("PlusieursParMois","Mensuel","Rare","Jamais")),
  Diplome = factor(diplome, levels = c("Sans","Bac","BacPlus3","BacPlus5")),
  Profession = factor(prof,
    levels = c("Cadre","ProfInt","Employe","Ouvrier","Inactif"))
)

write.csv(df, "enquete_numerique.csv", row.names = FALSE)

cat("Généré : enquete_numerique.csv (", nrow(df), "indiv. ×",
    ncol(df) - 1, "variables qualitatives)\n\n")
cat("Distribution des profils latents :\n"); print(table(type))
cat("\nVariables et modalités :\n")
for (v in names(df)[-1]) {
  cat("  ", v, ":", paste(levels(df[[v]]), collapse = " / "), "\n")
}
