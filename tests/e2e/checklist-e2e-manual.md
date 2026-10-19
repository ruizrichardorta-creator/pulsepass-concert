# Checklist E2E manual (orden obligatorio)

La ejecución debe realizarse solicitud por solicitud respetando dependencias de estado:

## A. Público
- [x] TC-HTTP-00: GET /api/venues/active (200 OK)
- [x] E2E-VEN-01: GET /api/venues/{{venueActiveCode}} (200 OK)
- [x] E2E-VEN-02: GET /api/venues/active (200 OK)
- [x] E2E-ART-03: GET /api/artists/active (200 OK, confirmar artistId=1 Solar Beat)
- [x] E2E-ART-01: GET /api/artists/{{artistId}} (200 OK)
- [x] E2E-ART-02: GET /api/artists/by-stage-name?stageName={{artistStageName}} (200 OK)
- [x] E2E-EVT-03: GET /api/events/published (200 OK)
- [x] E2E-EVT-02: GET /api/events/{{publishedEventCode}} (200 OK)
- [x] TC-SEC-004: GET /api/events/{{draftEventCode}} (404 Not Found esperado)
- [x] E2E-EVT-06: GET /api/events/by-artist?stageName={{artistStageName}} (200 OK)

## B. Registro y JWT
- [x] E2E-USR-01: POST /api/users (USER_A) (201 Created)
- [x] E2E-USR-01-B: POST /api/users (USER_B) (201 Created)
- [x] E2E-AUTH-01 / TC-AUTH-002: Login USER_A username (200 OK) -> userAToken
- [x] TC-AUTH-003: Login USER_A email (200 OK)
- [x] E2E-AUTH-01-B: Login USER_B (200 OK) -> userBToken
- [x] E2E-AUTH-01-STAFF: Login STAFF (200 OK) -> staffToken
- [x] E2E-AUTH-01-ADMIN: Login ADMIN (200 OK) -> adminToken
- [x] E2E-AUTH-02 (x4): GET /api/auth/me para A, B, STAFF, ADMIN (200 OK con roles)
- [x] TC-AUTH-004 / 005 / 007 / 008 / 012: Intentos con credenciales rotas (401 Unauthorized)
- [x] TC-SEC-001b: USER_A intenta crear evento (403 Forbidden)

## C. Catálogo (ADMIN)
- [x] E2E-EVT-01: POST /api/events (201 Created)
- [x] TC-SEC-015: ADMIN consulta borrador (200 OK)
- [x] E2E-EVT-05: POST asociar artista a evento (200 OK)
- [x] E2E-EVT-04: PATCH publicar evento (200 OK)
- [x] E2E-EVT-06: GET eventos por artista (200 OK con nuevo evento)
- [x] TC-SEC-001a: POST evento anónimo (401 Unauthorized)
- [x] TC-SEC-002a / 002b / 003: Intentos no autorizados de publicar/asociar (403 Forbidden)

## D. Tickets y Permisos Cruzados
- [x] E2E-TKT-01 (T1): Compra USER_A (201 Created) -> ticketCancelableCode
- [x] E2E-TKT-02: GET ticket propio PAID (200 OK)
- [x] E2E-TKT-03: GET tickets por email propio (200 OK)
- [x] TC-SEC-008: USER_A compra con email de B (403 Forbidden)
- [x] TC-SEC-009 / 010 / 011: USER_B lee, lista o cancela ticket de A (403 Forbidden)
- [x] E2E-TKT-05: PATCH cancelar ticket propio (200 OK, CANCELLED)
- [x] E2E-TKT-02: Re-consulta de ticket cancelado (200 OK, CANCELLED)
- [x] TC-BIZ-011: Cancelar ticket ya cancelado (409 Conflict)
- [x] E2E-TKT-01 (T2): Segunda compra USER_A (201 Created) -> ticketUsableCode
- [x] E2E-TKT-04: GET tickets pagados STAFF (200 OK)
- [x] TC-SEC-012 / 013: Operaciones operativas intentadas por USER_A (403 Forbidden)
- [x] E2E-TKT-06: PATCH usar ticket por STAFF (200 OK, USED)
- [x] TC-BIZ-013: Re-usar ticket ya usado (409 Conflict)
- [x] TC-BIZ-014: Comprar ticket de evento en DRAFT (409 Conflict)
- [x] E2E-USR-02 / USR-03: Consulta de perfil propio (200 OK)
- [x] TC-SEC-006 / 007: Consulta de usuario ajeno (403 Forbidden)

## E. Contrato HTTP y Errores
- [x] TC-HTTP-*-404: Venues, artistas, eventos y tickets inexistentes (404 Not Found)
- [x] TC-HTTP-*-400: Campos faltantes, enum erróneo y JSON roto (400 Bad Request)
- [x] TC-BIZ-*-409: Duplicados en registro, publicación y asociación (409 Conflict)
- [x] TC-SEC-016: Registro público inyectando rol ADMIN (201 Created con rol USER)

## F. Casos Manuales de JWT y Roles Revocados
- [x] TC-AUTH-009: GET /me con token alterado (401 Unauthorized)
- [x] TC-AUTH-010: GET /me con token expirado (401 Unauthorized)
- [x] TC-AUTH-011: GET /me con token firmado con otro secreto (401 Unauthorized)
- [x] TC-AUTH-013: Login de usuario inactivo (401 Unauthorized)
- [x] TC-AUTH-015: GET /venues/active con Bearer roto (200 OK como anónimo)
- [x] TC-SEC-017: Uso de ticket tras revocar rol STAFF en BD (403 Forbidden)
