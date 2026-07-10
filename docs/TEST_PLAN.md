# Test Plan

## Success Scenario (manual, run on live Vercel URL)
1. Open `/` — dashboard loads with ≥4 pain point cards. Each shows a title, severity badge, and urgency score. **Pass:** cards visible. **Fail:** blank page or console error.
2. Click a pain point card — detail page loads with the pain point fields and at least one linked change request. **Pass:** all fields shown. **Fail:** 404 or empty page.
3. Fill "Report a Pain Point" form with title="Test pain", description="This is a test", category="Bug", severity="high". Submit. **Pass:** new card appears on dashboard within 3 seconds. **Fail:** button does nothing or spinner hangs.
4. Open the new card's detail page. Fill "Add Change Request" form. Submit. **Pass:** new change request appears in the list. **Fail:** form error or silent failure.
5. Verify the new pain point card shows an AI theme chip and urgency score after creation. **Pass:** chip present. **Fail:** card shows ⚠️ with no score (acceptable only if OpenAI key is missing in env).

## Empty State
- Point to a fresh Supabase project with no seed data. Open `/`. **Pass:** "No pain points yet — report one below" message + form visible. **Fail:** error or blank.

## Error States
- Submit the pain point form with an empty title. **Pass:** inline "Title is required" error; no network call made.
- Simulate OpenAI timeout (remove API key from env). Submit a pain point. **Pass:** record saves, card appears with no score and ⚠️ icon. **Fail:** 500 error or no record saved.
- Load `/pain-points/00000000-0000-0000-0000-000000000000` (nonexistent ID). **Pass:** friendly "Pain point not found" message. **Fail:** unhandled error or blank page.

## Change Request Status Workflow
- On a change request, change status from `open` to `in review` via dropdown. Refresh the page. **Pass:** status persists as `in review`. **Fail:** reverts to `open`.

## Audit Log
- After any create action, query `audit_logs` in Supabase dashboard. **Pass:** a row exists with correct `action`, `object_type`, and `object_id`. **Fail:** table is empty.
