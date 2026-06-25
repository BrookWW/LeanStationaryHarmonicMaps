import LeanStationaryHarmonicMaps.StationaryHarmonicMap.API

noncomputable section

open MeasureTheory Set
open scoped Topology BigOperators ENNReal

namespace LeanStationaryHarmonicMaps
namespace StationaryHarmonicMap

/-!
# Minimal use of the public monotonicity API

This file is intentionally small: it checks that an external caller can import
the public API and apply the componentwise stationary Sobolev monotonicity
theorem without manually assembling the intermediate bridge packages.
-/

example
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
  stationarySobolevMonotonicity_euclidean
    (n := n) (m := m) (u := u) (Du := Du) (Ω := Ω) (a := a) (R0 := R0)
    (s := s) (r := r)
    hu_memLp hDu_aesm hDu_memLp hweakGradient hfirstVariation
    hΩ_meas hclosedBall_subset hs_pos hsr hr_lt

end StationaryHarmonicMap
end LeanStationaryHarmonicMaps

end
