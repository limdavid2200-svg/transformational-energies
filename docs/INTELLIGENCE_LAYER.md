# Intelligence Layer

## Messy Input
Free-text title and description from a non-technical user: e.g. "the export thing is totally broken when I have lots of data and nothing happens"

## Auto-Structure Schema (on pain point save)
```json
{
  "ai_theme": "Data Export",
  "ai_theme_source": "gpt-4o",
  "ai_theme_confidence": 0.95,
  "ai_theme_review_status": "unreviewed",
  "ai_urgency_score": 91,
  "ai_urgency_score_source": "gpt-4o",
  "ai_urgency_score_confidence": 0.89,
  "ai_urgency_score_review_status": "unreviewed"
}
```

## Events That Trigger AI
- Pain point created → theme classification + urgency scoring
- Change request created → one-sentence AI summary

## Scoring Rules (v1 — rule-based prompt, not ML)
- Urgency 0–100 derived from: severity label weight + description keywords ("broken", "crash", "data loss" = high) + category weight
- Confidence < 0.75 → card shows ⚠️ "needs review" indicator

## What Gets Ranked
- Dashboard default sort: `ai_urgency_score DESC NULLS LAST`
- Secondary sort: `created_at DESC`

## v1 vs Later
- **v1:** GPT-4o prompt → structured JSON → stored fields
- **Later:** fine-tuned classifier; trend analysis across themes over time; anomaly detection on sudden score spikes
