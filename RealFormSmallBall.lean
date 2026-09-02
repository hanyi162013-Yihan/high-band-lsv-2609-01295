import RealRandomMatrixModel
import RealAnisotropicGeometry

/-! One- and two-dimensional concentration for actual real linear forms. -/

noncomputable section
open MeasureTheory
open scoped ENNReal InnerProductSpace
namespace HighBandLSV.Anisotropic

variable {N : Nat}

def form (a b x : RV (Fin N)) : Complex :=
  (⟪x, a⟫_ℝ : Complex) + (⟪x, b⟫_ℝ : Complex) * Complex.I

def unitDirection (a : RV (Fin N)) : RV (Fin N) := ‖a‖⁻¹ • a

theorem unitDirection_norm {a : RV (Fin N)} (ha : 0 < ‖a‖) : ‖unitDirection a‖ = 1 := by
  rw [unitDirection, norm_smul, Real.norm_eq_abs, abs_of_pos (inv_pos.mpr ha)]
  exact inv_mul_cancel₀ ha.ne'

theorem scaled_unit_inner (a x : RV (Fin N)) (ha : 0 < ‖a‖) :
    ‖a‖ * ⟪x, unitDirection a⟫_ℝ = ⟪x, a⟫_ℝ := by
  simp only [unitDirection, inner_smul_right]
  rw [← mul_assoc, mul_inv_cancel₀ ha.ne', one_mul]

theorem unit_residual_orthogonal (a b : RV (Fin N)) :
    ⟪unitDirection a, unitDirection (residual a b)⟫_ℝ = 0 := by
  simp [unitDirection, inner_smul_left, inner_smul_right, residual_orthogonal]

theorem form_as_shear (a b x : RV (Fin N)) (ha : 0 < ‖a‖)
    (hr : 0 < ‖residual a b‖) :
    form a b x = HighBandLSV.Real.scaledShearToComplex (shear a b) ‖a‖ ‖residual a b‖
      (⟪x, unitDirection a⟫_ℝ, ⟪x, unitDirection (residual a b)⟫_ℝ) := by
  apply Complex.ext
  · simp only [form, Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.ofReal_im,
      Complex.I_re, Complex.I_im, mul_zero, zero_mul, sub_zero, add_zero,
      HighBandLSV.Real.scaledShearToComplex_re]
    exact (scaled_unit_inner a x ha).symm
  · simp only [form, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.mul_im,
      Complex.I_re, Complex.I_im, mul_one, zero_mul, add_zero, zero_add,
      HighBandLSV.Real.scaledShearToComplex_im]
    rw [scaled_unit_inner a x ha, scaled_unit_inner (residual a b) x hr]
    simp only [residual, inner_sub_right, inner_smul_right]
    ring

def swapComplex (z : Complex) : Complex := Complex.I * star z

theorem form_swap (a b x : RV (Fin N)) : form b a x = swapComplex (form a b x) := by
  apply Complex.ext <;> simp [form, swapComplex, Complex.mul_re, Complex.mul_im]

theorem swapComplex_distance (z w : Complex) : ‖swapComplex z - swapComplex w‖ = ‖z - w‖ := by
  unfold swapComplex
  rw [← mul_sub, ← star_sub, norm_mul, Complex.norm_I, one_mul, norm_star]

variable {Omega : Type*} [MeasurableSpace Omega] {P : Measure Omega}
variable [IsProbabilityMeasure P] {xi : Omega → RV (Fin N)} {rho C : Real}
variable (data : HighBandLSV.Real.OneTwoProjectionDensityInterface Omega N P xi rho C)

theorem form_one_small_ball (a b : RV (Fin N)) (ha : 0 < ‖a‖)
    (w : Complex) {s : Real} (hs : 0 ≤ s) :
    P {omega | ‖form a b (xi omega) - w‖ ≤ s} ≤
      ENNReal.ofReal (2 * (C * rho) * (s / ‖a‖)) := by
  have hp := data.one (unitDirection a) (unitDirection_norm ha)
  have hb := hp.scaled_real_small_ball (b := ‖a‖) (center := w.re) ha.ne' hs
  have hcover : {omega | ‖form a b (xi omega) - w‖ ≤ s} ⊆
      (fun omega => ‖a‖ * ⟪xi omega, unitDirection a⟫_ℝ) ⁻¹' Set.Icc (w.re - s) (w.re + s) := by
    intro omega homega
    have hnorm := (Complex.abs_re_le_norm (form a b (xi omega) - w)).trans homega
    have hre : (form a b (xi omega) - w).re = ⟪xi omega, a⟫_ℝ - w.re := by
      simp [form]
    rw [hre, abs_le] at hnorm
    change w.re - s ≤ ‖a‖ * ⟪xi omega, unitDirection a⟫_ℝ ∧
      ‖a‖ * ⟪xi omega, unitDirection a⟫_ℝ ≤ w.re + s
    rw [scaled_unit_inner a (xi omega) ha]
    constructor <;> linarith [hnorm.1, hnorm.2]
  exact (measure_mono hcover).trans (by simpa [abs_of_nonneg (norm_nonneg a)] using hb)

theorem form_two_small_ball_dominant (a b : RV (Fin N)) (hdom : ‖b‖ ≤ ‖a‖)
    (ha : 0 < ‖a‖) (hr : 0 < ‖residual a b‖) (w : Complex) {s : Real} (hs : 0 ≤ s) :
    P {omega | ‖form a b (xi omega) - w‖ ≤ s} ≤
      ENNReal.ofReal (min 1 (8 * (C * rho ^ 2) * s ^ 2 / (‖a‖ * ‖residual a b‖))) := by
  have h := data.generic_block_small_ball (unitDirection a) (unitDirection (residual a b))
    (unitDirection_norm ha) (unitDirection_norm hr) (unit_residual_orthogonal a b)
    (shear a b) ‖a‖ ‖residual a b‖ w s ha hr hs (shear_abs_le_one hdom)
  simpa only [← form_as_shear a b _ ha hr] using h

theorem form_two_small_ball (a b : RV (Fin N))
    (hgram : 0 < ‖a‖ * ‖residual a b‖) (w : Complex) {s : Real} (hs : 0 ≤ s) :
    P {omega | ‖form a b (xi omega) - w‖ ≤ s} ≤
      ENNReal.ofReal (min 1 (8 * (C * rho ^ 2) * s ^ 2 / (‖a‖ * ‖residual a b‖))) := by
  by_cases hdom : ‖b‖ ≤ ‖a‖
  · have ha : 0 < ‖a‖ := (mul_pos_iff_of_nonneg (norm_nonneg a)
        (norm_nonneg (residual a b))).mp hgram |>.1
    have hr : 0 < ‖residual a b‖ := (mul_pos_iff_of_nonneg (norm_nonneg a)
        (norm_nonneg (residual a b))).mp hgram |>.2
    exact form_two_small_ball_dominant data a b hdom ha hr w hs
  · have hswap : 0 < ‖b‖ * ‖residual b a‖ := by rw [← gram_product_symm]; exact hgram
    have hb : 0 < ‖b‖ := (mul_pos_iff_of_nonneg (norm_nonneg b)
        (norm_nonneg (residual b a))).mp hswap |>.1
    have hr : 0 < ‖residual b a‖ := (mul_pos_iff_of_nonneg (norm_nonneg b)
        (norm_nonneg (residual b a))).mp hswap |>.2
    have h := form_two_small_ball_dominant data b a (by linarith) hb hr (swapComplex w) hs
    have hevent : {omega | ‖form b a (xi omega) - swapComplex w‖ ≤ s} =
        {omega | ‖form a b (xi omega) - w‖ ≤ s} := by
      ext omega
      rw [form_swap, swapComplex_distance]
    rw [hevent, ← gram_product_symm a b] at h
    exact h

end HighBandLSV.Anisotropic

#print axioms HighBandLSV.Anisotropic.form_two_small_ball
