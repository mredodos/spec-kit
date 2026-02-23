# Data Model: Book and Universe Writing Framework

**Feature**: 001-book-universe-framework  
**Date**: 2025-02-23  
**Source**: [spec.md](./spec.md) Key Entities and Functional Requirements.

All entities are file-based. Each entity is represented by one or more Markdown (and optional YAML) files under the author's project directory (e.g. `universe/`).

---

## 1. Universe

**Purpose**: Top-level container for genre, style, inspirations, and world rules.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| name / id | string | Slug or identifier for directory or filename |
| genre | string | Free text |
| style | string | Free text |
| inspirations | string or list | Free text |
| world_rules | map or sections | Keys or sections: magic, technology, politics, institutions, morality, historical_conflicts, flora, fauna (configurable per spec) |

**File**: `universe/universe.md` (single file per project).  
**Relationships**: One universe per project root. Series and books belong to this universe (by containment under `universe/`).

---

## 2. Series

**Purpose**: Optional container for central conflict, ending, POV, tense, tone, target reader; groups books.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| id | string | Slug for directory name |
| central_conflict | string | Free text |
| ending | string | High-level |
| pov | string | e.g. first, third limited, third omniscient |
| tense | string | e.g. past, present |
| tone | string | Free text |
| chapter_rhythm | string | Free text (short/long chapters, etc.) |
| target_reader | string | Free text |

**File**: `universe/series/<series-id>/series.md`.  
**Relationships**: Belongs to universe (by path). Has many books (see Book).

---

## 3. Book

**Purpose**: Outline, act structure, plotlines, chapters; can stand alone or belong to a series.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| id | string | Slug for directory name |
| series_id | string (optional) | Reference to series; empty if standalone |
| outline | string | Free text |
| act_structure | string or structured | Free text or structured acts |
| plotlines | see Plotline | One main + zero or more secondary |
| chapters | see Chapter | Ordered list (order in manifest or directory convention) |
| editions | see Book edition | Trace of editions/reprints/rewrites |

**File**: `universe/books/<book-id>/book.md`. Directory contains `plotlines/`, `chapters/<chapter-id>/`, and edition metadata.  
**Relationships**: Optional parent series. Has many plotlines, many chapters, and zero or more editions.

---

## 4. Character

**Purpose**: Profile (role, physical/psychological traits, goals, backstory, flaw, secrets) and relationship arcs.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| id | string | Slug for filename |
| role | string | e.g. protagonist, antagonist, secondary |
| physical_traits | string | Free text |
| psychological_traits | string | Free text |
| goals | string | Free text |
| backstory | string | Free text |
| flaw | string | Functional to story (per spec) |
| secrets | string (optional) | Free text |
| relationship_arcs | list or string | References to other character ids + description of arc (e.g. ally → enemy) |

**File**: `universe/characters/<character-id>.md`.  
**Relationships**: Belongs to universe (and optionally to book/series by reference). Relationship arcs reference other characters by id.

---

## 5. Plotline (main / secondary)

**Purpose**: Narrative arc (setup, crisis, resolution) tied to main plot and theme.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| id | string | Slug |
| type | enum | main | secondary |
| arc | string or structured | setup, crisis, resolution (or free text) |
| link_to_theme | string | Free text |
| tie_to_main_plot | string | Free text |

**File**: `universe/books/<book-id>/plotlines/<plotline-id>.md`.  
**Relationships**: Belongs to one book.

---

## 6. Chapter

**Purpose**: Unit of incremental writing; has a writing guide and narrative content; can have multiple versions/variants.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| id | string | Slug for directory or filename |
| book_id | string | Parent book |
| guide | string | Writing guide/track (what to advance, threads, tone) |
| content | string | Narrative prose |
| version_trace | see Versioning | current version id, list of version ids with refs |

**Files**: `universe/books/<book-id>/chapters/<chapter-id>/guide.md`, `content.md` (or `versions/<version-id>.md`). Versioning metadata in `chapter-versions.yaml` or equivalent.  
**Relationships**: Belongs to one book. Multiple versions/variants; one marked current (FR-017).

---

## 7. Book edition / reprint

**Purpose**: Trace of editions, reprints, or rewrites; maps to chapter versions.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| edition_id | string | Slug or label |
| label | string | e.g. "First edition", "Revised" |
| chapter_version_refs | map | chapter_id → version_id (which chapter version belongs to this edition) |

**File**: `universe/books/<book-id>/editions.md` or `editions.yaml`.  
**Relationships**: Belongs to one book. References chapter versions (FR-018).

---

## 8. Continuity log

**Purpose**: Concrete facts (character details, dates, names, places) for consistency checks.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| entries | list | Each: fact description, source (chapter/scene), optional category |

**File**: `universe/continuity-log.md` (or structured YAML).  
**Relationships**: Project/universe level; referenced when checking chapters.

---

## 9. Timeline

**Purpose**: Ordered story-time events (and optionally real-world dates) for the book or series.

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| events | list | Each: description, story date/time, optional real-world date, optional chapter ref |

**File**: `universe/timeline.md` (or `timeline.yaml`).  
**Relationships**: Project/universe or per-book; used for consistency (FR-009).

---

## 10. Foreshadowing / open-thread register

**Purpose**: Where a promise or mystery is introduced, intended payoff, status (resolved, open, intentionally open).

| Field / concept | Type | Validation / notes |
|-----------------|------|---------------------|
| entries | list | Each: where seeded (chapter/scene), what it pays off, status: resolved | open | intentionally_open |

**File**: `universe/foreshadowing-register.md` (or YAML).  
**Relationships**: Project/universe level (FR-010, FR-012).

---

## Versioning (chapter and book)

- **Chapter versions**: Metadata (e.g. `chapter-versions.yaml`) lists version_id, label, path or ref to content, and `current: true` for one. Content may live in `chapters/<id>/versions/<version-id>.md` or in Git history.
- **Book editions**: Metadata (e.g. `editions.yaml`) lists edition_id, label, and `chapter_version_refs: { chapter_id: version_id }`. Framework MUST keep this trace even when using Git (FR-017, FR-018).

---

## Generated content (non-chapter)

AI-generated content that is not a full chapter (e.g. character description draft, scene draft, summary) is stored under `universe/` per FR-014. **Character drafts**: `universe/characters/<character-id>-draft.md` (or optionally `universe/drafts/character-<id>.md`). **Other types** (scene-draft, summary): `universe/drafts/<type>-<slug>.md`. The `universe/drafts/` directory is created by the script when needed. See contracts/script-commands.md for the generate-content command and output paths.

---

## Identity and lifecycle

- **Identity**: All entities use a stable id (slug) for filenames and references. No global uniqueness beyond project (single author, single universe per project).
- **Lifecycle**: No formal state machine. Author creates/updates/renames via scripts or manually; scripts create files from templates and optionally update versioning metadata when “add version” or “add edition” is requested.
