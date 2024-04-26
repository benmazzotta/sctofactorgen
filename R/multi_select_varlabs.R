#' @title Apply variable labels to multiselects
#' @description
#' Multiselects are complicated. They store responses to questions across multiple columns.
#' This function applies one label to each column, indicating both the question text (label) and response (label). These character strings are concatenated with a tilde ` ~ ` separator.
#' To do this, we process the labels first and then apply them to the columns of the response data.
#' At some point, I would like to have the ability to provide the user the choice whether these are dummy variables `{0,1}`, missing values, `{NA, 1}`, or booleans `{F, T}`.
#'
#' @param surveydata a tibble with survey data as processed by `scto_responses`
#' @param thefields a tibble with survey fields as processed by `read_questions`
#' @param thechoices a tibble with choices as processed by `read_choices`
#'
#' @return a tibble with variable labels for each column of a multiple_select question
#' @export
#' @importFrom dplyr filter select mutate transmute right_join relocate transmute
#' @importFrom tidyr nest replace_na
#' @importFrom tibble deframe
#' @importFrom stringr str_extract
#' @importFrom labelled set_variable_labels
#' @importFrom assertthat assert_that
#'
#' @examples NULL
multisel_label <- function(surveydata, thefields, thechoices) {
  ## Select the multi-select questions from the questionnaire
  q_multiple <-
    filter(thefields, str_detect(type, "select_multiple")) |>
    mutate(choices = str_extract(type, "\\w*$"), .after = 2)
  cat("Loaded multiselect quetions. \n")
  ## Generate the labels
  lab_multiselects <-
    ## Choose from the multiselects
    select(thechoices, list_name, value, label) |>
    ## Join these to the question names
    right_join(select(q_multiple, root = name, var_label = label,  list_name = choices), by = "list_name") |> select(-list_name)   |> relocate(root, .before=0) |>
    ## Generate the column heads
    transmute(colhead = paste(root, value, sep = "_"), variable = paste(var_label, label, sep = " ~ ")) |>
    deframe() |> as.list()
  cat("Generated the list of variable labels for multiselect columns.")
  # set_variable_labels(df_singlelab, .labels = varlabs, .strict = FALSE)  |>
  ## Apply the multirepsonse variable labels to the survey data
  set_variable_labels(surveydata, .labels = lab_multiselects, .strict = FALSE)
}

