# =============================================================
# Génération du jeu de données VINS DE BORDEAUX (TP1 ACP)
# Master GAMMA / BA / LMAD — Esprit School of Business
# Produit `vins_bordeaux.csv` (40 vins × 8 variables)
# =============================================================

set.seed(42)

# Trois grandes familles de vins (génère une structure ACP nette)
gen_vin <- function(n, prof) {
  # prof = liste des moyennes pour chaque variable
  with(prof,
    data.frame(
      Acidite     = round(rnorm(n, mean = m_ac,  sd = 0.4), 2),
      Tannins     = round(rnorm(n, mean = m_ta,  sd = 0.5), 2),
      Sucre       = round(rnorm(n, mean = m_su,  sd = 0.6), 2),
      Alcool      = round(rnorm(n, mean = m_al,  sd = 0.4), 2),
      Aromatique  = round(rnorm(n, mean = m_ar,  sd = 0.5), 2),
      Intensite   = round(rnorm(n, mean = m_in,  sd = 0.5), 2),
      Note        = round(rnorm(n, mean = m_no,  sd = 0.6), 1),
      Prix_eur    = round(exp(rnorm(n, mean = log(m_pr), sd = 0.25)), 0)
    )
  )
}

# Profil 1 : VINS PUISSANTS (Pomerol, Saint-Émilion)
v1 <- gen_vin(15, list(
  m_ac = 5.5, m_ta = 8.5, m_su = 2.0, m_al = 14.0,
  m_ar = 8.5, m_in = 8.5, m_no = 17, m_pr = 90
))
v1$Appellation <- "Pomerol_StEmilion"

# Profil 2 : VINS ÉQUILIBRÉS (Médoc classés)
v2 <- gen_vin(15, list(
  m_ac = 6.0, m_ta = 7.0, m_su = 1.5, m_al = 13.0,
  m_ar = 7.0, m_in = 7.0, m_no = 15, m_pr = 50
))
v2$Appellation <- "Medoc_classe"

# Profil 3 : VINS LÉGERS (Bordeaux génériques, jeunes)
v3 <- gen_vin(10, list(
  m_ac = 6.5, m_ta = 5.0, m_su = 1.0, m_al = 12.0,
  m_ar = 5.0, m_in = 5.0, m_no = 13, m_pr = 15
))
v3$Appellation <- "Bordeaux_generique"

# Concaténation et bornage réaliste
df <- rbind(v1, v2, v3)
df$Acidite    <- pmin(pmax(df$Acidite,    3),  9)
df$Tannins    <- pmin(pmax(df$Tannins,    1), 10)
df$Sucre      <- pmin(pmax(df$Sucre,      0),  5)
df$Alcool     <- pmin(pmax(df$Alcool,    11), 16)
df$Aromatique <- pmin(pmax(df$Aromatique, 1), 10)
df$Intensite  <- pmin(pmax(df$Intensite,  1), 10)
df$Note       <- pmin(pmax(df$Note,      10), 20)
df$Prix_eur   <- pmin(pmax(df$Prix_eur,   8),  500)

# Identifiant
df$Vin <- sprintf("Vin_%02d", seq_len(nrow(df)))

# Mélange pour éviter l'ordre trivial
df <- df[sample.int(nrow(df)), ]
rownames(df) <- df$Vin

# Réordonnancement des colonnes
df <- df[, c("Vin", "Acidite", "Tannins", "Sucre", "Alcool",
             "Aromatique", "Intensite", "Note", "Prix_eur",
             "Appellation")]

write.csv(df, "vins_bordeaux.csv", row.names = FALSE)
cat("Généré : vins_bordeaux.csv (",
    nrow(df), "vins ×",
    ncol(df) - 2, "variables actives + 2 supplémentaires)\n")
print(table(df$Appellation))
print(round(colMeans(df[, 2:9]), 2))
