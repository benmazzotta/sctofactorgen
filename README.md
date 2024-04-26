## Welcome

This package extends the functionality of `{rsurvecto}` . 

## Why

In R, it's nice to work with factor variables and data labels. Those things are already coded into SurveyCTO. It should be dead easy to get back data frames with the same structure as you coded into SurveyCTO. 

That's what `{sctofactorgen}` does.

## How it works

`{rsurveycto}` facilitates data download via SurveyCTO's API. The files available through that package are (1) survey data and (2) forms for data collection. 

The CSV data files do not contain labels that correspond to the text of questions and responses from the form. Yet we can download precisely the labels and factor levels we need via the same API. 

## What it does

This package creates factors for single- and multi-select response questions. It creates variable labels corresponding to the question label on the survey form. 

The first version of this package does not yet handle translations or repeated question groups. It only anticipates a single language with a single question label and a single value label for every question on the survey. 

Users are encouraged to read the `{rsurveycto}` package to learn more about the authentication process for accessing survey data. Users are also encouraged to practice downloading the questionnaire forms and survey data from SurveyCTO's server and desktop software to learn the structure of those files. 

## The contribution

This package is intended to improve on the existing workflows in R. Without this package, R users can obtain CSV files with the Rsurveycto package. They can download unlabeled CSV and Excel scripts that require custom R code to label and clean. They can download labeled data files in other formats such as SPSS and Stata. 

Due to minor differences in variable naming and labeling conventions between these packages and R, it is preferable to have the labeled data files created directly in R, without converting formats.

## Enjoy

Thanks for checking out the package!
