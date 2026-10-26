# Arranque de entornos ASISA

Scripts para abrir los espacios de trabajo de desarrollo de ASISA desde Windows.

## Requisitos

- Windows con PowerShell.
- Windows Terminal (`wt.exe`), Visual Studio Code (`code`) y aXet.code (`axet-code.exe`) disponibles en `PATH` para el perfil de integración.
- Git Bash instalado en `C:\Users\jgamezpo\AppData\Local\Programs\Git\git-bash.exe` para el perfil de ronda principal.
- Los repositorios y directorios definidos en los scripts deben existir en las rutas configuradas.

## Uso

Desde PowerShell, en la carpeta de este proyecto:

```powershell
.\start-environment.ps1
```

Se mostrará un menú con estos perfiles:

1. **Integración de desarrollos**: abre una pestaña de Windows Terminal con aXet.code para cada entorno configurado. También abre en VS Code los entornos marcados para ello.
2. **Ronda principal**: inicia Git Bash, que ejecuta `start-ronda-principal.sh` para abrir tres ventanas de VS Code: el proyecto principal, el frontend y el backend.

También se puede elegir el perfil directamente:

```powershell
.\start-environment.ps1 -Profile integration
.\start-environment.ps1 -Profile ronda-principal
```

## Rutas configuradas

El perfil de integración usa directorios bajo `C:\dev\modernizacion\Asisa\informesJasper\Implantaciones`:

- `Paso1PrepararMigracion`
- `jasper\informes_jasper`
- `documentacion\DocumentacionInterna`
- `BaremoJava\Baremo`

El perfil de ronda principal abre directorios bajo `C:\dev\modernizacion\Asisa\Ronda\Principal`, incluyendo el proyecto principal, `Frontend\Asisa.Ronda.Frontend` y `Backend`.

Si los repositorios están en otra ubicación, actualiza las rutas en `start-environment.ps1` y `start-ronda-principal.sh` antes de ejecutar los scripts. El perfil de ronda principal también espera encontrar Git Bash en la ruta indicada en la sección de requisitos.

## Errores y validaciones

El perfil de integración comprueba que existan los directorios y que estén disponibles los comandos requeridos antes de abrir los entornos. Si falta alguno, muestra el elemento que debe instalarse, añadirse a `PATH` o corregirse. El perfil de ronda principal valida la ubicación de Git Bash y del script lanzador.
