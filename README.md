# Project Template for Claude Code

Welcome! This project is configured for optimal use with the **[Claude Code](https://www.anthropic.com/claude-code)** terminal agent. Following the structure outlined below will help you collaborate with Claude effectively, automate tasks, and maintain consistency across the team.

---

## 🚀 Getting Started

1.  **Install Claude Code:** If you haven't already, install the agent globally.
    ```bash
    npm install -g @anthropic-ai/claude-code
    ```
    *Note: Do not use `sudo`. If you have permission issues, configure npm correctly for your user account.*

2.  **Verify Installation:** Run the diagnostic tool to ensure everything is set up correctly.
    ```bash
    claude doctor
    ```

3.  **Start a Session:** Navigate to the project root in your terminal and start a session.
    ```bash
    claude
    ```
    The agent will automatically load the project's configuration.

---

## 📂 File Structure & Purpose

This repository contains several special files that configure and guide the Claude agent. Here’s what each one does:

### 📄 `CLAUDE.md`
* **What it is:** The project's "constitution." This is the most important file for guiding Claude.
* **How it's used:** Its contents are automatically fed to the agent at the start of every session. It tells Claude about the tech stack, architecture, coding standards, and essential commands.
* **What to do:** **Read this file first** to understand the project's conventions. When you want to give Claude a permanent instruction, add it here.

---

### 🧠 `.claude/`
This directory is the agent's "brain," containing project-specific settings and commands.

#### `settings.json`
* **What it is:** Shared settings for the whole team.
* **How it's used:** Defines the default AI model, grants permissions for safe commands (to reduce repetitive prompts), and sets up automation hooks.
* **What to do:** Leave this as is unless the team decides to change a project-wide setting.

#### `settings.local.json` `(Optional)`
* **What it is:** Your personal settings overrides. This file is in `.gitignore`.
* **How it's used:** Use this to set personal preferences, like using a more powerful model (`"model": "claude-3-opus-20240229"`) or enabling verbose logging (`"verbose": true`) without affecting the team.

#### `commands/`
* **What it is:** A directory of custom slash commands.
* **How it's used:** Any `.md` file in here becomes a reusable command. For example, `.claude/commands/gen_commit_msg.md` can be run by typing `/gen_commit_msg` in the terminal. This is perfect for automating complex, multi-step prompts.
* **What to do:** Explore the existing commands. Create new ones to automate your own repetitive workflows.

---

### 🙈 `.claudeignore`
* **What it is:** A list of files and directories for Claude to ignore.
* **How it's used:** Prevents the agent from wasting time (and tokens) on irrelevant files like `node_modules/`, build artifacts, or local environment files. It works just like `.gitignore`.

---

### 🛠️ `.mcp.json` `(Optional)`
* **What it is:** Configuration for external tools via the Model Context Protocol (MCP).
* **How it's used:** This file gives Claude new capabilities, like controlling a web browser, running a security scanner, or connecting to a database.

---

### 🤖 `.github/workflows/claude-code-review.yml`
* **What it is:** A GitHub Actions workflow for automated code reviews.
* **How it's used:** When a pull request is opened, this action triggers Claude to review the changes and post comments, focusing on logic, potential bugs, and adherence to the project's `CLAUDE.md` constitution.

---

## ✨ Key Concepts

* **Trust the Constitution:** `CLAUDE.md` is your primary tool for ensuring the AI writes code that fits the project. Keep it updated.
* **Automate with Commands:** Use and create slash commands in `.claude/commands/` to save time and ensure consistency.
* **Plan Your Work:** For complex tasks, ask Claude to create a plan first before writing any code. This dramatically improves results. Example prompt: `"Create a step-by-step plan to implement the new login feature. Do not write any code yet."`

Happy coding!