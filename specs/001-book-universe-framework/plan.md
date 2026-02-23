# Implementation Plan: Book and Universe Writing Framework

**Branch**: `001-book-universe-framework` | **Date**: 2025-02-23 | **Spec**: [spec.md](./spec.md)  
**Input**: Feature specification from `specs/001-book-universe-framework/spec.md`

**Note**: This plan is produced by the `/speckit.structure` command. Technical approach: Markdown templates and bash/PowerShell scripts in Spec Kit style. **Nomenclature**: All names (folders, files, scripts, and UI/workflow terms) are aligned to author and book/writing context; no developer-only jargon in author-facing surfaces.

## Nomenclature (author-facing naming)

The framework MUST use a single, consistent nomenclature understandable to an author. Every folder, file, script name, and workflow term that the author sees or uses is renamed from the current “spec-kit” / dev vocabulary to writing and book vocabulary.

| Current (dev / Spec Kit) | Author-facing (writing / books) |
|--------------------------|----------------------------------|
| `.specify/` (framework root) | `.universe/` (framework config, templates, memory) |
| `spec` (feature specification) | **outline** or **story-bible** (scope of the story/universe) |
| `plan` (implementation plan) | **structure** or **blueprint** (how the book/series is structured) |
| `tasks` (implementation tasks) | **writing-steps** or **steps** (what to write next: chapters, scenes, etc.) |
| `implement` | **write** / **draft** |
| `feature` (unit of work) | **book** or **story** (when referring to one narrative unit) |
| `create-new-feature` (script) | **create-new-book** or **add-book** (when used in book workflow) |
| `check-prerequisites` (script) | **check-setup** or **validate-setup** |
| `setup-plan` (script) | **setup-structure** |
| `spec-template.md` | **outline-template.md** (for story/universe scope) |
| `plan-template.md` | **structure-template.md** |
| `tasks-template.md` | **writing-steps-template.md** |
| `constitution` (governance) | **writing-principles** or **universe-principles** (optional rename in `.universe/memory/`) |
| `checklist` | **checklist** (keep; authors understand it) |

**Scripts** in the author workflow already use `universe-*` / `Universe-*`; no change. Any remaining script that today has a “feature” or “spec” or “plan” in the name is renamed to the author term above (e.g. `create-new-book.sh`, `setup-structure.sh`, `validate-setup.sh`).

**Author project layout** uses only author terms: `universe/`, `books/`, `chapters/`, `characters/`, `plotlines/`, `continuity-log`, `timeline`, `foreshadowing-register`, `outline`, `structure`, `writing-steps` where applicable. No folder or file visible to the author is named `spec`, `plan`, `tasks`, `feature`, or `.specify`.

**Internal / repo-only** (e.g. this feature branch `001-book-universe-framework` and the folder `specs/001-...`): can stay for the framework’s own development workflow; the important point is that the *author’s* project and the *framework’s* config root (`.universe/`) and all *templates and scripts* use the author-facing nomenclature above.

## Summary

Transform Spec Kit from an app-development framework into a **book and universe writing framework**. Authors define narrative universes (genre, world rules, style), series and books (outline, act structure, POV/tense/tone), characters (profiles, relationship arcs), and plotlines; then write or generate chapters one-by-one with continuity tracking, timeline, and foreshadowing register. The framework supports chapter and book versioning (variants, editions) and AI generation via the author’s chosen agent (Cursor, Claude, Gemini, etc.) and shell (bash or PowerShell), providing context and prompts only. **Technical approach**: file-based artifacts (Markdown and optional YAML) with bash and PowerShell scripts in Spec Kit style; no new runtime or database; directory layout and templates defined in this plan and data-model.

## Technical Context

**Language/Version**: Markdown (artifacts), YAML (optional structured metadata), bash (scripts), PowerShell (scripts). No new language or runtime; existing Spec Kit repo tooling.  
**Primary Dependencies**: None beyond POSIX shell and PowerShell Core for scripts; optional Git for version control and file history.  
**Storage**: File-based only. All entities (universe, series, book, characters, plotlines, chapters, continuity log, timeline, foreshadowing register, versioning metadata) are files under a project directory (e.g. `universe/` at project root). Framework config and templates live under `.universe/`.  
**Testing**: Manual validation (author workflows); script linting (shellcheck, PSScriptAnalyzer) for scripts; no automated test suite required for MVP.  
**Target Platform**: Linux/macOS (bash), Windows (PowerShell); cross-platform where scripts are duplicated in bash and PowerShell.  
**Project Type**: CLI/toolkit—templates, scripts, and directory conventions; consumed by authors via shell commands and optional future CLI.  
**Performance Goals**: Scripts complete in under 5 seconds for typical operations (init, add-book, add-chapter, generate prompt); no strict latency target for AI generation (handled by external agent).  
**Constraints**: File-based only; single author per project; no export to PDF/DOCX/ePub; no bundled AI provider; generation via author-chosen agent.  
**Scale/Scope**: One universe per project directory; multiple series/books per universe; chapters and versioning as needed; context-size strategy (multi-request, summarization) per FR-016.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Code Quality**: Scripts and templates will be modular, with comments in English; linting (shellcheck, PSScriptAnalyzer) applied to new scripts.
- **User Experience Consistency**: Commands and messages use author-facing nomenclature (e.g. `validate-setup.sh`, `add-book.sh`, `universe-init.sh`); errors reported clearly (FR-015).
- **Simplicity**: Minimal structure—templates + scripts only; no new services or databases; versioning trace via metadata files (e.g. YAML or front matter) rather than custom DB.
- **Performance Requirements**: Scripts complete in under 5 seconds for typical operations (see Technical Context); AI generation latency is external.

