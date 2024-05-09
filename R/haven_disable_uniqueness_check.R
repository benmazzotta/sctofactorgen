## Discussion: Labelled has a uniqueness requirement that prevents reusing label lists. The requirement is implemented on the function set_value_labels(). So, we have to overwrite that function.
## Here is the rewritten function from {haven}

## See whether this works.
## Import new_labelled and rewrite the labelled function here.


#' Title
#'
#' @param x an object with a labels attribute
#' @param x A vector to label. Must be either numeric (integer or double) or
#'   character.
#'
#' @importFrom haven labelled new_labelled validate_labelled
#' @return the same object
#' @export
#'
#' @examples NULL
#' @param labels A named vector or `NULL`. The vector should be the same type
#'   as `x`. Unlike factors, labels don't need to be exhaustive: only a fraction
#'   of the values might be labelled.
#' @param label A short, human-readable description of the vector.
#' @export
#' @examples
labelled <- function(x = double(), labels = NULL, label = NULL) {
  x <- vec_data(x)
  labels <- vec_cast_named(labels, x, x_arg = "labels", to_arg = "x")
  validate_labelled(new_labelled(x, labels = labels, label = label))
}



## This is the altered validate_labelled function.
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
# environment(validate_labelled) <- asNamespace("haven")
# assignInNamespace("validate_labelled", validate_labelled, "haven")
