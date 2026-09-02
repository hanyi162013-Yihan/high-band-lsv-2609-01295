# Planar complex entry laws

The planar branch allows a bounded two-dimensional density for each complex raw entry. It does not factor that density into separate real and imaginary densities, and does not assume those two parts are independent.

For a normal vector with block mass at least `delta^2`, a sufficiently large coordinate supplies a one-entry density bound. Conditioning/convolution over the other independent entries preserves the density upper bound. The resulting quadratic small-ball bound can retain a factor `N`; `QuadraticLinearization.planar_column_linearization` converts it to a linear bound.

At the block-net stage the complex block has real dimension twice its complex dimension. Radial labels, actual internal centers, selected-row tensorization, and cyclic path cancellation produce a raw probability expression. `certificate_dimension_loss_union` absorbs the conservative dimension loss as well as the endpoint and column unions.

The main declarations are:

- `Planar.sum_has_bounded_density` and `Planar.sum_small_ball`.
- `PlanarRowBounds.center_row_probability`.
- `PlanarTensorization.center_union_endpoint_bound`.
- `FixedNormalProbability.fixed_bad_probability`.
- `PlanarBandModel.column_distance_small_ball`.
- `planar_bad_normals_from_numerics`.
- `eventually_planar_band_lsv`.
- `ModelStatements.planar_main_statement`.

All names are in `HighBandLSV`. The final constant is `sqrt (pi * L / c)`. No geometric Brascamp--Lieb hypothesis occurs in this branch.