No violations. Complexity Tracking table left empty.

## Project Structure

### Documentation (this feature)

*(Internal workflow: branch and folder names can stay as-is. Author-facing names are used in templates, scripts, and author project.)*

```text
specs/001-book-universe-framework/
├── plan.md              # This file (internal: "plan")
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
└── tasks.md              # Phase 2 output (internal: "tasks")
```

### Framework artifacts (repository root) — author-facing nomenclature

Framework root is **`.universe/`** (replaces `.specify/` for the book-universe framework). The constitution (`.specify/memory/constitution.md`) refers to `.specify/` for the general Spec Kit workflow; for this feature the config root is `.universe/` only. Templates and scripts use author-facing names only.

```text
.universe/
├── memory/
│   └── writing-principles.md       # was constitution.md
├── templates/
│   ├── writing-principles-template.md
│   ├── structure-template.md       # was plan-template.md
│   ├── outline-template.md         # was spec-template.md
│   ├── writing-steps-template.md   # was tasks-template.md
│   ├── checklist-template.md
│   ├── agent-file-template.md
│   └── universe/                   # book-universe content templates
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
scripts/                      # Author-facing scripts at repo root only (not under .universe/)
├── bash/
│   ├── validate-setup.sh
│   ├── add-book.sh
│   ├── setup-structure.sh
│   ├── update-agent-context.sh
│   ├── common.sh
│   ├── universe-init.sh
│   ├── universe-add-series.sh
│   ├── universe-add-book.sh
│   ├── universe-add-character.sh
│   ├── universe-add-plotline.sh
│   ├── universe-add-chapter.sh
│   ├── universe-generate-chapter.sh
│   ├── universe-generate-content.sh
│   ├── universe-versioning.sh
│   ├── universe-list-affected.sh
│   └── common-universe.sh
└── powershell/
    ├── Validate-Setup.ps1
    ├── Add-Book.ps1
    ├── Setup-Structure.ps1
    ├── Update-AgentContext.ps1
    ├── common.ps1
    ├── Universe-Init.ps1
    ├── Universe-AddSeries.ps1
    ├── Universe-AddBook.ps1
    ├── Universe-AddCharacter.ps1
    ├── Universe-AddPlotline.ps1
    ├── Universe-AddChapter.ps1
    ├── Universe-GenerateChapter.ps1
    ├── Universe-GenerateContent.ps1
    ├── Universe-Versioning.ps1
    ├── Universe-ListAffected.ps1
    └── Common-Universe.ps1
```

**Author project layout** (created by `universe-init` in the author’s project directory):

```text
<project-root>/
├── universe/
│   ├── universe.md           # genre, style, world rules
│   ├── series/
│   │   └── <series-id>/
│   │       └── series.md
│   ├── books/
│   │   └── <book-id>/
│   │       ├── book.md
│   │       ├── plotlines/
│   │       ├── chapters/
│   │       │   └── <chapter-id>/
│   │       │       ├── guide.md
│   │       │       ├── content.md
│   │       │       └── versions/   # or metadata + refs
│   │       └── editions.md        # book editions trace
│   ├── characters/
│   │   └── <character-id>.md
│   ├── continuity-log.md
│   ├── timeline.md
│   └── foreshadowing-register.md
└── .universe/                 # framework config (if present); author may not edit
```

**Structure Decision**: Single “framework” layout: templates under `.universe/templates/universe/`, author-facing scripts at repository root only in `scripts/bash/` and `scripts/powershell/` (no `.universe/scripts/` in this implementation; T001 does not create it). Script names: `universe-*` / `Universe-*`, `validate-setup`, `add-book`, `setup-structure`. Author content lives under `universe/` at project root. No developer jargon (spec, plan, tasks, feature) in author-facing paths or script names. No separate backend/frontend; no new binary CLI in this scope—invocation is via bash or PowerShell scripts. Directory structure may be refined in tasks (e.g. flat vs nested `chapters`).

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| (none) | — | — |
