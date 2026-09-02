import RealTensorization
import RealRawBound
import AnisotropicMesh
import RadialLedger

open scoped BigOperators
open MeasureTheory

namespace HighBandLSV.RealNetCost

/-- Cancellation of the two real block axes along a cyclic neighbor path.
The extra factor `N` in the row bound is deliberately retained so that the
same numerical certificate covers both real and planar input laws. -/
theorem weighted_cost_bound
    {N J r : Nat} {k l : Fin J} (path : NeighborPath.Path k l)
    (m : Fin J → Nat) (w : Fin J → Real)
    {A W h d K : Real}
    (hA : 1024 ≤ A) (hW : 0 ≤ W) (hh : 0 < h)
    (hw : ∀ j, 0 < w j) (hw1 : ∀ j, w j ≤ 1)
    (hm : ∀ j, r ≤ m j) (hsum : ∑ j, m j = N)
    (hend : w k / w l ≤ A * (K + 1) * J * d) :
    (∏ j, (1024 * w j / h ^ 2) ^ m j) *
      (∏ j, (A * N * W * d ^ 2 /
        w (NeighborPath.next path.vertices j)) ^ r) ≤
    (1024 / h ^ 2) ^ N * (A * N * W * d ^ 2) ^ (r * J) *
      (A * (K + 1) * J * d) ^ r := by
  have hA0 : 0 ≤ A := by linarith
  calc
    _ ≤ (1024 / h ^ 2) ^ N * (A * N * W * d ^ 2) ^ (r * J) *
        (w k / w l) ^ r :=
      RadialLedger.net_row_cancellation path m w (by norm_num)
        (by positivity) hh hw hw1 hm hsum
    _ ≤ _ := mul_le_mul_of_nonneg_left
      (pow_le_pow_left₀ (div_nonneg (hw k).le (hw l).le) hend r) (by positivity)

/-- The small and heavy endpoint labels supply the only uncancelled weight. -/
theorem actual_endpoint_bound
    {N W kappa J C1 K A wk wl : Real}
    (hN : 0 ≤ N) (hW : 0 < W) (hJ : 0 < J)
    (hC1 : 0 < C1) (hK : 0 ≤ K) (hA : 4 * C1 ≤ A)
    (hwk : 0 ≤ wk)
    (hsmall : wk ≤ delta N W kappa ^ 2)
    (hlarge : mesh N W kappa J C1 K / (4 * Real.sqrt J) ≤ wl) :
    wk / wl ≤ A * (K + 1) * J * delta N W kappa := by
  apply (Anisotropic.actual_endpoint_ratio hJ hC1 hK hwk hsmall hlarge).trans
  have hd : 0 ≤ delta N W kappa := by unfold delta; positivity
  exact mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_right
      (mul_le_mul_of_nonneg_right hA (by positivity)) hJ.le) hd

end HighBandLSV.RealNetCost

#print axioms HighBandLSV.RealNetCost.weighted_cost_bound
#print axioms HighBandLSV.RealNetCost.actual_endpoint_bound
