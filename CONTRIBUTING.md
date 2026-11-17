# Contributing

Start with [the roadmap and current plan](ROADMAP.md) and the
[issue tracker](https://github.com/benmazzotta/sctofactorgen/issues).
Search existing issues before opening a new one. Each implementation issue should
state the problem, scope, dependencies and observable acceptance criteria.

## Development

Use local, synthetic or de-identified fixtures. Ordinary tests must not connect to
a server or require credentials, paid SurveyCTO access or rsurveycto. API-specific
integration work belongs to issue #8 and must be opt-in.

```r
devtools::test()
devtools::check(args = "--no-manual")
```

Building the vignette requires Pandoc (available with RStudio). Regenerate Rd and
NAMESPACE with `roxygen2::roxygenise()` after changing roxygen documentation.
Add regression tests for changed behavior and inspect the package check output.
Test leading-zero codes, missing responses and reused choice lists when relevant.

Never commit server credentials, respondent data, R session files or local
RStudio state. Keep authentication files outside the checkout. Inspect the
staged file list before committing; a gitignore entry does not untrack a file
already in Git. Review any existing tracked authentication material privately.

## Review and completion

Link the issue in the pull request and explain behavior changes, limitations and
validation. Do not mark local-only work as released. Keep roadmap priorities,
release notes and issue status aligned. A fix is complete once merged with its
required checks passing; a release also requires the roadmap's release gates.
