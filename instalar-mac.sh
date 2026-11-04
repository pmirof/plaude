#!/usr/bin/env bash
# Enlaza las skills y el CLAUDE.md de este repositorio con Claude Code (macOS / Linux).
# Uso: en la carpeta del repo ejecuta:  bash instalar-mac.sh
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
STAMP="$(date +%Y%m%d%H%M%S)"

mkdir -p "$SKILLS_DIR"

# 1. Skills: un enlace por skill (así conviven con las que instales desde fuera)
for d in "$REPO"/skills/*/; do
  name="$(basename "$d")"
  dest="$SKILLS_DIR/$name"
  if [ -L "$dest" ]; then rm "$dest"
  elif [ -e "$dest" ]; then mv "$dest" "$dest.bak-$STAMP"; echo "  Copia de seguridad de la skill existente: $name"
  fi
  ln -s "${d%/}" "$dest"
  echo "OK skill: $name"
done

# 2. CLAUDE.md global: importa el del repo
GLOBAL_MD="$CLAUDE_DIR/CLAUDE.md"
IMPORT_LINE="@$REPO/CLAUDE.md"

if [ -f "$GLOBAL_MD" ]; then
  if ! grep -qF "$IMPORT_LINE" "$GLOBAL_MD"; then
    cp "$GLOBAL_MD" "$GLOBAL_MD.bak-$STAMP"
    printf '\n%s\n' "$IMPORT_LINE" >> "$GLOBAL_MD"
    echo "OK CLAUDE.md global: import añadido (copia de seguridad hecha)"
  else
    echo "OK CLAUDE.md global: ya estaba enlazado"
  fi
else
  echo "$IMPORT_LINE" > "$GLOBAL_MD"
  echo "OK CLAUDE.md global creado"
fi

echo
echo "Listo. Abre Claude Code y ejecuta /memory para comprobar que carga el CLAUDE.md."
