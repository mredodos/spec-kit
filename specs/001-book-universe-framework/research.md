# Research: Book and Universe Writing Framework

**Feature**: 001-book-universe-framework  
**Date**: 2025-02-23  
**Purpose**: Resolve technical context and document decisions for Phase 1 design.

## Decisions

### 1. Artifact format (language/storage)

- **Decision**: Markdown for all narrative and descriptive content (universe, series, book outline, character profiles, plotlines, chapter guides, chapter content, continuity log, timeline, foreshadowing register). Optional YAML front matter or separate YAML files for metadata (versioning, edition mapping, “current” pointers).
- **Rationale**: Spec requires file-based artifacts; Markdown is human-readable, diff-friendly, and matches existing Spec Kit templates. YAML keeps structured data (e.g. `current_chapter_version`, `edition_chapter_refs`) out of prose.
- **Alternatives considered**: Pure YAML for everything (rejected: poor for long narrative text). JSON (rejected: less readable for authors). Database (rejected: out of scope, spec says file-based).

### 2. Scripts and parity

- **Decision**: Bash and PowerShell scripts in Spec Kit style (same repo layout as existing `scripts/bash/` and `scripts/powershell/`). Naming: `universe-*.sh` and `Universe-*.ps1`. Shared logic in `common-universe.sh` / `Common-Universe.ps1`.
- **Rationale**: User input specified “template Markdown e script bash/PowerShell nello stile Spec Kit”; existing scripts (check-prerequisites, create-new-feature, setup-plan, update-agent-context) provide the pattern. Parity ensures Windows and Linux/macOS authors can use the same workflows.
- **Alternatives considered**: Python CLI only (rejected: user asked for bash/PowerShell). Single-shell (rejected: spec and user ask for both).

### 3. Directory layout for author content

- **Decision**: Single root `universe/` under project root. Under it: `universe.md`, `series/<id>/`, `books/<book-id>/` (with `plotlines/`, `chapters/<chapter-id>/`), `characters/`, `continuity-log.md`, `timeline.md`, `foreshadowing-register.md`. Versioning: per-chapter versions under `chapters/<id>/versions/` or metadata file referencing paths/commits; book editions in `books/<book-id>/editions.md` (or equivalent) mapping edition → chapter version refs.
- **Rationale**: One place for all narrative artifacts; hierarchy mirrors spec entities (Universe → Series → Book → Chapter). Exact paths can be refined in tasks (e.g. flat `chapters/` with IDs in filenames).
- **Alternatives considered**: `.specify/universe/` (rejected for author content to keep `.specify` for framework/templates; author content is project-specific). Multiple roots (e.g. `world/`, `manuscript/`) (rejected: single root is simpler).

### 4. AI generation integration

- **Decision**: Scripts prepare context (assemble universe, series, book, characters, plotlines, chapter guide into a prompt or temp file) and invoke the author’s chosen agent (Cursor, Claude, Gemini, etc.) via the same paradigm as current Spec Kit (e.g. agent-specific commands or CLI). Script does not call an API directly; it writes prompt/context and runs a command (e.g. `cursor-agent`, `claude`) or leaves instructions for the user. On failure: script reports error and does not overwrite chapter content (FR-015).
- **Rationale**: Spec and clarifications: “Same as current Spec Kit: author chooses shell and AI agent; framework provides context and prompts only.” No bundled provider.
- **Alternatives considered**: Embedded API client (rejected: out of scope). Script only generating a prompt file for manual paste (acceptable as MVP; script can also try to invoke agent if available).

### 5. Context-size strategy (FR-016)

- **Decision**: Document a default strategy in the plan/spec: (a) for chapter generation, supply “context relevant to the current chapter” (e.g. world rules, characters in scene, plotline beats for this chapter, prior chapter summary) rather than entire bible; (b) for long chapters, support multi-request generation (e.g. by scene or chunk) with summarization of prior output for continuity. Implementation plan may refine (e.g. max token estimate, chunk boundaries).
- **Rationale**: Spec requires a strategy; plan and scripts can implement summarization and chunking in a later task; MVP can start with “single prompt with selected context.”
- **Alternatives considered**: No strategy (rejected: FR-016). Full bible in every prompt (rejected: likely to exceed model limits).

### 6. Versioning trace representation

- **Decision**: Trace stored in framework artifacts: (1) Chapter: metadata (e.g. `chapter-versions.yaml` or front matter in a manifest) listing version id, label, path or Git ref, and `current`; (2) Book: `editions.md` or YAML listing edition id, label, and mapping of chapter → version id. Content of each version can be separate files (e.g. `chapters/<id>/versions/v1.md`) or Git history; framework only needs to know which is current and how editions map to chapter versions.
- **Rationale**: Spec says “framework keeps an explicit trace even when using Git”; metadata in repo satisfies that without duplicating full content if versions are files or commits.
- **Alternatives considered**: Full copy of every version in framework (rejected: heavy). Git-only (rejected: spec requires framework trace).

### 7. Nomenclature (author-facing naming)

- **Decision**: All author-facing folders, files, script names, and workflow terms use writing/book vocabulary. Framework root: `.universe/` (not `.specify/`). Templates: `outline-template.md`, `structure-template.md`, `writing-steps-template.md`, `writing-principles.md`. Scripts: `validate-setup`, `add-book`, `setup-structure`, and all `universe-*` / `Universe-*`. No "spec", "plan", "tasks", "feature", or "prerequisites" in names the author sees.
- **Rationale**: The user is an author; developer jargon would be confusing. Consistent naming reduces cognitive load and makes the tool feel native to writing.
- **Alternatives considered**: Keeping .specify and dev terms (rejected: target user is author). Mixed naming (rejected: one clear vocabulary).

## Open Points for Tasks

- Exact filenames and IDs (slug vs UUID) for series, books, chapters, characters.
- Whether `universe-init` creates a minimal `universe/universe.md` from template or only the directory structure.
- Prompt template format for generation (single Markdown file with placeholders vs script-built string).
- Shell function to “invoke agent” (detect which agent, run appropriate command) or leave invocation to the user.
