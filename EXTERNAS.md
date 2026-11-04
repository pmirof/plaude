# Skills externas que uso

No se copian en este repo: se instalan desde su origen para que se actualicen solas y respetar sus licencias.

| Skill | Para qué | Autor / repo |
|---|---|---|
| **karpathy-guidelines** | Evita la sobreingeniería y los cambios innecesarios | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) |
| **frontend-design** | Principios de diseño de interfaces (oficial) | [anthropics/skills](https://github.com/anthropics/skills) |
| **webapp-testing** | Pruebas en navegador con Playwright (oficial) | [anthropics/skills](https://github.com/anthropics/skills) |
| **ui-ux-pro-max** | Catálogo de estilos, paletas y tipografías | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |
| **static-analysis** | Escaneos de seguridad con CodeQL y Semgrep | [trailofbits/skills](https://github.com/trailofbits/skills) |

Además, nativas de Claude Code (no hace falta instalarlas): `code-review`, `security-review`, `simplify`, `run` y el modo plan (Shift+Tab). Por eso no se usa `differential-review` de Trail of Bits: se solapa con `code-review` y `security-review`.

## Instalación (Claude Code, una vez por ordenador)

En una terminal, **desde la carpeta de usuario** (no dentro de un proyecto):
```bash
cd ~
npx skills add https://github.com/forrestchang/andrej-karpathy-skills --skill karpathy-guidelines -a claude-code -g -y
npx skills add anthropics/skills --skill frontend-design -a claude-code -g -y
npx skills add anthropics/skills --skill webapp-testing -a claude-code -g -y
npx skills add nextlevelbuilder/ui-ux-pro-max-skill --skill ui-ux-pro-max -a claude-code -g -y
```
- `-a claude-code`: instala solo para Claude Code (sin la opción, el instalador ofrece decenas de agentes).
- `-g`: instalación global, en `~/.claude/skills/`.
- `-y`: sin preguntas.

Dentro de Claude Code, **un comando cada vez** (pegados juntos no se ejecutan):
```
/plugin marketplace add trailofbits/skills
/plugin
```
En `/plugin` → **Discover** → `static-analysis` → **Install for you (user scope)**. Después, `/reload-plugins`.

> ⚠️ `ui-ux-pro-max` se instala con `npx` y no como plugin: el plugin trae 7 skills (`design`, `brand`, `slides`…) que se solapan con `no-ai-look` y `frontend-design`.

## Instalación (Claude app: web, escritorio, móvil)
Descarga la carpeta de la skill desde su repo, comprímela en ZIP y súbela en la configuración de Claude, en el apartado de skills.

⚠️ Antes de instalar cualquier skill externa, revisa su SKILL.md y si trae scripts.
