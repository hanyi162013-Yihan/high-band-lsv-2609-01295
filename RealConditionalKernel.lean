import RealColumnExposure
import RandomMatrixModel

/-! A concrete conditional column kernel, with its joint-law identity proved. -/

noncomputable section
open MeasureTheory ProbabilityTheory
namespace HighBandLSV.RealColumnExposure
open HighBandLSV.RealBandModel

variable {n W : Nat} {c C rho : Real} (m : RealBandModel (n + 1) W c C rho)

def conditionalKernel (j : Fin (n + 1)) :
    Kernel (Rest n) (RealBandModel.AtomColumn (n + 1)) :=
  Kernel.const (Rest n) (m.columnLaw j)

instance conditionalKernel_markov (j : Fin (n + 1)) : IsMarkovKernel (conditionalKernel m j) := by
  unfold conditionalKernel
  infer_instance

theorem conditionalKernel_joint (j : Fin (n + 1)) :
    (restLaw m j).compProd (conditionalKernel m j) = (restLaw m j).prod (m.columnLaw j) := by
  simp [conditionalKernel]

theorem conditional_jointLaw (j : Fin (n + 1)) :
    Measure.map Prod.swap (Measure.map (expose j) m.law) =
      (restLaw m j).compProd (conditionalKernel m j) := by
  rw [(expose_preserving m j).map_eq, Measure.prod_swap, conditionalKernel_joint]

end HighBandLSV.RealColumnExposure

#print axioms HighBandLSV.RealColumnExposure.conditional_jointLaw
