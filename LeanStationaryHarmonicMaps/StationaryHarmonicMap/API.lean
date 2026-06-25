import LeanStationaryHarmonicMaps.StationaryHarmonicMap.Euclidean
import LeanStationaryHarmonicMaps.StationaryHarmonicMap.StationarityBridge

noncomputable section

open MeasureTheory Set
open scoped Topology BigOperators ENNReal

/-!
# Public API for stationary harmonic map monotonicity

This module is the intended public entry point for the stationary
`W^{1,2}_{loc}` monotonicity theorem.  The main user-facing objects are:

* `LocallyMemLpTwoIn`
* `GradientLocallyMemLpTwoIn`
* `CompactlySupportedC1In`
* `DistributionalWeakGradientIn`
* `DomainVariationStationaryIn`
* `StationarySobolevMapIn`
* `stationarySobolevMonotonicity_euclidean`

Implementation-route theorems in the radial/coarea files should normally be
treated as internal scaffolding.
-/

namespace LeanStationaryHarmonicMaps
namespace StationaryHarmonicMap

/-- Public componentwise monotonicity theorem.

This is the recommended entry point when the stationary Sobolev data are
available as separate hypotheses: local `L²` control of `u`, a.e. strong
measurability and local `L²` control of `Du`, the distributional weak-gradient
identity, and vanishing domain first variation. -/
theorem stationarySobolevMonotonicity_euclidean
    {n m : ℕ} [NeZero n]
    {u : Domain n → Target m} {Du : Domain n → Gradient n m}
    {Ω : Set (Domain n)} {a : Domain n} {R0 s r : ℝ}
    (hu_memLp : LocallyMemLpTwoIn u Ω)
    (hDu_aesm : GradientAEStronglyMeasurableIn Du Ω)
    (hDu_memLp : LocallyMemLpTwoIn Du Ω)
    (hweakGradient : DistributionalWeakGradientIn u Du Ω)
    (hfirstVariation : DomainVariationStationaryIn u Du Ω)
    (hΩ_meas : MeasurableSet Ω)
    (hclosedBall_subset : Metric.closedBall a R0 ⊆ Ω)
    (hs_pos : 0 < s)
    (hsr : s ≤ r)
    (hr_lt : r < R0) :
    weakTheta Du a s ≤ weakTheta Du a r :=
  weakTheta_le_of_stationary_sobolev_map_components_euclidean
    (n := n) (m := m) (u := u) (Du := Du) (Ω := Ω) (a := a) (R0 := R0)
    (s := s) (r := r)
    hu_memLp hDu_aesm hDu_memLp hweakGradient hfirstVariation
    hΩ_meas hclosedBall_subset hs_pos hsr hr_lt

end StationaryHarmonicMap
end LeanStationaryHarmonicMaps

end
