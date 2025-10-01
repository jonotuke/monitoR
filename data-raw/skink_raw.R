## code to prepare `skink_raw` dataset goes here
file <- "inst/extdata/skinks/2024-05-14-skink-zoo-monitor.xlsx"
skink_raw <- read_zoo(file) |>
  select(
    DateTime,
    `Space Use Coordinate X`,
    `Space Use Coordinate Y`,
    `Interval Channel 1 Value`
  )
usethis::use_data(skink_raw, overwrite = TRUE)
