# Installing the Book & Universe Framework CLI (speckit-book)

The **Book & Universe Writing Framework** is a **separate product** from the original [Spec Kit](https://github.com/github/spec-kit) (specify-cli). You can install both: `specify` for spec-driven software development and `book` for outline → structure → writing steps (books, series, universes).

## Prerequisites

- [uv](https://docs.astral.sh/uv/) (or pip)
- Python 3.11+
- Git (optional, for version control)

## Install the book CLI

From the root of this repo (or from your fork):

```bash
uv tool install speckit-book --from .
```

This installs the **`book`** command. Verify:

```bash
book --version
book --help
```

## Install from a Git URL (e.g. your fork)

```bash
uv tool install speckit-book --from git+https://github.com/YOUR_ORG/spec-kit.git
```

## Create a new project

```bash
book init my-writing-project --ai cursor-agent --ai-skills
cd my-writing-project
```

Or in the current directory:

```bash
book init --here --ai cursor-agent --ai-skills
```

## Where templates come from

By default, `book init` fetches the latest release from the GitHub repo configured for this CLI. To use **your fork** (e.g. for testing or your own releases), set:

```bash
export SPECKIT_BOOK_REPO_OWNER=your-github-username
export SPECKIT_BOOK_REPO_NAME=spec-kit
book init my-project --ai cursor-agent
```

## Coexistence with Spec Kit (specify)

| Product        | Package       | Command  | Use case                          |
|----------------|---------------|----------|-----------------------------------|
| Spec Kit       | specify-cli   | `specify`| Spec-driven software development  |
| Book framework | speckit-book  | `book`   | Outline, structure, writing steps |

Both can be installed at the same time. They do not overwrite each other.
