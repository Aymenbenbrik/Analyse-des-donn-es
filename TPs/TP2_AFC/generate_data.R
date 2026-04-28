# =============================================================
# Génération de DEUX tableaux de contingence pour le TP2 AFC
# Master GAMMA / BA / LMAD — Esprit School of Business
# =============================================================
# Dataset 1 : CSP × Niveau de diplôme (inspiré INSEE)
# Dataset 2 : Région × Mode de transport (mobilité quotidienne)
# =============================================================

set.seed(42)

# ---- DATASET 1 : CSP × Diplôme -----------------------------
# Totaux marginaux réalistes (en milliers)
csp <- c(
  "Cadres",
  "ProfessionsIntermediaires",
  "Employes",
  "Ouvriers",
  "Artisans_Commercants",
  "Agriculteurs"
)

dipl <- c(
  "Sans_diplome", "Brevet", "CAP_BEP", "Bac",
  "Bac_plus2", "Licence", "Master", "Doctorat"
)

# Probabilités conditionnelles (diplôme | CSP) - structure réaliste forte
prob_cond <- rbind(
  Cadres                    = c(0.01, 0.02, 0.04, 0.08, 0.15, 0.25, 0.35, 0.10),
  ProfessionsIntermediaires = c(0.03, 0.05, 0.10, 0.18, 0.32, 0.20, 0.10, 0.02),
  Employes                  = c(0.10, 0.15, 0.30, 0.25, 0.13, 0.05, 0.02, 0.00),
  Ouvriers                  = c(0.20, 0.25, 0.40, 0.10, 0.04, 0.01, 0.00, 0.00),
  Artisans_Commercants      = c(0.12, 0.15, 0.32, 0.20, 0.13, 0.06, 0.02, 0.00),
  Agriculteurs              = c(0.25, 0.20, 0.35, 0.10, 0.07, 0.02, 0.01, 0.00)
)

# Effectifs par CSP (en milliers, France ~25M actifs)
n_csp <- c(Cadres = 4500, ProfessionsIntermediaires = 6000,
           Employes = 6800, Ouvriers = 5200,
           Artisans_Commercants = 1700, Agriculteurs = 800)

# Tableau de contingence (avec léger bruit)
tab1 <- round(prob_cond * n_csp + matrix(rnorm(length(prob_cond), 0, 5),
                                           nrow = nrow(prob_cond)))
tab1[tab1 < 0] <- 0
colnames(tab1) <- dipl
tab1 <- as.table(tab1)

write.csv(as.data.frame.matrix(tab1), "csp_diplome.csv")
cat("Généré : csp_diplome.csv (", nrow(tab1), "x", ncol(tab1),
    "), total =", sum(tab1), "\n")
print(addmargins(tab1))


# ---- DATASET 2 : Région × Mode de transport ----------------
regions <- c("IleDeFrance", "AURA", "Occitanie", "GrandEst",
             "Bretagne", "PACA", "Normandie", "HautsDeFrance")

modes <- c("Voiture", "Transports_commun", "Velo", "Marche",
           "Train", "DeuxRoues_motor")

prob_cond2 <- rbind(
  IleDeFrance     = c(0.30, 0.42, 0.06, 0.10, 0.08, 0.04),
  AURA            = c(0.65, 0.18, 0.06, 0.07, 0.02, 0.02),
  Occitanie       = c(0.72, 0.12, 0.05, 0.06, 0.02, 0.03),
  GrandEst        = c(0.74, 0.13, 0.04, 0.05, 0.02, 0.02),
  Bretagne        = c(0.78, 0.08, 0.05, 0.06, 0.01, 0.02),
  PACA            = c(0.65, 0.15, 0.04, 0.07, 0.02, 0.07),
  Normandie       = c(0.78, 0.09, 0.03, 0.05, 0.03, 0.02),
  HautsDeFrance   = c(0.72, 0.13, 0.03, 0.06, 0.04, 0.02)
)

n_reg <- c(IleDeFrance = 6500, AURA = 3500, Occitanie = 2700,
           GrandEst = 2400, Bretagne = 1500, PACA = 2200,
           Normandie = 1500, HautsDeFrance = 2700)

tab2 <- round(prob_cond2 * n_reg + matrix(rnorm(length(prob_cond2), 0, 3),
                                            nrow = nrow(prob_cond2)))
tab2[tab2 < 0] <- 0
colnames(tab2) <- modes
tab2 <- as.table(tab2)

write.csv(as.data.frame.matrix(tab2), "region_transport.csv")
cat("\nGénéré : region_transport.csv (", nrow(tab2), "x", ncol(tab2),
    "), total =", sum(tab2), "\n")
print(addmargins(tab2))
