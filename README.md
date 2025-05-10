# 🌍 Principal Component Analysis on Global Socioeconomic Indicators (R)

This project performs Principal Component Analysis (PCA) using R on a dataset of 179 countries with 26 numeric socioeconomic, demographic, and environmental indicators.

---

## 📁 Dataset

- **Title**: Global Country Information Dataset 2023
- **Source**: [Kaggle - Countries of the World 2023](https://www.kaggle.com/datasets/nelgiriyewithana/countries-of-the-world-2023)
- **Observations**: 179 countries
- **Variables**: GDP, population, CO₂ emissions, education enrollment rates, fertility, mortality, etc.

---

## 🎯 Objective

- To reduce the dimensionality of 26 numeric variables
- To identify major latent components that explain global country-level variation
- To interpret patterns of countries based on socioeconomic structures

---

## ⚙️ Methods & Tools

- Language: **R**
- Libraries: `dplyr`, `ggplot2`, `ggrepel`
- PCA implementation: `prcomp()` with standardization
- Data preprocessing: handling missing values, formatting (% , $), renaming columns

---

## 📊 Key Results

- **PC1** (25% variance): Interpreted as a component related to economic & social development (e.g., education, healthcare, minimum wage)
- **PC2** (17% variance): Related to national power and resource scale (e.g., GDP, land size, military)
- Top contributing countries: China, India, Russia, USA
- Scree plot suggests ~6 to 8 meaningful components (eigenvalue > 1)
- PCA loading plots highlight variable clusters and correlations (e.g., population ↔ CO2 ↔ GDP)

---

## 📁 File Structure
