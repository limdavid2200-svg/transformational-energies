# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router) — deployed on Vercel
- **Database + Auth:** Supabase (Postgres + RLS + Auth)
- **AI:** OpenAI GPT-4o via server-side API route (key never in client bundle)
- **Styling:** Tailwind CSS

## Now vs Later
**Now:** pain point form → DB → AI tagging → dashboard display → change request form → DB
**Later:** auth + per-user isolation, voting, notifications, trend analysis

## Key User Action — Step by Step
1. Visitor opens `/` — Next.js fetches all `pain_points` from Supabase (server component)
2. Dashboard renders cards sorted by `ai_urgency_score` desc
3. Visitor fills the "Report a Pain Point" form and submits
4. Next.js API route `/api/pain-points` validates input, inserts row into `pain_points`
5. Same route calls OpenAI with the title + description; receives theme + urgency score
6. Updates the row with AI fields (value, source, confidence, review_status)
7. Client router refreshes — new card appears at correct rank on the dashboard
8. Every insert is also written to `audit_logs`

## Layer Plan
1. **Data layer first** — tables, constraints, RLS, seed rows
2. **App logic** — forms, API routes, status transitions; works with AI disabled
3. **AI on top** — theme tagging + urgency scoring add value but are non-blocking

## Core Without AI
If the OpenAI call fails, the pain point still saves with `ai_urgency_score = null` and `review_status = 'unreviewed'`. The dashboard renders the card without a score badge. No data is lost.
