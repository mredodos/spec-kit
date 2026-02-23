# Tasks: Book and Universe Writing Framework

**Input**: Design documents from `specs/001-book-universe-framework/`  
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

**Tests**: Not requested in the feature specification; no test tasks included.

**Organization**: Tasks are grouped by user story so each story can be implemented and validated independently. Paths are relative to repository root unless otherwise stated.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: User story label (US1–US6) for story phases only
- Include exact file paths in descriptions

## Path Conventions

- **Framework root**: `.universe/` (config, templates, memory)
- **Templates**: `.universe/templates/` and `.universe/templates/universe/`
- **Scripts**: `scripts/bash/`, `scripts/powershell/`
- **Author content**: Created under `universe/` at project root by scripts (not in repo by default)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Create framework directory structure and author-facing nomenclature layout.

- [X] T001 Create `.universe/` directory structure: `.universe/memory/`, `.universe/templates/`, `.universe/templates/universe/` at repository root (author-facing scripts live in `scripts/` at repo root only; do not create `.universe/scripts/` for this implementation)
- [X] T002 [P] Create `.universe/memory/writing-principles.md` from content of `.specify/memory/constitution.md` (or placeholder) using author-facing wording per plan Nomenclature
- [X] T003 [P] Create `.universe/templates/writing-principles-template.md`, `structure-template.md`, `outline-template.md`, `writing-steps-template.md`, `checklist-template.md`, `agent-file-template.md` (author-facing names per plan) in `.universe/templates/`
- [X] T004 Ensure `scripts/bash/` and `scripts/powershell/` exist at repository root for universe scripts

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: All content templates and shared script logic MUST exist before any user-story script can run.

**Checkpoint**: Foundation ready—user story implementation can begin.

- [X] T005 [P] Create `.universe/templates/universe/universe-template.md` with sections: genre, style, inspirations, world_rules (magic, technology, politics, institutions, morality, historical_conflicts, flora, fauna) per data-model.md
- [X] T006 [P] Create `.universe/templates/universe/series-template.md` with fields: central_conflict, ending, pov, tense, tone, chapter_rhythm, target_reader per data-model.md
- [X] T007 [P] Create `.universe/templates/universe/book-template.md` with fields: series_id (optional), outline, act_structure per data-model.md
- [X] T008 [P] Create `.universe/templates/universe/character-template.md` with fields: role, physical_traits, psychological_traits, goals, backstory, flaw, secrets, relationship_arcs per data-model.md
- [X] T009 [P] Create `.universe/templates/universe/plotline-template.md` with type (main|secondary), arc (setup, crisis, resolution), link_to_theme per data-model.md
- [X] T010 [P] Create `.universe/templates/universe/chapter-guide-template.md` and `chapter-content-template.md` for writing guide and narrative content per data-model.md
- [X] T011 [P] Create `.universe/templates/universe/continuity-log-template.md`, `timeline-template.md`, `foreshadowing-register-template.md` per data-model.md
- [X] T012 [P] Create `.universe/templates/universe/versioning-metadata-template.md` for chapter versions and book editions trace per data-model.md
- [X] T013 Create `scripts/bash/common-universe.sh` with REPO_ROOT resolution, template path helper, and slug validation; sourceable by universe-* scripts
- [X] T014 Create `scripts/powershell/Common-Universe.ps1` with equivalent helpers for PowerShell universe-* scripts

---

## Phase 3: User Story 1 - Define Universe and World Rules (Priority: P1) — MVP

**Goal**: Author can create a universe and set genre, style, inspirations, and world rules (at least two categories).

**Independent Test**: Run universe-init in a test dir; edit universe/universe.md with genre and two rule categories; verify structure is usable for later books/characters.

### Implementation for User Story 1

- [X] T015 [US1] Implement `scripts/bash/universe-init.sh`: accept optional project-dir (default .), create `universe/`, `universe/universe.md` from `.universe/templates/universe/universe-template.md`, and `universe/continuity-log.md`, `universe/timeline.md`, `universe/foreshadowing-register.md` from `.universe/templates/universe/` templates; support `--help`; exit 1 on missing/invalid args per contracts/script-commands.md
- [X] T016 [US1] Implement `scripts/powershell/Universe-Init.ps1`: same behavior as universe-init.sh with `-ProjectDir`, `-Help`; create universe/, universe.md, continuity-log.md, timeline.md, foreshadowing-register.md from templates
- [X] T017 [US1] Add author-facing success/error messages in English in universe-init.sh and Universe-Init.ps1 (no "spec" or "feature" in messages)

