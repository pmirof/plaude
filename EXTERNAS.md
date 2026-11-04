# Skills externas que uso

No se copian en este repo: se instalan desde su origen para que se actualicen solas y respetar sus licencias.

| Skill | Para qué | Autor / repo |
|---|---|---|
| **grill-me** | Me hace preguntas antes de programar, una a una y con respuesta recomendada | [mattpocock/skills](https://github.com/mattpocock/skills) |
| **karpathy-guidelines** | Evita la sobreingeniería y los cambios innecesarios | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) |
| **frontend-design** | Principios de diseño de interfaces (oficial) | [anthropics/skills](https://github.com/anthropics/skills) |
| **webapp-testing** | Pruebas en navegador con Playwright (oficial) | [anthropics/skills](https://github.com/anthropics/skills) |
| **ui-ux-pro-max** | Catálogo de estilos, paletas y tipografías | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |
| **static-analysis** + **differential-review** | Auditoría de seguridad (CodeQL, Semgrep, revisión de cambios) | [trailofbits/skills](https://github.com/trailofbits/skills) |

Además, nativo de Claude Code: `/security-review` y el modo plan (Shift+Tab).

## Instalación (Claude Code, una vez por ordenador)

En una terminal:
```bash
npx skills add https://github.com/mattpocock/skills --skill grill-me
npx skills add https://github.com/forrestchang/andrej-karpathy-skills --skill karpathy-guidelines
npx skills add anthropics/skills --skill frontend-design
npx skills add anthropics/skills --skill webapp-testing
```

Dentro de Claude Code:
```
/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
/plugin install ui-ux-pro-max@ui-ux-pro-max-skill
/plugin marketplace add trailofbits/skills
/plugin
```
En `/plugin`, del marketplace de Trail of Bits activa **solo** `static-analysis` y `differential-review`.

> Si `npx skills` instala en la carpeta del proyecto, ejecútalo desde tu carpeta de usuario o mueve el resultado a `~/.claude/skills/`.

## Instalación (Claude app: web, escritorio, móvil)
Descarga la carpeta de la skill desde su repo, comprímela en ZIP y súbela en la configuración de Claude, en el apartado de skills.

⚠️ Antes de instalar cualquier skill externa, revisa su SKILL.md y si trae scripts.
