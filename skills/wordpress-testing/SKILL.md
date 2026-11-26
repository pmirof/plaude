---
name: wordpress-testing
description: >-
  Úsala para crear o ampliar pruebas automatizadas de plugins y temas de WordPress, o para reproducir un fallo con una prueba de regresión que se quede en el proyecto.
---

# Pruebas automatizadas de WordPress

## Elegir la prueba

- Empieza por `composer.json`, `package.json`, la configuración de PHPUnit o Playwright y los workflows del proyecto. Reutiliza su bootstrap, comandos y datos de prueba.
- Usa pruebas unitarias de PHPUnit para lógica PHP aislada. Para hooks, capacidades, rutas REST, metadatos y migraciones, usa pruebas de integración con WordPress y la base de datos de pruebas. Si hay que montar la suite, elige `wp-env` o el entorno con Composer según la infraestructura y las versiones soportadas. [Guía de pruebas de plugins](https://developer.wordpress.org/news/2025/12/how-to-add-automated-unit-tests-to-your-wordpress-plugin/) · [`wp-env`](https://developer.wordpress.org/block-editor/reference-guides/packages/packages-env/#using-included-wordpress-phpunit-test-files)
- Usa Playwright si el resultado depende del navegador, por ejemplo guardar un bloque y reabrirlo en el editor. Usa Playground para pruebas en un WordPress desechable cuando PHP en WebAssembly y SQLite representen el entorno lo suficiente. [Playwright con WordPress Playground](https://developer.wordpress.org/playground/handbook/guides/e2e-testing-with-playwright/)

## Escribir la regresión

- Reproduce el fallo con el menor caso que conserve la causa. Si puedes ejecutar la prueba contra la versión anterior, confirma que falla por el motivo esperado. Después ejecútala con el cambio y pasa la suite relacionada.
- En integración, crea usuarios, entradas y opciones explícitos. Para permisos, comprueba la acción permitida y la denegada con las capacidades pertinentes. Comprueba el dato guardado o el efecto observable, incluido que una acción rechazada preserve el estado.
- Para actualizaciones, parte de datos con el esquema anterior. Comprueba que se conservan y que volver a ejecutar la migración deja un estado consistente si el proyecto permite reintentos.
- En el navegador, usa roles y nombres accesibles cuando se pueda. Espera mediante aserciones sobre el resultado visible y verifica que persista tras recargar cuando corresponda. [Buenas prácticas de Playwright](https://playwright.dev/docs/best-practices)

Usa un entorno desechable y datos de prueba. Al entregar, indica el comando ejecutado y qué comportamiento cubre. Deja explícitas las comprobaciones que queden pendientes si falta un entorno o una versión compatible.
