# Godot Production Toolkit CI Demo

Tiny public Godot 4 fixture for trying the Godot Production Toolkit actions in
GitHub Actions.

The workflow runs:

- `godot-ci-doctor-action` to produce JSON, Markdown, and HTML reports.
- `godot-release-dashboard-action` to combine those reports into a static
  dashboard artifact.

The project files are synthetic and intentionally small. They are only here to
make the CI workflow easy to inspect and copy.

## Run Locally

Install the toolkit packages from the source repository, then run the same
checks as CI:

```powershell
python -m pip install "git+https://github.com/NonniGB/godot-production-toolkit.git@main#subdirectory=godot-project-doctor"
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

- `godot-doctor-reports`: raw toolkit summaries.
- `release-dashboard`: static dashboard built from those summaries.

