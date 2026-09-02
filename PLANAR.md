# Elementary planar density route

For independent complex random variables with planar densities at most L, and
nonzero coefficient vector a of length m, the new proof gives

    density(sum_j a_j eta_j) <= m L / sum_j ||a_j||^2.

It does not assume independence of real and imaginary parts. Choose a largest
coefficient, scale its density using the real determinant of complex
multiplication, and average its independent random translates. A
Radon-Nikodym argument constructs an actual bounded density, not merely a
small-ball inequality. Integration over a disk gives the corresponding
quadratic small-ball estimate, capped at one.

## Declaration map

| Step | Declaration in `HighBandLSV` | Scope |
| --- | --- | --- |
| Real Jacobian of complex multiplication | `Planar.det_mulLinear`, `Planar.map_volume_mul` | Algebra and Haar measure |
| Scaling a dominated law | `Planar.map_mul_le_volume` | Measure domination |
| Independent random translation | `Planar.independent_add_le_volume` | Product law and integration |
| Largest-coefficient selection | `Planar.exists_coefficient_density_bound` | Finite sum inequality |
| Density of an independent complex sum | `Planar.sum_has_bounded_density` | Actual measurable density |
| Disk probability | `Planar.sum_small_ball` | Bound min(1, pi m L s^2 / energy) |
| Additional normal-net entropy | `dimension_loss_log_envelope`, `dimension_loss_normal_union` | Adds at most N log N; scalar coefficient 27 becomes 28 |
| Additional column prefactor | `dimension_loss_final_gap` | Absorbs sqrt(N) through a scalar W-to-2W comparison |

## Exact boundary

This is a dimension-loss alternative, not a proof of the dimension-free
Bobkov-Chistyakov density theorem. It needs only independence, measurability,
and the stated atom-law density domination hypotheses. It uses no additional
projection-density or Brascamp-Lieb assumption.

The entropy and threshold statements are scalar lemmas. They do not by
themselves construct `AppendixBInputs` for the random band matrix. Concrete
event definitions, row/net tensorization, exposure/conditioning, and the
model-to-certificate assembly remain to be connected in this standalone
project. A successful Lean build checks the stated theorems with their exact
hypotheses; it does not remove those hypotheses.

## Verification

The new module is a default Lake build target. GitHub Actions builds the
libraries from source and separately audits six public declarations using
`AxiomAudit.lean`. The accepted foundational dependencies are `propext`,
`Classical.choice`, and `Quot.sound`. The Actions run for a commit is the
verification record; an uploaded but unfinished run is not a successful check.
