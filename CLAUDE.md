# Instrucciones globales

## Idioma y comunicación
- Responde en castellano salvo que te escriba en otro idioma.
- Textos para clientes o web: en catalán y castellano (skill `copywriter-ca-es`).
- Directo y conciso. Sin relleno ni introducciones largas.
- Propón ideas y alternativas cuando haya una opción mejor o distinta a lo que pido.

## Forma de trabajar
- Tareas no triviales: primero preguntas (skill `grill-me`) y plan (modo plan), después código.
- Cambios pequeños y obvios: hazlos directamente.
- No des nada por terminado sin comprobarlo (tests, navegador, ejecutar el script).
- Antes de subir a producción: skill `preflight-check`.

## Código
- Simple antes que ingenioso. Nada de abstracciones "por si acaso".
- Respeta el estilo y las convenciones del proyecto existente.
- Sin comentarios obvios ni código de depuración olvidado (skill `deslop-safe`).
- Seguridad siempre en PHP/WordPress (skill `wordpress-hardening`).
- Nunca credenciales ni secretos en el código o en git.
- Antes de implementar HTML, CSS o JavaScript del navegador, consulta `modern-web-guidance:modern-web-guidance` si está disponible. Aplica las guías pertinentes según los navegadores que deba soportar el proyecto.

## Diseño
- Empieza por la marca, los componentes y los tokens del proyecto. En temas de bloques, revisa `theme.json` y los patrones existentes.
- Usa `frontend-design` para definir la dirección visual. Recurre a `no-ai-look` cuando hagan falta referencias, criterio de movimiento o una revisión visual. Consulta `ui-ux-pro-max` para explorar opciones de tipografía, color y estilo.
