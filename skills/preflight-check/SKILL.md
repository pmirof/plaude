---
name: preflight-check
description: >-
  Úsala al cerrar un cambio o preparar una subida a producción para verificar el alcance afectado y emitir un veredicto basado en pruebas.
---

# Listo para producción

Evalúa los bloques afectados por el cambio. Marca cada uno como comprobado, con aviso, falla, sin verificar o no aplica. Registra la evidencia de cada comprobación y el motivo de las pendientes.

## 1. Funciona (con evidencia real)
- Ejecutar las pruebas del proyecto que cubran el cambio. Si falta cobertura, comprobar el flujo de forma reproducible. Para añadir regresiones de WordPress, usa `wordpress-testing` si está disponible.
- Si hay interfaz, prueba el recorrido afectado en la aplicación en ejecución. Usa `/verify` en Claude Code si está disponible o la suite de navegador del proyecto. Para una comprobación puntual puedes recurrir a `webapp-testing`. Con Playwright, espera a un estado observable mediante aserciones sobre la interfaz y revisa los errores nuevos de consola y servidor. Captura móvil y escritorio si cambia la presentación. [Guía de Playwright](https://playwright.dev/docs/best-practices)
- Según el flujo, comprueba datos vacíos o inválidos, permisos insuficientes y reenvíos. Comprueba también que un fallo conserva el estado que corresponda.

## 2. Seguridad
- Revisar el diff con `wordpress-hardening` si afecta a PHP o WordPress o con `/security-review` cuando corresponda. Comprueba dependencias nuevas o actualizadas con el auditor del gestor de paquetes.
- Comprueba que el diff no incluye secretos ni archivos de entorno con datos reales.
- Debug desactivado en la configuración de producción.

## 3. Rendimiento
- Revisa las consultas que cambian y comprueba las que crecen con el número de elementos. Verifica el uso de índices cuando afecte a tiempos de respuesta.
- Revisa el tamaño y las dimensiones de las imágenes. Reserva la carga diferida para las que queden fuera de la vista inicial y evita aplicarla a la imagen que determina el LCP.
- CSS/JS sin dependencias innecesarias; nada bloqueante sin motivo.
- En cambios de rendimiento web, usa Lighthouse para LCP, CLS y TBT de laboratorio, con condiciones comparables. Para INP de campo, consulta CrUX o las métricas de usuarios reales del sitio si hay datos. Indica la fuente y los datos que falten. [Core Web Vitals](https://web.dev/articles/vitals#lab_tools_to_measure_core_web_vitals)

## 4. Accesibilidad
- Usa WCAG 2.2 AA como referencia para los criterios aplicables al flujo. Ejecuta axe si el entorno lo permite y recorre la interfaz con teclado. Comprueba el orden de foco, que sea visible y quede a la vista, y que los errores indiquen cómo corregir el campo. Revisa contraste, nombres accesibles, encabezados e idioma en los cambios relevantes. Usa lector de pantalla si cambia una interacción compleja y está disponible. [WCAG 2.2](https://www.w3.org/TR/WCAG22/) · [Pruebas con axe y Playwright](https://playwright.dev/docs/accessibility-testing)

## 5. SEO técnico (si es página pública)
- `title` y meta description descriptivos, Open Graph si aplica, URL limpia, canonical e indexación según el destino de la página.

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

Reserva 🟢 para cambios con todos los controles relevantes comprobados. Usa 🟡 para avisos o comprobaciones pendientes de bajo impacto. Usa 🔴 si hay un fallo bloqueante o falta evidencia de un control necesario para publicar.
