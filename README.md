# Godot Production Toolkit CI Demo

[![Godot toolkit demo](https://github.com/NonniGB/godot-production-toolkit-demo-ci/actions/workflows/toolkit-ci.yml/badge.svg)](https://github.com/NonniGB/godot-production-toolkit-demo-ci/actions/workflows/toolkit-ci.yml)

Tiny public Godot 4 fixture for trying the Godot Production Toolkit actions in
GitHub Actions.

The workflow runs:

- `godot-ci-doctor-action` to produce JSON, Markdown, and HTML reports.
- `godot-release-dashboard-action` to combine those reports into a static
  dashboard artifact.
- focused export preset and input-map checks against a pinned public Godot demo
  project.

The project files are synthetic and intentionally small. They are only here to
make the CI workflow easy to inspect and copy.

The fixture is MIT licensed so its workflow and tiny Godot files can be copied
into test projects.

The workflow also checks the `2d/dodge_the_creeps` sample from
[`godotengine/godot-demo-projects`](https://github.com/godotengine/godot-demo-projects)
at commit `2adc0b8a5638a73117c4ebee5626a6d2ca65252d`. That upstream repository
uses the MIT License, and this demo fetches it during CI rather than vendoring
the sample.

## Inspect The Latest Run

Open the
[successful main-branch workflow runs](https://github.com/NonniGB/godot-production-toolkit-demo-ci/actions/workflows/toolkit-ci.yml?query=branch%3Amain+is%3Asuccess)
and download these artifacts from the newest run:

| Artifact | What to open |
| --- | --- |
| `godot-toolkit-demo-dashboard` | `index.html`, the static dashboard built from the demo reports. |
| `godot-toolkit-demo-reports` | `artifact-index.md`, then `godot-project-doctor/summary.html`, `summary.md`, or `summary.json`. |
| `godot-toolkit-real-sample-reports` | `README.md`, then `export-presets.json` and `input-map.json` from the pinned public Godot sample. |

The workflow source is
[`.github/workflows/toolkit-ci.yml`](.github/workflows/toolkit-ci.yml). It keeps
the report output under `reports/godot-project-doctor` and builds the dashboard
under `reports/release-dashboard`.

## Run Locally

Install the toolkit packages from the source repository, then run the same
checks as CI:

```powershell
python -m pip install "git+https://github.com/NonniGB/godot-production-toolkit.git@main#subdirectory=godot-production-doctor"
python -m pip install "git+https://github.com/NonniGB/godot-production-toolkit.git@main#subdirectory=godot-export-preset-doctor"
python -m pip install "git+https://github.com/NonniGB/godot-production-toolkit.git@main#subdirectory=godot-input-map-auditor"
python -m pip install "git+https://github.com/NonniGB/godot-production-toolkit.git@main#subdirectory=godot-scene-signal-auditor"
python -m pip install "git+https://github.com/NonniGB/godot-production-toolkit.git@main#subdirectory=godot-mobile-perf-doctor"
python -m pip install "git+https://github.com/NonniGB/godot-production-toolkit.git@main#subdirectory=godot-release-dashboard-kit"

godot-project-doctor run godot-project-doctor.toml --format json --output reports/godot-project-doctor/summary.json
godot-project-doctor summarize reports/godot-project-doctor --format html --output reports/godot-project-doctor/summary.html --fail-on none
godot-release-dashboard build reports/godot-project-doctor --title "Toolkit CI Demo" --output reports/release-dashboard/index.html
```

To run the same focused checks against the pinned public Godot sample locally:

```powershell
git clone --filter=blob:none --sparse https://github.com/godotengine/godot-demo-projects.git fixtures\godot-demo-projects
cd fixtures\godot-demo-projects
git checkout 2adc0b8a5638a73117c4ebee5626a6d2ca65252d
git sparse-checkout set 2d\dodge_the_creeps
cd ..\..

godot-export-doctor fixtures\godot-demo-projects\2d\dodge_the_creeps --format json --output reports\real-godot-sample\export-presets.json --fail-on none
godot-input-audit fixtures\godot-demo-projects\2d\dodge_the_creeps --format json --output reports\real-godot-sample\input-map.json --fail-on none
```

## CI Artifacts

After the GitHub Actions workflow completes, open the run artifacts:

- `godot-toolkit-demo-reports`: raw toolkit summaries and an artifact index.
- `godot-toolkit-demo-dashboard`: static dashboard built from those summaries.
- `godot-toolkit-real-sample-reports`: focused checks against the pinned public
  Godot sample.
