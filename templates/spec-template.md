# Outline / Story Bible: [BOOK OR UNIVERSE NAME]

**Branch**: `[###-book-or-universe-name]`  
**Created**: [DATE]  
**Status**: Draft  
**Input**: Author description (from command arguments)

## Clarifications

<!-- Optional: Q&A from clarify command to lock scope and assumptions -->

## Assumptions

- [Assumption about audience, genre, single book vs series, tone.]
- [File-based artifacts; single author per project; no export to PDF/ePub in scope unless stated.]

## Out of scope

- [What this book/universe does NOT cover — e.g. publishing pipeline, multi-author.]

## User Scenarios & Testing *(mandatory)*

<!-- Prioritize author/reader journeys. Each scenario should be independently testable. -->

### User Story 1 - [Brief Title] (Priority: P1)

[Describe this author or reader journey in plain language]

**Why this priority**: [Value and why this order]

**Independent Test**: [How to verify this scenario alone — e.g. Author can complete a minimal world definition and add one book.]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]
2. **Given** [initial state], **When** [action], **Then** [expected outcome]

---

### User Story 2 - [Brief Title] (Priority: P2)

[Describe journey]

**Why this priority**: [Value]

**Independent Test**: [How to verify independently]

**Acceptance Scenarios**:

1. **Given** [state], **When** [action], **Then** [outcome]

---

[Add more user stories as needed, each with priority P1, P2, P3…]

### Edge Cases

- What happens when [e.g. author changes a world rule after chapters are written]?
- How does the framework handle [e.g. book not part of a series]?
- [Intentionally open questions vs missing resolution?]

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The framework MUST [e.g. support defining at least one narrative universe with genre, style, and world rules].
- **FR-002**: The framework MUST [e.g. support defining a series with central conflict, ending, POV, tense, tone, target reader].
- **FR-003**: The framework MUST [e.g. support defining books with outline and act structure, linked to series or standalone].
- **FR-004**: The framework MUST [e.g. support character profiles and relationship arcs].
- **FR-005**: The framework MUST [e.g. support plotlines, chapter guides, continuity log, timeline, foreshadowing register].
- [Add FR-006… as needed. Mark [NEEDS CLARIFICATION] where scope is unclear.]

### Key Entities

- **Universe**: [Top-level container; genre, style, inspirations, world rules.]
- **Series**: [Optional; central conflict, ending, POV, tense, tone; list of books.]
- **Book**: [Outline, act structure, plotlines, chapters; belongs to series or standalone.]
- **Character**: [Profile, role, traits, goals, backstory, flaw, relationship arcs.]
- **Plotline**: [Main/secondary; arc (setup, crisis, resolution); link to theme.]
- **Chapter**: [Writing guide and narrative content; unit of incremental writing.]

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: [e.g. An author can complete a minimal world definition (universe + at least two rule categories) before the first chapter.]
- **SC-002**: [e.g. An author can define a series and one book with outline and act structure, and derive at least one chapter-level writing guide.]
- **SC-003**: [e.g. An author can create characters with full profiles and reference them when writing or reviewing chapters.]
- **SC-004**: [e.g. An author can write a book of at least N chapters using chapter guides and maintain continuity log and timeline.]
- [Add SC-005… as needed.]
