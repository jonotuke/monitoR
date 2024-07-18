## code to prepare `skink` dataset goes here
file <- fs::path_package("monitoR", 
  "inst/extdata/skinks/2024-05-14-skink-zoo-monitor.xlsx")
skink <- read_zoo(file)
usethis::use_data(skink, overwrite = TRUE)
