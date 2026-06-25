import Mathlib

noncomputable section

open MeasureTheory Set
open scoped Topology BigOperators ENNReal

namespace LeanStationaryHarmonicMaps
namespace StationaryHarmonicMap

/-- Applying the pushforward of the signed/vector measure `μ.withDensityᵥ f`
to a measurable set is the same as integrating `f` over the preimage.  This is
the basic computation behind the radial signed pushforward used in the coarea
step. -/
theorem vectorMeasure_map_withDensity_apply
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    {μ : Measure α} {f : α → ℝ} {φ : α → β} {s : Set β}
    (hf : Integrable f μ) (hφ : Measurable φ) (hs : MeasurableSet s) :
    ((μ.withDensityᵥ f).map φ) s = ∫ x in φ ⁻¹' s, f x ∂μ := by
  rw [MeasureTheory.VectorMeasure.map_apply (μ.withDensityᵥ f) hφ hs,
    MeasureTheory.withDensityᵥ_apply hf (hφ hs)]

abbrev Domain (n : ℕ) := EuclideanSpace ℝ (Fin n)
abbrev Target (m : ℕ) := EuclideanSpace ℝ (Fin m)

/-- A pointwise gradient matrix: the `i`-th entry is the derivative in the
`i`-th domain coordinate, valued in the target Euclidean space.  This is the
object that will later be supplied by a weak derivative. -/
abbrev Gradient (n m : ℕ) := Fin n → Target m

/-- The radial signed pushforward of an integrable density on a ball, evaluated
on a measurable radius set. -/
theorem radialVectorMeasure_apply
    {n : ℕ} {f : Domain n → ℝ} {R0 : ℝ} {s : Set ℝ}
    (hf : IntegrableOn f (Metric.ball (0 : Domain n) R0) volume)
    (hs : MeasurableSet s) :
    (((volume.restrict (Metric.ball (0 : Domain n) R0)).withDensityᵥ f).map
        (fun x : Domain n => norm x)) s =
      ∫ x in {x : Domain n | norm x ∈ s}, f x
        ∂(volume.restrict (Metric.ball (0 : Domain n) R0)) := by
  simpa using
    vectorMeasure_map_withDensity_apply
      (μ := volume.restrict (Metric.ball (0 : Domain n) R0))
      (f := f) (φ := fun x : Domain n => norm x) (s := s)
      hf continuous_norm.measurable hs

end StationaryHarmonicMap
end LeanStationaryHarmonicMaps
