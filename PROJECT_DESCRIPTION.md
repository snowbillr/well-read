Objective: Create a sophisticated, minimal reading companion for casual readers to archive their library, track time-based reading sessions, and gain insights into their reading habits through predictive analytics.

1. User Experience & Design Philosophy

    Vibe: "Digital Stationery." The app should feel premium, tactile, and calm.

    Design Cues: High-end print typography (Serifs), plenty of white space (Cream/Off-white backgrounds), and a "Deep Ink" color palette.

    Core Interaction: One-tap entry. The user should be able to start a reading session with a single click from the home screen.

2. Core Functional Requirements
A. Library Management

    Entity: Book

    Attributes: Title, Author, Total Pages, Cover Image (optional).

    Status Tracking: Books should be categorized as Want to Read, Currently Reading, Completed, or DNF (did not finish).

    Completion Data: Store Date Started and Date Finished.

B. Reading Session Tracking (The Timer)

    Logic: A stopwatch that records duration in seconds.

    Workflow:

        Select Book → Start Timer.

        Stop Timer → Prompt for "Current Page".

        Calculate and store ReadingSession object linked to the Book.

    Resilience: Timer state must persist if the app is closed or refreshed during a session.

C. Insights & Predictive Analytics

The engineer must implement the following logic based on reading session history:

    PPM (Pages Per Minute): Total Pages Read​ / Total Minutes Read.

    Average Session: Mean duration of all sessions for a specific book.

    The "Well Read" Predictor: * Remaining Pages÷PPM=Estimated Minutes to Completion.

        Est. Minutes÷Avg. Session Duration=Sessions to Finish.

D. Reviews & Ratings

    Upon reaching the total page count, trigger a "Closing the Volume" flow.

    Rating: 1–5 stars (or half-stars).

    Review: Markdown-supported text area for "Final Thoughts."

3. Data Schema (Entity Relationship)
Table: Books	Table: Reading Sessions
id (UUID)	id (UUID)
title (String)	book_id (FK)
author (String)	start_time (Timestamp)
total_pages (Int)	duration_seconds (Int)
current_page (Int)	pages_read (Int)
rating (Int 1-5)	date (Date)
review_text (Text)
