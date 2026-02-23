# Quickstart: Book and Universe Writing Framework

**Feature**: 001-book-universe-framework  
**Date**: 2025-02-23  
**Audience**: Author who wants to create a narrative universe and write (or generate) a book with chapters, characters, and continuity tracking. All commands and paths use **author-facing names** (universe, book, chapter, structure, writing-steps); no developer jargon (spec, plan, tasks, feature).

## Prerequisites

- Bash (Linux/macOS) or PowerShell (Windows).
- Optional: Git for version control and file history.
- Optional: An AI agent (Cursor, Claude, Gemini, etc.) for chapter generation; the framework only prepares context and prompts (or invokes your chosen agent if configured).

## 1. Initialize a universe

From your project root (empty directory or existing repo):

**Bash:**
```bash
./scripts/bash/universe-init.sh
# or: ./scripts/bash/universe-init.sh /path/to/project
```

**PowerShell:**
```powershell
.\scripts\powershell\Universe-Init.ps1
# or: .\scripts\powershell\Universe-Init.ps1 -ProjectDir C:\path\to\project
```

This creates `universe/universe.md` and the base directory structure. Edit `universe/universe.md` to set genre, style, inspirations, and at least one category of world rules (e.g. magic, politics).

## 2. Add a series (optional)

**Bash:**
```bash
./scripts/bash/universe-add-series.sh my-series "My Series Name"
```

**PowerShell:**
```powershell
.\scripts\powershell\Universe-AddSeries.ps1 -SeriesId my-series -Name "My Series Name"
```

Edit `universe/series/my-series/series.md` to set central conflict, ending, POV, tense, tone, target reader.

## 3. Add a book

**Bash:**
```bash
./scripts/bash/universe-add-book.sh my-book --series-id my-series "Book One"
# standalone: ./scripts/bash/universe-add-book.sh my-book
```

**PowerShell:**
```powershell
.\scripts\powershell\Universe-AddBook.ps1 -BookId my-book -SeriesId my-series -Name "Book One"
```

Edit `universe/books/my-book/book.md` with outline and act structure. Add plotlines under `universe/books/my-book/plotlines/` (main + secondary).

## 4. Add characters

**Bash:**
```bash
./scripts/bash/universe-add-character.sh protagonist "Hero Name"
./scripts/bash/universe-add-character.sh antagonist "Villain Name"
```

**PowerShell:**
```powershell
.\scripts\powershell\Universe-AddCharacter.ps1 -CharacterId protagonist -Name "Hero Name"
.\scripts\powershell\Universe-AddCharacter.ps1 -CharacterId antagonist -Name "Villain Name"
```

Fill in each `universe/characters/<id>.md` with role, traits, goals, backstory, flaw, and relationship arcs.

## 5. Add chapters and write (or generate)

**Bash:**
```bash
./scripts/bash/universe-add-chapter.sh my-book ch01
# Edit universe/books/my-book/chapters/ch01/guide.md (what must happen in this chapter)
# Then either write content by hand in content.md, or generate:
./scripts/bash/universe-generate-chapter.sh my-book ch01
```

**PowerShell:**
```powershell
.\scripts\powershell\Universe-AddChapter.ps1 -BookId my-book -ChapterId ch01
# Edit guide.md, then write or generate:
.\scripts\powershell\Universe-GenerateChapter.ps1 -BookId my-book -ChapterId ch01
```

Generation builds context from your universe, series, book, characters, plotlines, and chapter guide, then invokes your chosen AI agent (or writes a prompt file for you to paste). If the agent is unavailable or fails, the script reports the error and does not overwrite your chapter content.

**Generate other content (drafts, summaries)** — When you need a character description draft, a scene draft, or a summary (not a full chapter), use the generate-content script. Same context and agent as chapter generation; output is written under `universe/drafts/` or, for character drafts, `universe/characters/<id>-draft.md`.

**Bash:**
```bash
./scripts/bash/universe-generate-content.sh character-draft --target-id protagonist
./scripts/bash/universe-generate-content.sh scene-draft --target-id ch01-scene2
./scripts/bash/universe-generate-content.sh summary
```

**PowerShell:**
```powershell
.\scripts\powershell\Universe-GenerateContent.ps1 -Type character-draft -TargetId protagonist
.\scripts\powershell\Universe-GenerateContent.ps1 -Type scene-draft -TargetId ch01-scene2
.\scripts\powershell\Universe-GenerateContent.ps1 -Type summary
```

On failure, the script does not overwrite existing files and exits with an error.

## 6. Continuity and tracking

- **Continuity log**: Edit `universe/continuity-log.md` to record concrete facts (character eye colour, dates, names) as you write.
- **Timeline**: Edit `universe/timeline.md` to keep story-time (and optionally real-world) order of events.
- **Foreshadowing register**: Edit `universe/foreshadowing-register.md` to list where you seed a promise or mystery, what it should pay off, and whether it is resolved or intentionally left open.

## 7. Versioning (chapter variants and book editions)

- **Chapter versions**: Use the versioning script to add a new version or variant of a chapter and to set which version is current (e.g. after a rewrite). The framework keeps a trace in metadata.
- **Book editions**: Use the versioning script to add an edition (reprint, rewrite) and to map which chapter versions belong to that edition.

## 8. Identify affected chapters (consistency review)

After you change a world rule (e.g. magic system) or a character trait, you can list which chapters (or scenes) reference it so you can review them for consistency. Use the list-affected script with either a world-rule category or a character id.

**Bash:**
```bash
./scripts/bash/universe-list-affected.sh --world-rule magic
./scripts/bash/universe-list-affected.sh --character-id protagonist
```

**PowerShell:**
```powershell
.\scripts\powershell\Universe-ListAffected.ps1 -WorldRule magic
.\scripts\powershell\Universe-ListAffected.ps1 -CharacterId protagonist
```

Output is printed to stdout (or written to a temporary list file, depending on implementation). Use this list to open and edit the affected chapters. MVP provides chapter-level listing; passage-level or line-level references may be added in a later version.

## Validation

- Run through the steps above; after step 5 you should have at least one chapter (hand-written or generated) and the continuity/timeline/foreshadowing files in place.
- Change a world rule or character trait and run **universe-list-affected** (step 8) to see which chapters are affected; review those chapters for consistency (SC-006).
- Optionally run **universe-generate-content** (step 5) to produce a character draft, scene draft, or summary and confirm output appears under `universe/drafts/` or `universe/characters/<id>-draft.md`.

## Next steps

- Break down implementation into tasks with `/speckit.tasks`.
- Implement scripts and templates per [plan.md](./plan.md) and [data-model.md](./data-model.md).
