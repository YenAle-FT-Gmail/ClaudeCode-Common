# Project Template for Claude Code

Welcome! This project is configured for optimal use with the **[Claude Code](https://www.anthropic.com/claude-code)** terminal agent. Following the structure outlined below will help you collaborate with Claude effectively, automate tasks, and maintain consistency across the team.

## 🚀 Getting Started


1. **Install Claude Code:** If you haven't already, install the agent globally.

    ```bash
    npm install -g @anthropic-ai/claude-code
    ```
    *Note: Do not use `sudo`. If you have permission issues, configure npm correctly for your user account.*

2. **Verify Installation:** Run the diagnostic tool to ensure everything is set up correctly.

    ```bash
    claude doctor
    ```

3. **Start a Session:** Navigate to the project root in your terminal and start a session.

    ```bash
    claude
    ```
    The agent will automatically load this project's configuration.

---

## 📋 How to Apply This Template to Other Projects

This repository acts as a master template. Use the included `integrate.sh` script to copy this setup to any of your other projects.

### 1. Using the Integration Script

From the root of this template repository, run the script with the path to your target project.

First, make the script executable:

    ```bash
    chmod +x integrate.sh
    ```

Then, run it on your project:

    ```bash
    ./integrate.sh /path/to/your/other-project
    ```

### 2. Customization Workflow

After running the script, follow these crucial steps in your target project:

1. **Customize CLAUDE.md (Most Important Step):** Open the new CLAUDE.md file. This is the "soul" of the agent's project-specific knowledge. Update it with the correct persona, tech stack, file architecture, and essential commands for that specific project.
2. **Tweak .claudeignore:** Add any project-specific files or directories that the agent should ignore (e.g., `__pycache__/`, `.venv/`, `.vite-cache/`).
3. **Review settings.json:** Optionally, add any frequently used, safe commands for the project to the `allowed_tools` array to avoid repetitive permission prompts.
4. **Commit the Changes:** Stage and commit the new setup files to your project's repository.

    ```bash
    git add .
    git commit -m "chore: integrate claude code setup"
    ```


## 📂 File Structure & Purpose

This repository contains several special files that configure and guide the Claude agent. Here’s what each one does:

- **📄 CLAUDE.md:** The project's "constitution." This is the most important file for guiding Claude. It tells the agent about the tech stack, architecture, coding standards, and essential commands. You must customize this for every project.
- **🧠 .claude/:** This directory is the agent's "brain," containing project-specific settings and commands.
    - `settings.json`: Shared settings for the whole team (default model, tool permissions, etc.).
    - `settings.local.json` (Optional): Your personal overrides (e.g., a more powerful model). This file is git-ignored.
    - `commands/`: A directory of reusable slash commands to automate complex prompts.
- **🙈 .claudeignore:** A list of files and directories for Claude to ignore, saving tokens and improving focus. It works just like .gitignore.
- **🛠️ .mcp.json (Optional):** Configuration for external tools (e.g., web browsers, security scanners) via the Model Context Protocol (MCP).
- **🤖 .github/workflows/claude-code-review.yml:** A sample GitHub Actions workflow for automating code reviews on pull requests.


## ✨ Best Practices & Key Concepts

- **Trust the Constitution:** `CLAUDE.md` is your primary tool for ensuring the AI writes code that fits the project. Keep it updated. The quality of your prompts and this file directly determines the quality of the agent's output.
- **Automate with Commands:** Use and create slash commands in `.claude/commands/` to save time and ensure complex tasks are performed consistently.
- **Plan Your Work:** For complex features, ask Claude to create a step-by-step plan first before writing any code. This dramatically improves results.
    - **Prompt Example:**
        > Create a step-by-step plan to implement the new login feature. Save it to TASK_PLAN.md and do not write any code yet.
- **Monorepo vs. Separate Repos (`CLAUDE.md` Strategy):**
    - **Separate Repos:** A project with a distinct frontend and backend in different repositories should have a separate, customized `CLAUDE.md` in each repo.
    - **Monorepo:** If your project contains multiple packages (e.g., client and server) in one repository, you should use a single, unified `CLAUDE.md` at the root. To avoid confusion, make your commands explicit (e.g., `npm run test --workspace=client` vs. `npm run test --workspace=server`) and structure the file with clear sections for each package.

Happy coding!


---

## 2. `integrate.sh`

This script automates copying the template files to your other projects.

```bash
#!/bin/bash

# A script to copy the Claude Code setup files to an existing project.
# Usage: ./integrate.sh /path/to/your/project

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
# The project to apply the template to (the first argument to the script).
TARGET_DIR="$1"
# The directory where this script is located (your setup repo).
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# --- Main Logic ---

# 1. Validate Input
if [ -z "$TARGET_DIR" ]; then
  echo "❌ Error: No target directory supplied."
  echo "Usage: ./integrate.sh /path/to/your/project"
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "❌ Error: Target directory '$TARGET_DIR' does not exist."
  exit 1
fi

echo "🚀 Starting Claude Code setup integration for: $TARGET_DIR"

# 2. List of files/dirs to copy from the source repo.
# Note: We handle .github separately for safety.
FILES_TO_COPY=(
  ".claude/"
  "CLAUDE.md"
  ".claudeignore"
  ".gitattributes"
  ".mcp.json"
)

# 3. Copy the core configuration files.
for item in "${FILES_TO_COPY[@]}"; do
  echo "  -> Copying $item..."
  # Use -r for directories, -f to overwrite if exists.
  cp -rf "$SOURCE_DIR/$item" "$TARGET_DIR/"
done

# 4. Intelligently handle GitHub Actions workflow.
echo "  -> Setting up GitHub workflow..."
# Create the .github/workflows directory in the target if it doesn't exist.
mkdir -p "$TARGET_DIR/.github/workflows"
# Copy only the specific review workflow file.
cp -f "$SOURCE_DIR/.github/workflows/claude-code-review.yml" "$TARGET_DIR/.github/workflows/"

# 5. Intelligently update the target project's .gitignore.
GITIGNORE_PATH="$TARGET_DIR/.gitignore"
IGNORE_LINE=".claude/settings.local.json"

echo "  -> Updating .gitignore..."
# Create .gitignore if it doesn't exist.
touch "$GITIGNORE_PATH"
# Add the ignore line if it's not already in the file.
if ! grep -qF "$IGNORE_LINE" "$GITIGNORE_PATH"; then
  echo -e "\n# Claude Code local settings (do not commit)" >> "$GITIGNORE_PATH"
  echo "$IGNORE_LINE" >> "$GITIGNORE_PATH"
  echo "     Added '$IGNORE_LINE' to .gitignore."
else
  echo "     .gitignore already contains '$IGNORE_LINE'."
fi

echo -e "\n✅ Integration complete!"
echo "---"
echo "Next Steps:"
echo "1. Customize the CLAUDE.md for the target project."
echo "2. Run 'git status' in your project to review the new files."
echo "3. Commit the new setup files: git commit -m 'chore: integrate claude code setup'"


## 3. CLAUDE.md (Placeholder Version)

This is the main "constitution" file. It must be customized for each project.

```markdown
# Project Constitution: {PROJECT_NAME}

## 1. Project Overview
You are {PERSONA}.
Your primary task is to {PROJECT_OVERVIEW}.

## 2. Core Architecture & Tech Stack
- **Tech Stack:** {TECH_STACK_LIST}
    - *Example: Python 3.11, FastAPI, Poetry, PostgreSQL, SQLAlchemy*
    - *Example: React 18, Vite, TypeScript, Tailwind CSS, Zustand*
- **Key Directories:**
{KEY_DIRECTORIES_LIST}
    - *Example: `/app/routers/` for API endpoint routers.*
    - *Example: `/src/components/` for reusable UI components.*

## 3. Coding Standards & Conventions
{CODING_STANDARDS_DESCRIPTION}
- *Example: Adhere to Black for formatting and Flake8 for linting.*
- *Example: All commit messages MUST follow the Conventional Commits specification.*
- *Example: All new logic MUST be accompanied by unit tests.*

## 4. Essential Commands
You MUST use these exact commands. Do not improvise. Refer to them by name.

<commands>
{COMMAND_LIST}
# --- Backend Example Commands (replace as needed) ---
- **Install Dependencies:** `poetry install`
- **Run Dev Server:** `poetry run uvicorn app.main:app --reload`
- **Run Tests:** `poetry run pytest`

# --- Frontend Example Commands (replace as needed) ---
- **Install Dependencies:** `npm install`
- **Run Dev Server:** `npm run dev`
- **Run Tests:** `npm run test -- --watchAll=false`
</commands>
```


## 4. .claudeignore

This file tells Claude what to ignore, saving tokens and improving focus.

```gitignore
# Dependencies
node_modules/
dist/
build/
coverage/

# Logs and sensitive files
*.log
.env
*.local
secrets/

# OS-specific
.DS_Store
Thumbs.db

# Add project-specific ignores below
# -----------------------------------
# Example for Python:
# __pycache__/
# .venv/
# instance/

# Example for Vite/Node:
# .vite-cache/
# .npm/
```


## 5. .claude/settings.json

Shared settings for the entire team.

```json
{
  "model": "claude-3-5-sonnet-20240620",
  "permissions": {
    "allowed_tools": [
      "git diff --staged"
    ]
  },
  "hooks": {
    "PostToolUse": [
      {
        "tool_name": "edit_file",
        "command": "npm run format {{filename}}",
        "show_output": false
      }
    ]
  }
}
```


## 6. .claude/settings.local.json

Personal settings that override the shared settings. This file should not be committed to Git.

```json
{
  "model": "claude-3-opus-20240229",
  "verbose": true
}
```


## 7. .claude/commands/gen_commit_msg.md

An example of a powerful custom command.

You are an expert programmer who writes concise, high-quality commit messages following the Conventional Commits specification.
Analyze the output of `git diff --staged` and generate a commit message.

The commit message must follow this structure:

```
<type>(<scope>): <subject>
[optional body]
[optional footer]
```

**Instructions:**
1. Run the `git diff --staged` command to see the changes.
2. Determine the correct `type` (e.g., `feat`, `fix`, `chore`, `docs`, `refactor`, `test`).
3. Determine an optional `scope` (e.g., `api`, `ui`, `db`).
4. Write a short, imperative `subject` line (max 50 chars).
5. If the change is complex, write a detailed `body` explaining the 'what' and 'why'.
6. Output **only** the complete commit message and nothing else.

**Example of your thought process:**

```thinking
The user ran `/gen_commit_msg`.
First, I need to see the changes. I will run `!git diff --staged`.
The diff shows a new function was added to `packages/server/src/auth.ts` and a corresponding test file was created.
This is a new feature related to authentication.
Therefore, the type is `feat` and the scope is `auth`.
The subject should be "add user password hashing and verification".
The body can explain that it uses bcrypt for hashing.
```

**Final Output (Only the message):**

```text
feat(auth): add user password hashing and verification

This commit introduces password hashing using bcrypt during user registration.
It also adds a `verifyPassword` utility function that will be used during the login process.
```


## 8. .github/workflows/claude-code-review.yml

A sample GitHub Actions workflow for automated code reviews.

```yaml
name: Claude Code Review

on:
  pull_request:
    types: [opened, synchronize]

permissions:
  contents: read
  pull-requests: write


  review:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0 # Fetch all history for better context

      - name: Claude Code Review
        uses: anthropics/claude-code-action@v1
        with:
          # Store your Anthropic API key as a secret in your repository settings
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          # Use a cost-effective model for automated reviews
          model: 'claude-3-5-sonnet-20240620'
          prompt: |
            You are a senior software architect reviewing a pull request.
            Your goal is to provide a high-level review focusing on logic, potential bugs, and adherence to the project's best practices as outlined in CLAUDE.md.
            Do NOT comment on minor style issues, as a linter will handle those.
            Provide your feedback as a concise list of suggestions. If there are no major issues, simply approve the PR with a positive comment.
```

## 9. .gitattributes

Helps enforce consistent file handling in Git.

```gitattributes
# Enforce Unix-style line endings for all text files
* text=auto eol=lf

# Explicitly mark common file types as text
*.js text
*.jsx text
*.ts text
*.tsx text
*.json text
*.md text
*.py text
*.html text
*.css text
*.yaml text
*.yml text

# Use Git LFS (Large File Storage) for binary assets if you have it installed
# *.png filter=lfs diff=lfs merge=lfs -text
# *.jpg filter=lfs diff=lfs merge=lfs -text
# *.zip filter=lfs diff=lfs merge=lfs -text
```


## 10. .mcp.json (Optional)

Configures connections to external tools. This is a placeholder; you would add real server configurations here.

```json
[
  {
    "name": "browser",
    "url": "http://localhost:3001",
    "description": "A web browser that can be used to view pages, take screenshots, and interact with elements.",
    "tools": ["navigate", "screenshot", "click", "type"]
  }
]
```
