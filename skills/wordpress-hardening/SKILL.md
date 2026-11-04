---
name: wordpress-hardening
description: Úsala al escribir o revisar código PHP o WordPress (plugins, temas, formularios, AJAX, endpoints) para aplicar y auditar las prácticas de seguridad.
---

# Seguridad en PHP y WordPress

Aplicar al escribir código nuevo y al revisar código existente. Si se revisa, entregar un informe con: archivo:línea, problema, gravedad (crítica/alta/media/baja) y arreglo propuesto.

## Regla base
**Toda entrada es hostil** ($_GET, $_POST, $_REQUEST, $_COOKIE, $_SERVER, $_FILES, cabeceras, JSON, datos de la BD que vinieron de usuarios). Sanitizar al entrar, validar, y escapar al salir.

## WordPress
### Entrada
- Sanitizar: `sanitize_text_field`, `sanitize_email`, `absint`, `sanitize_key`, `sanitize_file_name`, `wp_kses_post` para HTML permitido.
- Usar `wp_unslash()` antes de sanitizar datos de superglobales.

### Salida (escapar SIEMPRE al imprimir)
- `esc_html`, `esc_attr`, `esc_url`, `esc_js`, `wp_kses` / `wp_kses_post`, `esc_textarea`.
- Traducciones: `esc_html__`, `esc_attr_e`, etc.

### Autorización y CSRF
- Formularios y acciones: `wp_nonce_field` / `wp_create_nonce` + `check_admin_referer` / `check_ajax_referer` / `wp_verify_nonce`.
- Comprobar permisos con `current_user_can('capacidad_concreta')`, nunca solo con `is_admin()` (que solo indica que estás en el panel).
- REST API: `permission_callback` obligatorio y real (nunca `__return_true` en endpoints que modifican datos o devuelven datos privados).
- AJAX: separar `wp_ajax_` y `wp_ajax_nopriv_`; revisar que la versión nopriv no exponga nada sensible.

### Base de datos
- Siempre `$wpdb->prepare()` con placeholders (%s, %d, %f). Nunca concatenar variables en SQL.
- `esc_like()` para búsquedas LIKE.

### Archivos
- Subidas con `wp_handle_upload` y validar con `wp_check_filetype_and_ext`; lista blanca de extensiones.
- Nunca incluir/abrir rutas construidas con entrada del usuario sin normalizar y restringir (path traversal).
- Bloquear acceso directo en archivos PHP: `defined('ABSPATH') || exit;`

## PHP general (fuera de WordPress)
- PDO con sentencias preparadas; `PDO::ATTR_EMULATE_PREPARES => false`.
- `htmlspecialchars($x, ENT_QUOTES, 'UTF-8')` al imprimir.
- Contraseñas: `password_hash` / `password_verify`. Nunca md5/sha1.
- Sesiones: `session_regenerate_id(true)` tras login; cookies `HttpOnly`, `Secure`, `SameSite=Lax` o `Strict`.
- Tokens CSRF propios en formularios.
- Prohibido con entrada de usuario: `eval`, `unserialize` (usar `json_decode`), `extract`, `include` dinámico, `shell_exec`/`exec`/`system` (si es imprescindible, `escapeshellarg`).
- Comparaciones de tokens con `hash_equals`.
- Redirecciones solo a URLs propias (`wp_safe_redirect` en WP).

## Configuración y secretos
- Nada de credenciales, API keys ni contraseñas en el código ni en el repositorio: usar `wp-config.php`, variables de entorno o `.env` fuera del webroot e ignorado en git.
- Producción: `WP_DEBUG` y `display_errors` desactivados; `DISALLOW_FILE_EDIT` activado.
- Cabeceras recomendadas: `X-Content-Type-Options: nosniff`, `Referrer-Policy`, `X-Frame-Options` o CSP `frame-ancestors`, HSTS si hay HTTPS.

## Revisión
Además de revisar a mano, si están disponibles: ejecutar `/security-review`, PHPCS con el estándar `WordPress-Extra` / `WordPress.Security`, y Semgrep. Priorizar en el informe lo crítico primero y no inundar con avisos menores.
