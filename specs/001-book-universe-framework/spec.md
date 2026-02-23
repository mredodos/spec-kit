# Feature Specification: Book and Universe Writing Framework

**Feature Branch**: `001-book-universe-framework`  
**Created**: 2025-02-23  
**Status**: Draft  
**Input**: Transform Spec Kit from an app-development framework into a framework for writing single books, series, and narrative universes—with world-building, characters, plotlines, and chapter-by-chapter writing guidance.

## Clarifications

### Session 2025-02-23

- Q: In what form does the author consume the framework—file-based artifacts in a repo, or an application with its own storage? → A: File-based first; optionally add or plug an app later. For now limit scope to modifying what Spec Kit already does.
- Q: Single author per project or multiple authors/editors with possible concurrent editing? → A: Single author per project.
- Q: Must the framework support exporting manuscript/content to formats for publishers or readers (e.g. PDF, DOCX, ePub)? → A: No export in scope; output stays within framework files.
- Q: Add explicit out-of-scope exclusions to avoid scope creep (e.g. AI-generated prose, publishing pipeline)? → A: Yes; add a short Out of scope list.
- Q: Fix directory structure (where universe, series, books, chapters live) in the spec or leave to the technical plan? → A: Leave to the plan.
- Q: How does the framework integrate with AI for generation (fixed provider, author-supplied key, pluggable)? → A: Same as current Spec Kit: author chooses shell (bash or PowerShell) and AI agent (e.g. Cursor, Claude, Gemini); framework provides context/prompts and the chosen agent performs generation.
- Q: When generation is requested but the agent is unavailable or fails, how should the framework behave? → A: Report the error to the author and do not modify the chapter file; author retries or writes manually.
- Q: Must the spec require a strategy for context exceeding model limits (truncation, summarization)? → A: Yes; provide a strategy in spec (e.g. multi-request generation, summarization of previous part); the plan can specify modifications to this strategy.
- Q: Should the framework have an explicit requirement for content language (e.g. universe/book language for generation)? → A: No dedicated requirement; language is part of tone/style; the plan may add a language field if needed.
- Q: Should the book/universe framework coexist with the current app-development use of Spec Kit, or become book-only? → A: Book/universe only; the app development flow is no longer supported.

## Assumptions

- The primary user is an author (solo or small team) creating original fiction: single books, series, or shared universes. The framework assumes a single author per project (one active user per universe/repo); no concurrent-editing or multi-author conflict resolution is in scope.
- The framework is book/universe-only; the previous app-development flow (spec → plan → tasks for software) is not supported.
- The framework replaces the current “app/spec-driven development” metaphor with “book/universe-driven creation”: same rigor (spec → plan → tasks → implement) applied to narrative artifacts (world → series → book → chapter).
- “Chapter” is the unit of incremental delivery (analogous to current “spec” or feature slice); each chapter is written one-by-one with a clear guide/track derived from the book and series plan.
- World-building includes definable rules and constraints (magic, technology, politics, institutions, morality, history, flora, fauna, etc.) that the framework helps capture and keep consistent.
- The framework supports both pre-writing (world bible, outlines, character sheets, plotlines) and during-writing (continuity, timeline, foreshadowing register, scene and exposition discipline) without prescribing a specific tool or format. The framework MUST support generating chapters and other narrative content (e.g. character drafts, scene drafts, prose) via AI when the author requests it, so the author can rely on the framework to produce all the text they need; the author may also write by hand or mix AI-generated and manual content. AI generation uses the same paradigm as current Spec Kit: the author chooses shell (bash or PowerShell) and AI agent (e.g. Cursor, Claude, Gemini); the framework provides context and prompts and the chosen agent performs generation—no bundled provider or API key.
- The framework MUST define or support a strategy for handling context that exceeds the chosen agent’s model limits (e.g. generating long content in multiple requests, summarizing prior content for the next chunk, or selecting only context relevant to the current chapter). The implementation plan may refine or replace this strategy.
- **Artifacts are file-based**: universe, series, books, characters, plotlines, chapters, continuity log, timeline, and foreshadowing register are represented as files (e.g. Markdown or structured files) in a directory or repository. The framework MUST support versioning within the framework: chapters can have multiple versions or variants (e.g. when the author is not satisfied with the first draft), and the book can have editions, reprints, or rewrites (e.g. with added details). The framework keeps an explicit trace of these differences (versions/variants of chapters, editions of the book) even when the project also uses Git for file history. Scope for this feature is to modify or extend what Spec Kit already does (templates, commands, directory layout). The exact directory structure (where each entity lives) is defined in the implementation plan, not in this specification. A future application or attachment point is out of scope for this feature. Export to third-party formats (e.g. PDF, DOCX, ePub) for publishers or readers is out of scope; output is consumed only within the framework files.

