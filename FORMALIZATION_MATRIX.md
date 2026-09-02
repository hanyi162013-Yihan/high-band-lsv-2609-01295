# Formalization status matrix

This matrix describes the repaired least-singular-value argument and its high-band, Hilbert--Schmidt implementation. All declaration names below are in `HighBandLSV` unless a different namespace is shown. The final entry points discharge the intermediate interfaces; they are not merely restatements of `AppendixBInputs`.

`Proved` means a Lean proof, conditional only on the hypotheses visible in the corresponding declaration. For the real probability branch, the sole external analytic hypothesis is `RealFiniteGeometricBrascampLieb`.

## Deterministic, combinatorial, and algebraic steps

| Proof step | Lean declarations | Status |
|---|---|---|
| Balanced cyclic partition with the actual floor/ceiling parameters | `ceiling_partition_arithmetic`, `ModelPartition.actual` | Proved |
| Retained row count after excluding a column | `ModelPartition.retained_rows_fit`, `BlockGeometry.chooseRows` | Proved |
| Neighboring blocks lie in the variance-profile band | `ModelPartition.local_band`, `PathGeometry.target_in_band` | Proved |
| Normal space is the kernel of a projected conjugate transpose | `NormalKernelIdentity.normal_to_columns_iff_ker`, `NormalKernelIdentity.isNormal_iff_ker` | Proved for arbitrary coordinate blocks |
| Existence of a unit normal to all but one column | `NormalEvents.exists_unit_normal` | Proved |
| Hermitian inner product versus distance to the other-column span | `NormalEvents.norm_inner_le_distance` | Proved |
| Borel event expressing a uniform condition on all unit normals | `NormalEvents.measurableSet_good` | Proved; no measurable selector hypothesis |
| Hilbert--Schmidt cutoff implies the shifted column cap | `MatrixGeometry.hs_cutoff_column_bound` | Proved |
| Approximation errors combine over blocks | `BlockGeometry.Partition.assembled_error` | Proved |
| Complex radial/annular nets have real dimension twice the block size | `PlanarNets.exists_annular_net`, `RadialNetAssembly.chooseSystem` | Proved |
| Replace external covers by internal nets | `InternalNet.exists_internal_net` | Proved |
| Real/imaginary decomposition, shear, and orthogonal residual | `Anisotropic.gram_product_symm`, `Anisotropic.exists_block_label` | Proved |
| Profile-weighted full-column Gram product dominates the block product | `Anisotropic.weighted_block_gram_product`, `RealBandModel.block_gram_lower` | Proved |
| Complex anisotropic internal block nets | `Anisotropic.exists_internal_anisotropic_net` | Proved |
| Three scalar labels per block, including shear | `Anisotropic.labels_card`, `RealNormalNetEvents.endpoint_labels_card` | Proved |
| Product-net size and unit-sphere approximation | `Anisotropic.System.center_card`, `Anisotropic.System.covers_unit_sphere` | Proved |
| Small and heavy endpoint weights | `Anisotropic.heavy_block_weight`, `Anisotropic.actual_endpoint_ratio`, `RadialNetAssembly.heavy_weight` | Proved |
| A simple cyclic path between the endpoint blocks | `NeighborPath.between` | Proved |
| Cyclic path telescoping | `NeighborPath.inverse_product_ratio` | Proved |
| Cancellation between net weights and row small-ball denominators | `RadialLedger.net_row_cancellation`, `RealNetCost.weighted_cost_bound`, `RealNetCost.center_cost_bound` | Proved |
| Actual mesh positivity, approximation error, and mesh-size constraints | `MeshParameters.actual_mesh_bounds`, `Anisotropic.actual_mesh_quarter` | Proved |

## Probability and model construction

