# Label downloaded SurveyCTO data

Download your Excel form definition from the Design tab and a CSV export
with raw choice codes from the Export tab of your SurveyCTO server. Use
the form version that corresponds to the data. No API subscription or
credentials are needed by the following local workflow.

``` r

library(sctofactorgen)
form <- scto_read_form("questionnaire.xlsx")
data <- scto_read_csv("responses.csv")
fields <- read_questions(form)
choices <- read_choices(form)
data <- singsel_label(data, fields)
data <- singsel_asfactor(data, fields, choices)
data <- multisel_label(data, fields, choices)
data <- multisel_levels(data, fields, choices, na_value = "zero")
```

Single selects become factors in form choice order. Unknown codes
produce an error so mismatched form versions do not silently discard
responses. Multiselects require expanded columns named `question_code`.
The `zero` mode replaces missing indicators with zero; `boolean` returns
logical indicators; `NA` preserves missing indicators. Choose the mode
deliberately: a missing indicator can reflect a skipped question as well
as an unselected option. Unexpanded space-separated responses are left
unchanged.

Only single-language `label` columns and non-repeating fields are
currently supported. External choice lists and dynamic choice lists are
not resolved.

API downloads remain optional for accounts that have access. Install
`rsurveycto` separately and pass authentication explicitly:

``` r

auth <- rsurveycto::scto_auth("/path/outside/the/repository/auth_details")
form <- scto_form("form_id", auth)
data <- scto_responses("form_id", auth)
```

Keep credentials outside the package and source repository. Automated
tests use synthetic data and make no server requests.
