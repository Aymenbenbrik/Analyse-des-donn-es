# =============================================================
# Génération du jeu CREDIT SCORING pour le TP4 AFD
# Master GAMMA / BA / LMAD — Esprit School of Business
# Produit `credit_scoring.csv` (500 dossiers × 8 variables + classe)
# =============================================================

set.seed(42)

n_bons     <- 380   # bons clients (~76%)
n_defauts  <- 120   # défauts     (~24%)
n <- n_bons + n_defauts

# ---- Bons clients : profil stable ----------------------------
bons <- data.frame(
  Age              = round(rnorm(n_bons, 42, 9)),
  Revenu_kEUR      = round(rlnorm(n_bons, log(45), 0.30), 1),
  Anciennete_emp   = round(rnorm(n_bons, 8.0, 4)),
  Nb_credits       = sample(0:4, n_bons, replace = TRUE,
                              prob = c(0.30, 0.35, 0.20, 0.10, 0.05)),
  Ratio_endett     = round(rnorm(n_bons, 0.25, 0.10), 3),
  Nb_incidents_12m = sample(0:5, n_bons, replace = TRUE,
                              prob = c(0.78, 0.15, 0.05, 0.01, 0.005, 0.005)),
  Score_externe    = round(rnorm(n_bons, 720, 60)),
  Patrimoine_kEUR  = round(rlnorm(n_bons, log(80), 0.7), 0),
  Defaut           = factor("Bon", levels = c("Bon", "Defaut"))
)

# ---- Défauts : profil dégradé --------------------------------
defauts <- data.frame(
  Age              = round(rnorm(n_defauts, 35, 11)),
  Revenu_kEUR      = round(rlnorm(n_defauts, log(28), 0.45), 1),
  Anciennete_emp   = round(rnorm(n_defauts, 3.0, 3)),
  Nb_credits       = sample(0:6, n_defauts, replace = TRUE,
                              prob = c(0.05, 0.10, 0.20, 0.30, 0.20, 0.10, 0.05)),
  Ratio_endett     = round(rnorm(n_defauts, 0.55, 0.15), 3),
  Nb_incidents_12m = sample(0:8, n_defauts, replace = TRUE,
                              prob = c(0.20, 0.20, 0.20, 0.15, 0.10, 0.07, 0.05, 0.02, 0.01)),
  Score_externe    = round(rnorm(n_defauts, 580, 80)),
  Patrimoine_kEUR  = round(rlnorm(n_defauts, log(15), 0.8), 0),
  Defaut           = factor("Defaut", levels = c("Bon", "Defaut"))
)

# Concaténation et bornage réaliste
df <- rbind(bons, defauts)
df$Age              <- pmin(pmax(df$Age, 18), 75)
df$Revenu_kEUR      <- pmin(pmax(df$Revenu_kEUR, 8), 250)
df$Anciennete_emp   <- pmin(pmax(df$Anciennete_emp, 0), 40)
df$Ratio_endett     <- pmin(pmax(df$Ratio_endett, 0), 1.2)
df$Score_externe    <- pmin(pmax(df$Score_externe, 350), 900)
df$Patrimoine_kEUR  <- pmax(df$Patrimoine_kEUR, 0)

# Mélange
df <- df[sample.int(nrow(df)), ]
df$ID <- sprintf("client_%04d", seq_len(nrow(df)))
df <- df[, c("ID", "Age", "Revenu_kEUR", "Anciennete_emp",
             "Nb_credits", "Ratio_endett", "Nb_incidents_12m",
             "Score_externe", "Patrimoine_kEUR", "Defaut")]

write.csv(df, "credit_scoring.csv", row.names = FALSE)

cat("Généré : credit_scoring.csv (", nrow(df), "dossiers ×",
    ncol(df) - 2, "variables prédictives + 1 cible)\n\n")
cat("Distribution de la cible :\n"); print(table(df$Defaut))
cat("\nMoyennes par classe :\n")
num_cols <- sapply(df, is.numeric)
print(round(aggregate(df[, num_cols], by = list(Defaut = df$Defaut), FUN = mean), 2))
