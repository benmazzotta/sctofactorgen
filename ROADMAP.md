# Roadmap and working plan

Last reviewed: November 17, 2026. GitHub issues track execution; this
document records scope, order and release gates. Milestones are targets,
not date promises.

## Direction

Make SurveyCTO question and choice labels usable in R and RStudio from
locally downloaded Excel forms and CSV exports. Development and
automated tests must work without paid API access, a developer license
or server credentials. Optional API wrappers remain available for
eligible users; live verification is separate work.

## Today: November 17, 2026

[\#10: the credential-dependent pkgdown
build](https://github.com/benmazzotta/sctofactorgen/issues/10) is
resolved by merged PR \#9; documentation builds no longer require server
access.

1.  Review the existing local maintenance work under
    [\#2](https://github.com/benmazzotta/sctofactorgen/issues/2). Check
    the offline import and labelling workflow, preserve unrelated local
    edits, exclude credential/session files, and prepare the maintenance
    changes for review. Verify that repeated label text merging into a
    single factor level is documented.
2.  Implement [\#3: form
    validation](https://github.com/benmazzotta/sctofactorgen/issues/3).
    Start with required columns and one shared select/list parser.
    Reject malformed codes and report unsupported layouts explicitly.
    Add offline regression cases.
3.  Run R CMD check including the vignette, obtain passing hosted CI,
    and validate a de-identified Excel form plus matching CSV export
    from a community account. If representative exports are unavailable,
    finish the synthetic checks and keep the real-export acceptance item
    open. Do not claim a release gate has passed.

Today’s target is a reviewable offline maintenance release candidate.
Larger features start after that baseline is reliable. If time is
limited, complete steps 1 and 2; defer feature expansion and publishing
a release.

## Prioritized backlog

| Order | Work | Priority | Current state | Target |
|----|----|----|----|----|
| 0 | [\#10 Offline pkgdown build and CI setup](https://github.com/benmazzotta/sctofactorgen/issues/10) | High | Merged in PR \#9; hosted check passed | 0.1.2 |
| 1 | [\#2 Offline maintenance baseline](https://github.com/benmazzotta/sctofactorgen/issues/2) | High | Implemented on codex/offline-maintenance; review pending | 0.1.2 |
| 2 | [\#1 Reused labels](https://github.com/benmazzotta/sctofactorgen/issues/1) | High | Local fix and tests; close after merge | 0.1.2 |
| 3 | [\#3 Form validation and consistent list parsing](https://github.com/benmazzotta/sctofactorgen/issues/3) | High | Ready; build on local baseline | 0.1.2 |
| 4 | [\#4 Raw multiselect expansion](https://github.com/benmazzotta/sctofactorgen/issues/4) | Medium | Scoped; after baseline | 0.2.0 |
| 5 | [\#5 Explicit label-language selection](https://github.com/benmazzotta/sctofactorgen/issues/5) | Medium | Scoped; depends on validation | 0.2.0 |
| 6 | [\#6 Repeat groups and tables](https://github.com/benmazzotta/sctofactorgen/issues/6) | Low | Needs export-layout design and fixtures | Later |
| 7 | [\#7 Local external choice files](https://github.com/benmazzotta/sctofactorgen/issues/7) | Low | Needs file-reference design | Later |
| — | [\#8 Live API verification](https://github.com/benmazzotta/sctofactorgen/issues/8) | Low | Blocked on eligible access | No offline release dependency |

## Release gates

### 0.1.2: reliable offline baseline

[Milestone](https://github.com/benmazzotta/sctofactorgen/milestone/1)

- Local Excel forms and raw-code CSVs work without rsurveycto or
  credentials.
- Single-select factors preserve code matching, choice order and
  question labels.
- Reused choice lists and duplicate label text have regression coverage.
- All three expanded multiselect modes work and preserve variable
  labels.
- Missing/skipped versus unselected indicator behavior is documented
  explicitly.
- Invalid and unsupported inputs produce useful errors or diagnostics.
- Offline tests, installation and vignette build pass locally and in
  hosted CI.
- A representative de-identified community export pair is verified.
- Credential/session files are excluded from artifacts and public
  changes.

Current evidence from the local working tree: 23 passing assertions and
full R CMD check with 0 errors, 0 warnings and 0 notes (remote clock
verification disabled). Optional rsurveycto was unavailable locally; API
behavior is unverified. These are local results, not evidence of a
merged release or live API compatibility. Schema validation and
real-export verification are still pending.

### 0.2.0: broader local export support

[Milestone](https://github.com/benmazzotta/sctofactorgen/milestone/2)

Add explicit raw multiselect expansion and language selection, with
defined missing-value behavior, collision checks, offline fixtures and
working examples. Preserve the established local workflow and
identifiers.

### Later

Design repeat handling and local external-choice resolution using
representative export layouts. Nested repeats and dynamic server
datasets require explicit scope before implementation. No commitment to
automatic server synchronization or paid API infrastructure.

## Keeping the plan current

- Use issues for acceptance checklists, dependencies and implementation
  status.
- Apply one priority label. A status label is optional for later backlog
  items. `status: ready` means scoped, not necessarily next;
  dependencies still apply.
- Work on one implementation issue at a time. \#1 is a regression
  tracked under \#2.
- Update this document when priorities, release scope or constraints
  change, and replace the dated Today section when choosing the next
  work session.
- Close issues only after the fix and necessary tests are merged. Local
  work is in progress; blocked issues name their external prerequisite.
- Release only after the milestone gates pass; keep unverified work
  open.
