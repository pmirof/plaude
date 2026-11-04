---
name: preflight-check
description: Úsala antes de dar por terminado un cambio o de subir a producción: verifica funcionamiento, seguridad, rendimiento, accesibilidad, SEO y limpieza, y da un veredicto claro.
---

# Listo para producción

Objetivo: no decir "está listo" sin pruebas. Cada punto se marca como ✅ comprobado, ⚠️ con aviso, ❌ falla o ➖ no aplica, indicando CÓMO se ha comprobado.

## 1. Funciona (con evidencia real)
- Ejecutar los tests existentes (PHPUnit, npm test…). Si no hay, crear al menos una prueba rápida del flujo cambiado.
- Si es web: abrirla en navegador (Playwright / skill webapp-testing si está disponible), recorrer el flujo principal, hacer capturas en escritorio y móvil, y revisar la consola del navegador y los logs de PHP sin errores ni warnings.
- Probar casos límite: datos vacíos, datos erróneos, usuario sin permisos, doble envío de formulario.

## 2. Seguridad
- Pasar la skill `wordpress-hardening` (o `/security-review`) sobre lo cambiado.
- Ningún secreto, credencial ni `.env` en el diff.
- Debug desactivado en la configuración de producción.

## 3. Rendimiento
- Sin consultas a BD dentro de bucles (N+1); consultas con índices adecuados.
- Imágenes optimizadas (WebP/AVIF, tamaños correctos, `loading="lazy"` salvo la principal).
- CSS/JS sin dependencias innecesarias; nada bloqueante sin motivo.
- Si se puede, Lighthouse: apuntar LCP, CLS e INP.

## 4. Accesibilidad
- Contraste suficiente, `alt` en imágenes, `label` en campos, foco visible, todo usable con teclado, jerarquía de encabezados correcta, `lang` correcto (ca/es).

## 5. SEO técnico (si es página pública)
- `title` y meta description únicos, Open Graph, URL limpia, canonical, una sola H1, nada importante marcado como noindex por error.

## 6. Limpieza
- Pasar la skill `deslop-safe` sobre el diff.
- Sin `var_dump`, `console.log`, `print_r`, `die()` de depuración ni código comentado muerto.
- Linter/formateador del proyecto sin errores.

## 7. Despliegue
- Migraciones de BD o cambios de configuración anotados.
- Plan de vuelta atrás: cómo revertir si algo falla (backup, commit anterior).
- Si aplica, cachés a limpiar tras subir.
- Changelog / nota de versión actualizada.

## Veredicto final
Terminar con una tabla resumen de los 7 bloques y UNA de estas conclusiones:
- **🟢 Listo para producción**
- **🟡 Listo con avisos** (lista de avisos no bloqueantes)
- **🔴 No listo** (lista de bloqueantes y cómo arreglarlos)

Nunca dar 🟢 si algún punto relevante no se ha podido comprobar: en ese caso decirlo explícitamente.
