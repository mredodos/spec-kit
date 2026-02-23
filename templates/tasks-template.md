---

description: "Writing-steps template for book/universe implementation"
---

# Writing Steps (Tasks): [BOOK OR UNIVERSE NAME]

**Input**: Design documents from `/specs/[###-feature-name]/`
**Prerequisites**: plan.md (structure), spec.md (outline), research.md, data-model.md, contracts/

**Tests**: Test tasks are OPTIONAL - include only if requested in the outline.

**Organization**: Steps are grouped by user story so each story can be implemented and validated independently.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: User story label (e.g. US1, US2) for story phases
- Include exact file paths in descriptions

## Path Conventions

- **Framework root**: `.universe/` (config, templates, memory)
- **Templates**: `.universe/templates/` and `.universe/templates/universe/`
- **Scripts**: `scripts/bash/`, `scripts/powershell/`
- **Author content**: Created under `universe/` at project root by scripts

<!-- 
  The tasks command MUST replace sample tasks with actual tasks from:
  - User stories in spec.md (outline)
  - Plan (structure), data-model, contracts
  Organized by user story for independent implementation and testing.
  DO NOT keep sample tasks in the generated tasks.md.
-->

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Framework directory structure and author-facing layout

- [ ] T001 Create `.universe/` directory structure (memory/, templates/, templates/universe/) at repository root
- [ ] T002 [P] Create `.universe/memory/writing-principles.md` from constitution or placeholder
- [ ] T003 [P] Create templates in `.universe/templates/` (writing-principles, structure, outline, writing-steps, checklist, agent-file)
- [ ] T004 Ensure `scripts/bash/` and `scripts/powershell/` exist at repository root

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: All content templates and shared script logic MUST exist before any user-story script can run

**Checkpoint**: Foundation ready — user story implementation can begin

- [ ] T005 [P] Create universe content templates in `.universe/templates/universe/` (universe, series, book, character, plotline, chapter-guide, chapter-content, continuity-log, timeline, foreshadowing-register, versioning-metadata)
- [ ] T006 Create `scripts/bash/common-universe.sh` (REPO_ROOT, template path, slug validation)
- [ ] T007 Create `scripts/powershell/Common-Universe.ps1` with equivalent helpers

---

## Phase 3: User Story 1 - Define Universe (Priority: P1) — MVP

**Goal**: Author can create a universe and set genre, style, world rules.

**Independent Test**: Run universe-init; edit universe/universe.md with genre and at least two rule categories.

### Implementation for User Story 1

- [ ] T008 [US1] Implement universe-init.sh and Universe-Init.ps1 (create universe/, universe.md, continuity-log, timeline, foreshadowing-register from templates)
- [ ] T009 [US1] Add author-facing success/error messages (no "spec" or "feature" in messages)

**Checkpoint**: Author can run universe-init and get universe.md template; US1 test passes.

---

## Phase 4: User Story 2 - Series and Book Structure (Priority: P2)

**Goal**: Author can define series and add books with outline and act structure.

### Implementation for User Story 2

- [ ] T010 [P] [US2] Implement universe-add-series (bash + PowerShell)
- [ ] T011 [US2] Implement universe-add-book (bash + PowerShell)

**Checkpoint**: Author can add series and books; US2 test passes.

---

## Phase 5+: User Stories 3–6 and Polish

**Goal**: Characters, plotlines, chapters, generation, continuity/versioning, list-affected; then validate-setup, add-book/setup-structure wrappers, lint, quickstart validation, README.

- [ ] T012+ [US3] universe-add-character
- [ ] T013+ [US4] universe-add-plotline, universe-add-chapter
- [ ] T014+ [US5] universe-generate-chapter, universe-generate-content (context, prompts; on failure do not overwrite)
- [ ] T015+ [US6] universe-versioning, universe-list-affected; verify continuity/timeline/foreshadowing at init
- [ ] T016+ [Polish] validate-setup, add-book, setup-structure; shellcheck/PSScriptAnalyzer; quickstart validation; README

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: No dependencies.
- **Phase 2 (Foundational)**: Depends on Phase 1 — blocks all user stories.
- **Phase 3+**: Each user story phase depends on Phase 2; US2 on US1 (universe exists); US4 on US2 (book exists); US5 on US4 (chapter with guide); US6 on US3/US4.
- **Polish**: Depends on Phases 3–8 complete.

### Parallel Opportunities

- Within Phase 2: template creation and common scripts can run in parallel.
- Add-series and add-book can run in parallel; add-character, add-plotline, add-chapter similarly where no same-file dependency.

---

## Notes

- [P] = parallelizable (different files, no dependency).
- [USn] = task belongs to that user story for traceability.
- All script paths: repository root `scripts/bash/` and `scripts/powershell/`.
- Template paths: `.universe/templates/` and `.universe/templates/universe/`.
- Author content is created under `universe/` at the directory where the author runs the scripts.
