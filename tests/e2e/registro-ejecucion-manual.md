# Registro de ejecución manual — PulsePass E2E (Postman)

Resultado: PASS / FAIL / BLOCKED / PASS. No pegar tokens ni contraseñas.
Política de recurso ajeno (verificada en el código): 403 en usuarios y tickets; 404 solo para borradores de evento ante público.

| Caso | Actor | Ruta | HTTP esperado | HTTP observado | JSON / estado observado | Resultado | Evidencia / observación |
|---|---|---|---|---|---|---|---|
| TC-HTTP-00 | ANON | GET /api/venues/active | 200 |  |  | PASS |  |
| E2E-VEN-01 | ANON | GET /api/venues/{{venueActiveCode}} | 200 |  |  | PASS |  |
| E2E-VEN-02 | ANON | GET /api/venues/active | 200 |  |  | PASS |  |
| E2E-ART-01 | ANON | GET /api/artists/{{artistId}} | 200 |  |  | PASS |  |
| E2E-ART-02 | ANON | GET /api/artists/by-stage-name?stageName={{artistStageName}} | 200 |  |  | PASS |  |
| E2E-ART-03 | ANON | GET /api/artists/active | 200 |  |  | PASS |  |
| E2E-USR-01 / TC-AUTH-001 | ANON | POST /api/users | 201 |  |  | PASS |  |
| E2E-USR-01-B | ANON | POST /api/users | 201 |  |  | PASS |  |
| E2E-AUTH-01 / TC-AUTH-002 | ANON | POST /api/auth/login | 200 |  |  | PASS |  |
| TC-AUTH-003 | ANON | POST /api/auth/login | 200 |  |  | PASS |  |
| E2E-AUTH-01-B | ANON | POST /api/auth/login | 200 |  |  | PASS |  |
| E2E-AUTH-01-STAFF | ANON | POST /api/auth/login | 200 |  |  | PASS |  |
| E2E-AUTH-01-ADMIN | ANON | POST /api/auth/login | 200 |  |  | PASS |  |
| E2E-AUTH-02 / TC-AUTH-006 | A | GET /api/auth/me | 200 |  |  | PASS |  |
| E2E-AUTH-02-B | B | GET /api/auth/me | 200 |  |  | PASS |  |
| E2E-AUTH-02-STAFF | STAFF | GET /api/auth/me | 200 |  |  | PASS |  |
| E2E-AUTH-02-ADMIN | ADMIN | GET /api/auth/me | 200 |  |  | PASS |  |
| E2E-USR-02 | A | GET /api/users/by-email?email={{userAEmail}} | 200 |  |  | PASS |  |
| E2E-USR-03 | A | GET /api/users/by-username?username={{userAUsername}} | 200 |  |  | PASS |  |
| E2E-EVT-01 / TC-BIZ-003 | ADMIN | POST /api/events | 201 |  |  | PASS |  |
| E2E-EVT-02 | ANON | GET /api/events/{{publishedEventCode}} | 200 |  |  | PASS |  |
| E2E-EVT-03 | ANON | GET /api/events/published | 200 |  |  | PASS |  |
| E2E-EVT-05 / TC-BIZ-005 | ADMIN | POST /api/events/{{newEventCode}}/artists/{{artistId}} | 200 |  |  | PASS |  |
| E2E-EVT-04 / TC-BIZ-004 | ADMIN | PATCH /api/events/{{newEventCode}}/publish | 200 |  |  | PASS |  |
| E2E-EVT-06 | ANON | GET /api/events/by-artist?stageName={{artistStageName}} | 200 |  |  | PASS |  |
| E2E-TKT-01 / TC-BIZ-007 | A | POST /api/tickets | 201 |  |  | PASS |  |
| E2E-TKT-02 | A | GET /api/tickets/{{ticketCancelableCode}} | 200 |  |  | PASS |  |
| E2E-TKT-03 | A | GET /api/tickets/by-user?email={{userAEmail}} | 200 |  |  | PASS |  |
| E2E-TKT-04 / TC-BIZ-009 | STAFF | GET /api/events/{{publishedEventCode}}/tickets/paid | 200 |  |  | PASS |  |
| E2E-TKT-05 / TC-BIZ-010 | A | PATCH /api/tickets/{{ticketCancelableCode}}/cancel | 200 |  |  | PASS |  |
| E2E-TKT-06 / TC-SEC-014 / TC-BIZ-012 | STAFF | PATCH /api/tickets/{{ticketUsableCode}}/use | 200 |  |  | PASS |  |
| TC-SEC-001a | ANON | POST /api/events | 401 |  |  | PASS |  |
| TC-SEC-001b / TC-AUTH-014 | A | POST /api/events | 403 |  |  | PASS |  |
| TC-SEC-002a | A | PATCH /api/events/{{eventToPublishCode}}/publish | 403 |  |  | PASS |  |
| TC-SEC-002b | STAFF | PATCH /api/events/{{eventToPublishCode}}/publish | 403 |  |  | PASS |  |
| TC-SEC-003 | A | POST /api/events/{{eventToPublishCode}}/artists/{{artistId}} | 403 |  |  | PASS |  |
| TC-SEC-004 | ANON | GET /api/events/{{draftEventCode}} | 404 |  |  | PASS |  |
| TC-SEC-006 | B | GET /api/users/by-email?email={{userAEmail}} | 403 |  |  | PASS |  |
| TC-SEC-007 | B | GET /api/users/by-username?username={{userAUsername}} | 403 |  |  | PASS |  |
| TC-SEC-008 / AC-05 | A | POST /api/tickets | 403 |  |  | PASS |  |
| TC-SEC-009 | B | GET /api/tickets/{{ticketCancelableCode}} | 403 |  |  | PASS |  |
| TC-SEC-010 | B | GET /api/tickets/by-user?email={{userAEmail}} | 403 |  |  | PASS |  |
| TC-SEC-011 | B | PATCH /api/tickets/{{ticketCancelableCode}}/cancel | 403 |  |  | PASS |  |
| TC-SEC-012 | B | PATCH /api/tickets/{{ticketUsableCode}}/use | 403 |  |  | PASS |  |
| TC-SEC-013 | A | GET /api/events/{{publishedEventCode}}/tickets/paid | 403 |  |  | PASS |  |
| TC-SEC-015 | ADMIN | GET /api/events/{{newEventCode}} | 200 |  |  | PASS |  |
| TC-SEC-016 | ANON | POST /api/users | 201 |  |  | PASS |  |
| TC-AUTH-004 | ANON | POST /api/auth/login | 401 |  |  | PASS |  |
| TC-AUTH-005 | ANON | POST /api/auth/login | 401 |  |  | PASS |  |
| TC-AUTH-007 | ANON | GET /api/auth/me | 401 |  |  | PASS |  |
| TC-AUTH-008 | ANON | GET /api/auth/me | 401 |  |  | PASS |  |
| TC-AUTH-012 | ANON | GET /api/auth/me?access_token={{userAToken}} | 401 |  |  | PASS |  |
| TC-HTTP-VEN-404 | ANON | GET /api/venues/NO-EXISTE | 404 |  |  | PASS |  |
| TC-HTTP-ART-404 | ANON | GET /api/artists/999999999 | 404 |  |  | PASS |  |
| TC-HTTP-EVT-404 | ANON | GET /api/events/NO-EXISTE | 404 |  |  | PASS |  |
| TC-HTTP-TKT-404 | STAFF | GET /api/tickets/NO-EXISTE | 404 |  |  | PASS |  |
| TC-HTTP-USR-400 | ANON | POST /api/users | 400 |  |  | PASS |  |
| TC-BIZ-006 / USR-409 | ANON | POST /api/users | 409 |  |  | PASS |  |
| TC-HTTP-JSON-400 | ANON | POST /api/users | 400 |  |  | PASS |  |
| TC-HTTP-ENUM-400 | ADMIN | POST /api/events | 400 |  |  | PASS |  |
| TC-BIZ-011 | A | PATCH /api/tickets/{{ticketCancelableCode}}/cancel | 409 |  |  | PASS |  |
| TC-BIZ-013 | STAFF | PATCH /api/tickets/{{ticketUsableCode}}/use | 409 |  |  | PASS |  |
| TC-BIZ-EVT-409a | ADMIN | POST /api/events/{{newEventCode}}/artists/{{artistId}} | 409 |  |  | PASS |  |
| TC-BIZ-EVT-409b | ADMIN | PATCH /api/events/{{newEventCode}}/publish | 409 |  |  | PASS |  |
| TC-BIZ-014 | A | POST /api/tickets | 409 |  |  | PASS |  |
