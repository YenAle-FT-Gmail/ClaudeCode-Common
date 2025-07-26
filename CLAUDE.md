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

## Critical Rules
- ALWAYS strive to write production ready code
- ALWAYS strive to write the minimal amount of code to achieve the task
- ALWAYS retain design patterns and principles
- NEVER write code that is not relevant to the task at hand
- When something doesn't work, debug and fix it - don't start over with a simple version