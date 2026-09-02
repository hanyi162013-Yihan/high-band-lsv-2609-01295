# Source comparison and precise scope

Compared on 2026-09-02 with the primary source:
[arXiv:2609.01295v1, Theorem 3.1 and Appendix B](https://arxiv.org/html/2609.01295v1).
The current source labels the high-band input **Theorem 3.1**.

## Main result implemented

The strongest paper-facing entry points are:

- `HighBandLSV.PaperModelTheorem.real_main_statement`
- `HighBandLSV.PaperModelTheorem.planar_main_statement`

Both conclude the actual-model Hilbert-Schmidt-truncated least-singular-value
bound with a literal exponential threshold and an existential natural cutoff.
There are no normal-net, small-ball, conditional-kernel, or numerical-certificate
hypotheses in these statements. The bandwidth upper bound is derived from the
profile, and positive bandwidth is derived from the high-band lower bound.
The real theorem has the explicit accepted geometric Brascamp-Lieb input used
to obtain real projected densities. The planar theorem has no such input.

The formalization permits any positive `kappa`, so in particular includes the
paper's restricted range. Centering, unit atom variance, and column normalization
are not needed for this truncated conclusion. Only the stated row normalization,
variance bounds, and density assumptions are used. Consequently the paper's
centered, unit-variance, doubly stochastic models satisfy stronger assumptions
than this implementation needs.

## Proof correspondence and deliberate alternatives

| Source location | Implementation and qualification |
| --- | --- |
| B.1 | The real projection-density development is used with explicit GBL hypothesis. |
| B.2 | The dimension-free convolution statement is not proved here. The project instead proves an elementary single-coordinate bound with a dimension factor, then absorbs the resulting entropy loss. No convolution theorem is assumed. |
| B.3 | The actual balanced cyclic partition and its local band inclusion are proved. |
| B.4 | Anisotropic internal nets handle real atoms; annular complex nets handle planar atoms. Cardinalities and probability costs are proved, not supplied as data. |
| B.8 | `NormalKernelIdentity.isNormal_iff_ker` identifies the deleted-column normal space with the projected-adjoint kernel. |
| B.5 and B.11-B.20 | The required normal-spread argument is proved at the actual HS-induced cap. The standalone version for every polynomial cap is not claimed. |
| B.21-B.24 | Distance-to-span, measurable column events, exposure, and averaging are proved. Pointwise normal selection inside an already measurable section avoids a global measurable-selector requirement. |

The implemented exponent ledger explicitly accommodates the extra `N^(r*J)`
factor. Its numerical inequalities are proved eventually for the actual
parameters; they do not remain theorem assumptions.

## Not claimed

- The optional conditional-direction extension of Remark 2.11. The complete
  model-level theorems cover real atoms and complex atoms with bounded joint
  planar density, including dependent real and imaginary parts.
- Removing the HS cutoff by a separate moment/tail theorem.
- The remaining circular-law sections or Appendix A.
- A numerical algorithm computing the asymptotic cutoff.

These are scope boundaries, not hidden hypotheses of the two proved main
statements. See `FORMALIZATION_MATRIX.md` for declaration-level coverage and
`BUILD.md` for the all-source build and dependency-audit procedure.
