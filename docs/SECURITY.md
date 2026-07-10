# Security

## Secret Handling
- `OPENAI_API_KEY` and `SUPABASE_SERVICE_ROLE_KEY` stored in Vercel environment variables only
- Never referenced in any client component or exposed in API responses
- All AI calls made from Next.js API routes (server-side only)

## Permission Model (v1 — demo phase)
- Supabase RLS: open read + write policies so the app is demoable without login
- No user data is sensitive in the demo phase — all rows are illustrative
- Lock-down sprint replaces policies with `auth.uid() = user_id` checks

## Lock-Down Sprint Checklist
- [ ] Replace v1 RLS policies with owner-scoped policies on every table
- [ ] Supabase anon key stays in the client; service role key is server-only
- [ ] Auth flows (login/signup) guard all write paths

## Approved Tools Rule
- Agent may only call `tag_and_score_pain_point` and `summarise_change_request`
- No `run_any`, `eval`, or dynamic tool construction permitted
- Any new tool requires explicit addition to the approved list and a code review

## Audit Principle
Every create, update, and delete — whether by a human or the AI agent — writes a row to `audit_logs` with actor, action, object, and timestamp. Audit rows are append-only; no delete policy is granted.
