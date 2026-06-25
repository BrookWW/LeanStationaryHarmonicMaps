# LeanStationaryHarmonicMaps

This repository contains a Lean formalization of the monotonicity formula for
stationary `W^{1,2}_{loc}` maps with Euclidean target.

The proof is deliberately target independent. It uses only the displayed weak
gradient and vanishing domain first variation; no target-manifold structure is
used in the monotonicity argument. An embedded manifold-valued application can
therefore call this theorem after supplying the usual stationary Sobolev data
and first-variation identity.

The public theorem is:

```lean
stationaryW12LocMonotonicity_euclidean
```

It proves, for `0 < s <= r < R0`,

```lean
weakTheta hmap.w12.weakGrad a s <= weakTheta hmap.w12.weakGrad a r
```

from a bundled stationary Sobolev witness:

```lean
StationaryW12LocMap u Omega
```

The intended import for users who only want the final theorem is:

```lean
import LeanStationaryHarmonicMaps.StationaryHarmonicMap.MainTheorem
```

The broader public API, including the componentwise convenience wrapper, is:

```lean
import LeanStationaryHarmonicMaps.StationaryHarmonicMap.API
```

## What Is Assumed

| Assumption | Lean interface | Role |
| --- | --- | --- |
| Local `L^2` control of the map | `LocallyMemLpTwoIn u Omega` | Supplies the map side of the Sobolev package. |
| Displayed weak gradient | `W12LocMapWitness.weakGrad` | The gradient used in the energy and monotonicity quantity. |
| A.e. strong measurability of the weak gradient | `GradientAEStronglyMeasurableIn weakGrad Omega` | Makes the weak radial energy densities measurable. |
| Local `L^2` control of the weak gradient | `LocallyMemLpTwoIn weakGrad Omega` | Gives local integrability of the energy density. |
| Weak-gradient identity | `DistributionalWeakGradientIn u weakGrad Omega` | Records that the displayed gradient is distributional. |
| Vanishing domain first variation | `DomainVariationStationaryIn u weakGrad Omega` | The stationarity input used by the monotonicity proof. |
| Domain bookkeeping | `MeasurableSet Omega`, `Metric.closedBall a R0 <= Omega` | Lets local hypotheses apply on the relevant ball. |
| Radius hypotheses | `0 < s`, `s <= r`, `r < R0` | The interval on which monotonicity is stated. |

The package

```lean
StationaryW12LocMap u Omega
```

bundles the first-variation identity together with a `W12LocMapWitness`.

## What Is Proved Internally

| Internal layer | Representative declarations | Purpose |
| --- | --- | --- |
| Sobolev witness bridge | `W12LocMapWitness.toW12LocIn` | Converts the public witness into the older internal weak `W^{1,2}_{loc}` interface. |
| Stationary package bridge | `StationaryW12LocMap.toWeakStationaryMapIn` | Converts the public stationary witness into the internal weak-stationary package. |
| Radial vector-field calculus | `RadialVectorFieldDerivativeFormula`, `RadialVectorFieldDivergenceFormula`, `RadialStressContractionFormula` | Formalizes the pointwise algebra behind radial stationarity. |
| Cutoff infrastructure | `AdmissibleRadialCutoff`, `weakPrimitiveCutoffRealization` | Supplies the smooth radial test functions and primitive cutoff step. |
| Radius/coarea representation | `ballIntegralRadiusWeightedRepresentationForWeights_euclidean` | Pushes ball integrals to a one-dimensional radius density. |
| Radius derivative identification | `ballIntegralRadiusDerivativeIdentificationForWeights` | Identifies the derivative of the ball integral with the radial density a.e. |
| Thin-shell control | `radialOpenShellsVolumeTendstoZero_euclidean` | Supplies the absolute-continuity input for radius-variable energies. |
| Boundary-to-monotonicity step | `weakTheta_increment_eq_weakMonotonicityRhs_of_boundary_forWeights` | Converts the a.e. boundary identity into the monotonicity increment formula. |
| Arbitrary center reduction | `weakTheta_le_of_arbitrary_center_W12Loc_euclidean` | Translates the origin-centered theorem to an arbitrary center. |
| Final theorem | `stationaryW12LocMonotonicity_euclidean` | Exposes the packaged public monotonicity statement. |