## Out of scope

- **App development flow**: The previous use of Spec Kit for application/software development (spec → plan → tasks → implement for code) is out of scope; the framework is for book and universe creation only.
- **Publishing pipeline**: Submission to publishers, retailers, or distribution platforms is out of scope.
- **Multi-author / concurrent editing**: No conflict resolution or locking for multiple simultaneous editors (single author per project).

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Define Universe and World Rules (Priority: P1)

As an author, I define the narrative universe and its rules so that style, genre, inspirations, and fundamental constraints (magic, technology, politics, institutions, morality, conflicts, flora, fauna) are established before I write. The framework guides me to capture rules that limit characters and create obstacles, not only possibilities.

**Why this priority**: Without a defined world and its rules, later narrative choices risk contradicting each other; the universe is the foundation for every book and series in it.

**Independent Test**: Author completes a world definition (genre, tone, and at least two rule categories—e.g. magic and politics). A reviewer can verify that the rules are stated clearly enough to judge future chapters for consistency.

**Acceptance Scenarios**:

1. **Given** no universe exists, **When** the author creates a new universe, **Then** they can set genre, style, inspirations, and at least one category of world rules (e.g. magic, technology, politics, institutions, morality, history, flora, fauna).
2. **Given** an existing universe, **When** the author adds or edits rules, **Then** the framework keeps these rules visible and usable when defining books, characters, and chapters.
3. **Given** world rules are defined, **When** the author or a later process checks a chapter or scene, **Then** it is possible to verify narrative choices against those rules for consistency.

---

### User Story 2 - Define Series and Book Structure (Priority: P2)

As an author, I define the series (central conflict, ending, tone, POV, tense, target reader) and each book (outline, act structure, identity within the series) so that I have a clear narrative spine and a plan before writing the first chapter.

**Why this priority**: The series-level conflict, ending, and book-level outline prevent disconnected “episode” books and support seeding setup and payoff across the series.

**Independent Test**: Author defines one series (central conflict, high-level ending, POV/tense/tone) and one book (outline with act structure). The book can be linked to the series and used as the basis for chapter-level planning.

**Acceptance Scenarios**:

1. **Given** a universe exists, **When** the author creates a series, **Then** they can set the central conflict of the whole series, the intended ending (at least at high level), narrative POV and tense, tone, and target reader.
2. **Given** a series exists, **When** the author adds a book, **Then** they can attach an outline and act structure to that book and associate it with the series.
3. **Given** a book has an outline, **When** the author plans chapters, **Then** they can derive or attach a writing guide/track for each chapter from the book and series plan.

---

### User Story 3 - Create and Manage Characters (Priority: P3)

As an author, I create character profiles (physical, psychological, peculiarities, goals, backstory, secrets, flaws) and relationship arcs so that every main and important secondary character has a clear narrative function and a path across the series. Antagonists have coherent logic and motivations, not “evil by default.”

**Why this priority**: Characters drive plot and theme; without structured profiles and relationship arcs, the cast can become inconsistent or underused.

**Independent Test**: Author creates at least one protagonist and one antagonist with profiles (traits, goals, flaw tied to the story) and defines at least one relationship arc (e.g. friendship → rivalry). Profiles are usable when writing or checking chapters.

**Acceptance Scenarios**:

1. **Given** a book or series exists, **When** the author creates a character, **Then** they can define at least: role (e.g. protagonist, antagonist, secondary), physical and psychological traits, goals, backstory, and a flaw or constraint that is functional to the story.
2. **Given** multiple characters exist, **When** the author defines relationships, **Then** they can describe how relationships change over the story (e.g. ally → enemy) and link these arcs to the series or book.
3. **Given** character profiles and relationship arcs exist, **When** the author writes or reviews a chapter, **Then** they can reference these profiles to keep behavior and voice consistent.

---

### User Story 4 - Define Main and Secondary Plotlines and Chapter Guide (Priority: P4)

As an author, I define main and secondary plotlines for the book (and optionally the series) and a writing guide/track for each chapter so that I follow a clear path when writing, with subplots having their own structure (setup, crisis, resolution) and linking to the main theme.

**Why this priority**: Plotlines and chapter-level guidance turn the book outline into actionable steps; without them, chapter-by-chapter writing lacks direction.

**Independent Test**: Author defines at least one main plotline and one secondary plotline for a book, and at least one chapter with a short writing guide (what must happen, which threads to advance). The guide is available when “implementing” that chapter.

**Acceptance Scenarios**:

