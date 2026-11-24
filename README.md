# Arranque de entornos ASISA

Scripts para abrir los espacios de trabajo de desarrollo de ASISA desde Windows.

## Requisitos

- Windows con PowerShell.
- Visual Studio Code (`code`) disponible en `PATH` para los perfiles de integración, ronda principal y Seguridad de ronda.
- Git Bash instalado en `C:\Users\jgamezpo\AppData\Local\Programs\Git\git-bash.exe` para los perfiles que ejecutan launchers Bash.
- Los repositorios y directorios definidos en los scripts deben existir en las rutas configuradas.

## Uso

Desde PowerShell, en la carpeta de este proyecto:

```powershell
.\start-environment.ps1
```

Se mostrará un menú con estos perfiles:

1. **Proyecto Arranque**: inicia Git Bash, que ejecuta `start-arranque.sh` para abrir esta carpeta en una nueva ventana de VS Code.
2. **integracion desarrollos jasper**: inicia Git Bash y ejecuta `start-integracion-desarrollos-jasper.sh` para abrir en VS Code la preparación de migración, los desarrollos Jasper, la documentación interna y el código Java de Pólizas.
3. **Ronda principal**: inicia Git Bash, que ejecuta `start-ronda-principal.sh` para abrir tres ventanas de VS Code: el proyecto principal, el frontend y el backend.
4. **Seguridad de ronda**: inicia Git Bash, que ejecuta `start-seguridad-de-ronda.sh` para abrir tres ventanas de VS Code: el proyecto, el frontend y el backend de Seguridad.
5. **Suite mis programas HTML en local**: inicia Git Bash y ejecuta `start-suite-mis-programas-html-en-local.sh` para abrir la suite configurada en una nueva ventana de VS Code.
6. **Tests informes Jasper**: inicia Git Bash y ejecuta `start-tests-informes-jasper.sh` para abrir `C:\dev\modernizacion\Asisa\informesJasper\MigracionInformesJasper` en una nueva ventana de VS Code.
7. **Bonificación Seguridad Social**: inicia Git Bash y ejecuta `start-bonificacion-seguridad-social.sh` para abrir `C:\dev\BoniSS` en una nueva ventana de VS Code.
8. **boton desahogo**: inicia Git Bash y ejecuta `start-boton-desahogo.sh` para abrir `C:\dev\misReposGithubNTT\boton-desahogo` en una nueva ventana de VS Code.

También se puede elegir el perfil directamente:

```powershell
.\start-environment.ps1 -Profile arranque
.\start-environment.ps1 -Profile integration
.\start-environment.ps1 -Profile ronda-principal
.\start-environment.ps1 -Profile seguridad-de-ronda
.\start-environment.ps1 -Profile suite-mis-programas-html-en-local
.\start-environment.ps1 -Profile tests-informes-jasper
.\start-environment.ps1 -Profile bonificacion-seguridad-social
.\start-environment.ps1 -Profile boton-desahogo
```

## Rutas configuradas

El launcher de integración Jasper abre en ventanas separadas de VS Code:

- `Paso1PrepararMigracion`
- `jasper\informes_jasper`
- `documentacion\DocumentacionInterna`
- `polizas\Polizas` (código Java de Pólizas)

El perfil Proyecto Arranque abre la carpeta que contiene este proyecto. El perfil de ronda principal abre directorios bajo `C:\dev\modernizacion\Asisa\Ronda\Principal`, incluyendo el proyecto principal, `Frontend\Asisa.Ronda.Frontend` y `Backend`. El perfil de Seguridad de ronda abre `C:\dev\modernizacion\Asisa\Ronda\Seguridad` y sus carpetas `projects\ASISA\ModernizacionSeguridad\ModernizedApp\Frontend\qi-security-spa` y `projects\ASISA\ModernizacionSeguridad\ModernizedApp\Backend`. El perfil de tests de informes Jasper abre `C:\dev\modernizacion\Asisa\informesJasper\MigracionInformesJasper`. El perfil **boton desahogo** abre `C:\dev\misReposGithubNTT\boton-desahogo`.

Si los repositorios están en otra ubicación, actualiza las rutas en `start-environment.ps1` y en el launcher correspondiente (`start-ronda-principal.sh` o `start-seguridad-de-ronda.sh`) antes de ejecutar los scripts. Proyecto Arranque determina su carpeta a partir de la ubicación de `start-arranque.sh`. Los perfiles que usan Git Bash esperan encontrarlo en la ruta indicada en la sección de requisitos.

## Errores y validaciones

El perfil de integración comprueba que existan los directorios y que estén disponibles los comandos requeridos antes de abrir los entornos. Si falta alguno, muestra el elemento que debe instalarse, añadirse a `PATH` o corregirse. El perfil de ronda principal valida la ubicación de Git Bash y del script lanzador.
