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