# Model-level formalization status

This is a work-in-progress status matrix, not a completion certificate.
The complete random-matrix-model theorem has not yet passed a whole-project
build. A passing deterministic or probability lemma must not be confused with
a model-level least-singular-value theorem.

The baseline theorem `HighBandLSV.eventually_high_band_lsv` is checked, but its
`AppendixBInputs` argument still contains probability interfaces. The work below
constructs those estimates from entry laws rather than assuming them.

## Current proof layers

| Paper step | Lean declarations | Current status |
| --- | --- | --- |
| Actual balanced cyclic partition | `actual_partition_geometry`, `actual_partition_bounds` | Checked baseline |
| Deleted-adjoint normal-space algebra | `Section5Formalization.MatrixNormal` | Checked baseline |
| Independent planar entry model and matrix map | `PlanarBandModel`, `PlanarBandModel.measurable_matrix` | Module checked |
| Bandwidth bound from row normalization | `PlanarBandModel.bandwidth_le` | Module checked |
| Density scaling and independent summation | `Planar.map_mul_le_volume`, `Planar.sum_has_bounded_density` | Module checked |
| General complex-atom small-ball estimate | `Planar.sum_small_ball` | Module checked; no independence of real and imaginary parts assumed |
| Exact fresh-column exposure and conditional kernel | `ColumnExposure.expose_preserving`, `ColumnExposure.conditional_jointLaw` | Module checked |
| Moving coefficients and frozen outside variables | `ColumnExposure.moving_block_small_ball` | Module checked |
| Borel universal normal-spread event | `NormalEvents.measurableSet_good` | Module checked |
| Unit normal on every fiber, including deficient rank | `NormalEvents.exists_unit_normal` | Module checked |
| Actual matrix column-distance probability | `PlanarBandModel.column_distance_small_ball` | Source written; dependency-gated build pending |
| Internal radial complex-block nets | `PlanarNets.exists_annular_net` | Module checked |
| Balanced block assembly and deleted row families | `BlockGeometry.Partition.assembled_error`, `BlockGeometry.chooseRows` | Source written; build pending |
| Explicit simple nearest-neighbor path | `NeighborPath.between` | Module checked |
| Exact path product and endpoint ratio | `NeighborPath.inverse_product_ratio` | Module checked |
| Path assignment remains in the variance-profile band | `PathGeometry.target_in_band` | Source written; build pending |
| Weighted net-cardinality/probability cancellation | `RadialLedger.net_row_cancellation`, `RadialLedger.radial_to_endpoint_bound` | Module checked |
| Full vector net and heavy/small endpoint weights | `RadialNetAssembly.System.covers_unit_sphere`, `RadialNetAssembly.heavy_weight` | Source written; build pending |
| Actual bad-normal event covered by finite nets | `NormalNetEvents.fixedBad_subset_net_union` | Source written; build pending |
| Hilbert--Schmidt cutoff supplies column bounds | `MatrixGeometry.hs_cutoff_column_bound` | Source written; build pending |
| Zero-radius and positive-radius row branches | `PlanarRowBounds.center_row_probability` | Source written; build pending |
| Exact original-column tensorization | `PlanarBandModel.selected_rows_probability` | Module checked |
| Finite unions and real-valued product bounds | `FiniteProbability.finite_union`, `FiniteProbability.product_bound` | Module checked |
| Tensorization for actual assembled net vectors | `PlanarTensorization.center_union_endpoint_bound` | Source written; build pending |
| Model-derived fixed-index and global normal estimates | `FixedNormalProbability.fixed_bad_probability`, `FixedNormalProbability.bad_normal_probability` | Source written; build pending |
| Actual Appendix B mesh inequalities | `MeshParameters.actual_mesh_bounds` | Source written; build pending |
| Comparison with the paper's raw envelope | `RadialRawBound.actual_fixedEnvelope_le_raw` | Source written; build pending |
| Extra planar dimension factor in exponent ledger | `dimension_loss_normal_union`, `dimension_loss_final_gap` | Module checked |
| Quadratic-to-linear column estimate | `QuadraticLinearization.planar_column_linearization` | Module checked |
| Scalar eventual parameter certificate | `eventually_actual_numerics` | Checked baseline; dimension-loss assembly remains |
| Distance-to-span and final generic probability assembly | `high_band_lsv_from_inputs` | Checked baseline, with interface hypotheses |
| Complete planar-model main theorem | Not yet declared | Remaining work |
| Real-atom anisotropic block-net branch | Not yet integrated | Remaining work |
| Real projection-density theorem from geometric BL | Separate pinned dependency and original adapter available | Model-level integration remains |

## Meaning of the planar variant

The elementary planar density bound incurs a factor equal to the number of
coordinates. Consequently, the row tensorization has an additional
`N^(r*J)` factor, and the final column estimate has an additional `sqrt N`
factor. The scalar lemmas account for both factors explicitly. They are not
silently discarded, and a proof of those scalar lemmas alone does not finish
the random-matrix theorem.

The radial construction is appropriate for genuinely planar atom laws.
Real-valued atoms have singular planar laws and require a separate anisotropic
construction. The planar proof is not being claimed to cover real atoms.

## Permitted external mathematical input

For the real branch, the only permitted deep input is the previously accepted
real projection-density theorem, or its pinned realization with
`RealFiniteGeometricBrascampLieb` as an explicit theorem hypothesis.
Conditional kernels, independence, density scaling, measurable events, finite
nets, and probability estimates must be proved in the project or its checked
dependencies; they are not allowed to remain as additional final hypotheses.

No custom axiom or unfinished proof is acceptable for a completion claim.
Compiler error-recovery reports containing `sorryAx` are failures, not
verified declarations. The final status matrix and build revision will be
updated only after the relevant files pass.