**Checkpoint**: Author can run universe-init and get a filled universe.md template; US1 test passes.

---

## Phase 4: User Story 2 - Define Series and Book Structure (Priority: P2)

**Goal**: Author can define a series (central conflict, ending, POV, tense, tone, target reader) and add books with outline and act structure, linked to series or standalone.

**Independent Test**: After universe exists, run universe-add-series and universe-add-book; verify series.md and book.md created and book can reference series.

### Implementation for User Story 2

- [X] T018 [P] [US2] Implement `scripts/bash/universe-add-series.sh`: args series-id [name], create `universe/series/<series-id>/series.md` from series-template; `--help`; stderr and exit 1 if universe/ missing or invalid slug per contracts
- [X] T019 [P] [US2] Implement `scripts/powershell/Universe-AddSeries.ps1`: `-SeriesId`, `-Name`, same behavior as bash script
- [X] T020 [P] [US2] Implement `scripts/bash/universe-add-book.sh`: args book-id [--series-id id] [name], create `universe/books/<book-id>/book.md` and dirs plotlines/ chapters/; optionally write series_id into book.md; `--help` per contracts
- [X] T021 [US2] Implement `scripts/powershell/Universe-AddBook.ps1`: `-BookId`, `-SeriesId`, `-Name`, same behavior as bash script

**Checkpoint**: Author can add series and books; US2 test passes.

---

## Phase 5: User Story 3 - Create and Manage Characters (Priority: P3)

**Goal**: Author can create character profiles (role, traits, goals, backstory, flaw, secrets) and relationship arcs; profiles are usable when writing or reviewing chapters.

**Independent Test**: Run universe-add-character for protagonist and antagonist; fill profiles; verify files under universe/characters/.

### Implementation for User Story 3

- [X] T022 [P] [US3] Implement `scripts/bash/universe-add-character.sh`: args character-id [name], create `universe/characters/<character-id>.md` from character-template; `--help`; validate slug per contracts
- [X] T023 [US3] Implement `scripts/powershell/Universe-AddCharacter.ps1`: `-CharacterId`, `-Name`, same behavior as bash script

**Checkpoint**: Author can add characters with full profile template; US3 test passes.

---

## Phase 6: User Story 4 - Define Main and Secondary Plotlines and Chapter Guide (Priority: P4)

**Goal**: Author can define main and secondary plotlines per book and add chapters with a writing guide/track per chapter.

**Independent Test**: Add plotlines (main + secondary) to a book, then add a chapter; verify guide.md and content.md (or equivalent) exist and guide is usable when writing.

### Implementation for User Story 4

- [X] T024 [P] [US4] Implement `scripts/bash/universe-add-plotline.sh`: args book-id plotline-id [main|secondary], create `universe/books/<book-id>/plotlines/<plotline-id>.md` from plotline-template; exit 1 if book missing per contracts
- [X] T025 [US4] Implement `scripts/powershell/Universe-AddPlotline.ps1`: `-BookId`, `-PlotlineId`, `-Type`, same behavior
- [X] T026 [P] [US4] Implement `scripts/bash/universe-add-chapter.sh`: args book-id chapter-id, create `universe/books/<book-id>/chapters/<chapter-id>/guide.md` and `content.md` from chapter-guide and chapter-content templates; `--help` per contracts
- [X] T027 [US4] Implement `scripts/powershell/Universe-AddChapter.ps1`: `-BookId`, `-ChapterId`, same behavior

**Checkpoint**: Author can add plotlines and chapters with guides; US4 test passes.

---

## Phase 7: User Story 5 - Generate Chapters and Content via AI (Priority: P5)

**Goal**: Author can request the framework to generate chapter prose (and other content) using context (universe, characters, plotlines, chapter guide); on agent failure, framework reports error and does not overwrite content (FR-015). Context-size strategy supported (FR-016).

