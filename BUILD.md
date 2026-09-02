# Reproducible verification

The Lean toolchain and all dependencies are pinned by the Lake project. Lean is `v4.32.0`; use the exact revisions in `lake-manifest.json` rather than substituting a newer Mathlib checkout.

```sh
lake exe cache get
lake build
lake env lean AxiomAudit.lean
```

## GitHub Actions

The workflow:

1. Checks out the exact submitted revision.
2. Restores or downloads the pinned Lean and compiled dependencies.
3. Rebuilds every project library from source. Project build artifacts are not used as a substitute for this build.
4. Compiles `AxiomAudit.lean` and checks 25 selected proof-dependency lists.
5. Allows only the standard Lean logical foundations in those lists.
6. Records the checked revision.
7. Rejects forbidden proof placeholders and additional axiom/unsafe declarations.
8. Requires the matching `.olean` artifact for every tracked Lean file other than `AxiomAudit.lean`, which was compiled explicitly in step 4.

Warnings about unused variables are not proof gaps. A compiler error, a missing module artifact, a failed audit, or a proof-recovery dependency is a failed verification, not a successful formalization.

The GitHub Actions logs expose both the fully elaborated final theorem types and their dependency lists. This matters because a dependency audit alone does not display explicit theorem hypotheses such as geometric Brascamp--Lieb.

No GitHub credentials or local authentication configuration are part of the project sources.

`ProjectAxiomAudit.lean` is a normal build target importing every tracked production module. During the source build it uses Lean's own dependency collector and module-ownership metadata to check all production declarations, including auxiliary declarations, against the same whitelist. An empty audit or an unexpected dependency fails the build.
