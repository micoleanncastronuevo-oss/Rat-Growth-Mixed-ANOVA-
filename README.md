# Castronuevo, Micole Ann M.
# BIO2105 Sec 4
# Biostatistics

# Rat Growth: Mixed-Design Repeated Measures ANOVA

## Project Overview

This project examines changes in rat body weight across five measurement occasions over a four-week period using a mixed-design repeated measures Analysis of Variance (ANOVA). It investigates whether body weight differs among three treatment groups (Control, Thiouracil, and Thyroxin), changes significantly over time, and whether the pattern of weight gain depends on the treatment administered.

The analysis is performed using R to evaluate the effects of Treatment, Time, and their interaction on rat body weight.

## Research Objectives

This study aims to:

1. Determine whether rat body weight changes significantly across the five measurement occasions.
2. Determine whether significant differences in body weight exist among the Control, Thiouracil, and Thyroxin treatment groups.
3. Examine whether the pattern of body weight changes over time differs significantly among the treatment groups.

## Dataset Description

The dataset used in this project is the `rats` dataset from the `nlmm` R package.

It contains body weight measurements from 27 rats across three treatment groups, resulting in 135 observations. Each rat was measured at five occasions: Baseline (Week 0), Week 1, Week 2, Week 3, and Week 4.

### Variables

| Variable |                         Description                              | Measurement Level |
|    id    |             Unique identifier assigned to each rat.              |      Nominal      |
|    trt   |         Treatment group: Control, Thiouracil, or Thyroxin.       |      Nominal      |
|   time   | Measurement occasion: Week 0, Week 1, Week 2, Week 3, or Week 4. |    Categorical    |
|    y     |            Body weight of each rat, measured in grams.           |       Scale       |

### Treatment Group Distribution

| Treatment Group | Number of Rats |
|     Control     |       10       |
|   Thiouracil    |       10       |
|    Thyroxin     |        7       |
|     Total       |       27       |

The dataset is organized in long format, where each row represents one body weight measurement from a specific rat at a particular measurement occasion.

Three rats originally assigned to the Thyroxin group were removed following an accident, resulting in unequal group sizes. The original observations are retained in the analysis.


### Dataset Source

- R Package: nlmm
- Dataset Name: rats
- Documentation: https://rdrr.io/cran/nlmm/man/rats.html


## Statistical Analysis

A two-way mixed-design repeated measures ANOVA is conducted using the rstatix package.

The analysis examines the following effects:

- Main Effect of Treatment: Determines whether average body weight differs significantly among the three treatment groups.
- Main Effect of Time: Determines whether average body weight changes significantly across the five measurement occasions.
- Treatment × Time Interaction: Determines whether the pattern of body weight changes over time differs significantly among treatment groups.


### Assumption Checking

The following statistical assumptions are evaluated:

1. Normality using the Shapiro-Wilk test.
2. Outliers using boxplots and outlier detection procedures.
3. Homogeneity of variances using Levene's test.
4. Homogeneity of covariance matrices using Box's M test.
5. Sphericity using Mauchly's test.

When the sphericity assumption is violated, the Greenhouse-Geisser correction is applied.


### Post Hoc Analysis

When the Treatment × Time interaction is statistically significant, follow-up analyses are conducted to examine:

- Treatment differences at each measurement occasion using separate one-way ANOVA tests and Tukey's HSD pairwise comparisons.
- Changes over time within each treatment group using separate repeated measures ANOVA.
- Pairwise comparisons between measurement occasions using paired t-tests with Holm-adjusted p-values.


## Instructions for Reproducing the Analysis

### Requirements

The following software and R packages are required:

- R
- RStudio
- nlmm
- tidyverse
- rstatix
- ggpubr

### Steps

1. Install R and RStudio if they are not yet available on your computer.
2. Open RStudio.
3. Install the required packages by running the following command in the R console:
  install.packages(c("nlmm", "tidyverse", "rstatix", "ggpubr"))
4. Open the project folder or GitHub repository.
5. Open `Rat_Growth_Mixed_ANOVA.R` in RStudio.
6. Run the script to load the dataset, prepare the variables, generate descriptive statistics and visualizations, check statistical assumptions, conduct the mixed-design repeated measures ANOVA, and perform post hoc analyses.
7. Open `Rat_Growth_Mixed_ANOVA.Rmd` in RStudio.
8. Click the Knit button to generate the final HTML or PDF statistical report.
9. Review the rendered report to ensure that all statistical outputs, tables, visualizations, and interpretations are complete.

## Files Included

1. README.md: Project overview, research objectives, dataset description, and instructions for reproducing the analysis. 
2. Rat_Growth_Mixed_ANOVA.R: R script containing the statistical procedures and analysis. 
3. Rat_Growth_Mixed_ANOVA.Rmd: R Markdown source report containing the methodology, R code, statistical outputs, and interpretations. 
4. Rat_Growth_Mixed_ANOVA.html: Rendered statistical report presenting the analysis and findings.
5. Rat_Growth_Dataset.csv: Dataset containing the rat body weight measurements used in the analysis. 


## Summary of Findings

The mixed-design repeated measures ANOVA revealed statistically significant main effects of Treatment and Time, as well as a significant Treatment × Time interaction.

All three treatment groups demonstrated significant increases in body weight throughout the four-week measurement period. However, the Thiouracil group exhibited significantly lower body weights than both the Control and Thyroxin groups during Weeks 3 and 4. No statistically significant differences were observed between the Control and Thyroxin groups across the five measurement occasions.

These findings indicate that the effect of treatment on rat body weight depends on the measurement occasion. Although all groups experienced increases in body weight, Thiouracil treatment was associated with a slower pattern of weight gain compared with the Control and Thyroxin groups.