**Independent Test**: With a book that has a chapter with guide and context, run universe-generate-chapter; if agent available, prose appears in chapter content; if agent fails, no overwrite and non-zero exit.

### Implementation for User Story 5

- [X] T028 [US5] Implement `scripts/bash/universe-generate-chapter.sh`: args book-id chapter-id [--agent name]; resolve paths universe/ books/<book-id>/ chapters/<chapter-id>/; assemble context from universe.md, series, book.md, characters/*.md, plotlines/*.md, chapter guide.md; write prompt to temp file or stdout, or invoke author's agent (e.g. cursor-agent, claude) per contracts; on invocation failure: stderr message, do not overwrite chapter content, exit 2 per FR-015
- [X] T029 [US5] Implement `scripts/powershell/Universe-GenerateChapter.ps1`: `-BookId`, `-ChapterId`, `-Agent`; same behavior and FR-015 compliance
- [X] T030 [US5] Document or implement context-size strategy in universe-generate-chapter scripts: e.g. supply only context relevant to current chapter, or summarization of prior output for long chapters, per FR-016 and research.md decision 5
- [X] T044 [US5] Extend universe-generate-chapter scripts or add `scripts/bash/universe-generate-content.sh` and `scripts/powershell/Universe-GenerateContent.ps1` to support generating non-chapter content (e.g. character description draft, scene draft, summary) per FR-014; same context and agent selection as chapter generation; store or attach output under `universe/` (e.g. characters/ or a dedicated drafts path) per contracts

**Checkpoint**: Generation works when agent available; on failure, content unchanged and error reported; US5 test passes. Other content (FR-014) can be generated and stored.

---

## Phase 8: User Story 6 - Write Chapters with Continuity and Tracking (Priority: P6)

**Goal**: Author can maintain continuity log, timeline, and foreshadowing register; chapter and book versioning (variants, editions) are tracked in the framework (FR-017, FR-018).

**Independent Test**: Run universe-init (or ensure continuity/timeline/foreshadowing files exist); add two chapter versions and two book editions; verify metadata trace.

### Implementation for User Story 6

- [X] T031 [US6] Verify universe-init (T015/T016) creates `universe/continuity-log.md`, `universe/timeline.md`, `universe/foreshadowing-register.md` from templates; add quickstart note that these are created at init
- [X] T032 [P] [US6] Implement `scripts/bash/universe-versioning.sh`: support add-version and set-current for chapter versions, and add-edition / set-edition-chapters for book editions; update versioning metadata (e.g. YAML or front matter) in `universe/books/<book-id>/chapters/<chapter-id>/` and `universe/books/<book-id>/editions.md` per data-model and FR-017, FR-018
- [X] T033 [US6] Implement `scripts/powershell/Universe-Versioning.ps1`: same actions (AddVersion, SetCurrent, AddEdition, SetEditionChapters) and metadata updates
- [X] T034 [US6] Add help and error handling (stderr, exit 1) for universe-versioning scripts per contracts; do not overwrite user content on error
- [X] T043 [US6] Implement `scripts/bash/universe-list-affected.sh` and `scripts/powershell/Universe-ListAffected.ps1`: given a world-rule category or character id, list or tag chapters (and optionally scenes) that reference it (e.g. grep/search in universe/books/*/chapters/**) so the author can identify affected content for consistency review per FR-011 and SC-006; output to stdout or write to a temporary list file; document usage in quickstart.md. MVP: chapter-level listing; passage-level or line-level listing is out of scope for this implementation.

**Checkpoint**: Continuity, timeline, foreshadowing files exist; versioning scripts update trace; author can identify affected chapters; US6 test passes.

---

## Phase 9: Polish & Cross-Cutting Concerns

**Purpose**: Author-facing renames, linting, and validation.

- [X] T035 [P] Add `scripts/bash/validate-setup.sh`: check universe/ exists and required structure present; author-facing messages; `--help` (replaces or aliases check-prerequisites for book-universe context)
- [X] T036 [P] Add `scripts/powershell/Validate-Setup.ps1`: same checks and messages
- [X] T037 [P] Add `scripts/bash/add-book.sh` and `scripts/powershell/Add-Book.ps1`: thin wrappers that call `universe-add-book.sh` / `Universe-AddBook.ps1` with the same args (author-facing name per plan Nomenclature); support `--help` / `-Help`
- [X] T038 [P] Add `scripts/bash/setup-structure.sh` and `scripts/powershell/Setup-Structure.ps1`: create initial outline and structure files from `.universe/templates/outline-template.md` and `.universe/templates/structure-template.md` in project root or under `universe/` (author-facing name for one-time structure setup per plan); support `--help` / `-Help`
- [ ] T039 Run shellcheck on scripts/bash/universe-*.sh and scripts/bash/common-universe.sh; fix reported issues; add shellcheck directive comments where suppressions are justified
- [ ] T040 Run PSScriptAnalyzer (or equivalent) on scripts/powershell/Universe-*.ps1 and Common-Universe.ps1; fix critical findings
- [ ] T041 Validate quickstart.md: run through steps 1–8 in a test directory and confirm universe-init, add-series, add-book, add-character, add-chapter, generate-content, list-affected, and continuity/versioning work; document any gaps in quickstart or plan
- [X] T042 Update README or docs to reference .universe/ and author-facing script names (universe-init, validate-setup, add-book, setup-structure) and link to specs/001-book-universe-framework/quickstart.md

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: No dependencies—can start immediately.
- **Phase 2 (Foundational)**: Depends on Phase 1—blocks all user stories.
- **Phase 3 (US1)**: Depends on Phase 2.
- **Phase 4 (US2)**: Depends on Phase 2 (and logically US1 for “series then book” flow; scripts can run once universe exists).
- **Phase 5 (US3)**: Depends on Phase 2.
- **Phase 6 (US4)**: Depends on Phase 2 (book and chapter need book from US2).
- **Phase 7 (US5)**: Depends on Phase 2 and Phase 6 (chapter with guide).
- **Phase 8 (US6)**: Depends on Phase 2 and Phase 3 (universe-init creates continuity/timeline/foreshadowing; versioning needs chapters).
- **Phase 9 (Polish)**: Depends on Phases 3–8 being complete.

### User Story Completion Order

- **US1 (P1)**: First—universe must exist for series, books, characters.
- **US2 (P2)**: Second—series and books needed for plotlines and chapters.
- **US3 (P3)**: Can be parallel to US2 (characters need universe only).
- **US4 (P4)**: After US2 (needs book).
- **US5 (P5)**: After US4 (needs chapter with guide).
- **US6 (P6)**: After US3 and US4 (continuity/versioning).

### Parallel Opportunities

- Within Phase 2: T005–T012 and T013/T014 can be parallel (templates and common scripts).
- Phase 4: T018/T019 (add-series) and T020/T021 (add-book) can be done in parallel by different devs.
- Phase 6: T024/T025 (plotline) and T026/T027 (chapter) can be parallel.
- Phase 9: T035–T038 and T039/T040 (lint) can be parallel.

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup  
2. Complete Phase 2: Foundational  
3. Complete Phase 3: User Story 1 (universe-init)  
4. **STOP and VALIDATE**: Run universe-init in test dir, edit universe.md, confirm structure  
5. Demo: author has a universe and can add rules

### Incremental Delivery

1. Setup + Foundational → templates and common scripts ready  
2. US1 → universe-init → MVP  
3. US2 → add-series, add-book → author can structure a book  
4. US3 → add-character → full cast  
5. US4 → add-plotline, add-chapter → chapter guides  
6. US5 → generate-chapter → AI-assisted writing  
7. US6 → continuity, timeline, foreshadowing, versioning → full tracking  
8. Polish → validate-setup, add-book, setup-structure, lint, docs  

---

## Notes

- [P] = parallelizable (different files, no dependency on same-phase tasks).  
- [USn] = task belongs to that user story for traceability.  
- All script paths: repository root `scripts/bash/` and `scripts/powershell/`.  
- Template paths: repository root `.universe/templates/` and `.universe/templates/universe/`.  
- Author content is created under `universe/` at the directory where the author runs the scripts (project root).
