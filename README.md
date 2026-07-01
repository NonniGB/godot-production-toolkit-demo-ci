# Godot Production Toolkit CI Demo

[![Godot toolkit demo](https://github.com/NonniGB/godot-production-toolkit-demo-ci/actions/workflows/toolkit-ci.yml/badge.svg)](https://github.com/NonniGB/godot-production-toolkit-demo-ci/actions/workflows/toolkit-ci.yml)

Tiny public Godot 4 fixture for trying the Godot Production Toolkit actions in
GitHub Actions.

The workflow runs:

- `godot-ci-doctor-action` to produce JSON, Markdown, and HTML reports.
- `godot-release-dashboard-action` to combine those reports into a static
  dashboard artifact.

The project files are synthetic and intentionally small. They are only here to
make the CI workflow easy to inspect and copy.

The fixture is MIT licensed so its workflow and tiny Godot files can be copied
into test projects.

## Inspect The Latest Run

Open the
[successful main-branch workflow runs](https://github.com/NonniGB/godot-production-toolkit-demo-ci/actions/workflows/toolkit-ci.yml?query=branch%3Amain+is%3Asuccess)
and download these artifacts from the newest run:

| Artifact | What to open |
| --- | --- |
| `godot-toolkit-demo-dashboard` | `index.html`, the static dashboard built from the demo reports. |
| `godot-toolkit-demo-reports` | `artifact-index.md`, then `godot-project-doctor/summary.html`, `summary.md`, or `summary.json`. |

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

## CI Artifacts

After the GitHub Actions workflow completes, open the run artifacts:

- `godot-toolkit-demo-reports`: raw toolkit summaries and an artifact index.
- `godot-toolkit-demo-dashboard`: static dashboard built from those summaries.
