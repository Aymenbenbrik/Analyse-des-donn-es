# Analyse des Données

**Master GAMMA · Master Business Analytics · Licence Mathématiques Appliquées (LMAD)**
**Esprit School of Business**

Ce dépôt contient le cours d'**Analyse des Données** dans la tradition de l'école française
(Benzécri, Lebart, Saporta, Escofier-Pagès) : approche géométrique fondée sur l'inertie
et la décomposition matricielle, avec une emphase sur la **théorie** et l'**interprétation**.

## Plan du cours

1. **Introduction & statistiques descriptives multivariées** — tableau de données, $\Sigma$, distance, inertie
2. **Algèbre linéaire pour l'analyse des données** — théorème spectral, SVD, Eckart-Young
3. **Analyse en Composantes Principales (ACP)** — inertie maximale, axes, cercle des corrélations
4. **Analyse Factorielle des Correspondances (AFC)** — tableaux de contingence, $\chi^2$, biplot
5. **Analyse des Correspondances Multiples (ACM)** — TDC, Burt, modalités
6. **Classification** — CAH, k-means, couplage avec ACP/AFC
7. **Analyse Factorielle Discriminante (AFD)** — critère de Fisher, règle de Bayes
8. **Méthodes avancées** — MDS, AFM, analyse canonique, PLS

## Structure du dépôt

```
.
├── slides/
│   ├── main.tex               Préambule Beamer (Metropolis)
│   └── chapters/              Un fichier par chapitre
│       ├── ch1_introduction.tex
│       ├── ch2_algebre_lineaire.tex
│       ├── ch3_acp.tex
│       ├── ch4_afc.tex
│       ├── ch5_acm.tex
│       ├── ch6_classification.tex
│       ├── ch7_afd.tex
│       ├── ch8_methodes_avancees.tex
│       └── bibliographie.tex
├── cours/
│   └── cours_complet.tex      Polycopié (book class) avec démonstrations
├── figures/                   Figures TikZ + PNG
└── TPs/
    ├── TP1_ACP/               Énoncé + correction R + dataset
    ├── TP2_AFC/
    ├── TP3_ACM/
    └── TP4_AFD/
```

## Travaux pratiques

Les TPs sont en **R** avec les packages standards de l'analyse des données :

| TP | Méthode | Dataset | Packages R |
|----|---------|---------|------------|
| TP1 | ACP | `decathlon` (FactoMineR) ou vins | `FactoMineR`, `factoextra`, `corrplot` |
| TP2 | AFC | INSEE CSP × Diplôme | `FactoMineR`, `ca` |
| TP3 | ACM | Enquête consommation | `FactoMineR`, `ade4` |
| TP4 | AFD + classif | Credit scoring | `MASS`, `FactoMineR`, `caret` |

## Prérequis

### Mathématiques (LMAD)
- Algèbre linéaire : valeurs propres, diagonalisation, formes quadratiques
- Probabilités : variance, covariance, espérance conditionnelle
- Statistique inférentielle : tests, estimation

### Logiciel
- **R** ≥ 4.2 avec : `FactoMineR`, `factoextra`, `ade4`, `MASS`, `corrplot`, `cluster`
- **RStudio** (recommandé)
- **LaTeX** (TeX Live ou MiKTeX) avec Beamer/Metropolis

## Compilation

```bash
# Slides
cd slides && pdflatex main.tex && pdflatex main.tex

# Polycopié
cd cours && pdflatex cours_complet.tex && pdflatex cours_complet.tex
```

## Références principales

- **Saporta, G.** (2011). *Probabilités, analyse des données et statistique* (3e éd.). Technip.
- **Lebart, L., Morineau, A., Piron, M.** (2006). *Statistique exploratoire multidimensionnelle*. Dunod.
- **Escofier, B., Pagès, J.** (2008). *Analyses factorielles simples et multiples*. Dunod.
- **Husson, F., Lê, S., Pagès, J.** (2017). *Analyse de données avec R* (2e éd.). PUR.
- **Benzécri, J.-P.** (1973). *L'analyse des données* (2 vol.). Dunod.

## Licence

Matériel pédagogique pour usage académique — Esprit School of Business.
