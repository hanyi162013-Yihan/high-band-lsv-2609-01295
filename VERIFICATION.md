# Verification record

## Fully checked mathematical source

- Source revision: `50b3d2f9150f58bdb506bb528660bf3651ef81af`.
- Successful GitHub run: [33627100982](https://github.com/hanyi162013-Yihan/high-band-lsv-2609-01295/actions/runs/33627100982).
- Completion time recorded by GitHub: 2026-09-02 12:04:59 UTC.
- Tracked Lean files covered: **70**.
- Production modules audited: **68**.
- Production declarations audited, including generated declarations: **1,388**.
- Additional selected dependency reports checked: **25**.

Every registered project library was compiled from source. The final audit file
was also compiled explicitly. The workflow checked compiled-module coverage for
every tracked Lean source and rejected forbidden proof placeholders or added
axiom declarations. Cached dependencies do not replace compilation of the
project's proof sources.

The exhaustive audit found no axiom dependency outside the standard Lean
foundations `propext`, `Classical.choice`, and `Quot.sound`. An explicit theorem
hypothesis is not an axiom dependency, so the model and analytic hypotheses were
also printed and inspected rather than relying on this audit alone.

## Mathematical objects checked

The expanded definition of `HighBandLSV.hilbertSchmidt` uses
`Matrix.frobeniusNormedRing`. It is not the entrywise maximum norm or an
operator-norm substitute.

The definition of `GinibreLSV.leastSingularValue A` is
`A.singularValues (n - 1)`. The main statements concern this actual matrix
singular value, not an uninterpreted small-ball event.

The strongest paper-facing declarations are:

- `HighBandLSV.PaperModelTheorem.real_main_statement`.
- `HighBandLSV.PaperModelTheorem.planar_main_statement`.

They state the literal exponential threshold, retain the HS truncation, and
provide a natural-number cutoff uniform in the allowed shift and small-ball
parameter. Bandwidth positivity and the bandwidth upper bound are derived from
the model assumptions. No normal-net, conditional-probability, density-scaling,
or asymptotic numerical-certificate interface remains in these statements.

## Exact remaining boundary

The real theorem assumes
`LivshytsProjectionFormalization.RealFiniteGeometricBrascampLieb`, the explicitly
agreed analytic input used by the real projection-density development. It is
not presented as proved here. The planar theorem does not assume it and does
not require independent real and imaginary parts.

The model still naturally includes independent entry laws and bounded raw
densities; these are hypotheses of the random-matrix theorem, not unproved
intermediate estimates. The proof constructs the product model, exposure
kernel, small-ball estimates, and final probability bound from those data.

This record certifies the stated Lean conclusions, not the entire circular-law
paper or every stronger standalone intermediate formulation. In particular,
the optional conditional-direction extension and removal of the HS cutoff are
not claimed. See [SOURCE_COMPARISON.md](SOURCE_COMPARISON.md) and
[FORMALIZATION_MATRIX.md](FORMALIZATION_MATRIX.md).

## Reproduction

Follow [BUILD.md](BUILD.md). The repository workflow runs the complete build,
the selected theorem audit, the exhaustive production-declaration audit, the
source-policy scan, and compiled-module coverage. The successful run above is
an immutable record for the listed mathematical revision; later documentation
commits are checked by the same workflow.
