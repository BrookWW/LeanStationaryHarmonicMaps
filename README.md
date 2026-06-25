# LeanStationaryHarmonicMaps

This repository contains a Lean formalization of the monotonicity formula for
stationary harmonic maps in the Euclidean setting.

The public entry point is the stationary `W^{1,2}_{loc}` monotonicity theorem
exposed in:

```lean
import LeanStationaryHarmonicMaps.StationaryHarmonicMap.API
```

The recommended theorem is:

```lean
stationarySobolevMonotonicity_euclidean
```

It proves, for `0 < s ≤ r < R0`,

```lean
weakTheta Du a s ≤ weakTheta Du a r
```

from the componentwise stationary Sobolev hypotheses:

* local `L²` control of the map `u`;
* a.e. strong measurability of the weak gradient field `Du`;
* local `L²` control of `Du`;
* the distributional weak-gradient identity;
* vanishing domain first variation against compactly supported `C¹` vector
  fields;
* the measurable-domain and closed-ball containment assumptions.

## Build

This project uses Lean 4 and mathlib through Lake.

```bash
lake build LeanStationaryHarmonicMaps
lake build LeanStationaryHarmonicMaps.Examples.StationaryMonotonicity
```

The example file
`LeanStationaryHarmonicMaps/Examples/StationaryMonotonicity.lean` checks that
an external caller can use the public API without manually assembling the
intermediate bridge packages.

## Main Files

* `LeanStationaryHarmonicMaps/StationaryHarmonicMap/API.lean`:
  public API and recommended monotonicity theorem.
* `LeanStationaryHarmonicMaps/StationaryHarmonicMap/StationarityBridge.lean`:
  stationary Sobolev package and componentwise theorem.
* `LeanStationaryHarmonicMaps/StationaryHarmonicMap/SobolevBridge.lean`:
  local `W^{1,2}` bridge from `MemLp 2` and distributional weak gradients.
* `LeanStationaryHarmonicMaps/StationaryHarmonicMap/WeakGradientBridge.lean`:
  bundled compactly supported `C¹` test functions and weak-gradient identity.
* `LeanStationaryHarmonicMaps/StationaryHarmonicMap/Euclidean.lean`:
  local wrapper around the concrete `EuclideanSpace` API used by the proof.

## Scope

This is a specialized formalization for the stationary harmonic-map
monotonicity theorem. It does not aim to provide a general-purpose Sobolev or
elliptic-regularity library. The Sobolev assumptions are packaged in the form
needed by this monotonicity proof.

## Verification Status

The project is intended to build without incomplete proof commands or
nonstandard trusted declarations.
