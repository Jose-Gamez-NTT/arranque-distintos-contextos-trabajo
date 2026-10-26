[CmdletBinding()]
param(
    [ValidateSet('integration', 'ronda-principal')]
    [string]$Profile
)

$integrationEnvironments = @(
    [pscustomobject]@{
        Name          = 'Preparar migracion'
        Path          = 'C:\dev\modernizacion\Asisa\informesJasper\Implantaciones\Paso1PrepararMigracion'
        OpenInVSCode  = $false
    },
    [pscustomobject]@{
        Name          = 'Informes Jasper'
        Path          = 'C:\dev\modernizacion\Asisa\informesJasper\Implantaciones\jasper\informes_jasper'
        OpenInVSCode  = $true
    },
    [pscustomobject]@{
        Name          = 'Documentacion interna'
        Path          = 'C:\dev\modernizacion\Asisa\informesJasper\Implantaciones\documentacion\DocumentacionInterna'
        OpenInVSCode  = $true
    },
    [pscustomobject]@{
        Name          = 'Baremo Java'
        Path          = 'C:\dev\modernizacion\Asisa\informesJasper\Implantaciones\BaremoJava\Baremo'
        OpenInVSCode  = $true
    }
)

function Test-CommandAvailable {
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    $command = Get-Command -Name $Name -ErrorAction SilentlyContinue
    if (-not $command) {
        throw "No se encontro la dependencia requerida: $Name. Instalela o agreguela al PATH."
    }

    return $command
}

function Test-Environment {
    param(
        [Parameter(Mandatory)]
        [object[]]$Environments
    )

    $missingPaths = @(
        $Environments |
            Where-Object { -not (Test-Path -LiteralPath $_.Path -PathType Container) } |
            ForEach-Object { "[$($_.Name)] $($_.Path)" }
    )

    if ($missingPaths.Count -gt 0) {
        throw "No se encontraron los siguientes directorios:`n$($missingPaths -join "`n")"
    }

    return @{
        AxetCode       = Test-CommandAvailable -Name 'axet-code.exe'
        WindowsTerminal = Test-CommandAvailable -Name 'wt.exe'
        VSCode         = Test-CommandAvailable -Name 'code'
    }
}

function Start-AxetTerminal {
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Environment,

        [Parameter(Mandatory)]
        [System.Management.Automation.CommandInfo]$WindowsTerminalCommand
    )

    $escapedPath = $Environment.Path.Replace("'", "''")
    $encodedCommand = [Convert]::ToBase64String(
        [System.Text.Encoding]::Unicode.GetBytes("Set-Location -LiteralPath '$escapedPath'; & axet-code.exe -y")
    )
    $arguments = "-w 0 new-tab --title `"$($Environment.Name)`" --startingDirectory `"$($Environment.Path)`" powershell.exe -NoExit -EncodedCommand $encodedCommand"

    Start-Process -FilePath $WindowsTerminalCommand.Source -ArgumentList $arguments
}

function Open-VSCode {
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Environment,

        [Parameter(Mandatory)]
        [System.Management.Automation.CommandInfo]$VSCodeCommand
    )

    & $VSCodeCommand.Source $Environment.Path
}

function Start-DevelopmentEnvironment {
    param(
        [Parameter(Mandatory)]
        [object[]]$Environments
    )

    $dependencies = Test-Environment -Environments $Environments

    foreach ($environment in $Environments) {
        Write-Host "Abriendo $($environment.Name)..."
        Start-AxetTerminal -Environment $environment -WindowsTerminalCommand $dependencies.WindowsTerminal

        if ($environment.OpenInVSCode) {
            Open-VSCode -Environment $environment -VSCodeCommand $dependencies.VSCode
        }
    }
}

function Start-IntegrationProfile {
    Start-DevelopmentEnvironment -Environments $integrationEnvironments
}

function Start-RondaPrincipal {
    $gitBashPath = 'C:\Users\jgamezpo\AppData\Local\Programs\Git\git-bash.exe'
    $launcherPath = 'C:\dev\Arranque\start-ronda-principal.sh'

    if (-not (Test-Path -LiteralPath $gitBashPath -PathType Leaf)) {
        throw "No se encontro Git Bash: $gitBashPath"
    }

    if (-not (Test-Path -LiteralPath $launcherPath -PathType Leaf)) {
        throw "No se encontro el script de arranque: $launcherPath"
    }

    Start-Process -FilePath $gitBashPath -ArgumentList @('--cd-to-home', '-c', '"bash /c/dev/Arranque/start-ronda-principal.sh"')
}

function Show-ProfileMenu {
    Clear-Host
    Write-Host '========================================'
    Write-Host ' Entorno ASISA - Informes Jasper'
    Write-Host '========================================'
    Write-Host ''
    Write-Host '1. Integracion de desarrollos'
    Write-Host '2. Ronda principal'
    Write-Host '0. Salir'
    Write-Host ''

    switch (Read-Host 'Seleccione perfil') {
        '1' { return 'integration' }
        '2' { return 'ronda-principal' }
        '0' { return $null }
        default { throw 'Seleccion no valida. Use 0, 1 o 2.' }
    }
}

try {
    if (-not $Profile) {
        $Profile = Show-ProfileMenu
    }

    switch ($Profile) {
        'integration' { Start-IntegrationProfile }
        'ronda-principal' { Start-RondaPrincipal }
        $null { }
    }
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
