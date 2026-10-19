CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO venues (code, name, city, address, capacity, active)
VALUES ('E2E-VEN-01', 'Venue E2E', 'Ciudad E2E', 'Direccion E2E 123', 5000, TRUE);

INSERT INTO events (event_code, name, description, category, status, event_date, minimum_age, venue_id)
SELECT e.code, e.name, 'Fixture E2E', 'MUSIC', e.status, now() + interval '6 months', 0, v.id
FROM venues v,
     (VALUES ('E2E-PUB-01',   'E2E publicado',    'PUBLISHED'),
             ('E2E-DRAFT-01', 'E2E borrador',     'DRAFT'),
             ('E2E-TOPUB-01', 'E2E por publicar', 'DRAFT')) AS e(code, name, status)
WHERE v.code = 'E2E-VEN-01';

WITH u AS (
    INSERT INTO users (username, email, active) VALUES
        ('e2e_admin',    'admin.e2e@example.test',    TRUE),
        ('e2e_staff',    'staff.e2e@example.test',    TRUE),
        ('e2e_inactive', 'inactive.e2e@example.test', FALSE)
    RETURNING id, username
), p AS (
    INSERT INTO user_profiles (user_id, first_name, last_name, birth_date)
    SELECT id, 'E2E', initcap(split_part(username, '_', 2)), DATE '1990-01-01' FROM u
), c AS (
    INSERT INTO user_credentials (user_id, password_hash, password_changed_at)
    SELECT id,
           crypt(CASE username WHEN 'e2e_admin' THEN :'admin_pass'
                               WHEN 'e2e_staff' THEN :'staff_pass'
                               ELSE :'inactive_pass' END, gen_salt('bf', 10)),
           now()
    FROM u
)
INSERT INTO user_roles (user_id, role)
SELECT id, CASE username WHEN 'e2e_admin' THEN 'ADMIN'
                         WHEN 'e2e_staff' THEN 'STAFF'
                         ELSE 'USER' END
FROM u;