| Proof step | Lean declarations | Status |
|---|---|---|
| Construct the independent-entry matrix laws from densities | `PlanarBandModel.law`, `RealBandModel.law` | Constructed; probability normalization proved |
| Coordinate measurability, independence, and marginal laws in the real model | `RealBandModel.measurable_coordinateRV`, `RealBandModel.independent_coordinates`, `RealBandModel.marginal_law` | Proved |
| Turn the accepted real density theorem into the exact one/two-axis interface | `Real.realOneTwoProjectionDensityInterfaceFromGBL`, `RealBandModel.projectionInterface` | Proved from the explicit GBL hypothesis |
| Real two-dimensional small-ball estimate, including shear | `Anisotropic.form_two_small_ball`, `RealBandModel.linearForm_two_small_ball` | Proved from that interface |
| Real row estimate in the two-axis, one-axis, and zero-label regimes | `RealBandModel.anisotropic_row_probability` | Proved in all regimes |
| Real one-axis bound from block mass | `RealBandModel.linearForm_block_mass_small_ball` | Proved |
| General planar density convolution and small balls | `Planar.sum_has_bounded_density`, `Planar.sum_small_ball` | Proved; no real/imaginary independence assumption |
| Planar row small-ball estimate | `PlanarRowBounds.center_row_probability` | Proved |
| Independence over selected columns and deleted row families | `ProductEvents.finite_constraints`, `BlockGeometry.RowSelection.product_by_blocks` | Proved |
| Tensorization at a fixed net point | `PlanarTensorization.point_probability`, `RealTensorization.point_probability` | Proved from the actual product laws |
| Union over centers and labels | `PlanarTensorization.center_union_endpoint_bound`, `RealNetProbability.label_union_bound` | Proved |
| Cover the fixed bad-normal event by net events | `NormalNetEvents.fixedBad_subset_net_union`, `RealNormalNetEvents.fixedBad_subset_net_union` | Proved |
| Fixed bad-normal probability | `FixedNormalProbability.fixed_bad_probability`, `RealFixedNormalProbability.actual_fixed_probability` | Proved |
| Union over the excluded column and endpoint blocks | `NormalNetEvents.normal_cover`, `FixedNormalProbability.bad_normal_probability`, `RealFixedNormalProbability.bad_normals_union` | Proved |
| Expose one column and integrate over all remaining columns | `ColumnExposure.expose_preserving`, `RealColumnExposure.exposure_probability_bound` | Proved |
| A concrete conditional kernel with the correct joint law | `RealColumnExposure.conditional_jointLaw` | Constructed and proved |
| Measurability of the real exposed distance event | `RealBandModel.measurableSet_exposedDistanceEvent` | Proved |
| Actual model column-distance bound | `PlanarBandModel.column_distance_small_ball`, `RealBandModel.column_distance_small_ball` | Proved; no normal-selector or conditional-density hypothesis |
| Quadratic planar probability bound converted to a linear bound | `QuadraticLinearization.planar_column_linearization` | Proved |
| Distance-to-span implication and final union over columns | `lsv_probability_from_cover`, `real_lsv_from_bad_normals` | Proved |

## Exponent ledger and final closure

| Proof step | Lean declarations | Status |
|---|---|---|
| Compare the actual net/row costs with the raw exponential expression | `RadialRawBound.actual_fixedEnvelope_le_raw`, `RealRawBound.actual_fixedEnvelope_le_raw` | Proved |
| Exact logarithm of the raw cost | `log_rawFixedBound` | Proved |
| Absorb the retained factor `N^(r*J)` and all endpoint unions | `certificate_dimension_loss_union` | Proved |
| Derive all eventual numerical conditions from the bandwidth assumptions | `eventually_model_numerics` | Proved |
| Absorb the column prefactor at the exact `3*kappa` threshold | `dimension_loss_column_union_bound` | Proved |
| Exponentially small bad-normal event in each actual model | `planar_bad_normals_from_numerics`, `real_bad_normals_from_numerics` | Proved |
| Finite-parameter model-level conclusions | `planar_model_lsv_of_numerics`, `real_model_lsv_of_numerics` | Proved |
| Final asymptotic planar theorem | `eventually_planar_band_lsv` | Proved without GBL |
| Final asymptotic real theorem | `eventually_real_band_lsv` | Proved with the single explicit GBL input |
| Explicit exponential threshold and natural-number cutoff | `ModelStatements.threshold_formula`, `ModelStatements.planar_main_statement`, `ModelStatements.real_main_statement` | Proved; no numerical-certificate hypothesis at these entry points |
| Nonvacuous concrete model and theorem application | `Examples.model_nonempty`, `Examples.eventually_uniform_dense_lsv` | Constructed and proved |
| Independence-based transfer to other column representations | `ModelLawTransport.real_matrix_law`, `ModelLawTransport.planar_matrix_law` | Proved equality of matrix laws |

## What remains outside the formalization

| Item | Exact status |
|---|---|
| Real finite geometric Brascamp--Lieb inequality itself | Not proved here. It is the explicit `RealFiniteGeometricBrascampLieb` hypothesis supplying the previously accepted projection-density theorem. |
| A separate measurable cofactor selector | Not required by this implementation. The proof uses a Borel universal normal event and pointwise choices after column exposure. No selector assumption remains. |
| An unconditional probability estimate for failure of the Hilbert--Schmidt cutoff | Not claimed. The final theorem estimates the intersection with the cutoff event. |
| Other sections and conclusions of the manuscripts | Outside this project. This is not a whole-paper formalization. |
| A computable numerical value of the eventual cutoff `N0` | Not extracted. Its existence and all required inequalities are proved. |

The actual mesh, endpoint weights, and exponential threshold are preserved. Some intermediate constants are enlarged, and a conservative dimension factor is retained and explicitly absorbed by the exponent ledger. The proof is consequently not a line-by-line transcription, but does not replace an unproved probability step with a hypothesis at the final entry points.

## Whole-project checking

`ProjectAxiomAudit.lean` imports all production modules and traverses their declarations using Lean's kernel environment and module-ownership metadata. Every collected dependency must be one of the three standard logical foundations listed in `STATUS.md`. The build additionally checks the 25 named declarations in `AxiomAudit.lean`, rejects forbidden source constructs, and verifies that no tracked Lean source lacks its compiled module artifact.
