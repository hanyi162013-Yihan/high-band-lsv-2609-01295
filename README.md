# High-band least singular values: arXiv:2609.01295

A standalone Lean 4 + Mathlib formalization of the actual parameter choices and the final probability assembly in Theorem 3.1 and Appendix B of Yi Han's [arXiv:2609.01295v1](https://arxiv.org/abs/2609.01295v1).

The source labels the result **Theorem 3.1**, rather than Proposition 3.1.

## Scope and explicit boundary

This repository proves the deterministic estimates, partition arithmetic, exponent ledger, eventual numerical closure, and the final implication from an explicit probabilistic certificate. It does **not** claim a complete proof of the paper's theorem directly from the random matrix model assumptions.

The remaining probabilistic inputs are fields of `HighBandLSV.AppendixBInputs`, not additional Lean axioms. They include a covering of the bad-normal event, a fixed-index small-ball estimate, and a good-normal column-distance estimate. Constructing these fields from the atom laws and variance profile remains outside this standalone formalization. `PlanarSmallBall.lean` supplies an elementary general-complex density bound with a dimension factor, without assuming independence of real and imaginary parts or another analytic theorem. Its scalar entropy and final-threshold absorption estimates are included. Connecting these ingredients to a concrete matrix-model certificate is still pending; see `PLANAR.md`.

See [STATUS.md](STATUS.md) for the precise correspondence and outstanding work.

## Main theorem

The strongest entry point is:

```lean
HighBandLSV.eventually_high_band_lsv
```

For fixed positive `chi` and `kappa` with `kappa < chi / 4`, fixed nonnegative `R` and `Kz`, and a bandwidth sequence satisfying the high-band lower bound and a fixed linear upper bound, this theorem automatically establishes all the numerical side conditions for sufficiently large `N`.

Given `AppendixBInputs` eventually, uniformly for `norm z <= Kz`, its conclusion is the HS-truncated estimate, uniformly for `t >= 0`:

\[
\mu\left\{s_{\min}(X-zI)\le
 t\exp\!\left(-N^{3\kappa}\frac{N}{W}\right),\quad
 \|X\|_{\mathrm{HS}}\le R\sqrt N\right\}
\le C_{\mathrm{col}}t+\exp\!\left(-N^{1+\kappa/4}\right).
\]

The probability measure, probability space, and random matrix may vary with `N`. The formal conclusion is expressed using `Measure` and `ENNReal.ofReal`; a probability measure is a particular instance.

For a single dimension, use `HighBandLSV.high_band_lsv_from_numerics`, with an explicit `NumericalCertificate`. The lower-level `high_band_lsv_from_inputs` exposes the two final scalar bounds directly. These are conditional theorems, not substitutes for a derivation of the certificate from the random matrix model.

## Actual Appendix B parameters

The implementation uses the source's scales rather than an unspecified polynomial surrogate:

\[
\begin{aligned}
 d_0&=\lfloor\min(W,N)/8\rfloor,&
 J&=\lceil N/d_0\rceil,& d&=\lfloor N/J\rfloor,& r&=d-1,\\
 \Lambda&=N^\kappa N/W,& \delta&=e^{-\Lambda},&
 K_N&=(R+K_z+1)\sqrt N,&
 h&=\frac{\delta}{C_1(K_N+1)\sqrt J}.
\end{aligned}
\]

The integer definitions are total in Lean. Their intended positive-dimension interpretation is proved under explicit positivity hypotheses and, in the main eventual theorem, for sufficiently large `N`.

The fixed-index envelope is represented literally by `rawFixedBound`:

\[
 (C/h)^{3J}C^N h^{-2N}(CW\delta^2)^{rJ}
 [C(K_N+1)J\delta]^r.
\]

The exact coefficient of `Lambda` in its logarithm is proved to be

\[
 3J+2(N-rJ)-r.
\]

The normal-event union factor is `N * J * J`. The sharp distance-to-span argument gives `sqrt N`, and the final column prefactor is `N * sqrt N * sqrt W`. The final column estimate does not condition on the HS event: that cutoff is discarded on the good-normal branch.

## Layout

- `HighBandLSV.lean`: parameters, actual partition bounds, HS estimates, sharp distance-to-span lemma, logarithmic bookkeeping, numerical closure, and conditional probability assembly.
- `Section5Formalization.lean`: root for the retained deterministic Section 5 core.
- `Section5Formalization/`: five retained core modules from the earlier local formalization, without the previous full probabilistic development.
- `STATUS.md`: proof-status matrix and remaining interface construction.
- `BUILD.md`: completed local build and dependency-audit record, when available.

## Build

The project pins Lean `v4.32.0` and its dependencies in `lake-manifest.json`.

```sh
lake exe cache get
lake build
```

All three libraries, including `PlanarSmallBall`, are default build targets. GitHub Actions also compiles `AxiomAudit.lean` and checks six public declarations against the foundational-axiom whitelist. The source includes `#print axioms` commands: these inspect dependencies and do not introduce axioms. See the repository's Actions tab for the actual run status; adding the workflow alone does not mean verification passed.

The upstream projection-density project is pinned as a reference dependency. Its presence does not automatically discharge any field of `AppendixBInputs`, nor remove its own geometric Brascamp-Lieb hypothesis.

## Publication

This independent repository does not modify the original paper or the original Section 5 workspace. It is initially private. No project license has been selected; dependency licenses remain governed by their respective upstream projects.