The route theorems in the radial, coarea, cutoff, and boundary files are
internal scaffolding. They are kept because they document and verify the proof
architecture, but users should normally import `MainTheorem.lean` or `API.lean`.

## What Comes From Mathlib

| Mathlib ingredient | Used for |
| --- | --- |
| `EuclideanSpace R (Fin n)` and finite-dimensional inner product spaces | The domain, target, coordinate gradients, and Hilbert-Schmidt energy. |
| Lebesgue/Haar volume on Euclidean space | Ball energies and radial pushforward measures. |
| `MemLp`, `eLpNorm`, `IntegrableOn`, `AEStronglyMeasurable` | The local Sobolev and measurability infrastructure. |
| Bochner integration and set integrals | Weak-gradient identities, first variation, and energy formulas. |
| Radon-Nikodym and vector measures | The radial density representation of ball integrals. |
| Interval integrals, absolute continuity, and FTC lemmas | The one-dimensional radius calculus. |
| `ContDiff`, `fderiv`, and `ContDiffBump` | Smooth test functions and cutoff construction. |
| Distribution/test-function a.e. vanishing lemma | Turning distributional identities into a.e. boundary identities. |
| Euclidean ball-volume formula | Proving the thin-shell volume estimate. |

## Build

This project uses Lean 4 and mathlib through Lake.

```bash
lake build LeanStationaryHarmonicMaps
lake build LeanStationaryHarmonicMaps.Examples.UseMainTheorem
lake build LeanStationaryHarmonicMaps.Examples.StationaryMonotonicity
```

`LeanStationaryHarmonicMaps/Examples/UseMainTheorem.lean` demonstrates the
minimal route: construct a `StationaryW12LocMap` package and call the main
monotonicity theorem. `StationaryMonotonicity.lean` also checks the broader
public API and the older componentwise wrapper.

## Article Outline

The writing scaffold in `docs/paper-outline.md` contains:

* the mathematical statement;
* the corresponding Lean statement;
* a public dependency graph;
* the internal proof-route diagram;
* a comparison with the DGM Sobolev witness strategy;
* the target-independence explanation;
* explicit non-goals;
* limitations and the future manifold-wrapper shape.

## Main Files

| File | Contents |
| --- | --- |
| `LeanStationaryHarmonicMaps/StationaryHarmonicMap/SobolevWitness.lean` | DGM-style local `W^{1,2}` witness with an explicit weak gradient. |
| `LeanStationaryHarmonicMaps/StationaryHarmonicMap/StationaryMap.lean` | Stationary Sobolev map package built from the witness plus first variation. |
| `LeanStationaryHarmonicMaps/StationaryHarmonicMap/MainTheorem.lean` | Final witness-style monotonicity theorem. |
| `LeanStationaryHarmonicMaps/StationaryHarmonicMap/API.lean` | Public facade and componentwise convenience wrapper. |
| `LeanStationaryHarmonicMaps/Examples/UseMainTheorem.lean` | Minimal example for calling the final theorem. |
| `LeanStationaryHarmonicMaps/Examples/StationaryMonotonicity.lean` | Broader public API example. |

## Scope

Following the same broad engineering choice as the De Giorgi-Nash-Moser
formalization, the Sobolev layer is project-defined and built from mathlib's
`MemLp`, weak-derivative identities, Bochner integration, and Euclidean measure
theory.

The project does not aim to provide a full manifold-valued target theory.
The monotonicity theorem is stated for Euclidean targets because the proof uses
only weak gradients and domain variations. Target-manifold constraints can be
added later as a thin wrapper that supplies `StationaryW12LocMap`.

## Non-goals

This repository deliberately does not try to be:

* a full manifold-valued Sobolev theory;
* a heat-flow formalization;
* a regularity or epsilon-regularity development;
* a partial-regularity formalization;
* a general-purpose Sobolev library.

These non-goals are part of the design. The project isolates the monotonicity
formula from heavier surrounding theories, while leaving room for thin wrappers
around the final `StationaryW12LocMap` API.

## Verification Status

The project is intended to build without incomplete proof commands or
nonstandard trusted declarations.
