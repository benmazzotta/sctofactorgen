## Discussion: Labelled has a uniqueness requirement that prevents reusing label lists. The requirement is implemented on the function set_value_labels(). So, we have to overwrite that function.
## Here is the rewritten function from {haven}

#' Title
#'
#' @param x an object with a labels attribute
#'
#'@importFrom haven validate_labelled
#' @return the same object
#' @export
#'
#' @examples NULL
validate_labelled <- function(x) {
  labels <- attr(x, "labels")
  if (is.null(labels)) {
    return(x)
  }

  if (is.null(names(labels))) {
    cli_abort("{.arg labels} must have names.")
  }
  # if (any(duplicated(stats::na.omit(labels)))) {
  # cli_abort("{.arg labels} must be unique.")
  # }

  x
}


# environment(newfn) <- asNamespace('packagename')
# assignInNamespace("oldfn", newfn, ns = "packagename")
## This is the idiom for overwriting a function from the other namespace.
environment(validate_labelled) <- asNamespace("haven")
assignInNamespace("validate_labelled", validate_labelled, "haven")
