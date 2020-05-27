fit_cpq0 <- lm(log(cpq) ~ age65_0 + pa_0 + comorb1_0 +  
                 gastroad_0 + death + metformin_0 + hrqolcat_0, 
               data = sdc_data)
fit_cpq1 <- update(fit_cpq0, .~. + intgroup_0)
fit_cpq2 <- update(fit_cpq1, .~. + log(hosp+1))

texreg(l = list(fit_cpq0, fit_cpq1, fit_cpq2), 
       file = paste0(getwd(),"/tables/fit_cpq.tex"),
       digits = 3, label = "tab:fit_cpq")

sdc_data$resid_cpq <- (sdc_data$cpq - exp(fitted(fit_cpq1)) * mean(exp(resid(fit_cpq1))))