1. **Given** a book exists, **When** the author defines plotlines, **Then** they can create a main plotline and one or more secondary plotlines, with each subplot having a clear narrative arc that intersects with the main plot.
2. **Given** plotlines exist, **When** the author adds a chapter, **Then** they can attach a writing guide/track for that chapter (what to advance, which characters and threads, tone) derived from or aligned with the book outline.
3. **Given** a chapter has a guide, **When** the author writes the chapter, **Then** they can use the guide to stay on track and later verify that the chapter fulfils the intended beats.

---

### User Story 5 - Generate Chapters and Content via AI (Priority: P5)

As an author, I can ask the framework to generate chapter prose and other narrative content (e.g. character or scene drafts) using AI, so that I can have the framework produce all the text I need and write entirely with AI if I want. Generation uses the existing context (universe, characters, plotlines, chapter guide).

**Why this priority**: The author may want the framework to do the actual writing, not only structure and guidance; generation is a core capability.

**Independent Test**: Author requests generation of one chapter from a chapter guide; the framework produces narrative text consistent with the guide and world/character context and stores it in the chapter artifact.

**Acceptance Scenarios**:

1. **Given** a book has a chapter with a writing guide and sufficient context (universe, characters, plotlines), **When** the author requests the framework to generate the chapter prose, **Then** the framework generates narrative content aligned with the guide and context and stores it in the chapter.
2. **Given** the author needs other content (e.g. character description draft, scene draft), **When** the author requests generation, **Then** the framework can generate that content using the same context and store or attach it appropriately.
3. **Given** generated content exists, **When** the author edits or rewrites it, **Then** the framework treats it like any other author content (no lock-in to “AI-only” workflow).

---

### User Story 6 - Write Chapters with Continuity and Tracking (Priority: P6)

As an author, I write chapters one-by-one (like current “specs” or feature slices) and maintain continuity (details, timeline, foreshadowing) so that I do not contradict earlier chapters and I fulfil narrative promises. The framework helps me keep a continuity log, internal timeline, and foreshadowing register.

**Why this priority**: This is the core “implementation” step: chapters are the deliverable units; continuity and tracking protect quality across the book.

**Independent Test**: Author writes two chapters in sequence, using a continuity log and a simple timeline. They register at least one foreshadowing in the first chapter and verify it is traceable when editing the second. No implementation technology is assumed.

**Acceptance Scenarios**:

1. **Given** a book has at least one chapter with a writing guide, **When** the author writes or edits that chapter, **Then** they can do so in a single “unit” (one chapter at a time) with the guide visible.
2. **Given** the author is writing or editing, **When** they record continuity details (e.g. character eye colour, dates, named minor elements), **Then** these are stored and retrievable so that later chapters can be checked for consistency.
3. **Given** the author seeds a foreshadowing or open thread, **When** they register it (where it appears, what it should pay off), **Then** they can later verify that it is either paid off or deliberately left open, and update the world/series bible when the story evolves.

---

### Edge Cases

