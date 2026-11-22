# 4.1 Load Packages and Prepare the Data

install.packages(c("nlmm"))
install.packages(c("tidyverse","rstatix","ggpubr"))

library(nlmm)
library(tidyverse)
library(rstatix)
library(ggpubr)

data("rats", package = "nlmm")

rats <- rats %>%
  mutate(
    id = factor(id),
    trt = factor(
      trt,
      levels = c(1,2,3),
      labels = c("Control","Thiouracil","Thyroxin")
    ),
    time = factor(
      time,
      levels = 0:4,
      labels = c(
        "Week 0", "Week 1", "Week 2",
        "Week 3", "Week 4"
      )
    )
  )

str(rats)
dim(rats)
head(rats)
table(rats$trt)

# 4.2 Descriptive Statistics

rats%>%
  group_by(trt,time) %>%
  get_summary_stats(y,type = "mean_sd")

# 4.3 Visualization

ggboxplot(
  rats,
  x = "time",
  y = "y",
  color = "trt",
  palette = "jco"
)

rats%>%
  group_by(trt,time) %>%
  summarise(
    mean_weight = mean(y),
    .groups = "drop"
  ) %>%
  ggplot(
    aes(
      x = time,
      y = mean_weight,
      color = trt,
      group = trt
    )
  ) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(
    x = "Measurement Ocassion",
    y = "Mean Body Weight (grams)",
    color = "Treatment"
  ) +
  theme_minimal()

# 4.4 Assumption Checking

#Normality per treatment and time:

rats %>%
  group_by(trt, time) %>%
  shapiro_test(y)

#Outlier detection:

rats%>%
  group_by(trt, time) %>%
  identify_outliers(y)

#Homogeneity of variances:

rats %>%
  group_by(time) %>%
  levene_test(y ~ trt)

#Prepare wide-format data for Box's M:

rats_wide <- rats %>%
  pivot_wider(
    id_cols = c(id, trt),
    names_from = time,
    values_from = y,
    names_prefix = "time_"
  )

box_m(
  rats_wide %>%
    select(starts_with("time_")),
  rats_wide$trt
)

# 4.5 Mixed-Design Repeated Measures ANOVA

res.aov <- anova_test(
  data = rats,
  dv = y,
  wid = id,
  between = trt,
  within = time
)

# Inspect ANOVA and sphericity information
res.aov


# Obtain the ANOVA table
get_anova_table(res.aov)


# 4.6 Decomposition of the Interaction

#Treatment differences at each week:

rats %>%
  group_by(time) %>%
  anova_test(
    dv = y,
    wid = id,
    between = trt
  ) %>%
  get_anova_table()

# Pairwise treatment comparisons at each week:

rats %>%
  group_by(time) %>%
  tukey_hsd(y ~ trt)

# Time differences within each treatment group:

rats %>%
  group_by(trt) %>%
  anova_test(
    dv = y,
    wid = id,
    within = time
  ) %>%
  get_anova_table()

#Paired comparisons of measurement occassions:

rats %>%
  group_by(trt) %>%
  pairwise_t_test(
    y ~ time,
    paired = TRUE,
    p.adjust.method = "holm"
  )


