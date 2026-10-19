# E2E manual PulsePass (Postman)
1. Base pulsepass_e2e + app arrancada (Flyway) + fixtures/seed-e2e.sql (con -v admin_pass, staff_pass, inactive_pass).
2. App en :8080 con su propio PULSEPASS_JWT_SECRET_BASE64 de E2E y DB_URL a pulsepass_e2e.
3. Postman: importar postman/*.json y elegir el ambiente PulsePass-local.
4. Llenar variables como Current value. Contraseñas y tokens nunca se exportan ni se versionan.
5. Seguir checklist-e2e-manual.md. Un Send por request, sin Runner, sin scripts.
6. Tras cada login, copiar accessToken a userAToken / userBToken / staffToken / adminToken. Dura 15 min.
7. Copiar los códigos devueltos: artistId, ticketCancelableCode, ticketUsableCode.
8. Anotar en registro-ejecucion-manual.md: PASS / FAIL / BLOCKED. Un 200 solo no es PASS: revisar el JSON.
9. Si falta un prerrequisito, marcar BLOCKED, no PASS.
