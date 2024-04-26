## Multiselects are generally 1-vs-NA encoded.
## We could think about what belongs in the NA.

## Approach 1: boolean
## Approach 2: 1-0
## Approach 3: Record the multiselect value in the column head


#' Convert multi select variables to factors
#'
#' @param surveydata a tibble with survey data as processed by `scto_responses`
#' @param thefields a tibble with survey fields as processed by `read_questions`
#' @param thechoices a tibble with choices as processed by `read_choices`
#' @param na_value a character string, one of `"zero"`, `"boolean"`, or `"NA"`
#'
#' @return a tibble with survey data where single select variables have variable labels in the `label` attribute
#' @importFrom dplyr filter select mutate right_join relocate transmute
#' @importFrom tidyr nest replace_na
#' @importFrom tibble deframe
#' @importFrom stringr str_extract
#' @importFrom labelled set_variable_labels
#' @importFrom assertthat assert_that
#' @export
#'
#' @examples NULL
multisel_levels <- function(surveydata, thefields, thechoices, na_value= "zero") {
  assert_that(na_value %in% c("zero", "boolean", "NA"),
                          msg = "na_value must take one of the following values: zero, boolean, or NA.")
  ## Step 1. identify multiselects
  q_multiple <- filter(thefields, str_detect(type, "select_multiple")) |>
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
    filter(colhead %in% names(surveydata))
  ## Step 2. semi-join names to multiselects
  ## Step 3. mutate across those values, replacing {1 vs NA} with {1 vs zero} or {T vs F}
  mutate(surveydata, across(!!{lab_multiselects$colhead}, ~replace_na(., "0") |> as.numeric()))
}
