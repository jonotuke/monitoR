## code to prepare `cassowary` dataset goes here
file <- "inst/extdata/cassowarys/2024-11-14-cassowaries.xlsx"

cassowary <- file |> readxl::read_excel(guess_max = 4000)
cassowary |> glimpse()
cassowary <- cassowary |> janitor::clean_names()

cassowary <- cassowary |>
  dplyr::select(
    time = date_time,
    X = space_use_coordinate_x,
    Y = space_use_coordinate_y,
    behaviour = interval_channel_1_value,
    cassowary = focal_name,
    jeffery_side = question_which_side_was_jeffery_on_left_or_73,
    martina_side = question_which_side_was_martina_on_left_or_74
  )
cassowary |> count(martina_side)
cassowary <- cassowary |>
  dplyr::mutate(
    time = lubridate::ymd_hms(time),
    behaviour = stringr::str_to_title(behaviour)
  )
cassowary <- cassowary |>
  dplyr::filter(!is.na(X)) |>
  dplyr::filter(!is.na(Y)) |>
  dplyr::filter(!is.na(behaviour)) |> 
  dplyr::filter(!is.na(jeffery_side))
cassowary
usethis::use_data(cassowary, overwrite = TRUE)

