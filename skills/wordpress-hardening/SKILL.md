---
name: wordpress-hardening
description: Úsala al escribir o revisar código PHP o WordPress (plugins, temas, formularios, AJAX, endpoints) para aplicar y auditar las prácticas de seguridad.
---

# Seguridad en PHP y WordPress

Aplicar al escribir código nuevo y al revisar código existente. Si se revisa, entregar un informe con: archivo:línea, problema, gravedad (crítica/alta/media/baja) y arreglo propuesto.

## Regla base
Trata como no fiables las entradas del cliente, de terceros y los datos de usuario almacenados. Valida tipo, formato y límites en el primer punto de entrada. Normaliza solo cuando el contrato lo permita. Escapa al generar la salida según el contexto. [Validación en WordPress](https://developer.wordpress.org/apis/security/data-validation/)

## WordPress
### Entrada
- Usa `wp_unslash()` para datos de superglobales a los que WordPress añadió barras. Para datos REST, usa los parámetros de `WP_REST_Request` y el esquema o los callbacks de la ruta.
- Rechaza valores inválidos cuando el contrato exige un valor válido. Para campos que admiten normalización, elige la función según el tipo de campo, como `sanitize_text_field` para texto simple o `wp_kses_post` para HTML permitido.

### Salida (escapar SIEMPRE al imprimir)
- `esc_html`, `esc_attr`, `esc_url`, `esc_js`, `wp_kses` / `wp_kses_post`, `esc_textarea`.
- Traducciones: `esc_html__`, `esc_attr_e`, etc.

### Autorización y CSRF
- Formularios y acciones: `wp_nonce_field` / `wp_create_nonce` + `check_admin_referer` / `check_ajax_referer` / `wp_verify_nonce`.
- Comprueba la capacidad que autoriza la acción y pasa el ID cuando el permiso depende del objeto, como en `current_user_can( 'edit_post', $post_id )`. Es una comprobación independiente del nonce.
- REST API: `permission_callback` obligatorio y real (nunca `__return_true` en endpoints que modifican datos o devuelven datos privados).
- AJAX: separar `wp_ajax_` y `wp_ajax_nopriv_`; revisar que la versión nopriv no exponga nada sensible.

### Base de datos
- Usa las APIs de WordPress cuando cubran la consulta. Para SQL con valores dinámicos, usa `$wpdb->prepare()` con el marcador del tipo correspondiente. Restringe columnas y órdenes dinámicos a una lista permitida. WordPress 6.2 en adelante admite `%i` para identificadores. [Referencia de `wpdb::prepare()`](https://developer.wordpress.org/reference/classes/wpdb/prepare/)
- En búsquedas `LIKE`, aplica `$wpdb->esc_like()` al texto antes de añadir comodines y pasa el patrón resultante como parámetro de `prepare()`.

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
- Mantén los datos de entrada fuera del código ejecutable, las rutas de inclusión y los comandos de shell. Para datos serializados externos, usa un formato de datos como JSON y valida su estructura.
- Comparaciones de tokens con `hash_equals`.
- Redirecciones solo a URLs propias (`wp_safe_redirect` en WP).

## Configuración y secretos
- Nada de credenciales, API keys ni contraseñas en el código ni en el repositorio: usar `wp-config.php`, variables de entorno o `.env` fuera del webroot e ignorado en git.
- Producción: `WP_DEBUG` y `display_errors` desactivados; `DISALLOW_FILE_EDIT` activado.
- Cabeceras recomendadas: `X-Content-Type-Options: nosniff`, `Referrer-Policy`, `X-Frame-Options` o CSP `frame-ancestors`, HSTS si hay HTTPS.

## Revisión
- Usa OWASP ASVS 5.0 para seleccionar controles pertinentes al cambio, por ejemplo acceso a datos, carga de archivos, sesiones o dependencias. Cita el identificador del control y la evidencia cuando el informe se base en él. [OWASP ASVS](https://asvs.owasp.org/)
- Ejecuta PHPCS y los analizadores que ya use el proyecto. Para cambios de dependencias, revisa el archivo de bloqueo y los avisos aplicables con `composer audit --locked`, `npm audit` o el equivalente del proyecto. En instalaciones WordPress, incluye núcleo, plugins y temas que intervienen cuando se puedan identificar sus versiones.
- Prioriza los hallazgos por impacto y distingue los comprobados de los que necesitan evidencia adicional.
