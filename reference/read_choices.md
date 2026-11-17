# Extract response choices from a form definition

The form is available from the SurveyCTO. It has three parts, including
settings, fields, and choices. We restructure this with dplyr and
janitor so that it works nicely with other packages.

## Usage

``` r
read_choices(theform)
```

## Arguments

- theform:

  A survey form as imported by `scto_form`

## Value

a tibble with response choices named as they appear on the XLS form
`choices`

## Examples

``` r
NULL
#> NULL
```
