## Welcome ![](reference/figures/logo.png)

This package labels SurveyCTO exports locally and optionally works with
[rsurveycto](https://agency-fund.github.io/rsurveycto/).

## Status

Maintenance now focuses on an offline workflow that requires no paid API
access. Download an Excel form definition and a CSV export with raw
choice codes from SurveyCTO, then label them locally:

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

See the
[roadmap](https://benmazzotta.github.io/sctofactorgen/ROADMAP.md) for
priorities and current limitations.

Use the matching form version. Duplicate display labels become a single
factor level, as in base R. Multiselect conversion expects expanded
`question_code` columns; `na_value = "NA"` preserves missing indicators
and `"boolean"` returns logical values. The default `"zero"` treats
missing indicators as unselected, including skipped questions.

`rsurveycto` is optional and only needed for API downloads on eligible
accounts. Pass credentials explicitly to
[`scto_form()`](https://benmazzotta.github.io/sctofactorgen/reference/scto_form.md)
and
[`scto_responses()`](https://benmazzotta.github.io/sctofactorgen/reference/scto_responses.md).
Automated tests require neither credentials nor a server. Live API
access has not been verified as part of this maintenance.

## Why

In R, it’s nice to work with factor variables and data labels. Those
things are already coded into SurveyCTO. It should be dead easy to get
back data frames with the same structure as you coded into SurveyCTO.

That’s what
[sctofactorgen](https://benmazzotta.github.io/sctofactorgen/) does.

## How it works

[rsurveycto](https://agency-fund.github.io/rsurveycto/) facilitates data
download via SurveyCTO’s API. The files available through that package
are (1) survey data and (2) forms for data collection.

The CSV data files do not contain labels that correspond to the text of
questions and responses from the form. The Excel form definition
supplies the question labels and choice lists. These can be read locally
with
[`scto_read_form()`](https://benmazzotta.github.io/sctofactorgen/reference/scto_read_form.md),
or downloaded through the API when available.

## What it does

This package creates factors for single- and multi-select response
questions. It creates variable labels corresponding to the question
label on the survey form.

The first version of this package does not yet handle translations or
repeated question groups. It only anticipates a single language with a
single question label and a single value label for every question on the
survey.

Users are encouraged to read the
[rsurveycto](https://agency-fund.github.io/rsurveycto/) package to learn
more about the authentication process for accessing survey data. Users
are also encouraged to practice downloading the questionnaire forms and
survey data from SurveyCTO’s server and desktop software to learn the
structure of those files.

## The contribution

This package is intended to improve on the existing workflows in R.
Without this package, R users can obtain CSV files with the Rsurveycto
package. They can download unlabeled CSV and Excel scripts that require
custom R code to label and clean. They can download labeled data files
in other formats such as SPSS and Stata.

Due to minor differences in variable naming and labeling conventions
between these packages and R, it is preferable to have the labeled data
files created directly in R, without converting formats.

## Enjoy

Thanks for checking out the package!
