# RustForge Community

Foro de comunidad para publicar changelogs de un cliente Rust, recibir reportes de seguridad y moderar conversaciones.

## Stack
PHP 8.2, Apache, MySQL 8, PDO, HTML/CSS sin framework. No requiere Composer.

## Inicio rápido con Docker

```bash
docker compose up -d
# abre http://localhost:8080
```

El primer usuario registrado obtiene rol `user`. Para convertirlo en administrador, ejecuta en MySQL:

```sql
UPDATE users SET role = 'admin' WHERE email = 'tu@email.com';
```

## Inicio sin Docker

1. Crea una base MySQL e importa `db/schema.sql`.
2. Exporta `DB_HOST`, `DB_NAME`, `DB_USER` y `DB_PASS`.
3. Sirve `public/` con Apache o `php -S localhost:8080 -t public`.

## Seguridad

El MVP usa consultas preparadas, password hashing, CSRF, control de MIME/extensión y límite de 5 MB para imágenes. En producción añade HTTPS, almacenamiento externo para uploads, rate limiting, backups, logs y un proxy/WAF.

## Rutas

`/` portada · `/?page=category&id=...` categoría · `/ ?page=thread&id=...` post · `/ ?page=security` reportes · `/ ?page=admin` moderación.
