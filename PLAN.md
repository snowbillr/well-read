# Implementation Plan: Well Read

## Phase 1: Foundation & Design System
- [ ] **Configure Tailwind & Design System**:
    - [ ] Define "Deep Ink" color palette and Cream/Off-white backgrounds in `tailwind.config.js`.
    - [ ] Import a premium Serif font (e.g., via Google Fonts or generic serif stack) for the "Digital Stationery" vibe.
    - [ ] Create basic layout wrapper (`application.html.erb`) with the defined styling.

## Phase 2: Core Data Models
- [ ] **Book Model**:
    - [ ] Generate `Book` scaffold/model.
        - Attributes: `id:bigint`, `title:string`, `author:string`, `total_pages:integer`, `current_page:integer` (default: 0), `isbn:string`, `status:string` (enum: want_to_read, currently_reading, completed, dnf), `rating:integer`, `review_text:text`, `started_at:datetime`, `finished_at:datetime`.
    - [ ] Add validations (presence of title/author/total_pages).
    - [ ] Implement status enum and logic.
    - [ ] Configure ActiveStorage for optional Cover Image.
- [ ] **ReadingSession Model**:
    - [ ] Generate `ReadingSession` model.
        - Attributes: `id:bigint`, `book:references` (type: bigint), `duration_seconds:integer`, `pages_read:integer`, `start_time:datetime`.
    - [ ] Add associations (`Book has_many :reading_sessions`).

## Phase 3: Library Management (UI)
- [ ] **Books CRUD**:
    - [ ] Index view ("Library"): List books by status.
    - [ ] Create/Edit views: Simple, clean forms with "Digital Stationery" styling.
    - [ ] Show view: Details, stats, and "Start Session" CTA.

## Phase 4: The Reading Session (Timer)
- [ ] **Session UI & Logic**:
    - [ ] Create a "Session" view/mode for a specific book.
    - [ ] **Start Timer**: "Start" button uses Turbo to hit `ReadingSessionsController#create`.
        - [ ] Creates the `ReadingSession` record (setting `start_time`).
        - [ ] Returns a Turbo Stream to replace "Start" button with "Stop" button.
    - [ ] **Stop Timer**: "Stop" button uses Turbo to hit `ReadingSessionsController#update` (or `stop` action).
        - [ ] Calculates and saves `duration_seconds`.
        - [ ] Returns a Turbo Stream to trigger the "Session Completion" modal/form.
- [ ] **Session Completion Flow**:
    - [ ] Form Input: "Current Page" (validate it is > previous page).
    - [ ] Calculation: Derive `pages_read` (`new_current_page - previous_current_page`).
    - [ ] Submit final update to `ReadingSessionsController`.
    - [ ] Update `Book` attributes (`current_page`).
    - [ ] Reset UI to initial state via Turbo Stream.

## Phase 5: Analytics & Insights
- [ ] **Analytics Logic (Model Methods)**:
    - [ ] `Book#ppm`: (Total Pages Read / Total Minutes Read).
    - [ ] `Book#average_session_duration`.
    - [ ] `Book#estimated_completion_time`: (Remaining Pages / PPM).
    - [ ] `Book#sessions_to_finish`.
- [ ] **Dashboard/Stats View**:
    - [ ] Display these metrics on the Book Show page.
    - [ ] Implement "One-tap entry" on the Home screen for the "Currently Reading" book.

## Phase 6: Reviews & "Closing the Volume"
- [ ] **Completion Flow**:
    - [ ] Detect when `current_page >= total_pages` after a session.
    - [ ] Trigger "Closing the Volume" flow (redirect to specific view).
    - [ ] Form for Rating (1-5 stars) and Review (Markdown support).
    - [ ] Update `Book#status` to `completed` and set `finished_at`.

## Phase 7: Polish & Refinement
- [ ] **PWA Configuration**:
    - [ ] Ensure icons/manifest are set up for "Add to Home Screen".
- [ ] **UI Polish**:
    - [ ] Verify "Digital Stationery" look (padding, typography, colors).
    - [ ] Refine empty states and transitions.
