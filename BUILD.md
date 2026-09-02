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
