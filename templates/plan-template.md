# Implementation Plan (Structure / Blueprint): [BOOK OR UNIVERSE]

**Branch**: `[###-book-or-universe-name]` | **Date**: [DATE] | **Spec**: [link to spec.md]
**Input**: Outline from `/specs/[###-feature-name]/spec.md`

**Note**: This template is filled by the plan command. All names are author-facing (outline, structure, writing-steps, writing-principles).

## Nomenclature (author-facing)

| Internal / workflow | Author-facing |
|---------------------|---------------|
| spec | **outline** / story-bible |
| plan | **structure** / blueprint |
| tasks | **writing-steps** |
| constitution | **writing-principles** |
| feature | **book** / story |

## Summary

[Extract from outline: primary scope + approach — e.g. file-based universe, series, books, characters, plotlines, chapters; scripts and templates.]

## Technical Context

**Language/Version**: Markdown (artifacts), optional YAML (metadata), bash and PowerShell (scripts).  
**Primary Dependencies**: POSIX shell, PowerShell Core; optional Git.  
**Storage**: File-based only. Universe, series, books, characters, plotlines, chapters, continuity log, timeline, foreshadowing register under project directory (e.g. `universe/`). Framework config and templates under `.universe/`.  
**Testing**: Manual validation (author workflows); script linting (shellcheck, PSScriptAnalyzer) where applicable.  
**Target Platform**: Linux/macOS (bash), Windows (PowerShell).  
**Project Type**: CLI/toolkit — templates, scripts, directory conventions for authors.  
**Performance Goals**: Scripts complete in under a few seconds for typical operations (init, add-book, add-chapter).  
**Constraints**: File-based; single author per project; no export to PDF/ePub unless in scope.  
**Scale/Scope**: One universe per project; multiple series/books; chapters and versioning as needed.

## Constitution Check (Writing Principles)

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Quality**: Structure and content clear, documented; templates and checklists used.
- **Consistency**: Names, rules, tone aligned across universe and series; continuity log and foreshadowing register used.
- **Simplicity**: Simplest structure that serves the story; complexity justified.
- **Performance**: Scripts run in reasonable time; no strict target for AI generation (external agent).

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (structure/blueprint)
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
└── tasks.md             # Writing-steps (from tasks command)
```

### Framework artifacts (repository root)

```text
.universe/
├── memory/
│   └── writing-principles.md
├── templates/
│   ├── writing-principles-template.md
│   ├── structure-template.md
│   ├── outline-template.md
│   ├── writing-steps-template.md
│   ├── checklist-template.md
│   ├── agent-file-template.md
│   └── universe/
│       ├── universe-template.md
│       ├── series-template.md
│       ├── book-template.md
│       ├── character-template.md
│       ├── plotline-template.md
│       ├── chapter-guide-template.md
│       ├── chapter-content-template.md
│       ├── continuity-log-template.md
│       ├── timeline-template.md
│       ├── foreshadowing-register-template.md
│       └── versioning-metadata-template.md
scripts/
├── bash/                 # universe-init, universe-add-*, validate-setup, add-book, setup-structure, etc.
└── powershell/
```

### Author project layout (created by universe-init)

```text
<project-root>/
├── universe/
│   ├── universe.md
│   ├── series/<series-id>/series.md
│   ├── books/<book-id>/book.md, plotlines/, chapters/
│   ├── characters/
│   ├── continuity-log.md
│   ├── timeline.md
│   └── foreshadowing-register.md
└── .universe/            # framework config (if present)
```

**Structure Decision**: [Document the chosen layout and any variation — e.g. flat vs nested chapters.]

## Complexity Tracking

> Fill only if Writing Principles have justified exceptions.

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| (none) | — | — |
