import MatrixGeometry

/-! The Hermitian normal equations are exactly a projected-adjoint kernel. -/

noncomputable section
open scoped BigOperators InnerProductSpace
namespace HighBandLSV.NormalKernelIdentity

def projection {N : Nat} (S : Finset (Fin N)) :
    (Fin N → Complex) →ₗ[Complex] (Fin N → Complex) where
  toFun v k := if k ∈ S then v k else 0
  map_add' v w := by
    funext k
    by_cases hk : k ∈ S <;> simp [hk]
  map_smul' a v := by
    funext k
    by_cases hk : k ∈ S <;> simp [hk]

def adjointOperator {N : Nat} (A : NormalEvents.Mat N) :
    (Fin N → Complex) →ₗ[Complex] (Fin N → Complex) where
  toFun := A.conjTranspose.mulVec
  map_add' v w := by
    funext k
    simp [Matrix.mulVec, dotProduct, mul_add, Finset.sum_add_distrib]
  map_smul' a v := by
    funext k
    simp [Matrix.mulVec, dotProduct, Finset.mul_sum, mul_left_comm, mul_assoc]

theorem adjoint_coordinate {N : Nat} (A : NormalEvents.Mat N)
    (u : NormalEvents.Vec N) (k : Fin N) :
    (A.conjTranspose.mulVec (fun i => u i)) k =
      star (inner Complex u (NormalEvents.col A k)) := by
  have hi : inner Complex u (NormalEvents.col A k) = ∑ i, star (u i) * A i k := by
    simpa [shifted] using MatrixGeometry.inner_shifted_column A (0 : Complex) u k
  rw [hi]
  simp [Matrix.mulVec, dotProduct, Matrix.conjTranspose_apply, mul_comm]

/-- This identity applies to an arbitrary block projection, not only to deletion
of one column. The conjugate transpose is essential over the complex field. -/
theorem normal_to_columns_iff_ker {N : Nat} (A : NormalEvents.Mat N)
    (S : Finset (Fin N)) (u : NormalEvents.Vec N) :
    (∀ k ∈ S, inner Complex u (NormalEvents.col A k) = 0) ↔
      (fun i => u i) ∈ LinearMap.ker ((projection S).comp (adjointOperator A)) := by
  constructor
  · intro h
    change (fun k => if k ∈ S then (A.conjTranspose.mulVec (fun i => u i)) k else 0) =
      (fun _ => 0)
    funext k
    by_cases hk : k ∈ S
    · simp [hk, adjoint_coordinate A u k, h k hk]
    · simp [hk]
  · intro h k hk
    have hf : (fun k => if k ∈ S then (A.conjTranspose.mulVec (fun i => u i)) k else 0) =
        (fun _ => 0) := h
    have hz := congrFun hf k
    have hz' : star (inner Complex u (NormalEvents.col A k)) = 0 := by
      simpa only [if_pos hk, adjoint_coordinate] using hz
    have hs := congrArg star hz'
    simpa using hs

theorem isNormal_iff_ker {N : Nat} (A : NormalEvents.Mat N)
    (j : Fin N) (u : NormalEvents.Vec N) :
    NormalEvents.IsNormal A j u ↔
      (fun i => u i) ∈ LinearMap.ker
        ((projection (Finset.univ.erase j)).comp (adjointOperator A)) := by
  simpa only [NormalEvents.IsNormal, Finset.mem_erase, Finset.mem_univ, and_true] using
    normal_to_columns_iff_ker A (Finset.univ.erase j) u

end HighBandLSV.NormalKernelIdentity

#print axioms HighBandLSV.NormalKernelIdentity.normal_to_columns_iff_ker
#print axioms HighBandLSV.NormalKernelIdentity.isNormal_iff_ker
