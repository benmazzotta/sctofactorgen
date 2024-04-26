#' Convert single select variables to factors
#'
#' @param surveydata a tibble with survey data as processed by `scto_responses`
#' @param thefields a tibble with survey fields as processed by `read_questions`
#' @param thechoices a tibble with choices as processed by `read_choices`
#'
#' @return a tibble with survey data where single select variables have variable labels in the `label` attribute
#' @importFrom dplyr filter select mutate right_join relocate across
#' @importFrom tidyr nest
#' @importFrom tibble deframe
#' @importFrom stringr str_extract str_detect
#' @importFrom labelled set_variable_labels set_value_labels var_label
#' @importFrom haven as_factor
#' @importFrom purrr map map_chr map2 map_df
#' @export
#'
#' @examples NULL
singsel_asfactor <-
  ## Three arguments: the data frame, the fields, and the choices
  function(surveydata, thefields, thechoices) {
    ## Select the single-select questions
    q_single <- filter(thefields, str_detect(type, "select_one")) |>
      mutate(choices = str_extract(type, "\\w*$"), .after = 2)
    cat("Loaded choices\n")
    ## Select the single-select responses
    lab_singleselects <-
      select(thechoices, list_name, value, label) |>
      ## This nests the lists in a single column
      nest(.by= list_name) |>
      ## Now map the deframe function onto the nested column
      mutate(data = map(data, ~deframe(.x[c("label", "value")]))) |>
      ## Join these to the question names
      right_join(select(q_single, name, list_name = choices), by = "list_name") |>
      select(-list_name) |> relocate(name, .before=0) |>
      ## And extract the whole thing into a named list of vectors.
      deframe()
    # cat("Listed single-selects\n")
    # print(head(lab_singleselects))
    # cat("Quick peek at the survey data")
    # print(glimpse(head(surveydata,20)))
    # str(lab_singleselects)
    ## Now return the labeled survey data
    set_value_labels(surveydata, .labels = lab_singleselects, .strict = FALSE) |>
      as_factor()
  }
