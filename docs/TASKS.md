# Tasks

## Sprint 1 — Database + Core Engine ✦ v1 functional milestone
**Goal:** Pain point submit + display works end-to-end against the live database. No login required.

- [ ] Run migration SQL: create `pain_points`, `change_requests`, `audit_logs`; seed 4 demo rows each
- [ ] Confirm RLS open policies active on all three tables
- [ ] Build `/` dashboard page (server component): fetch and display all pain_points sorted by urgency
- [ ] Pain point card component: title, category badge, severity badge, status, urgency score
- [ ] Loading state (skeleton cards), empty state ("No pain points yet — report one below"), error state (banner)
- [ ] "Report a Pain Point" form: title, description, category select, severity select
- [ ] POST `/api/pain-points`: validate → insert to Supabase → write audit_log row → return created record
- [ ] On success: router.refresh() so new card appears without full reload
- [ ] Build `/pain-points/[id]` detail page: pain point fields + linked change requests list
- [ ] "Add Change Request" form on detail page: title, description, priority select
- [ ] POST `/api/change-requests`: validate → insert → audit_log → return
- [ ] All form fields show inline validation errors; submit button disabled during request
- [ ] Definition of Done: submit a pain point on the live Vercel URL → it appears on the dashboard after refresh; navigate to detail → change request form saves and appears in the list

## Sprint 2 — AI Intelligence Layer
**Goal:** Every new pain point and change request is auto-tagged and scored by AI on save.

- [ ] In `/api/pain-points` POST handler, after insert call `tag_and_score_pain_point(id)`
- [ ] OpenAI call returns `{ theme, urgency_score, confidence }`; update row with all ai_* fields
- [ ] If OpenAI call fails, log error, leave ai_* fields null — do not block the response
- [ ] In `/api/change-requests` POST handler, call `summarise_change_request(id)` after insert
- [ ] Dashboard cards show AI theme chip and urgency score badge
- [ ] Cards with `confidence < 0.75` show ⚠️ icon with tooltip "AI confidence low — review suggested"
- [ ] Dashboard "Sort by urgency" is the default; add toggle to sort by newest
- [ ] Definition of Done: submit a pain point → within 3 seconds the card reloads with a theme chip and urgency score; a forced OpenAI failure leaves the card visible with null score and no crash

## Sprint 3 — Polish & Portfolio Presentation
**Goal:** App is visually sharp, every edge case is handled, and it's deployed with a live URL.

- [ ] Responsive layout (mobile + desktop) with consistent spacing and type scale
- [ ] Status workflow on change requests: open → in review → resolved via dropdown; PATCH `/api/change-requests/[id]`
- [ ] Review all loading / empty / error states across every screen — no blank white pages
- [ ] Add recruiter-facing hero copy on dashboard header: one sentence explaining what the app does
- [ ] In-app "About this project" panel: tech stack, AI features, source code link
- [ ] Confirm Vercel deployment; smoke-test the full success scenario on the live URL
- [ ] Definition of Done: the 30-second recruiter demo (open URL → see data → submit pain point → see it ranked) works on the live URL on both desktop and mobile

## Sprint 4 — Lock It Down (Auth + Per-User Isolation)
**Goal:** Real users can sign up; data is private and owner-scoped.

- [ ] Enable Supabase Auth (email/password); build `/login` and `/signup` pages
- [ ] Replace v1 RLS policies with `auth.uid() = user_id` on all tables
- [ ] Set `user_id` on every insert from `supabase.auth.getUser()`
- [ ] Write operations require authenticated session; reads on `/` remain public for demo rows
- [ ] Audit log `actor` field set to `auth.uid()` when logged in
- [ ] Definition of Done: two browser sessions with different accounts see only their own records; unauthenticated POST to `/api/pain-points` is rejected with 401

## Gantt
```
Week 1  |-- Sprint 1 (DB + Core Engine) --|-- Sprint 2 (AI Layer) --|
Week 2  |-- Sprint 3 (Polish + Deploy) --|-- Sprint 4 (Auth Lock-Down) --|
```
