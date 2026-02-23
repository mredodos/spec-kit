# Agent Rules / Context — [UNIVERSE OR BOOK NAME]

Optional file to provide context or instructions to your chosen AI agent (Cursor, Claude, Gemini, etc.) when generating or editing content. The framework may merge this with universe, characters, and plotlines when building prompts.

**Last updated**: [DATE]

## Instructions for the Agent

- **Tone**: [e.g. literary, commercial, dark, hopeful]
- **Style**: [e.g. close third person, present tense, short chapters]
- **Avoid**: [e.g. anachronisms, modern slang, explicit content]
- **Language**: [e.g. English, Italian]

## Key References

- **Universe**: [Path or summary — e.g. universe/universe.md]
- **Series**: [If applicable — series id and central conflict]
- **Book(s)**: [Book ids and one-line premise]
- **Main characters**: [Ids and one-line role]

## Project Structure (for context)

```text
universe/
├── universe.md
├── series/<id>/series.md
├── books/<id>/book.md, plotlines/, chapters/
├── characters/
├── continuity-log.md
├── timeline.md
└── foreshadowing-register.md
```

## Manual Additions

<!-- Add any extra instructions, do-not-use phrases, or style notes for the agent. -->
