# SAT Missed Question Tracker

A GitHub Pages SAT missed-question tracker using Supabase Auth, PostgreSQL, RLS, and Chart.js.

## Files

- `index.html` — login, dashboard, add-question form, question log, graphs, and edit modal.
- `app.js` — authentication, CRUD operations, filters, recommendations, and charts.
- `config.js` — Supabase project URL and public publishable key.
- `style.css` — responsive interface styling.
- `supabase.sql` — database table, indexes, constraints, and RLS policies.

## Supabase setup

1. Create/open the Supabase project.
2. Open **SQL Editor**.
3. Paste and run `supabase.sql`.
4. In **Authentication → Providers**, enable Email.
5. In **Authentication → URL Configuration**, add the final GitHub Pages URL as the Site URL/redirect URL as appropriate.

## GitHub Pages

Push these files to the repository root and enable GitHub Pages from the repository's Pages settings. The app is static and does not need a private backend server.

## Security

`config.js` contains only the browser-safe public Supabase publishable key. Never put a Supabase service-role/secret key in frontend code. Database access is protected by Supabase Auth and Row Level Security so each authenticated user can access only their own `missed_questions` rows.

## Test

Create an account, log in, add a missed question, check the Dashboard, Question Log, and Graphs, then create a second account to confirm that accounts cannot see one another's records.
