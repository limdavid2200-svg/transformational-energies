create table if not exists pain_points (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  title text not null,
  description text,
  category text,
  severity text default 'medium',
  status text default 'open',
  ai_theme text,
  ai_theme_source text,
  ai_theme_confidence numeric,
  ai_theme_review_status text default 'unreviewed',
  ai_urgency_score numeric,
  ai_urgency_score_source text,
  ai_urgency_score_confidence numeric,
  ai_urgency_score_review_status text default 'unreviewed'
);

alter table pain_points enable row level security;
drop policy if exists "pain_points_v1_read" on pain_points;
create policy "pain_points_v1_read" on pain_points for select using (true);
drop policy if exists "pain_points_v1_write" on pain_points;
create policy "pain_points_v1_write" on pain_points for all using (true) with check (true);

create table if not exists change_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  pain_point_id uuid references pain_points(id) on delete cascade,
  title text not null,
  description text,
  status text default 'open',
  priority text default 'medium',
  ai_summary text,
  ai_summary_source text,
  ai_summary_confidence numeric,
  ai_summary_review_status text default 'unreviewed'
);

alter table change_requests enable row level security;
drop policy if exists "change_requests_v1_read" on change_requests;
create policy "change_requests_v1_read" on change_requests for select using (true);
drop policy if exists "change_requests_v1_write" on change_requests;
create policy "change_requests_v1_write" on change_requests for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  actor text,
  action text not null,
  object_type text not null,
  object_id uuid,
  detail jsonb
);

alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into pain_points (id, title, description, category, severity, status, ai_theme, ai_theme_source, ai_theme_confidence, ai_theme_review_status, ai_urgency_score, ai_urgency_score_source, ai_urgency_score_confidence, ai_urgency_score_review_status)
values
  ('a1000000-0000-0000-0000-000000000001', 'Onboarding takes too long', 'New users spend 45+ minutes completing setup before they can use core features. Drop-off is high.', 'UX', 'high', 'open', 'Onboarding Friction', 'gpt-4o', 0.91, 'unreviewed', 87, 'gpt-4o', 0.88, 'unreviewed'),
  ('a1000000-0000-0000-0000-000000000002', 'Export to CSV is broken for large datasets', 'Exporting more than 500 rows silently fails with no error shown to the user.', 'Bug', 'critical', 'open', 'Data Export', 'gpt-4o', 0.95, 'unreviewed', 94, 'gpt-4o', 0.93, 'unreviewed'),
  ('a1000000-0000-0000-0000-000000000003', 'No dark mode support', 'Multiple users have requested dark mode. Currently there is no toggle or system preference detection.', 'Accessibility', 'low', 'open', 'Accessibility & Display', 'gpt-4o', 0.82, 'unreviewed', 41, 'gpt-4o', 0.80, 'unreviewed'),
  ('a1000000-0000-0000-0000-000000000004', 'Search results are not ranked by relevance', 'The search feature returns results in creation order, not by relevance. Users miss the best matches.', 'Search', 'medium', 'open', 'Search Quality', 'gpt-4o', 0.89, 'unreviewed', 68, 'gpt-4o', 0.87, 'unreviewed');

insert into change_requests (pain_point_id, title, description, status, priority, ai_summary, ai_summary_source, ai_summary_confidence, ai_summary_review_status)
values
  ('a1000000-0000-0000-0000-000000000001', 'Streamline onboarding to 3 steps', 'Reduce required fields at signup; move optional setup to a post-activation checklist.', 'in review', 'high', 'Collapse onboarding to essential fields only; defer optional config.', 'gpt-4o', 0.90, 'unreviewed'),
  ('a1000000-0000-0000-0000-000000000002', 'Fix CSV export for 500+ rows', 'Add server-side pagination for export and surface an error state when export fails.', 'open', 'critical', 'Paginate export server-side; add visible error feedback on failure.', 'gpt-4o', 0.94, 'unreviewed'),
  ('a1000000-0000-0000-0000-000000000003', 'Add dark mode toggle', 'Implement system preference detection and a manual override toggle in user settings.', 'open', 'low', 'Detect system dark preference; add manual toggle in settings.', 'gpt-4o', 0.83, 'unreviewed'),
  ('a1000000-0000-0000-0000-000000000004', 'Rank search by relevance score', 'Integrate full-text search scoring so top matches appear first.', 'open', 'medium', 'Replace creation-order sort with relevance scoring in search.', 'gpt-4o', 0.88, 'unreviewed');