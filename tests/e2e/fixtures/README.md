# Fixtures E2E

Datos deterministas requeridos para la base de datos `pulsepass_e2e`. Nunca correr en otra base de datos.

## Catálogo de Fixtures
| Fixture | Código / Valor | Estado / Rol | Propósito |
|---|---|---|---|
| Venue activo | `E2E-VEN-01` | `active = TRUE` | Aforo de 5000 personas |
| Evento publicado | `E2E-PUB-01` | `PUBLISHED` | Disponible para compra pública |
| Evento borrador | `E2E-DRAFT-01` | `DRAFT` | Validación de denegación pública y acceso exclusivo ADMIN |
| Evento por publicar | `E2E-TOPUB-01` | `DRAFT` | Evento reservado para flujo de publicación manual |
| Artistas | IDs 1 al 5 | Activos | Generados en migración V2 (Solar Beat ID 1) |
| ADMIN | `e2e_admin` | `ADMIN` | Pruebas de administración y catálogo |
| STAFF | `e2e_staff` | `STAFF` | Validación y uso de tickets |
| Inactivo | `e2e_inactive` | `USER` (`active = FALSE`) | Bloqueo de autenticación para cuentas inactivas |

## Procedimiento de Reinicio (Reset)
1. Borrar y recrear la base de datos `pulsepass_e2e`.
2. Iniciar el backend para ejecutar las migraciones de Flyway.
3. Reejecutar `seed-e2e.sql` mediante `psql` suministrando las contraseñas correspondientes.
