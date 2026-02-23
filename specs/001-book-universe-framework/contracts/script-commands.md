# Contract: Book-Universe Script Commands

**Feature**: 001-book-universe-framework  
**Date**: 2025-02-23  
**Purpose**: Define the script-based “CLI” surface exposed to the author. Bash and PowerShell scripts MUST follow this contract for naming, arguments, and exit behavior so that automation and docs stay consistent.

## Invocation context

- **Working directory**: Author's project root (where `universe/` will live or already exists).
- **Shell**: Bash (Linux/macOS) or PowerShell (Windows); scripts come in pairs (e.g. `universe-init.sh` and `Universe-Init.ps1`).
- **Output**: Success messages to stdout; errors to stderr; exit code 0 on success, non-zero on failure. On generation failure (FR-015): report error, do not overwrite content; exit non-zero.

## Commands (scripts)

| Command (conceptual) | Bash script | PowerShell script | Purpose |
|----------------------|-------------|--------------------|---------|
| Init universe | `universe-init.sh [project-dir]` | `Universe-Init.ps1 [-ProjectDir path]` | Create `universe/` and minimal `universe.md` from template. Default project-dir = current dir. |
| Add series | `universe-add-series.sh <series-id> [name]` | `Universe-AddSeries.ps1 -SeriesId <id> [-Name <name>]` | Create `universe/series/<series-id>/series.md` from template. |
| Add book | `universe-add-book.sh <book-id> [--series-id <id>] [name]` | `Universe-AddBook.ps1 -BookId <id> [-SeriesId <id>] [-Name <name>]` | Create `universe/books/<book-id>/` and `book.md`; optionally link to series. |
| Add character | `universe-add-character.sh <character-id> [name]` | `Universe-AddCharacter.ps1 -CharacterId <id> [-Name <name>]` | Create `universe/characters/<character-id>.md` from template. |
| Add plotline | `universe-add-plotline.sh <book-id> <plotline-id> [main\|secondary]` | `Universe-AddPlotline.ps1 -BookId <id> -PlotlineId <id> [-Type main\|secondary]` | Create `universe/books/<book-id>/plotlines/<plotline-id>.md`. |
| Add chapter | `universe-add-chapter.sh <book-id> <chapter-id>` | `Universe-AddChapter.ps1 -BookId <id> -ChapterId <id>` | Create `universe/books/<book-id>/chapters/<chapter-id>/` with `guide.md` and `content.md` (or equivalent). |
| Generate chapter | `universe-generate-chapter.sh <book-id> <chapter-id> [--agent <name>]` | `Universe-GenerateChapter.ps1 -BookId <id> -ChapterId <id> [-Agent <name>]` | Build context from universe/series/book/characters/plotlines/chapter guide; write prompt or invoke author's agent. On agent failure: report error, do not overwrite chapter content; exit non-zero. |
| Generate other content | `universe-generate-content.sh <type> [--target-id <id>] [--agent <name>]` | `Universe-GenerateContent.ps1 -Type <type> [-TargetId <id>] [-Agent <name>]` | Generate non-chapter content (e.g. character-draft, scene-draft, summary). Same context and agent as chapter generation. Output: character draft → `universe/characters/<id>-draft.md` or `universe/drafts/character-<id>.md`; other types → `universe/drafts/<type>-<slug>.md`. On failure: do not overwrite; exit non-zero (FR-014, FR-015). |
| List affected | `universe-list-affected.sh (--world-rule <category> \| --character-id <id>)` | `Universe-ListAffected.ps1 [-WorldRule <category>] [-CharacterId <id>]` | List chapters (and optionally scenes) that reference the given world-rule category or character id. Output to stdout or a temp list file. MVP: chapter-level (FR-011, SC-006). |
| Versioning | `universe-versioning.sh <book-id> <chapter-id> add-version \| set-current <version-id>` | `Universe-Versioning.ps1 -BookId <id> -ChapterId <id> -Action AddVersion \| SetCurrent -VersionId <id>` | Add a new chapter version or set current version; update metadata. Similarly for book editions (e.g. `add-edition`, `set-edition-chapters`). |

## Argument conventions

- **Ids**: Non-empty slugs (lowercase, hyphens allowed); no path separators or spaces.
- **Optional args**: Use `--opt value` (bash) and `-Opt value` (PowerShell). Defaults: project-dir = `.`; series-id = none (standalone book); type = secondary (plotline); agent = from env or config if present. For universe-generate-content: type is one of character-draft, scene-draft, summary; target-id required for character-draft, optional for others (used as output slug). For universe-list-affected: exactly one of --world-rule or --character-id is required.
- **Help**: Every script MUST support `--help` / `-Help` and print usage to stdout, then exit 0.

## Error behavior

- Missing required args or invalid ids: message to stderr, exit 1.
- Missing `universe/` or required parent entity (e.g. book not found): message to stderr, exit 1.
- Generation (universe-generate-chapter, universe-generate-content): if agent invocation fails or times out, message to stderr, do not overwrite content, exit non-zero (e.g. 2).
- List affected: if universe/ is missing or neither --world-rule nor --character-id is given, message to stderr, exit 1.

## Files created/updated

Scripts MUST only create or update files under the project's `universe/` tree (and optionally under a config or temp directory agreed in implementation). They MUST NOT overwrite user content on generation failure (FR-015). Generated non-chapter content (universe-generate-content) MUST be written under `universe/drafts/` or, for character drafts, `universe/characters/<id>-draft.md`; the `universe/drafts/` directory may be created by the script if absent.
