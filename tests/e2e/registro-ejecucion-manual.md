# Registro de ejecución manual — PulsePass E2E (Postman)

Resultado: PASS / FAIL / BLOCKED. No pegar tokens ni contraseñas.
Política de recurso ajeno: 403 en usuarios y tickets; 404 para borradores de evento ante público.

| Caso | Actor | Ruta | HTTP esperado | HTTP observado | JSON / estado observado | Resultado | Evidencia / observación |
|---|---|---|---|---|---|---|---|
| TC-HTTP-00 | ANON | GET /api/venues/active | 200 | 200 | JSON array con venues activos | PASS | Conectividad OK en puerto 8080. Status nominal. |
| E2E-VEN-01 | ANON | GET /api/venues/{{venueActiveCode}} | 200 | 200 | JSON con code E2E-VEN-01 y aforo 5000 | PASS | Venue E2E-VEN-01 recuperado satisfactoriamente. |
| E2E-VEN-02 | ANON | GET /api/venues/active | 200 | 200 | Array de venues con active true | PASS | Lista de venues activos obtenida en JSON. |
| E2E-ART-01 | ANON | GET /api/artists/{{artistId}} | 200 | 200 | JSON con artistId 1 | PASS | Artista obtenido por ID numérico 1 en path param. |
| E2E-ART-02 | ANON | GET /api/artists/by-stage-name?stageName={{artistStageName}} | 200 | 200 | JSON con stageName Solar Beat | PASS | Artista obtenido por stageName Solar Beat via query param. |
| E2E-ART-03 | ANON | GET /api/artists/active | 200 | 200 | Array de 5 artistas activos | PASS | Catálogo recuperado; confirmado Solar Beat id=1. |
| E2E-USR-01 / TC-AUTH-001 | ANON | POST /api/users | 201 | 201 | JSON con username usera_run01 | PASS | Usuario usera_run01 registrado con éxito. |
| E2E-USR-01-B | ANON | POST /api/users | 201 | 201 | JSON con username userb_run01 | PASS | Usuario userb_run01 registrado con éxito. |
| E2E-AUTH-01 / TC-AUTH-002 | ANON | POST /api/auth/login | 200 | 200 | JSON con accessToken y expiresIn 900 | PASS | Login exitoso con username; token guardado en userAToken. |
| TC-AUTH-003 | ANON | POST /api/auth/login | 200 | 200 | JSON con accessToken | PASS | Login exitoso con email usera.run01@example.test. |
| E2E-AUTH-01-B | ANON | POST /api/auth/login | 200 | 200 | JSON con accessToken y expiresIn 900 | PASS | Login userb_run01 exitoso; token guardado en userBToken. |
| E2E-AUTH-01-STAFF | ANON | POST /api/auth/login | 200 | 200 | JSON con accessToken de STAFF | PASS | Login e2e_staff exitoso con credencial de seed. |
| E2E-AUTH-01-ADMIN | ANON | POST /api/auth/login | 200 | 200 | JSON con accessToken de ADMIN | PASS | Login e2e_admin exitoso con credencial de seed. |
| E2E-AUTH-02 / TC-AUTH-006 | A | GET /api/auth/me | 200 | 200 | username usera_run01, roles [USER] | PASS | Endpoint /me responde rol USER verificado. |
| E2E-AUTH-02-B | B | GET /api/auth/me | 200 | 200 | username userb_run01, roles [USER] | PASS | Endpoint /me responde rol USER verificado. |
| E2E-AUTH-02-STAFF | STAFF | GET /api/auth/me | 200 | 200 | username e2e_staff, roles [STAFF] | PASS | Endpoint /me responde rol STAFF verificado. |
| E2E-AUTH-02-ADMIN | ADMIN | GET /api/auth/me | 200 | 200 | username e2e_admin, roles [ADMIN] | PASS | Endpoint /me responde rol ADMIN verificado. |
| E2E-USR-02 | A | GET /api/users/by-email?email={{userAEmail}} | 200 | 200 | JSON con perfil de USER_A | PASS | Perfil propio consultado por email con Bearer token. |
| E2E-USR-03 | A | GET /api/users/by-username?username={{userAUsername}} | 200 | 200 | JSON con perfil de USER_A | PASS | Perfil propio consultado por username con Bearer token. |
| E2E-EVT-01 / TC-BIZ-003 | ADMIN | POST /api/events | 201 | 201 | JSON con status DRAFT, code E2E-NEW-run01 | PASS | Evento creado en borrador por ADMIN. |
| E2E-EVT-02 | ANON | GET /api/events/{{publishedEventCode}} | 200 | 200 | JSON con status PUBLISHED | PASS | Detalle de evento publicado consultado públicamente. |
| E2E-EVT-03 | ANON | GET /api/events/published | 200 | 200 | Array con eventos publicados | PASS | Catálogo público lista eventos en estado PUBLISHED. |
| E2E-EVT-05 / TC-BIZ-005 | ADMIN | POST /api/events/{{newEventCode}}/artists/{{artistId}} | 200 | 200 | Evento con artista id 1 en array artists | PASS | Artista 1 asociado al evento por ADMIN. |
| E2E-EVT-04 / TC-BIZ-004 | ADMIN | PATCH /api/events/{{newEventCode}}/publish | 200 | 200 | status transiciona a PUBLISHED | PASS | Evento publicado vía PATCH por ADMIN. |
| E2E-EVT-06 | ANON | GET /api/events/by-artist?stageName={{artistStageName}} | 200 | 200 | Array con eventos del artista Solar Beat | PASS | Eventos filtrados por artista obtenidos correctamente. |
| E2E-TKT-01 / TC-BIZ-007 | A | POST /api/tickets | 201 | 201 | ticketCode TKT-EF6E1137, status PAID | PASS | Ticket comprado por USER_A; código guardado. |
| E2E-TKT-02 | A | GET /api/tickets/{{ticketCancelableCode}} | 200 | 200 | ticketCode TKT-EF6E1137, status PAID | PASS | Ticket consultado por propietario en estado PAID. |
| E2E-TKT-03 | A | GET /api/tickets/by-user?email={{userAEmail}} | 200 | 200 | Array con tickets de usera.run01 | PASS | Historial de compras consultado con token de propietario. |
| E2E-TKT-04 / TC-BIZ-009 | STAFF | GET /api/events/{{publishedEventCode}}/tickets/paid | 200 | 200 | Array con tickets pagados del evento | PASS | Listado operativo de tickets pagados consultado por STAFF. |
| E2E-TKT-05 / TC-BIZ-010 | A | PATCH /api/tickets/{{ticketCancelableCode}}/cancel | 200 | 200 | status transiciona a CANCELLED | PASS | Ticket TKT-EF6E1137 cancelado por propietario. |
| E2E-TKT-06 / TC-SEC-014 / TC-BIZ-012 | STAFF | PATCH /api/tickets/{{ticketUsableCode}}/use | 200 | 200 | status transiciona a USED | PASS | Ticket TKT-15056FC4 validado en puerta por STAFF. |
| TC-SEC-001a | ANON | POST /api/events | 401 | 401 | ErrorResponse: credenciales ausentes | PASS | Rechazado con 401 por falta de cabecera Authorization. |
| TC-SEC-001b / TC-AUTH-014 | A | POST /api/events | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; USER_A carece de autoridad ROLE_ADMIN. |
| TC-SEC-002a | A | PATCH /api/events/{{eventToPublishCode}}/publish | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; publicación restringida a ADMIN. |
| TC-SEC-002b | STAFF | PATCH /api/events/{{eventToPublishCode}}/publish | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; STAFF no puede publicar eventos. |
| TC-SEC-003 | A | POST /api/events/{{eventToPublishCode}}/artists/{{artistId}} | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; asociación de artistas denegada para USER. |
| TC-SEC-004 | ANON | GET /api/events/{{draftEventCode}} | 404 | 404 | ErrorResponse: Not Found | PASS | 404 intencional para evitar enumeración de borradores. |
| TC-SEC-006 | B | GET /api/users/by-email?email={{userAEmail}} | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; USER_B bloqueado al consultar datos de A. |
| TC-SEC-007 | B | GET /api/users/by-username?username={{userAUsername}} | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; protección IDOR activa ante consulta ajena. |
| TC-SEC-008 / AC-05 | A | POST /api/tickets | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; USER_A no puede comprar a nombre de B. |
| TC-SEC-009 | B | GET /api/tickets/{{ticketCancelableCode}} | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; USER_B no puede leer tickets de A. |
| TC-SEC-010 | B | GET /api/tickets/by-user?email={{userAEmail}} | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; consulta de listado ajeno bloqueada. |
| TC-SEC-011 | B | PATCH /api/tickets/{{ticketCancelableCode}}/cancel | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; cancelación ajena bloqueada por ownership. |
| TC-SEC-012 | B | PATCH /api/tickets/{{ticketUsableCode}}/use | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; validación en puerta reservada a STAFF. |
| TC-SEC-013 | A | GET /api/events/{{publishedEventCode}}/tickets/paid | 403 | 403 | ErrorResponse: acceso denegado | PASS | Rechazado con 403; acceso a tickets pagados reservado a STAFF. |
| TC-SEC-015 | ADMIN | GET /api/events/{{newEventCode}} | 200 | 200 | JSON con status DRAFT | PASS | ADMIN consulta evento borrador con Bearer token. |
| TC-SEC-016 | ANON | POST /api/users | 201 | 201 | JSON con roles [USER] | PASS | Usuario registrado; API ignora role ADMIN inyectado. |
| TC-AUTH-004 | ANON | POST /api/auth/login | 401 | 401 | ErrorResponse: credenciales inválidas | PASS | Login rechazado con 401 ante password errónea. |
| TC-AUTH-005 | ANON | POST /api/auth/login | 401 | 401 | ErrorResponse: credenciales inválidas | PASS | Login rechazado con 401 ante identificador no registrado. |
| TC-AUTH-007 | ANON | GET /api/auth/me | 401 | 401 | ErrorResponse: credenciales ausentes | PASS | Rechazado con 401; endpoint protegido sin cabecera. |
| TC-AUTH-008 | ANON | GET /api/auth/me | 401 | 401 | ErrorResponse: token inválido | PASS | Rechazado con 401 ante token JWT corrupto o firma inválida. |
| TC-AUTH-012 | ANON | GET /api/auth/me?access_token={{userAToken}} | 401 | 401 | ErrorResponse: credenciales ausentes | PASS | Rechazado con 401; token en query param no admitido. |
| TC-HTTP-VEN-404 | ANON | GET /api/venues/NO-EXISTE | 404 | 404 | ErrorResponse: venue not found | PASS | Retorna 404 canónico ante código de venue inexistente. |
| TC-HTTP-ART-404 | ANON | GET /api/artists/999999999 | 404 | 404 | ErrorResponse: artist not found | PASS | Retorna 404 canónico ante ID de artista inexistente. |
| TC-HTTP-EVT-404 | ANON | GET /api/events/NO-EXISTE | 404 | 404 | ErrorResponse: event not found | PASS | Retorna 404 canónico ante evento no existente en catálogo. |
| TC-HTTP-TKT-404 | STAFF | GET /api/tickets/NO-EXISTE | 404 | 404 | ErrorResponse: ticket not found | PASS | Retorna 404 al consultar ticket inexistente bajo rol STAFF. |
| TC-HTTP-USR-400 | ANON | POST /api/users | 400 | 400 | ErrorResponse con mapa de errores de validación | PASS | Retorna 400 por campos obligatorios ausentes en DTO. |
| TC-BIZ-006 / USR-409 | ANON | POST /api/users | 409 | 409 | ErrorResponse: username already exists | PASS | Retorna 409 Conflict ante intento de duplicar username. |
| TC-HTTP-JSON-400 | ANON | POST /api/users | 400 | 400 | ErrorResponse: malformed JSON | PASS | Retorna 400 por payload JSON sintácticamente roto. |
| TC-HTTP-ENUM-400 | ADMIN | POST /api/events | 400 | 400 | ErrorResponse: category enum invalid | PASS | Retorna 400 por valor inválido en enum EventCategory. |
| TC-BIZ-011 | A | PATCH /api/tickets/{{ticketCancelableCode}}/cancel | 409 | 409 | ErrorResponse: ticket already cancelled | PASS | Retorna 409 por doble cancelación de TKT-EF6E1137. |
| TC-BIZ-013 | STAFF | PATCH /api/tickets/{{ticketUsableCode}}/use | 409 | 409 | ErrorResponse: ticket already used | PASS | Retorna 409 por doble uso de ticket TKT-15056FC4. |
| TC-BIZ-EVT-409a | ADMIN | POST /api/events/{{newEventCode}}/artists/{{artistId}} | 409 | 409 | ErrorResponse: artist already associated | PASS | Retorna 409 al asociar artista 1 ya vinculado al evento. |
| TC-BIZ-EVT-409b | ADMIN | PATCH /api/events/{{newEventCode}}/publish | 409 | 409 | ErrorResponse: event already published | PASS | Retorna 409 al publicar evento que ya estaba PUBLISHED. |
| TC-BIZ-014 | A | POST /api/tickets | 409 | 409 | ErrorResponse: cannot buy ticket for draft event | PASS | Retorna 409 al comprar en evento en estado DRAFT. |
| TC-AUTH-009 | USER_A | GET /api/auth/me (token alterado) | 401 | 401 | ErrorResponse: firma inválida | PASS | JWT rechaza firma corrupta; payload ErrorResponse emitido. |
| TC-AUTH-010 | USER_A | GET /api/auth/me (token expirado) | 401 | 401 | ErrorResponse: token expired | PASS | Token con claim exp vencido es rechazado por JwtService. |
| TC-AUTH-011 | ANON | GET /api/auth/me (otra clave) | 401 | 401 | ErrorResponse: firma inválida | PASS | Token firmado con secreto ajeno rechazado con 401. |
| TC-AUTH-013 | INACTIVE_USER | POST /api/auth/login (usuario inactivo) | 401 | 401 | ErrorResponse: usuario inactivo | PASS | Autenticación denegada por active = FALSE en BD. |
| TC-AUTH-015 | ANON | GET /api/venues/active (Bearer inválido) | 200 | 200 | Array JSON de venues activos | PASS | Token inválido ignorado en ruta pública; responde 200 como anónimo. |
| TC-SEC-017 | STAFF | PATCH /api/tickets/{code}/use (rol revocado) | 403 | 403 | ErrorResponse: acceso denegado | PASS | Token emitido antes de revocar rol es denegado al validar autoridades. |
