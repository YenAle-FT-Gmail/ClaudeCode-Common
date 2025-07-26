# Project Constitution: "EchoLoom" Web App

## 1. Project Overview
You are an expert full-stack TypeScript developer. Your task is to help build and maintain EchoLoom, a real-time collaborative text editor. The application uses a React frontend and a Node.js/Express backend with WebSocket for real-time communication.

## 2. Core Architecture & Tech Stack
- **Monorepo Structure:** The project is a monorepo with two main packages: `packages/client` (React frontend) and `packages/server` (Express backend).
- **Frontend:** React 18, TypeScript, Vite, Tailwind CSS. State management is handled with Zustand.
- **Backend:** Node.js 20, Express, TypeScript, WebSocket (`ws` library).
- **Database:** PostgreSQL with Prisma ORM.
- **Key Files:**
    - `packages/client/src/App.tsx`: Main frontend component.
    - `packages/server/src/server.ts`: Main backend entry point and WebSocket server setup.
    - `prisma/schema.prisma`: The single source of truth for the database schema.

## 3. Coding Standards & Conventions
- **Language:** All code MUST be written in TypeScript.
- **Style:** Adhere to the rules in `.eslintrc.json`. Use Prettier for formatting.
- **Commit Messages:** Follow the Conventional Commits specification. A `/gen_commit_msg` command is available.
- **Testing:** Use Jest for all unit and integration tests. All new features must be accompanied by tests. Place test files next to the source files (`*.test.ts`).

## 4. Essential Commands
Always use these exact commands. Do not guess or improvise.

<commands>
- **Install Dependencies:** `npm install`
- **Run Frontend Dev Server:** `npm run dev --workspace=client`
- **Run Backend Dev Server:** `npm run dev --workspace=server`
- **Run All Tests:** `npm test`
- **Run Linter:** `npm run lint`
- **Format Code:** `npm run format`
- **Generate Prisma Client:** `npx prisma generate`
</commands>

## Critical Rules
- ALWAYS strive to write production ready code
- ALWAYS strive to write the minimal amount of code to achieve the task
- ALWAYS retain design patterns and principles
- NEVER write code that is not relevant to the task at hand
- When something doesn't work, debug and fix it - don't start over with a simple version