## We need to authorize SCTO first.

## Read the authentication file
library(rsurveycto)
auth <- scto_auth("../vignettes/auth_details")

## Test that we can authenticate
test_that("authentication", {
  expect_true(check_scto_api(auth))
})

## Can we obtain a data frame
df <- scto_responses(.formid = "github_with_dup_labels") |>as.data.frame()
## Validate that this is a data frame
test_that("data frame obtained", {
  expect_equal(class(df), "data.frame")
})


names(df)
qnr <- scto_form("github_with_dup_labels")
names(qnr)
lapply(qnr, class)

## Read the choices
df_choices <- read_choices(qnr) |> glimpse()
## Read the questions
df_questions <- read_questions(qnr) |> glimpse()
## Attach the variable labels to single selects
df <- singsel_label(df, thefields = df_questions)
## Attach variable labels to multiselects
df <- multisel_label(df, thefields = df_questions, thechoices = df_choices)

## Convert single selects to factors
df <- singsel_asfactor(df, thefields = df_questions, thechoices = df_choices)
df <- multisel_levels(df, thefields = df_questions, thechoices = df_choices)
df <- singsel_label(df, thefields = df_questions)
df <- multisel_label(df, thefields = df_questions, thechoices = df_choices)


## Nice and tidy
glimpse(df)
labelled::get_variable_labels(df) |> enframe() |> unnest(value) |> knitr::kable()
str(df)

