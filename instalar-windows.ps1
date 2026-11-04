# Enlaza las skills y el CLAUDE.md de este repositorio con Claude Code (Windows).
# Uso: abre PowerShell en la carpeta del repo y ejecuta:  .\instalar-windows.ps1
# Intenta enlace simbólico (activa el Modo de desarrollador de Windows para no necesitar admin),
# luego junction (solo discos locales) y, si nada funciona, copia las skills.

$ErrorActionPreference = "Stop"
$repo      = $PSScriptRoot
$claudeDir = Join-Path $env:USERPROFILE ".claude"
$skillsDir = Join-Path $claudeDir "skills"

New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null

# 1. Skills: un enlace por skill (así conviven con las que instales desde fuera)
foreach ($skill in Get-ChildItem -Directory (Join-Path $repo "skills")) {
    $destino = Join-Path $skillsDir $skill.Name
    if (Test-Path $destino) {
        $item = Get-Item $destino -Force
        if ($item.LinkType) { $item.Delete() }   # borra solo el enlace, nunca el contenido del repo
        elseif (Test-Path (Join-Path $destino ".plaude")) { Remove-Item $destino -Recurse -Force }
        else {
            Rename-Item $destino "$($skill.Name).bak-$(Get-Date -Format yyyyMMddHHmmss)"
            Write-Host "  Copia de seguridad de la skill existente: $($skill.Name)"
        }
    }
    try {
        # Enlace simbólico: funciona con unidades de red (requiere Modo de desarrollador o admin)
        New-Item -ItemType SymbolicLink -Path $destino -Target $skill.FullName -ErrorAction Stop | Out-Null
        Write-Host "OK skill (enlace): $($skill.Name)"
    } catch {
        Write-Host "  (sin enlace simbólico: $($_.Exception.Message.Trim()))"
        try {
            # Junction: solo si el repo está en un disco local
            New-Item -ItemType Junction -Path $destino -Target $skill.FullName -ErrorAction Stop | Out-Null
            Write-Host "OK skill (junction): $($skill.Name)"
        } catch {
            # Último recurso: copia (vuelve a ejecutar el instalador después de cada git pull)
            Copy-Item $skill.FullName $destino -Recurse
            New-Item -ItemType File -Path (Join-Path $destino ".plaude") | Out-Null
            Write-Host "OK skill (copia): $($skill.Name)  -> tras 'git pull' vuelve a ejecutar este script"
        }
    }
}

# 2. CLAUDE.md global: importa el del repo
$globalMd  = Join-Path $claudeDir "CLAUDE.md"
$repoMd    = (Join-Path $repo "CLAUDE.md") -replace '\\', '/'
$importLin = "@$repoMd"

if (Test-Path $globalMd) {
    $contenido = Get-Content $globalMd -Raw
    if ($contenido -notmatch [regex]::Escape($importLin)) {
        Copy-Item $globalMd "$globalMd.bak-$(Get-Date -Format yyyyMMddHHmmss)"
        Add-Content $globalMd "`n$importLin"
        Write-Host "OK CLAUDE.md global: import añadido (copia de seguridad hecha)"
    } else { Write-Host "OK CLAUDE.md global: ya estaba enlazado" }
} else {
    Set-Content $globalMd $importLin -Encoding UTF8
    Write-Host "OK CLAUDE.md global creado"
}

Write-Host "`nListo. Abre Claude Code y ejecuta /memory para comprobar que carga el CLAUDE.md."
