# Formalization status

## Reading this matrix

"Proved" refers to an actual Lean proof. "Interface" means an explicit field or theorem hypothesis; it is not a theorem derived here from the random matrix model. A successful build establishes the conditional implications exactly as stated, not the missing construction of their hypotheses.

The target is Theorem 3.1 and Appendix B of arXiv:2609.01295v1. This repository isolates the revised HS argument and actual parameter ledger. It does not import the entire older Section 5 probability development.

## Source-to-Lean matrix

| Paper step | Lean declarations or location | Status |
| --- | --- | --- |
| Scales `Lambda`, `delta`, and the final least-singular-value threshold | `lambda`, `delta`, `tau`, `threshold_ratio` | Proved algebra; definitions match the stated scales. |
| HS-derived cap and net mesh | `hsCap`, `mesh`, `hsCap_polynomial`, `mesh_log`, `mesh_error` | Proved. |
| Seed block, ceiling block count, balanced sizes, retained rows | `seedSize`, `ceilBlocks`, `blockCount`, `blockSize`, `retainedRows`, `ceiling_partition_arithmetic`, `seed_size_bounds` | Proved for the explicit integer hypotheses. |
| Balanced interval partition and cyclic band geometry | `actual_partition_geometry`; retained `CyclicPartition.lean` | Proved deterministic geometry. |
| Normal-space algebra | Retained `MatrixNormal.lean` | Retained proved deterministic algebra. It is not a construction of the new random good-normal event. |
| Actual block-count and row-count scale estimates | `partition_real_scales`, `ActualPartitionBounds`, `actual_partition_bounds` | Proved, with constants `32 * Cw` and `1 / (64 * Cw)` used in the eventual argument. |
| Frobenius/HS norm and Euclidean operator norm comparison | `hilbertSchmidt`, `hilbertSchmidt_formula`, `norm_apply_le_hilbertSchmidt`, `euclideanOpNorm_le_hilbertSchmidt` | Proved. The matrix norm is explicitly Frobenius here. |
| Passing from the HS cutoff to the shifted operator cap | `shifted_apply`, `shifted_opNorm_le`, `hs_truncation_implies_cap` | Proved. |
| Measurable choice/exposure, conditional laws, block nets, and the cyclic-path probability certificate for this version | `AppendixBInputs.normal_cover`, `AppendixBInputs.fixed_small_ball` | Interface. The full random certificate has not been constructed in this repository. Retained deterministic ingredients do not discharge these fields by themselves. |
| Real projection-density small ball | Used only through the certificate fields | Analytic/model interface. The separate real projection project is conditional on finite geometric Brascamp-Lieb. |
| General complex planar-density small ball | Used only through the certificate fields | Analytic/model interface. The Bobkov-Chistyakov maximum-density input is not proved or connected here. |
| Converting quadratic small-ball control to linear control | `min_one_square_le`, `planar_to_linear` | Proved scalar implication; not a proof of the planar density theorem. |
| Fixed-direction conditional scalar-density case | Used only through the certificate fields | Analytic/model interface; conditioning and independence must be supplied. |
| Literal fixed-index probability envelope | `rawFixedBound` | Exact expression defined. The probability upper bound by this expression is a certificate field. |
| Exact logarithm and entropy coefficient | `entropy_coefficient`, `logEnvelope`, `remainder`, `exact_log_coefficient`, `log_rawFixedBound`, `rawFixedBound_eq_exp` | Proved, including the coefficient `3J + 2(N-rJ) - r`. |
| Bounding the remaining logarithmic terms | `remainder_le_24`, `hs_cap_log_bounds`, `envelope_le_entropy_gain` | Proved from explicit scalar hypotheses. |
| Union over normal structures | `normalStructureIndex_card`, `normal_union_absorption`, `NumericalCertificate.normal_bound` | Proved; the factor is `N * J * J`. |
| Sharp distance-to-span implication with `sqrt N` | `exists_norm_div_sqrt_le_coordinate`, `distance_div_sqrt_le_singularQuotient`, `distance_div_sqrt_le_lsv`, `small_lsv_implies_close_column` | Proved, including the closed-threshold event. |
| Good-normal column small ball | `AppendixBInputs.column_small_ball` | Interface, required without conditioning on the HS cutoff. |
| Absorbing the final column prefactor | `columnPrefactor`, `column_prefactor_bound`, `final_log_dominance_of_threshold`, `eventually_final_log_dominance` | Proved for the actual prefactor `N * sqrt N * sqrt W`. |
| Event decomposition and final finite-dimensional estimate | `high_band_lsv_from_inputs`, `high_band_lsv_from_numerics` | Proved conditional on `AppendixBInputs` and explicit numerical conditions. |
| Eventual validity of numerical conditions with the actual integer partition | `eventually_actual_numerics` | Proved. No unproved numerical-certificate assumption remains in the eventual entry point. |
| Uniform large-dimension theorem, for bounded `z` and all `t >= 0` | `eventually_high_band_lsv` | Proved conditional on eventual, uniform `AppendixBInputs`. |

All declarations without a file qualifier in this table are in the `HighBandLSV` namespace and in `HighBandLSV.lean`.

## Exactly what remains

1. Construct `AppendixBInputs` from the paper's independent atom laws, density assumptions, and band variance profile. This includes the new good-normal event, measurable exposure/conditioning, complex block-net estimates, the cyclic-path probabilistic argument, the fixed-index envelope estimate, and the good-normal column bound. The fields have not simply been renamed as proved theorems.
2. Supply and connect the needed density inequalities for each distributional case. The real projection result is conditional on geometric Brascamp-Lieb. The arbitrary complex planar case additionally needs the appropriate maximum-density result. The directional conditional-density case needs its stated conditioning and independence justified from the model.

The arithmetic, actual-parameter numerical closure, HS-to-operator-cap reduction, distance-to-span estimate, and final event/union-bound assembly are not on this remaining-work list.

## Logical audit

There are no intended additional axioms or proof placeholders in this development. The source prints the dependencies of the finite-dimensional main theorem, partition arithmetic, exact logarithmic bound, final exponent domination, actual eventual numerical closure, and the eventual main theorem.

A passing build should list only Lean's usual foundational dependencies (`propext`, `Classical.choice`, and `Quot.sound`, or a subset). In particular, a failed elaboration that prints `sorryAx` is not a successful verification. See `BUILD.md` for the completed build record rather than treating intermediate compiler output as a passed proof.
