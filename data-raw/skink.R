## code to prepare `skink` dataset goes here
data(skink_raw)
skink <- clean_zoo(skink_raw)
usethis::use_data(skink, overwrite = TRUE)