- What happens when the author changes a world rule or character trait after several chapters are written? The framework MUST allow rules and profiles to be updated and MUST support identifying affected chapters or scenes for consistency review.
- How does the framework handle a book that is not part of a series? Universe and book-level structure (outline, plotlines, chapter guide) MUST work without a series; series is optional.
- What if the author wants to leave some questions deliberately unanswered? The framework MUST support marking certain themes or questions as “intentionally open” so they are not treated as oversights.
- How are contradictions between earlier and later material handled? The framework MUST support a way to record continuity facts and, where possible, to flag or list passages that may conflict with them; resolution remains the author’s responsibility. For MVP, identifying affected *chapters* (or scenes as units) is in scope; listing specific *passages* or line-level locations may be a later refinement.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The framework MUST support defining at least one narrative universe with genre, style, inspirations, and configurable rule categories (e.g. magic, technology, politics, institutions, morality, historical conflicts, flora, fauna).
- **FR-002**: The framework MUST support defining a series with central conflict, high-level ending, narrative POV and tense, tone, chapter rhythm, and target reader.
- **FR-003**: The framework MUST support defining one or more books per series (or standalone), each with an outline and act structure.
- **FR-004**: The framework MUST support creating character profiles with at least: role, physical and psychological traits, goals, backstory, flaws functional to the story, and optional secrets; and relationship arcs between characters.
- **FR-005**: The framework MUST support defining main and secondary plotlines per book, with subplots having a clear narrative structure that links to the main plot and theme.
- **FR-006**: The framework MUST support defining a writing guide/track per chapter, derived from or aligned with the book outline and plotlines.
- **FR-007**: The framework MUST support writing and managing chapters one-by-one as discrete units, with each chapter having an associated guide where defined.
- **FR-008**: The framework MUST support a continuity log (or equivalent) for recording concrete details (e.g. character attributes, dates, names) for consistency across chapters.
- **FR-009**: The framework MUST support an internal timeline of story events so that events and character locations can be checked for consistency.
- **FR-010**: The framework MUST support a foreshadowing and open-thread register (where something is seeded, what it is intended to pay off, and whether it is resolved or intentionally left open).
- **FR-011**: The framework MUST allow the author to update the world bible, character profiles, and series/book plans as the story evolves, and to trace impact on existing chapters or scenes where applicable.
- **FR-012**: The framework MUST support marking themes or questions as intentionally unanswered so they are not treated as missing resolution.
- **FR-013**: The framework MUST support generating chapter narrative content via AI when the author requests it, using the chapter guide and context (universe, series, book, characters, plotlines) so that the author can have the framework write chapters. Generation is performed by the author’s chosen AI agent (e.g. Cursor, Claude, Gemini) and shell (bash or PowerShell); the framework supplies context and prompts only (same paradigm as current Spec Kit agent selection).
- **FR-014**: The framework MUST support generating other author-requested content via AI (e.g. character description drafts, scene drafts, summaries) when the author chooses, using the same world and narrative context and the same agent/shell selection as for chapter generation.
- **FR-015**: When AI generation is requested but the chosen agent is unavailable or the invocation fails, the framework MUST report the error clearly to the author and MUST NOT overwrite or replace the chapter or other content; the author may retry or write manually.
- **FR-016**: The framework MUST support a strategy for handling context that exceeds the model’s limits (e.g. generating content in multiple requests, summarizing prior output for continuity, or supplying only context relevant to the current chapter); the implementation plan may specify or modify this strategy.
- **FR-017**: The framework MUST support multiple versions or variants per chapter (e.g. when the author keeps or compares alternative drafts) and MUST keep a trace of which version is current and of the differences between versions within the framework, even when using Git.
- **FR-018**: The framework MUST support book-level versioning (editions, reprints, rewrites with added details, etc.) and MUST keep a trace of these editions and their relationship to the content (e.g. which chapter versions belong to which edition) within the framework, even when using Git.

### Key Entities

- **Universe**: The top-level container; holds genre, style, inspirations, and world rules (magic, technology, politics, institutions, morality, history, flora, fauna, etc.). A book or series may belong to one universe.
- **Series**: Optional; belongs to a universe. Holds central conflict, ending, POV, tense, tone, target reader, and list of books. Drives character arcs and secrets across multiple books.
- **Book**: Belongs to a series or stands alone; has outline, act structure, main and secondary plotlines, and a list of chapters.
- **Character**: Belongs to a universe and/or book/series. Has profile (traits, goals, backstory, flaw, secrets), role, and relationship arcs with other characters.
- **Plotline (main/secondary)**: Belongs to a book; describes an arc (setup, crisis, resolution) and how it ties to the main plot and theme.
- **Chapter**: Belongs to a book; has a writing guide/track and the actual narrative content; is the unit of incremental writing. A chapter MAY have multiple versions or variants (e.g. drafts); the framework tracks which version is current and the relationship between versions.
- **Book edition / reprint**: A book MAY have multiple editions, reprints, or rewrites (e.g. with added details); the framework tracks editions and which chapter versions belong to which edition.
- **Continuity log**: Stores concrete facts (character details, dates, names, places) for consistency checks.
- **Timeline**: Ordered story-time events (and optionally real-world dates) for the book or series.
- **Foreshadowing / open-thread register**: Records where a promise or mystery is introduced, its intended payoff, and its status (resolved, open, or intentionally left open).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: An author can complete a minimal world definition (universe + at least two rule categories) before creating the first chapter of a book.
- **SC-002**: An author can define a series and one book with outline and act structure, and derive at least one chapter-level writing guide from that book.
- **SC-003**: An author can create at least three characters (e.g. protagonist, antagonist, one secondary) with full profiles and at least one relationship arc, and reference them when writing or reviewing a chapter.
- **SC-004**: An author can write a book of at least five chapters one-by-one, using chapter guides, and maintain a continuity log and timeline so that a reviewer can verify there are no stated continuity errors.
- **SC-005**: An author can register at least three foreshadowing or open-thread items and later mark them as resolved or intentionally open, so that narrative promises are traceable.
- **SC-006**: After changing a world rule or character trait, the author can identify which chapters or scenes are affected for consistency review (e.g. via list or tagging), without the framework imposing automatic changes.
- **SC-007**: An author can request the framework to generate at least one chapter’s prose from a chapter guide and context; the generated text is stored in the chapter artifact and can be edited like any other content.
- **SC-008**: An author can create at least two versions or variants of the same chapter and have the framework track which is current and the relationship between them; and can create at least two editions (or rewrites) of a book with the framework tracking which chapter versions belong to which edition.
