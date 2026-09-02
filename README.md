# High-band least singular values

Lean 4 + Mathlib proofs of the model-level, Hilbert--Schmidt-truncated least-singular-value bound, using the parameter scale of Proposition 3.1 / Appendix B of arXiv:2609.01295 and the repaired Section 5 argument.

[Build status](https://github.com/hanyi162013-Yihan/high-band-lsv-2609-01295/actions)

## Main result

Fix positive `chi` and `kappa`, nonnegative `R` and `Kz`, and `Cw >= 1`. Suppose eventually

\[
0<W_N,\qquad N^{1/2+\chi}\le W_N\le C_wN.
\]

For the independent-entry band models specified below, eventually, uniformly in `|z| <= Kz` and `t >= 0`,

\[
\mathbb P\!\left\{s_{\min}(X-zI)\le
 t\exp\!\left(-N^{3\kappa}\frac{N}{W_N}\right),\quad
 \|X\|_{\mathrm{HS}}\le R\sqrt N\right\}
\le C_{\mathrm{col}}t+\exp\!\left(-N^{1+\kappa/4}\right).
\]

The constants proved here are

\[
C_{\mathrm{col}}=
\begin{cases}
2\sqrt2\,e\rho/\sqrt c,&\text{real entry densities bounded by }\rho,\\
\sqrt{\pi L/c},&\text{complex planar densities bounded by }L.
\end{cases}
\]

The real theorem has the explicit geometric Brascamp--Lieb hypothesis described below. The planar theorem does not require that hypothesis, or independence of the real and imaginary parts of an entry.

## Actual random-matrix models

Write `X i j = sigma i j * xi i j`. The raw entries are mutually independent and have probability densities with the indicated uniform bound. Identical distributions are not required. The deterministic profile satisfies

\[
\sigma_{ij}\ge0,\qquad
\frac cW\le\sigma_{ij}^2\quad\text{if }\operatorname{dist}_{\mathrm{cyc}}(i,j)\le W,
\qquad \sigma_{ij}^2\le\frac CW,\qquad
\sum_j\sigma_{ij}^2=1.
\]

These conditions are the fields of `PlanarBandModel` and `RealBandModel`. Their laws are constructed as products of the entry-density measures. Centering and moment bounds are not needed for this truncated conclusion.

## Checked entry points

- [PlanarModelTheorem.lean](PlanarModelTheorem.lean): `HighBandLSV.eventually_planar_band_lsv`.
- [RealModelTheorem.lean](RealModelTheorem.lean): `HighBandLSV.eventually_real_band_lsv`.
- [ModelStatements.lean](ModelStatements.lean): `real_main_statement` and `planar_main_statement`, with an explicit existential cutoff `N0` and the exponential threshold expanded.
- [NormalKernelIdentity.lean](NormalKernelIdentity.lean): the normal equations are exactly `ker (P_S * A*)`, including deletion of one column.
- [UniformModelExample.lean](UniformModelExample.lean): a concrete centered-uniform model, proof that the model assumptions are inhabited for every dimension, and an application of the real main theorem.
- [ModelLawTransport.lean](ModelLawTransport.lean): equality of matrix laws for independent column representations on other probability spaces with the specified column marginals.

See [the full status matrix](FORMALIZATION_MATRIX.md) and [scope and verification status](STATUS.md).

## What is no longer an interface assumption

The final model-level theorems do not assume a normal-spread estimate, a finite-net probability bound, a conditional density estimate, a conditional-independence statement, a measurable choice of normal vector, or a numerical certificate. The proof constructs or derives the necessary objects and estimates. Eventual numerical certificates are themselves proved from the bandwidth hypotheses.

The argument uses a measurable event quantifying over all unit normal vectors and pointwise normal choices on fixed-column sections. A measurable cofactor selector is therefore unnecessary, rather than left as an assumption.

## Sole remaining analytic input for real laws

`LivshytsProjectionFormalization.RealFiniteGeometricBrascampLieb` is an explicit theorem hypothesis. The accepted real projection-density theorem is available conditional on this inequality. The one- and two-dimensional projection bounds used here, coefficient scaling, Gram-determinant comparison, and the random-matrix probability estimates are proved from that input.

This repository does **not** claim a proof of geometric Brascamp--Lieb. The planar model theorem has no corresponding external density-theorem hypothesis.

## Reproduce the checks

The toolchain and dependencies are pinned in `lean-toolchain` and `lake-manifest.json`.

```sh
lake exe cache get
lake build
lake env lean AxiomAudit.lean
```

GitHub Actions rebuilds every project library from source, checks 25 selected dependency lists against the standard Lean logical foundations, rejects forbidden proof placeholders/declarations, and requires a compiled artifact for every tracked Lean source. `AxiomAudit.lean` is compiled explicitly in its own step.

No new axiom declarations or unchecked proof placeholders are used. Standard Lean dependencies such as `propext`, `Classical.choice`, and `Quot.sound` are not additional analytic hypotheses.

This is not a formalization of every section of either manuscript, nor a proof of an unconditional Hilbert--Schmidt tail estimate.

[ProjectAxiomAudit.lean](ProjectAxiomAudit.lean) additionally traverses declarations by their owning production module and checks every such declaration's transitive dependencies. This supplements, rather than replaces, the 25 named theorem checks.
