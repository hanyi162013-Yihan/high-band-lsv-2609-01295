# Verification status and scope

## Model-level closure

Both final model-level theorems first passed a complete source build and the then-current 18-declaration dependency audit at:

- Revision: `ad1ecd86464b767cd241323b540b691174f36e4f`.
- [Successful GitHub Actions run](https://github.com/hanyi162013-Yihan/high-band-lsv-2609-01295/actions/runs/33620772395).

The repository also checks the expanded mathematical statements, projected-adjoint kernel identities, concrete model instance, and representation-law equalities. The current workflow audits 25 selected declarations and checks source/artifact coverage for every tracked Lean file. Consult the latest successful workflow on the current revision for the complete verification record.

## Exact theorem scope

The conclusion is the high-band least-singular-value probability bound **intersected with** `hilbertSchmidt X <= R * sqrt N`, uniform in bounded `z` and nonnegative `t`. It is not an unconditional norm-tail theorem and not a formalization of all sections of either paper.

The final asymptotic entry points assume the bandwidth regime and the concrete matrix-model data. They do not require an `AppendixBInputs` object, a normal-spread probability bound, a net probability bound, or a `NumericalCertificate`.

Legacy interface-based results in `HighBandLSV.lean` remain valid reusable intermediate theorems. Their continued presence is not a gap in the later model-level results: the latter derive the necessary probability estimates and eventual numerical conditions.

## Analytic boundary

For real entry laws, `RealFiniteGeometricBrascampLieb` remains an explicit theorem hypothesis. Its projection-density consequences and their integration into the matrix model are proved. Geometric Brascamp--Lieb itself is not claimed as formalized here.

For planar complex entry laws, no GBL or real-projection-density hypothesis is used. The real and imaginary parts of an entry need not be independent.

All retained trust dependencies printed by the selected theorem audit must belong to `propext`, `Classical.choice`, and `Quot.sound`. This logical audit does not erase or conceal the real theorem's explicit GBL hypothesis.

## Probability-space details

The canonical models use products of entry-density measures. The conditional column kernel is constructed on the space of the remaining raw columns, with its joint-law identity proved. Conditioning on these raw columns is sufficient because the observed remaining matrix columns are measurable functions of them.

No measurable normal-vector selection is assumed. A universal Borel good-normal event permits a pointwise choice in each exposed-column section, followed by integration of the measurable distance event.

`ModelLawTransport` proves equality of matrix laws for independent raw-column representations with the specified column marginals on other probability spaces. It does not silently identify arbitrary unrelated laws.

The original Section 5 workspace and the manuscript source are not modified by this independent project.

The full-project audit in `ProjectAxiomAudit.lean` also checks the transitive dependencies of declarations by source-module ownership. It covers auxiliary results that are not reached by the 25 selected theorem checks.
