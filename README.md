<div align="center">

# plaude

**Skills y configuración para trabajar con Claude y Claude Code sin pelearse con él.**

[![Licencia MIT](https://img.shields.io/badge/licencia-MIT-blue.svg)](LICENSE)
![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-d97757)
![Claude app](https://img.shields.io/badge/Claude%20app-compatible-d97757)
![Windows | macOS | Linux](https://img.shields.io/badge/Windows%20%7C%20macOS%20%7C%20Linux-lightgrey)

</div>

---

## Por qué existe

Claude escribe bien, pero sin guía acaba metiendo comentarios que no hacen falta, abstracciones que nadie pidió, diseños que gritan "esto lo ha hecho una IA" y un "listo" que no ha comprobado nadie.

**plaude** junta las skills que uso a diario para evitar eso. Algunas son mías y otras son de gente que lo hace mejor que yo. La idea es que cubran todo el ciclo (preguntar, diseñar, programar, limpiar, asegurar y probar) **sin que dos skills hagan lo mismo**.

## Sobre el nombre

El nombre viene de Carlos, compañero de trabajo, que empezó a llamarme Plaude por tener siempre Claude abierto. Empezó como broma y se quedó. **plaude** va por él.

---

## Cómo está montado

Una regla: **una necesidad, una skill**.

- **Si alguien ya lo ha resuelto bien**, se usa su skill y se instala desde su repo, con la licencia de su autor.
- **Si lo que existe no encaja**, porque es demasiado genérico o no sabe nada de PHP, WordPress o catalán, hay una skill propia.

### Qué cubre cada una

| Fase | Skill | Origen |
|---|---|---|
| Entender qué hay que hacer | [`grill-me`](skills/grill-me/SKILL.md) | **plaude** |
| No complicar las cosas | `karpathy-guidelines` | externa |
| Dirección visual | `frontend-design` | externa (oficial de Anthropic) |
| Consulta de estilos, paletas y tipografías | `ui-ux-pro-max` | externa opcional |
| Referencias visuales y movimiento | [`no-ai-look`](skills/no-ai-look/SKILL.md) | **plaude** |
| Implementación frontend y compatibilidad entre navegadores | `modern-web-guidance` | externa (Google Chrome) |
| Detectar herramientas y versiones de un proyecto WordPress | `wp-project-triage` | externa (WordPress) |
| Arquitectura y ciclo de vida de plugins | `wp-plugin-development` | externa (WordPress) |
| Desarrollo de bloques y temas de bloques | `wp-block-development`, `wp-block-themes` | externas opcionales (WordPress) |
| Limpiar código generado por IA | [`deslop-safe`](skills/deslop-safe/SKILL.md) | **plaude** |
| Revisión de código y seguridad de los cambios | `code-review`, `security-review` | nativas de Claude Code |
| Escaneos de seguridad (CodeQL, Semgrep) | `static-analysis` | externa (Trail of Bits) |
| Seguridad PHP y WordPress | [`wordpress-hardening`](skills/wordpress-hardening/SKILL.md) | **plaude** |
| Comprobaciones puntuales en el navegador | `webapp-testing` | externa (oficial de Anthropic) |
| Levantar un WordPress desechable | `wp-playground` | externa (WordPress) |
| Escribir pruebas automatizadas de WordPress | [`wordpress-testing`](skills/wordpress-testing/SKILL.md) | **plaude** |
| Revisión antes de producción | [`preflight-check`](skills/preflight-check/SKILL.md) | **plaude** |
| Textos en catalán y castellano | [`copywriter-ca-es`](skills/copywriter-ca-es/SKILL.md) | **plaude** |

---

## Las skills de plaude

### `grill-me`
Antes de programar, pregunta una cosa cada vez y propone siempre una respuesta recomendada, hasta aclarar las decisiones importantes. Lo que puede averiguar leyendo el código no lo pregunta. Termina con un resumen y pasa al plan.

**Por qué propia:** parte de la idea de la `grill-me` de Matt Pocock, pero aquella ya solo delega en otra skill y Claude no puede lanzarla por su cuenta. Esta funciona sola y Claude la usa sin que haya que pedírselo.

### `deslop-safe`
Repasa el código que ha escrito la IA y quita lo que sobra: comentarios que repiten el código, `try/catch` que no hacen nada, clases que se usan una vez, logs olvidados, mensajes de error con emojis. No toca el comportamiento.

**Por qué propia:** las versiones públicas (deslop y similares) están bien, pero no saben que en WordPress un nonce o un `esc_html` no son "código defensivo innecesario". Esta sí lo sabe, y no se carga la seguridad por limpiar.

### `no-ai-look`
Ayuda a encontrar referencias concretas y a decidir cómo animar con criterio. En una interfaz existente, parte de su marca y componentes y revisa los cambios con contenido real en móvil y escritorio.

**Por qué propia:** reúne mis referencias visuales y los criterios de movimiento que uso para decidir cuándo basta CSS y cuándo hace falta algo más.

### `wordpress-hardening`
Reglas concretas para PHP y WordPress sobre validación, escapado, nonces, permisos, consultas, subidas de archivos, sesiones y dependencias. Sirve para escribir código y para auditarlo con los controles de OWASP ASVS que apliquen. El informe ordena los hallazgos por gravedad.

**Por qué propia:** las de Trail of Bits son muy buenas pero genéricas. Esta conoce las funciones de WordPress por su nombre.

### `wordpress-testing`

Ayuda a dejar una regresión reproducible en el proyecto. Usa PHPUnit con WordPress para comprobar hooks, permisos, guardado y migraciones, y Playwright para recorridos que necesitan un navegador.

### `preflight-check`
La última revisión antes de subir. Comprueba que funciona (con pruebas reales, no a ojo), la seguridad, el rendimiento, la accesibilidad, el SEO, la limpieza y el plan de despliegue. Llama a las demás skills cuando las necesita y termina con un veredicto:

- 🟢 Listo para producción
- 🟡 Listo con avisos
- 🔴 No listo

Nunca da 🟢 si algo no se ha podido comprobar.

**Por qué propia:** no hay ninguna pública que junte todo esto con un veredicto claro al final.

### `copywriter-ca-es`
Textos para webs, avisos, emails y redes, en catalán y castellano. Cada idioma se escribe como lo haría alguien que lo habla, no traducido uno del otro. Tiene vetadas las frases típicas de IA ("en el mundo actual", "lleva tu negocio al siguiente nivel"…).

**Por qué propia:** nadie va a publicar una skill para escribir en catalán como se habla aquí.

---

## Instalación

### Claude Code

Clonar el repo y ejecutar el instalador. El instalador:

- Enlaza cada skill en `~/.claude/skills/`. No las copia, así que un `git pull` las actualiza.
- Añade el `CLAUDE.md` del repo al `~/.claude/CLAUDE.md` global.
- Hace copia de seguridad de cualquier archivo existente con el mismo nombre.

**macOS / Linux**
```bash
git clone https://github.com/pmirof/plaude.git
cd plaude
bash instalar-mac.sh
```

**Windows (PowerShell)**
```powershell
git clone https://github.com/pmirof/plaude.git
cd plaude
.\instalar-windows.ps1
```

> [!TIP]
> En Windows conviene activar el **Modo de desarrollador** (Configuración → "desarrollador") para que el instalador pueda crear enlaces sin permisos de administrador. Sin él, las skills se copian y hay que volver a ejecutar el instalador después de cada `git pull`.

Para comprobar la instalación: abrir Claude Code, ejecutar `/memory` (debe aparecer el `CLAUDE.md`) y preguntar qué skills tiene disponibles.

### Skills externas

Se instalan por separado desde su autor original. Los comandos están en [EXTERNAS.md](EXTERNAS.md).

### App de Claude (web, escritorio, móvil)

Comprimir la carpeta de la skill (por ejemplo `skills/preflight-check/`) en un ZIP y subirla en la configuración de Claude, en el apartado de skills. Queda guardada en la cuenta y disponible en todos los dispositivos.

---

## Estructura

```
plaude/
├── CLAUDE.md               instrucciones globales
├── EXTERNAS.md             skills de terceros y cómo instalarlas
├── skills/
│   ├── copywriter-ca-es/
│   ├── deslop-safe/
│   ├── grill-me/
│   ├── no-ai-look/
│   ├── preflight-check/
│   ├── wordpress-hardening/
│   └── wordpress-testing/
├── instalar-mac.sh
├── instalar-windows.ps1
└── LICENSE
```

## Personalización

El `CLAUDE.md` está escrito para un flujo concreto: castellano, PHP y WordPress, y textos en catalán. Lo recomendable es hacer un fork, adaptarlo y quitar las skills que no se usen. Con pocas skills bien escogidas, Claude acierta más que con veinte.

## Contribuir

Issues y PRs bienvenidos, sobre todo si una skill falla en un caso concreto. Única condición: que una skill nueva no se solape con otra que ya exista.

## Créditos

- **Pau**, autor de **plaude**.
- **Carlos**, por el nombre.
- **Claude**, que ayudó a escribir las skills y, de paso, este README.
- [Matt Pocock](https://github.com/mattpocock/skills), por la idea de `grill-me`.
- [forrestchang](https://github.com/forrestchang/andrej-karpathy-skills) (a partir de las ideas de Andrej Karpathy), [Anthropic](https://github.com/anthropics/skills), [nextlevelbuilder](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) y [Trail of Bits](https://github.com/trailofbits/skills), por las skills externas.
- [Google Chrome y colaboradores](https://github.com/GoogleChrome/modern-web-guidance), por `modern-web-guidance`.
- [WordPress y sus colaboradores](https://github.com/WordPress/agent-skills), por las skills oficiales de WordPress.

## Licencia

[MIT](LICENSE) para todo lo que hay en este repo. Las skills externas tienen la licencia de sus autores.
