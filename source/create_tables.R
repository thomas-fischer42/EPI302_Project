
stat_and_pct <- function(x, y, digits = 2) {
  x <- round(x, digits)
  y <- round(x/y, digits)
  paste0(x, " (", y, ")")
}

demographic <- sdc_data %>% 
  group_by(intgroup_0) %>% 
  summarise('Patients' = n(), 
            'Age' = stat_and_pct(sum(age65_0 == ">= 65 years"), n()),
            'Female' = stat_and_pct(sum(female_0 == "Female"), n()),
            'Migrant' = stat_and_pct(sum(mig_0 == "Yes"), n()),
            'Smoker' = stat_and_pct(sum(smok_0 == "Smoker"), n()),
            'PA' = stat_and_pct(sum(pa_0 == "Moderate-High"), n()),
  ) %>% 
  ungroup()

xtable(demographic, label = "tab:descr_stat_demo", align = "llrrrrrr",
       caption = "Demographics") %>% 
  print(file = "tables/descr_stat_demo.tex", include.rownames=FALSE,
        scalebox = 0.7)


health_by_intgroup <- sdc_data %>%
  group_by(intgroup_0) %>%
  summarise('Patients' = n(), 
            'CVD' = stat_and_pct(sum(cvd == "Yes"), n()),
            'Deaths' = stat_and_pct(sum(death == "Yes"), n()),
            'Average QALY' = mean(qaly),
            'Average cost' = mean(cumcosttotal)
  ) %>%
  ungroup()


xtable(health_by_intgroup, label = "tab:descr_stat_health", align = "llrrrrr",
       caption = "Descriptive statistics") %>% 
  print(file = "tables/descr_stat_health.tex", include.rownames=FALSE,
        scalebox = 0.7)


