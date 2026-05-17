# Testing the Book & Universe Framework in a New Project Folder

This is the **Book & Universe Writing Framework** (speckit-book). It is **independent** from the original Spec Kit (specify-cli): different package, different command, so both can be installed at the same time.

---

## Step 0: Install the book CLI (speckit-book)

From the **root of this repo**:

```bash
cd /path/to/spec-kit
uv tool install speckit-book --from .
```

This installs the **`book`** command. It does **not** replace `specify` (original Spec Kit). Check:

```bash
book --version
which book
# You can still have specify installed:
which specify
```

---

## Option 1: Test with a published release (recommended after release)

Once you have published a release that includes the new nomenclature (outline/structure) **from this repo or your fork** (so the zip contains `outline.md` / `structure.md` and the new templates):

1. **Create a new project** (from any directory, with `speckit-book` installed):
   ```bash
   book init mio-progetto-test --ai cursor-agent --ai-skills
   ```
2. **Go into the project** and open it in Cursor:
   ```bash
   cd mio-progetto-test
   cursor .
   ```
3. **Check commands**: In Cursor you should see `/speckit.outline`, `/speckit.structure`, `/speckit.tasks`, `/speckit.implement`, etc.
4. **Quick test**: Run `/speckit.constitution` first, then `/speckit.outline` with a short description (e.g. a small feature or book idea).

---

## Option 2: Test from the repo (current source, without publishing)

Use this to try the **new nomenclature** (outline, structure) before releasing.

### Step 1: Build the package locally

From the **spec-kit repo root**:

```bash
cd /home/edowinubu/projects/AIFB_WWU/spec-kit
./.github/workflows/scripts/create-release-packages.sh v0.0.0-test
```

This creates `.genreleases/sdd-cursor-agent-package-sh/` (and other agents) using the current `templates/commands/` (outline.md, structure.md, etc.).

### Step 2: Create a test project from the built package

```bash
# Create new folder and copy the built template into it
mkdir -p ../spec-kit-test-proj
cp -r .genreleases/sdd-cursor-agent-package-sh/. ../spec-kit-test-proj/
```

### Step 3: (Optional) Add constitution from template

The built package has `.specify/templates/` but no `.specify/memory/` until init runs. To get the writing principles (constitution) in place without running init (which would re-download the release):

```bash
mkdir -p ../spec-kit-test-proj/.specify/memory
cp templates/constitution-template.md ../spec-kit-test-proj/.specify/memory/constitution.md
```

### Step 4: Open and test in Cursor

```bash
cd ../spec-kit-test-proj
cursor .
```

In Cursor you should see the new commands: `/speckit.outline`, `/speckit.structure`, etc. Test with a short outline and then structure.

### Step 5: (Optional) Install CLI and run init there

If you want to run `specify` commands (e.g. `specify check`) inside the test project, install the CLI and run init in place so the project is fully set up (this will **download the latest GitHub release** and may overwrite commands with the release version):

```bash
cd ../spec-kit-test-proj
uv tool install specify-cli   # or use your usual install
specify init --here --ai cursor-agent --ai-skills --force
```

**Note:** Running `book init --here` overwrites `.cursor/commands/` with whatever is in the **published** release. To keep the locally built commands, skip this step or run it only when your release is already published. To point `book init` at your fork, set `SPECKIT_BOOK_REPO_OWNER` and `SPECKIT_BOOK_REPO_NAME` before running.

---

## Summary

| Goal                         | Action |
|-----------------------------|--------|
| Install the book CLI        | `uv tool install speckit-book --from .` (independent from `specify`). |
| Test after a release       | `book init mio-progetto --ai cursor-agent --ai-skills` then `cd mio-progetto && cursor .` |
| Test current repo (no release) | Build package with `create-release-packages.sh v0.0.0-test`, copy `.genreleases/sdd-cursor-agent-package-sh/.` into a new folder, optionally copy constitution, then open that folder in Cursor. |
