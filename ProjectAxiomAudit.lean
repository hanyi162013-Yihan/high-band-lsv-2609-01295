import Lean.Util.CollectAxioms
import AnisotropicLabels
import AnisotropicMesh
import AnisotropicNetAssembly
import AnisotropicNetGeometry
import AnisotropicNets
import BlockGeometry
import FiniteProbability
import FixedNormalProbability
import HighBandLSV
import InternalNet
import LSVAssembly
import MatrixColumnBound
import MatrixGeometry
import MeshParameters
import ModelLawTransport
import ModelNumerics
import ModelPartition
import ModelStatements
import NeighborPath
import NormalEvents
import NormalKernelIdentity
import NormalNetEvents
import PathGeometry
import PlanarModelTheorem
import PlanarNets
import PlanarNormalTheorem
import PlanarRowBounds
import PlanarSmallBall
import PlanarTensorization
import ProductEvents
import QuadraticLinearization
import RadialLedger
import RadialNetAssembly
import RadialRawBound
import RandomMatrixModel
import RealAnisotropicGeometry
import RealColumnExposure
import RealColumnSmallBall
import RealConditionalKernel
import RealFixedNormalProbability
import RealFormSmallBall
import RealLSVAssembly
import RealMatrixColumnBound
import RealMatrixForms
import RealModelTheorem
import RealNetCost
import RealNetProbability
import RealNormalNetEvents
import RealNormalTheorem
import RealProjectionAdapter
import RealProjectionInterface
import RealProjectionSmallBall
import RealRandomMatrixModel
import RealRawBound
import RealRowBounds
import RealSmallBallNumerics
import RealTensorization
import RealWeightedGeometry
import Section5Formalization
import Section5Formalization.BlockEnergy
import Section5Formalization.CyclicPartition
import Section5Formalization.DeterministicCompletion
import Section5Formalization.ExponentLedger
import Section5Formalization.MatrixNormal
import Section5Formalization.Section5Formalization
import Section5Formalization.VolumetricNet
import UniformModelExample

/-! Comprehensive dependency audit, selected by the owning source module. -/

open Lean Elab Command

run_cmd do
  let env ← getEnv
  let productionModules : Array String := #[
    "AnisotropicLabels",
    "AnisotropicMesh",
    "AnisotropicNetAssembly",
    "AnisotropicNetGeometry",
    "AnisotropicNets",
    "BlockGeometry",
    "FiniteProbability",
    "FixedNormalProbability",
    "HighBandLSV",
    "InternalNet",
    "LSVAssembly",
    "MatrixColumnBound",
    "MatrixGeometry",
    "MeshParameters",
    "ModelLawTransport",
    "ModelNumerics",
    "ModelPartition",
    "ModelStatements",
    "NeighborPath",
    "NormalEvents",
    "NormalKernelIdentity",
    "NormalNetEvents",
    "PathGeometry",
    "PlanarModelTheorem",
    "PlanarNets",
    "PlanarNormalTheorem",
    "PlanarRowBounds",
    "PlanarSmallBall",
    "PlanarTensorization",
    "ProductEvents",
    "QuadraticLinearization",
    "RadialLedger",
    "RadialNetAssembly",
    "RadialRawBound",
    "RandomMatrixModel",
    "RealAnisotropicGeometry",
    "RealColumnExposure",
    "RealColumnSmallBall",
    "RealConditionalKernel",
    "RealFixedNormalProbability",
    "RealFormSmallBall",
    "RealLSVAssembly",
    "RealMatrixColumnBound",
    "RealMatrixForms",
    "RealModelTheorem",
    "RealNetCost",
    "RealNetProbability",
    "RealNormalNetEvents",
    "RealNormalTheorem",
    "RealProjectionAdapter",
    "RealProjectionInterface",
    "RealProjectionSmallBall",
    "RealRandomMatrixModel",
    "RealRawBound",
    "RealRowBounds",
    "RealSmallBallNumerics",
    "RealTensorization",
    "RealWeightedGeometry",
    "Section5Formalization",
    "Section5Formalization.BlockEnergy",
    "Section5Formalization.CyclicPartition",
    "Section5Formalization.DeterministicCompletion",
    "Section5Formalization.ExponentLedger",
    "Section5Formalization.MatrixNormal",
    "Section5Formalization.Section5Formalization",
    "Section5Formalization.VolumetricNet",
    "UniformModelExample"]
  let allowed : Array Name := #[``propext, ``Classical.choice, ``Quot.sound]
  let mut count : Nat := 0
  for (name, _) in env.checked.get.constants.toList do
    if let some idx := env.getModuleIdxFor? name then
      let owner := (env.header.modules[idx.toNat]!).module
      if productionModules.contains owner.toString then
        let dependencies ← Lean.collectAxioms name
        for dependency in dependencies do
          unless allowed.contains dependency do
            throwError m!"Unexpected dependency {dependency} in project declaration {name}"
        count := count + 1
  if count == 0 then
    throwError "The full-project dependency audit did not inspect any declarations"
  logInfo m!"Full-project dependency audit passed for {count} declarations in {productionModules.size} production modules."
