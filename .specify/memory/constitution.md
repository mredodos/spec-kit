<!--
Sync Impact Report
- Version change: (none) → 1.0.0
- Modified principles: N/A (initial fill from template)
- Added sections: Core Principles (4), Quality Gates & Constraints, Development Workflow & Compliance, Governance
- Removed sections: Template placeholders PRINCIPLE_5, generic SECTION_2/3 placeholders
- Templates: plan-template.md ✅ (Constitution Check aligns); spec-template.md ✅ (no change needed); tasks-template.md ✅ (task types compatible); commands/*.md ⚠ N/A (no .specify/templates/commands/)
- Follow-up TODOs: None
-->

# Spec Kit Constitution

## Core Principles

### I. Code Quality

- Code MUST be modular, testable, and maintainable; SOLID and DRY apply.
- Public APIs, modules, and non-trivial logic MUST have docstrings and comments in English.
- Linters and formatters MUST be configured and passing; no unexplained suppressions.
- **Rationale**: Quality is non-negotiable for long-term maintainability and safe refactoring.

### II. User Experience Consistency

- User-facing behavior (CLI, UI, messages, errors) MUST be consistent across commands and surfaces.
- Wording, patterns, and interaction flows MUST align with existing product behavior unless explicitly changed by spec.
- Accessibility and clear feedback (success, progress, errors) MUST be considered for all user-facing features.
- **Rationale**: Consistent UX reduces cognitive load and support burden; deviations must be intentional.

### III. Simplicity

- Prefer the simplest design that meets the spec; YAGNI—do not add scope not required by the specification.
- Complexity (extra abstractions, dependencies, or options) MUST be justified in plan or spec.
- File size and module scope SHOULD stay manageable; flag files approaching or exceeding ~1600 lines for review.
- **Rationale**: Simplicity reduces defects, speeds onboarding, and keeps the system predictable.

### IV. Performance Requirements

- Performance goals and constraints (e.g., latency, throughput, memory) MUST be stated in the spec or plan when relevant.
- Features that affect hot paths or resource usage MUST document expected impact and any limits.
- Regressions against stated performance targets MUST be treated as bugs and addressed before release.
- **Rationale**: Explicit performance requirements prevent surprise regressions and guide optimization efforts.

## Quality Gates & Constraints

- **Constitution Check**: Plans and specs MUST pass a constitution check (alignment with the four principles above) before Phase 0 research and again after Phase 1 design.
- **Technology choices**: Stack and dependencies MUST support the project’s performance and quality goals; document trade-offs when they affect principles.
- **Security**: Input validation, sanitization, and auth/capability checks MUST follow project and OWASP guidance where applicable.

## Development Workflow & Compliance

- All PRs and reviews MUST verify compliance with this constitution; violations require justification in the plan’s Complexity Tracking or equivalent.
- Spec-driven flow: significant features MUST have spec → plan → tasks → implement; small bugfixes or refactors may skip to implementation when scope is clear.
- Use `.specify/` artifacts and Speckit commands (e.g. `/speckit.outline`, `/speckit.structure`, `/speckit.tasks`, `/speckit.implement`) as the primary source of truth for scope and acceptance.

## Governance

- This constitution overrides conflicting ad-hoc practices; amendments require documentation, approval, and an updated Sync Impact Report at the top of this file.
- Versioning: MAJOR for backward-incompatible principle removals or redefinitions; MINOR for new principles or material expansion; PATCH for clarifications and non-semantic edits.
- Compliance reviews: Principles are declarative and testable; use them in plan gates and checklists to ensure consistent application.

**Version**: 1.0.0 | **Ratified**: 2025-02-23 | **Last Amended**: 2025-02-23
