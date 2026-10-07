# RustForge Community — Plan de implementación

## Producto
Foro en PHP 8.2 + MySQL/MariaDB para publicar cambios del cliente Rust, organizar debates y permitir reportes de seguridad con imágenes. El MVP es autocontenido: un front controller, PDO, sesiones, CSRF y esquema SQL reproducible.

## Diseño
- **Movimiento:** editorial oscuro / terminal de ingeniería, inspirado en comunidades técnicas como OxideMod sin copiar su identidad.
- **Principios:** jerarquía clara, densidad útil, contraste alto y moderación visible.
- **Color:** carbón y azul petróleo como base; naranja óxido como color propio para acciones y avisos.
- **Layout:** navegación lateral compacta + contenido principal en columnas asimétricas; el feed de novedades tiene prioridad.
- **Firma visual:** etiqueta `BUILD / CHANGELOG`, líneas divisoras monoespaciadas y tarjetas con estado.
- **Interacción:** acciones explícitas, confirmación para moderación, mensajes de estado y permisos por rol.
- **Tipografía:** Inter para lectura y Space Mono para metadatos, tags y números.
- **Marca:** RustForge es “el registro técnico de tu cliente Rust”; personalidad directa, técnica y comunitaria.
- **Voz:** “Publica el cambio. Reproduce el fallo. Mejora el cliente.”

## Arquitectura
- `public/index.php`: rutas, auth, CRUD de categorías/posts/comentarios, chat y panel admin.
- `config.php`: conexión PDO y configuración de sesión.
- `db/schema.sql`: tablas, índices, roles, insignias y datos demo mínimos.
- `public/assets/style.css`: sistema visual responsive.
- `docker-compose.yml`: PHP Apache + MySQL para desarrollo local.

## Requisitos cubiertos
Registro/login, roles admin/moderador/usuario, insignias, categorías y subcategorías, posts, adjuntos de imágenes, reportes de seguridad, comentarios/chat, desactivar chat, banear usuarios, cerrar posts y CRUD de categorías.
