$DefaultModuleSaveDir = Join-Path -Path $HOME -ChildPath 'powershell' | Join-Path -ChildPath 'modules'

function Assert-ModuleSaveDirInPsModulePath {
    [CmdletBinding()]
    param (
        [ValidateSet( 'Both', 'User', 'Session' )]
        [string] $EnvironmentVariableTarget = 'Both',

        $ModuleSaveDir = $DefaultModuleSaveDir
    )
    if ( $EnvironmentVariableTarget -eq 'Both' -or $EnvironmentVariableTarget -eq 'Session' ) {
        $PathList = $env:PSModulePath -split ';'
        if ( $PathList -notcontains $ModuleSaveDir ) {
            $PathList += $ModuleSaveDir
            $env:PSModulePath = $PathList -join ';'
        }
    }
    if ( $EnvironmentVariableTarget -eq 'Both' -or $EnvironmentVariableTarget -eq 'User' ) {
        $PathList = ( [System.Environment]::GetEnvironmentVariables('PsModulePath') ) -split ';'
        if ( $PathList -notcontains $ModuleSaveDir ) {
            $PathList += $ModuleSaveDir
            [System.Environment]::SetEnvironmentVariable('PsModulePath', ( $PathList -join ';' ), 'User')
        }
    }
}

Get-SavedModule
Update-SavedModule
Uninstall-SavedModule