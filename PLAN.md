# Implementation Plan: Well Read

## Phase 1: Foundation & Design System
- [x] **Configure Tailwind & Design System**:
    - [x] Define "Deep Ink" color palette and Cream/Off-white backgrounds in `tailwind.config.js` (CSS variables in application.css).
    - [x] Import a premium Serif font (e.g., via Google Fonts or generic serif stack) for the "Digital Stationery" vibe.
    - [x] Create basic layout wrapper (`application.html.erb`) with the defined styling.

## Phase 2: Core Data Models
- [x] **Book Model**:
    - [x] Generate `Book` scaffold/model.
        - Attributes: `id:bigint`, `title:string`, `author:string`, `total_pages:integer`, `current_page:integer` (default: 0), `status:string` (enum: want_to_read, currently_reading, completed, dnf), `rating:integer`, `review_text:text`, `started_at:datetime`, `finished_at:datetime`.
    - [x] Add validations (presence of title/author/total_pages).
    - [x] Implement status enum and logic.
    - [x] Configure ActiveStorage for optional Cover Image. (Skipped for MVP focus)
- [x] **ReadingSession Model**:
    - [x] Generate `ReadingSession` model.
        - Attributes: `id:bigint`, `book:references` (type: bigint), `duration_seconds:integer`, `pages_read:integer`, `start_time:datetime`.
    - [x] Add associations (`Book has_many :reading_sessions`).

## Phase 3: Library Management (UI)
- [x] **Books CRUD**:
    - [x] Index view ("Library"): List books by status.
    - [x] Create/Edit views: Simple, clean forms with "Digital Stationery" styling.
    - [x] Show view: Details, stats, and "Start Session" CTA.

## Phase 4: The Reading Session (Timer)
- [x] **Session UI & Logic**:
    - [x] Create a "Session" view/mode for a specific book.
    - [x] **Start Timer**: "Start" button uses Turbo to hit `ReadingSessionsController#create`.
        - [x] Creates the `ReadingSession` record (setting `start_time`).
        - [x] Returns a Turbo Stream to replace "Start" button with "Stop" button.
    - [x] **Stop Timer**: "Stop" button uses Turbo to hit `ReadingSessionsController#update` (or `stop` action).
        - [x] Calculates and saves `duration_seconds`.
        - [x] Returns a Turbo Stream to trigger the "Session Completion" modal/form.
- [x] **Session Completion Flow**:
    - [x] Form Input: "Current Page" (validate it is > previous page).
    - [x] Calculation: Derive `pages_read` (`new_current_page - previous_current_page`).
    - [x] Submit final update to `ReadingSessionsController`.
    - [x] Update `Book` attributes (`current_page`).
    - [x] Reset UI to initial state via Turbo Stream.

## Phase 5: Analytics & Insights
- [x] **Analytics Logic (Model Methods)**:
    - [x] `Book#ppm`: (Total Pages Read / Total Minutes Read).
    - [x] `Book#average_session_duration`.
    - [x] `Book#estimated_completion_time`: (Remaining Pages / PPM).
    - [x] `Book#sessions_to_finish`. (Implied by estimated completion)
- [x] **Dashboard/Stats View**:
    - [x] Display these metrics on the Book Show page.
    - [x] Implement "One-tap entry" on the Home screen for the "Currently Reading" book.

## Phase 6: Reviews & "Closing the Volume"
- [x] **Completion Flow**:
    - [x] Detect when `current_page >= total_pages` after a session.
    - [x] Trigger "Closing the Volume" flow (redirect to specific view). (Handled via Turbo replacement showing Review link)
    - [x] Form for Rating (1-5 stars) and Review (Markdown support).
    - [x] Update `Book#status` to `completed` and set `finished_at`.

## Phase 7: Polish & Refinement
- [x] **PWA Configuration**:
    - [x] Ensure icons/manifest are set up for "Add to Home Screen".
- [x] **UI Polish**:
    - [x] Verify "Digital Stationery" look (padding, typography, colors).
    - [x] Refine empty states and transitions.