# Arranque de entornos ASISA

Scripts para abrir los espacios de trabajo de desarrollo de ASISA desde Windows.

## Requisitos

- Windows con PowerShell.
- Windows Terminal (`wt.exe`), Visual Studio Code (`code`) y aXet.code (`axet-code.exe`) disponibles en `PATH` para el perfil de integración.
- Git Bash instalado en `C:\Users\jgamezpo\AppData\Local\Programs\Git\git-bash.exe` para los perfiles Proyecto Arranque y ronda principal.
- Los repositorios y directorios definidos en los scripts deben existir en las rutas configuradas.

## Uso

Desde PowerShell, en la carpeta de este proyecto:

```powershell
.\start-environment.ps1
```

Se mostrará un menú con estos perfiles:

1. **Proyecto Arranque**: inicia Git Bash, que ejecuta `start-arranque.sh` para abrir esta carpeta en una nueva ventana de VS Code.
2. **integracion desarrollos jasper**: abre una pestaña de Windows Terminal con aXet.code para cada entorno configurado. También abre en VS Code los entornos marcados para ello.
3. **Ronda principal**: inicia Git Bash, que ejecuta `start-ronda-principal.sh` para abrir tres ventanas de VS Code: el proyecto principal, el frontend y el backend.
4. **Suite mis programas HTML en local**: inicia Git Bash y ejecuta `start-suite-mis-programas-html-en-local.sh` para abrir la suite configurada en una nueva ventana de VS Code.
5. **Tests informes Jasper**: inicia Git Bash y ejecuta `start-tests-informes-jasper.sh` para abrir `C:\dev\modernizacion\Asisa\informesJasper\MigracionInformesJasper` en una nueva ventana de VS Code.

También se puede elegir el perfil directamente:

```powershell
.\start-environment.ps1 -Profile arranque
.\start-environment.ps1 -Profile integration
.\start-environment.ps1 -Profile ronda-principal
.\start-environment.ps1 -Profile suite-mis-programas-html-en-local
.\start-environment.ps1 -Profile tests-informes-jasper
```

## Rutas configuradas

El perfil de integración usa directorios bajo `C:\dev\modernizacion\Asisa\informesJasper\Implantaciones`:

- `Paso1PrepararMigracion`
- `jasper\informes_jasper`
- `documentacion\DocumentacionInterna`
- `BaremoJava\Baremo`

El perfil Proyecto Arranque abre la carpeta que contiene este proyecto. El perfil de ronda principal abre directorios bajo `C:\dev\modernizacion\Asisa\Ronda\Principal`, incluyendo el proyecto principal, `Frontend\Asisa.Ronda.Frontend` y `Backend`. El perfil de tests de informes Jasper abre `C:\dev\modernizacion\Asisa\informesJasper\MigracionInformesJasper`.

Si los repositorios están en otra ubicación, actualiza las rutas en `start-environment.ps1` y `start-ronda-principal.sh` antes de ejecutar los scripts. Proyecto Arranque determina su carpeta a partir de la ubicación de `start-arranque.sh`. Los perfiles que usan Git Bash esperan encontrarlo en la ruta indicada en la sección de requisitos.

## Errores y validaciones

El perfil de integración comprueba que existan los directorios y que estén disponibles los comandos requeridos antes de abrir los entornos. Si falta alguno, muestra el elemento que debe instalarse, añadirse a `PATH` o corregirse. El perfil de ronda principal valida la ubicación de Git Bash y del script lanzador.
