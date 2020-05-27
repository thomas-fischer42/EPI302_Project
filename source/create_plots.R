# Plot of assignments to treatment groups
png("figures/int_alloc.png")
tmp <- sdc_data %>%
  group_by(canton_abr, canton_0, intgroup_0) %>%
  summarise(count = n()) %>%
  ungroup() %>% 
  mutate(geometry = canton_geom(canton_0))
ggplot(tmp) + 
  geom_sf(aes(geometry = geometry, fill = intgroup_0)) + 
  geom_sf_label(aes(geometry = geometry, label = canton_abr),
                size=2, alpha = 0.4) + 
  xlab("") + ylab("") +
  theme_minimal() +
  theme(legend.position="bottom", legend.box = "horizontal")
dev.off()

# Plot of cumulative costs vs hospitalisations
png("figures/hosp_cumcost.png")
ggplot(sdc_data) +  
  geom_violin(aes(x = factor(hosp), y = cumcosttotal, fill = intgroup_0)) +
  facet_wrap(~comorb1_0 + cvd) + 
  xlab("Number of hospitalizations") + 
  ylab("Cumulative costs (2002-2012)") + 
  theme_minimal()
dev.off()


# Plot hrqol_0 vs hrqol_9 stratified by intgroup_0
png("figures/hrqol_transition.png")
sdc_data %>%
  filter(death == "No") %>% 
  ggplot() + 
  geom_smooth(aes(x = hrqol_0, y = hrqol_9, group = intgroup_0, col = intgroup_0)) +
  geom_abline(slope = 1, intercept = 0, lty = 2) + 
  xlim(range(sdc_data$hrqol_0)) + 
  ylim(range(sdc_data$hrqol_9, na.rm = TRUE)) + 
  xlab("HrQOL in 2002") + ylab("HrQOL in 2012") + 
  theme_minimal() + 
  theme(legend.position="bottom", legend.box = "horizontal")
dev.off()


# Plot of cpq resid
#tmp <- sdc_data %>%
#  group_by(canton_abr, canton_0, intgroup_0) %>%
#  summarise(resid_cpq = mean(resid_cpq)) %>%
#  ungroup() %>% 
#  mutate(geometry = canton_geom(canton_0))

#ggplot(tmp) + 
#  geom_sf(aes(geometry = geometry, fill = resid_cpq, col = intgroup_0)) + 
#  geom_sf_label(aes(geometry = geometry, label = canton_abr),
#                size=2, alpha = 0.4) + 
#  xlab("") + ylab("") +
#  theme_minimal() +
#  theme(legend.position="bottom", legend.box = "horizontal")

