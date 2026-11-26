# Skills externas que uso

Cada skill se instala desde el repositorio de su autor y conserva su licencia.

| Skill | Para qué | Autor / repo |
|---|---|---|
| **karpathy-guidelines** | Evita la sobreingeniería y los cambios innecesarios | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) |
| **frontend-design** | Principios de diseño de interfaces (oficial) | [anthropics/skills](https://github.com/anthropics/skills) |
| **webapp-testing** | Comprobaciones puntuales en navegador con Playwright (oficial) | [anthropics/skills](https://github.com/anthropics/skills) |
| **ui-ux-pro-max** | Catálogo opcional de estilos, paletas y tipografías | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |
| **modern-web-guidance** | Guías de HTML, CSS y JavaScript con datos de compatibilidad y alternativas para navegadores sin soporte | [GoogleChrome/modern-web-guidance](https://github.com/GoogleChrome/modern-web-guidance) |
| **static-analysis** | Escaneos de seguridad con CodeQL y Semgrep | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **wp-project-triage** | Detecta el tipo de proyecto, herramientas y versiones para las skills de WordPress | [WordPress/agent-skills](https://github.com/WordPress/agent-skills) |
| **wp-plugin-development** | Arquitectura, hooks, ajustes y ciclo de vida de plugins | [WordPress/agent-skills](https://github.com/WordPress/agent-skills) |
| **wp-playground** | Entorno desechable de WordPress para previsualizar y probar | [WordPress/agent-skills](https://github.com/WordPress/agent-skills) |
| **wp-block-development** | Opcional para crear y mantener bloques de Gutenberg | [WordPress/agent-skills](https://github.com/WordPress/agent-skills) |
| **wp-block-themes** | Opcional para temas de bloques, `theme.json`, plantillas y patrones | [WordPress/agent-skills](https://github.com/WordPress/agent-skills) |

Claude Code incluye `/code-review`, `/security-review`, `/simplify`, `/run`, `/verify`, `/run-skill-generator` y el modo plan (Shift+Tab). Para verificar proyectos con un arranque especial, `/run-skill-generator` puede guardar la receta en el proyecto. [Skills de Claude Code](https://code.claude.com/docs/en/skills#run-and-verify-your-app)

Para probar en navegador, empieza por la suite del proyecto. Usa `webapp-testing` para comprobaciones puntuales y espera una condición observable con aserciones de Playwright. [Buenas prácticas de Playwright](https://playwright.dev/docs/best-practices)

## Instalación (Claude Code, una vez por ordenador)

En una terminal, **desde la carpeta de usuario** (no dentro de un proyecto):
```bash
cd ~
npx skills add https://github.com/forrestchang/andrej-karpathy-skills --skill karpathy-guidelines -a claude-code -g -y
npx skills add anthropics/skills --skill frontend-design -a claude-code -g -y
npx skills add anthropics/skills --skill webapp-testing -a claude-code -g -y
npx skills add WordPress/agent-skills --skill wp-project-triage wp-plugin-development wp-playground -a claude-code -g -y
```
- `-a claude-code`: instala solo para Claude Code (sin la opción, el instalador ofrece decenas de agentes).
- `-g`: instalación global, en `~/.claude/skills/`.
- `-y`: sin preguntas.

`wp-plugin-development` usa el detector de `wp-project-triage`. Las guías oficiales tienen como objetivo WordPress 7.0 o posterior. Comprueba las APIs y el esquema disponibles si el proyecto soporta versiones anteriores. Playground CLI requiere Node.js 20.18 o posterior. [WordPress Agent Skills](https://github.com/WordPress/agent-skills) · [Playground CLI](https://developer.wordpress.org/playground/developers/local-development/wp-playground-cli/#requirements)

Para consultar catálogos de diseño o trabajar con el editor de bloques, elige el comando que corresponda.

```bash
npx skills add nextlevelbuilder/ui-ux-pro-max-skill --skill ui-ux-pro-max -a claude-code -g -y
npx skills add WordPress/agent-skills --skill wp-block-development -a claude-code -g -y
npx skills add WordPress/agent-skills --skill wp-block-themes -a claude-code -g -y
```

Dentro de Claude Code, **un comando cada vez** (pegados juntos no se ejecutan):
```
/plugin marketplace add trailofbits/skills
/plugin
```
En `/plugin` → **Discover** → `static-analysis` → **Install for you (user scope)**. Después, `/reload-plugins`.

Para `modern-web-guidance`, instala el plugin desde el marketplace de Google Chrome. Requiere Node.js 22 o posterior para consultar las guías con `npx`. En Claude Code, ejecuta un comando cada vez:

```
/plugin marketplace add GoogleChrome/modern-web-guidance
/plugin install modern-web-guidance@googlechrome
/reload-plugins
```

En `/plugin` → **Marketplaces** → `googlechrome`, activa **AutoUpdate**. Comprueba que aparece `/modern-web-guidance:modern-web-guidance` al escribir `/modern-web-guidance`.

## Instalación (Claude app: web, escritorio, móvil)
Descarga la carpeta de la skill desde su repo, comprímela en ZIP y súbela en la configuración de Claude, en el apartado de skills.

Para `modern-web-guidance`, sigue los pasos de Claude Code. La skill consulta las guías ejecutando `npx`.

⚠️ Antes de instalar cualquier skill externa, revisa su SKILL.md y si trae scripts.
