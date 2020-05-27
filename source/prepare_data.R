
source("source/helper_functions.R")
geo_codes <- read.csv("data/nuts") # Sourced from wikipedia
sdc_data <- read.csv("data/SDC_III.csv", sep = ";") 
geo_data <- readRDS("data/gadm36_CHE_1_sf.rds") # https://gadm.org/download_country_v3.html


# Data transformations
sdc_data <- sdc_data %>%
  mutate_if(is.factor, to_real) %>%
  mutate_at(vars(afford_0,afford_9, comorb1_0, comorb1_9, cvd, death,
                 gastroad_0, gastroad_9, gpdenscat_0, hospdenscat_0,
                 hosp10kmdenscat_0, hl_0, hl_9, hrqolcat_0, hrqolcat_9,
                 metformin_0, metformin_9, mig_0, migprog_0,
                 ssedhba1ccat1_0, ssedhba1ccat1_9, ssedhba1ccat2_0,
                 ssedhba1ccat2_9, ssedhba1ccat3_0, ssedhba1ccat3_9,
                 visits3_0, visits3_9), to_yesNo) %>%
  mutate(age65_0 = factor(age65_0, levels = c(0,1), labels = c("<65 years", ">= 65 years")),
         canton_name = canton_name(canton_0),
         canton_abr = canton_abr(canton_0),
         proage_0 = case_when( is.na(proage_0) ~ "No",
                               (proage_0 == 0) ~ "No",
                               (proage_0 == 1) ~ "Yes") %>%
           as.factor(),
         educ_0 = factor(educ_0, levels = c(1,2,3), labels = c("Compulsory", "Secondary", "Tertiary")),
         female_0 = factor(female_0, levels = c(0,1), labels = c("Male","Female")),
         intgroup_0 = factor(intgroup_0, levels = c(1,2,3), 
                             labels = c("Control", "Pharmacotherapy", "Physical Activity")),
         langreg_0 = factor(langreg_0, levels = c(1,2,3), labels = c("German", "French","Italian")),
         pa_0 = factor(pa_0, levels = c(0,1), labels = c("Low", "Moderate-High")),
         pa_9 = factor(pa_9, levels = c(0,1), labels = c("Low", "Moderate-High")),
         smok_0 = factor(smok_0, levels = c(0,1), labels = c("Non-smoker", "Smoker")),
         smok_9 = factor(smok_9, levels = c(0,1), labels = c("Non-smoker", "Smoker"))) %>%
  select(canton_0, canton_name, canton_abr, langreg_0, intgroup_0, everything())

