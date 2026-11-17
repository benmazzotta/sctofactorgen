#' Convert single select variables to factors
#'
#' @param surveydata a tibble with survey data as processed by `scto_responses`
#' @param thefields a tibble with survey fields as processed by `read_questions`
#' @param thechoices a tibble with choices as processed by `read_choices`
#'
#' Duplicate display labels become a single factor level, as in base R.
#' Unknown response codes produce an error.
#'
#' @return Survey data with single select factors in form choice order.
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
singsel_asfactor <- function(surveydata, thefields, thechoices) {
  questions <- thefields[grepl("^select_one\\s+", thefields$type), , drop = FALSE]
  for (i in seq_len(nrow(questions))) {
    name <- questions$name[i]
    if (!name %in% names(surveydata)) next
    list_name <- sub("^select_one\\s+([^[:space:]]+).*$", "\\1", questions$type[i])
    choices <- thechoices[thechoices$list_name == list_name, , drop = FALSE]
    if (!nrow(choices)) stop("No choices found for ", name, call. = FALSE)
    codes <- as.character(choices$value)
    if (anyNA(codes) || anyDuplicated(codes))
      stop("Choice codes must be non-missing and unique within ", list_name, call. = FALSE)
    x <- as.character(surveydata[[name]])
    unknown <- !is.na(x) & !x %in% codes
    if (any(unknown)) stop("Unknown choice codes in ", name, call. = FALSE)
    label <- attr(surveydata[[name]], "label")
    surveydata[[name]] <- factor(x, levels = codes, labels = as.character(choices$label))
    attr(surveydata[[name]], "label") <- label
  }
  surveydata
}
