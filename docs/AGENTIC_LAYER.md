# Agentic Layer

## Risk Levels & Actions

### Low — Auto-execute (no approval needed)
- Tag a pain point with an AI theme on submit
- Score urgency 0–100 on submit
- Generate a one-sentence change request summary on submit

### Medium — Light approval (builder confirms before apply)
- Bulk-update status of all `open` pain points in a category to `in review`
- Auto-generate a draft change request from a pain point (draft shown, not saved until confirmed)

### High — Always approval before execution
- Send a pain point summary digest to an email address
- Mark a pain point `resolved` and archive its change requests

### Critical — Human-only, never agent-executed
- Permanent deletion of any pain point or change request
- Any external API call not on the approved tool list

## Named Tools (v1)
- `tag_and_score_pain_point(pain_point_id)` — calls OpenAI, writes ai_* fields
- `summarise_change_request(change_request_id)` — calls OpenAI, writes ai_summary fields

## Audit Log Fields (every agent action)
`actor`, `action`, `object_type`, `object_id`, `detail (JSON: prompt, model, confidence)`, `created_at`

## v1 vs Later
- **v1:** low-risk tools only, triggered on form submit
- **Later:** medium/high actions with approval UI; scheduled digest emails
