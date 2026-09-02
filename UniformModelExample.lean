import RealModelTheorem

/-! A concrete, centered, bounded-density model and an application of the main theorem. -/

noncomputable section
open MeasureTheory LivshytsProjectionFormalization
open scoped ENNReal BigOperators
namespace HighBandLSV.Examples

def centeredUniformDensity (N : Nat) : CoordinateDensityData Real N 1 where
  pdf _ := (Set.Icc (-1 / 2 : Real) (1 / 2)).indicator (fun _ => 1)
  measurable_pdf _ := measurable_const.indicator measurableSet_Icc
  integral_pdf _ := by
    rw [lintegral_indicator measurableSet_Icc]
    norm_num [Real.volume_Icc]
  pdf_le _ x := by
    by_cases hx : x ∈ Set.Icc (-1 / 2 : Real) (1 / 2)
    · rw [Set.indicator_of_mem hx]
      norm_num
    · rw [Set.indicator_of_notMem hx]
      exact bot_le

/-- The raw coordinates are uniform on `[-1/2,1/2]`; the deterministic profile
has exactly normalized squared row sums. No moment assumption is used by the
Hilbert--Schmidt-truncated least-singular-value theorem. -/
def uniformDenseModel (N : Nat) : RealBandModel N N 1 1 1 where
  sigma _ _ := 1 / Real.sqrt N
  sigma_nonneg _ _ := div_nonneg zero_le_one (Real.sqrt_nonneg _)
  local_floor := by
    intro i j hij
    simp [div_pow, Real.sq_sqrt (Nat.cast_nonneg N)]
  variance_upper := by
    intro i j
    simp [div_pow, Real.sq_sqrt (Nat.cast_nonneg N)]
  row_normalization := by
    intro i
    have hNnat : N ≠ 0 := by have := i.isLt; omega
    have hN : (N : Real) ≠ 0 := by exact_mod_cast hNnat
    simp only [div_pow, one_pow, Real.sq_sqrt (Nat.cast_nonneg N),
      Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
    field_simp [hN]
  density _ := centeredUniformDensity N

theorem model_nonempty (N : Nat) : Nonempty (RealBandModel N N 1 1 1) :=
  ⟨uniformDenseModel N⟩

theorem eventually_uniform_dense_lsv
    {kappa R Kz : Real} (hGBL : RealFiniteGeometricBrascampLieb)
    (hk : 0 < kappa) (hR : 0 ≤ R) (hKz : 0 ≤ Kz) :
    ∀ᶠ (N : Nat) in Filter.atTop, ∀ z : Complex, ‖z‖ ≤ Kz → ∀ t : Real, 0 ≤ t →
      (uniformDenseModel N).law
        (leastSingularBadEvent (fun omega => shifted ((uniformDenseModel N).matrix omega) z)
            (tau N N kappa t) ∩ hsEvent (uniformDenseModel N).matrix R) ≤
        ENNReal.ofReal ((2 * Real.sqrt 2 * Real.exp 1) * t) +
          ENNReal.ofReal (Real.exp (-(N : Real) ^ (1 + kappa / 4))) := by
  have hWp : ∀ᶠ (N : Nat) in Filter.atTop, 0 < N := Filter.eventually_gt_atTop 0
  have hband : ∀ᶠ (N : Nat) in Filter.atTop,
      (N : Real) ^ (1 / 2 + (1 / 4 : Real)) ≤ N := by
    filter_upwards [hWp] with N hN
    have hN1 : (1 : Real) ≤ N := by exact_mod_cast hN
    calc
      _ ≤ (N : Real) ^ (1 : Real) :=
        Real.rpow_le_rpow_of_exponent_le hN1 (by norm_num)
      _ = (N : Real) := Real.rpow_one _
  have hupper : ∀ᶠ (N : Nat) in Filter.atTop, (N : Real) ≤ (1 : Real) * N := by
    filter_upwards [] with N
    simp
  simpa using eventually_real_band_lsv (chi := 1 / 4) (Cw := 1) hGBL
    (by norm_num) (by norm_num) (by norm_num) hk hR hKz (by norm_num)
    (fun N => N) uniformDenseModel hWp hband hupper

end HighBandLSV.Examples

#print axioms HighBandLSV.Examples.model_nonempty
#print axioms HighBandLSV.Examples.eventually_uniform_dense_lsv
