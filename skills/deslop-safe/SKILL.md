---
name: deslop-safe
description: >-
  Úsala para revisar y limpiar código generado por IA: quita comentarios obvios, abstracciones innecesarias, código defensivo inútil y verborrea, sin cambiar el comportamiento.
---

# Limpiar AI slop del código

Objetivo: que el código parezca escrito por un desarrollador senior con criterio, no por una IA. Regla de oro: **no cambiar el comportamiento**.

## Qué eliminar o simplificar

### Comentarios
- Comentarios que repiten lo que hace el código (`// incrementa el contador` sobre `i++`).
- Comentarios de "narración" (`// Ahora vamos a...`, `// Paso 1:`).
- Docblocks enormes en funciones triviales.
- Mantener solo los comentarios que explican el **por qué**, no el qué.

### Código defensivo innecesario
- `try/catch` que solo vuelven a lanzar o hacen `console.log` del error.
- Comprobaciones de null/undefined imposibles según el flujo o los tipos.
- Validaciones duplicadas de algo que ya se validó antes.
- Fallbacks que esconden errores reales.

### Sobreingeniería
- Integra una abstracción de un solo uso si mejora la lectura y conserva los límites que usan el proyecto y sus pruebas.
- Configuración/parametrización "por si acaso" que nadie usa.
- Capas de abstracción sin una segunda implementación.
- Constantes para valores usados una vez y autoexplicativos.

### Verborrea
- Variables intermedias que no aportan claridad.
- Simplifica retornos condicionales conservando el tipo. En JavaScript, `return x` solo sustituye a `if (x) return true; else return false;` si `x` es booleano.
- Nombres excesivamente largos o genéricos (`dataResult`, `handleProcessData`, `utilsHelper`).
- Logs de depuración olvidados.

### Incoherencias con el proyecto
- Estilo distinto al resto del código (comillas, indentación, naming, patrones).
- Dependencias nuevas para algo que el proyecto ya resuelve.
- Mezcla de paradigmas (callbacks + async/await, etc.).

### Texto de UI y mensajes
- Mensajes tipo "¡Ups! Algo salió mal 😅", emojis innecesarios, textos de marketing en errores.
- Strings sobreexplicativos.

## Cómo trabajar
1. Leer el archivo completo y el código del proyecto que lo rodea para conocer sus convenciones.
2. Si existe `git diff`, centrarse en lo añadido recientemente, no en código antiguo ajeno.
3. Aplicar los cambios.
4. Ejecutar las pruebas relevantes para comprobar el comportamiento y usar el linter para el estilo. Si no puedes ejecutar las pruebas, deja constancia.
5. Resumir en 3-5 líneas qué tipo de cosas se han quitado (no una lista de cada línea).

## Qué NO hacer
- No reescribir lógica que funciona "porque quedaría más bonita".
- No quitar validaciones de seguridad reales (entrada de usuario, permisos, escapado, nonces en WordPress, etc.).
- No renombrar APIs públicas ni cosas usadas desde otros archivos sin comprobarlo.
