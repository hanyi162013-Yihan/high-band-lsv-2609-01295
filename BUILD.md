# Verified local build

Date: 2026-09-02.

Environment: local macOS; Lean `v4.32.0`; dependencies pinned by `lake-manifest.json`.

Command:

```sh
LEAN_NUM_THREADS=1 lake build
```

Result:

```text
Build completed successfully (8668 jobs).
```

Exit status: 0. The final `HighBandLSV` compilation took 326 seconds. Existing dependency and core artifacts were reused where Lake considered them up to date. This is not a claim of 8668 freshly recompiled modules or a clean-machine build.

Both project libraries are default targets. All seven project Lean source files were covered by the successful build, with the retained core modules compiled earlier in the same local verification process. The build has non-fatal linter warnings concerning unused variables, unused simplification arguments, and redundant tactics.

## Declaration dependency audit

The successful build printed:

| Declaration | Reported foundational dependencies |
| --- | --- |
| `HighBandLSV.high_band_lsv_from_numerics` | `propext`, `Classical.choice`, `Quot.sound` |
| `HighBandLSV.ceiling_partition_arithmetic` | `propext`, `Quot.sound` |
| `HighBandLSV.log_rawFixedBound` | `propext`, `Classical.choice`, `Quot.sound` |
| `HighBandLSV.eventually_final_log_dominance` | `propext`, `Classical.choice`, `Quot.sound` |
| `HighBandLSV.eventually_actual_numerics` | `propext`, `Classical.choice`, `Quot.sound` |
| `HighBandLSV.eventually_high_band_lsv` | `propext`, `Classical.choice`, `Quot.sound` |

No `sorryAx` or additional axioms occur in these reported dependency closures.

This audit does not eliminate theorem hypotheses. In particular, `AppendixBInputs` remains an explicit probabilistic certificate, whose construction from the matrix model is not supplied here. See `STATUS.md`.

## Verification location

This verification ran locally, not in GitHub Actions. This initial publication does not configure an Actions workflow. The local build log is ignored rather than committed; the relevant result and audit are recorded above.

## Remote verification for the planar extension

The original local build record above concerns the baseline. The later
`PlanarSmallBall.lean` extension and `AxiomAudit.lean` are checked by the
`Lean proof check` GitHub Actions workflow. This supersedes the earlier
statement that no Actions workflow is configured. The extension has three
library targets plus the separate audit file.

The last local planar build was stopped at the user's request to switch to
remote compilation. Uploading the source, creating a workflow, or obtaining
GitHub authorization is not a successful Lean check. The run associated with
a given commit records the actual result. The workflow builds the project
libraries from source, then checks six axiom lists. It accepts only `propext`,
`Classical.choice`, and `Quot.sound`; ordinary theorem hypotheses remain
explicit hypotheses. See `PLANAR.md` and `STATUS.md` for the remaining
model-to-certificate work.

### Successful remote check: 2026-09-02

- Verified source commit: `c13976dc5aace2c8923c22414f573f5026dfa476`.
- [Successful GitHub Actions run](https://github.com/hanyi162013-Yihan/high-band-lsv-2609-01295/actions/runs/33594512597).
- `lake build`: `Build completed successfully (8670 jobs).`
- `PlanarSmallBall`: compiled successfully in 8.7 seconds.
- Complete hosted job: 8 minutes, including environment setup and caching.
- The dependency cache was successfully saved.
- `AxiomAudit.lean`: all six declarations were checked; each reported exactly
  `[propext, Classical.choice, Quot.sound]`.
- This verifies the new dimension-loss planar density and scalar absorption
  proofs, as well as the existing conditional high-band theorem. It does not
  construct the outstanding `AppendixBInputs` matrix-model certificate.

This record is a documentation-only update after the checked source commit.
The Lean sources and workflow were not changed when recording the result.
