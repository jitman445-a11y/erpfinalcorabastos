
ERP Corabastos — ZIP final conectado a Supabase (index modified)

What is included
- index.html (updated to use your Supabase URL & anon key)
- schema.sql (SQL script to create necessary tables in Supabase)
- README (this file)

Important notes
1) You MUST run the SQL in 'schema.sql' in your Supabase project's SQL editor (https://app.supabase.com) BEFORE using the app.
   - The anon key cannot create tables; run SQL using the Supabase SQL editor as a project admin.

2) Security
   - The file contains the Supabase anon key (public). Do NOT put your service_role key anywhere in the frontend.
   - anon key is okay for client usage but keep project access secure.

3) How to deploy
   - Run schema.sql in Supabase SQL Editor.
   - Upload the ZIP contents to GitHub Pages (or any static host).
   - Open index.html in browser; the app will connect to Supabase.

4) If you want, I can automatically run the SQL and verify (requires service_role key access or direct access to your Supabase project).

Files in this package:
- index.html      (main frontend)
- schema.sql      (DB schema for Supabase)
