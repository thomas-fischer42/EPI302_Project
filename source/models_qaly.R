
fit_qaly0 <- lm( qaly ~ age65_0 + female_0 + pa_0 + metformin_0 + 
                   hosp10kmdens_0 + comorb1_0 + hrqol_0, 
                 data = sdc_data)
fit_qaly1 <- update(fit_qaly0, .~. + intgroup_0)
fit_qaly2 <- update(fit_qaly1, .~. + obstime)
fit_qaly3 <- update(fit_qaly1, data = sdc_data %>% filter(death == "No"))

#texreg(l = list(fit_qaly0, fit_qaly1, fit_qaly2, fit_qaly3), 
#       file = paste0(getwd(),"/tables/fit_qaly.tex"),
#       digits = 3, label = "tab:fit_qaly")

