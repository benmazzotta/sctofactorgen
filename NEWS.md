# sctofactorgen 0.1.2

* Add local Excel form and CSV readers; API access is no longer required for
  labelling exports. `rsurveycto` is now an optional dependency.
* Preserve text choice codes and form choice order. Allow duplicate label text,
  and reject duplicate codes or unknown responses instead of silently losing data.
* Implement all three multiselect output modes and preserve variable labels.
* Replace use of unavailable haven internals with public validation.
* API wrappers now require explicit form IDs and authentication rather than
  looking for global variables. `check_scto_api()` checks object class only;
  it does not test server permissions or connectivity.
* Replace live credential tests with synthetic offline fixtures and add package
  checks in GitHub Actions. Exclude local credentials from package builds.
* Rework the vignette for offline use. Repeated groups, translated labels,
  external choices, and unexpanded multiselects remain unsupported.
