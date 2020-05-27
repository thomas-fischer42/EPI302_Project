to_real <- function(x) {
  if (is.factor(x)) {
    x <- as.character(x)
  } 
  as.numeric(gsub(",",".",x))
}

to_yesNo <- function(x) {
  factor(x, levels = c(0,1), labels = c("No","Yes"))
}

canton_name <- function(x) {
  labs <- substr(geo_data$GID_1, 5, 10)
  labs <- sub("(_.)", "", labs) 
  ind <- sapply(x, function(y) which(geo_codes$Num == y))
  return(geo_data$NAME_1[ind])
}

canton_abr <- function(x) {
  labs <- substr(geo_data$GID_1, 5, 10)
  labs <- sub("(_.)", "", labs) 
  short <- substr(geo_data$HASC_1, 4,10)
  ind <- sapply(x, function(y) which(geo_codes$Num == y))
  return(short[ind])
}

canton_geom <- function(x) {
  labs <- substr(geo_data$GID_1, 5, 10)
  labs <- sub("(_.)", "", labs) 
  ind <- sapply(x, function(y) which(geo_codes$Num == y))
  return(geo_data$geometry[ind])
}
