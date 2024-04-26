#' Check the SurveyCTO API has been authorized and stored as `auth`
#'
#' @param .auth an authorization block from `{rsurveycto::scto_auth}`
#'
#' @return boolean
#' @export
#'
#' @examples NULL
check_scto_api <- function(.auth = auth) {
  are_equal(class(.auth), "scto_auth")
}
