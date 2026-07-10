# Data Model

## pain_points
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner-scoping at lock-down |
| created_at | timestamptz | default now() |
| title | text NOT NULL | |
| description | text | |
| category | text | e.g. UX, Bug, Accessibility |
| severity | text | low / medium / high / critical |
| status | text | open / in review / resolved |
| ai_theme | text | AI-generated |
| ai_theme_source | text | e.g. "gpt-4o" |
| ai_theme_confidence | numeric | 0.0–1.0 |
| ai_theme_review_status | text | unreviewed / approved / rejected |
| ai_urgency_score | numeric | 0–100, AI-generated |
| ai_urgency_score_source | text | |
| ai_urgency_score_confidence | numeric | |
| ai_urgency_score_review_status | text | |

## change_requests
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| pain_point_id | uuid FK → pain_points.id | CASCADE delete |
| title | text NOT NULL | |
| description | text | |
| status | text | open / in review / resolved |
| priority | text | low / medium / high / critical |
| ai_summary | text | AI-generated |
| ai_summary_source | text | |
| ai_summary_confidence | numeric | |
| ai_summary_review_status | text | |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| actor | text | "anonymous" pre-auth |
| action | text | create / update / delete |
| object_type | text | pain_point / change_request |
| object_id | uuid | |
| detail | jsonb | diff or context |

## RLS
- All tables: v1 open policies (select + all). Replaced with `auth.uid() = user_id` at lock-down sprint.
