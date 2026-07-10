# PRD — Transformational Energies

## Problem
A professional developer needs a live, deployed app they can point employers to in an interview — something that shows real data, real AI integration, and real CRUD, not a to-do list clone.

## Target User
One professional individual (the builder) demoing to recruiters and hiring managers.

## Core Objects
- **Pain Point** — a problem captured with title, description, category, severity, status, and AI-generated theme + urgency score.
- **Change Request** — a proposed solution linked to a pain point, with its own status, priority, and AI-generated summary.
- **Audit Log** — every meaningful create/update/delete recorded with actor, action, and timestamp.

## MVP Must-Haves (v1)
- [ ] Submit a new pain point via form; record persists to database
- [ ] Submit a change request linked to a pain point; record persists
- [ ] Dashboard lists all pain points with severity badge, AI urgency score, and status
- [ ] Detail view shows a pain point and its change requests
- [ ] AI auto-tags theme and scores urgency on every new pain point save
- [ ] AI confidence and review status stored alongside every AI field
- [ ] App loads with seed data — no login required to view
- [ ] All screens handle loading, empty, error, and ready states

## Non-Goals (v1)
- Multi-user accounts, teams, or sharing
- Email/Slack notifications
- Voting or upvoting
- Auth / login wall (scheduled for Sprint 4)

## Success Criteria
**A recruiter opens the live URL, sees a populated dashboard of pain points with AI urgency scores, clicks one, reads its change requests, submits a new pain point using the form, and sees it appear on the dashboard — all within 30 seconds, without creating an account.**

### Definition of Done
Pass: the end-to-end scenario above completes on the deployed Vercel URL with data persisting across page refreshes. Fail: any step shows a dead button, blank screen, or console error.
