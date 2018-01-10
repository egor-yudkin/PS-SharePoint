# Functions to manage SharePoint-related Windows services across farm servers.
# Author: Egor Yudkin
# Modified: 12/27/2017

Function Restart-SPTimerService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Restarting SharePoint Timer service on $server"
	     Restart-Service -InputObject (Get-Service -ComputerName $server -Name "sptimerv4")
	    }
    }
}

Function Stop-SPTimerService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Stopping SharePoint Timer service on $server"
	     Stop-Service -InputObject (Get-Service -ComputerName $server -Name "sptimerv4")
	    }
    }
}

Function Start-SPTimerService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Starting SharePoint Timer service on $server"
	     Start-Service -InputObject (Get-Service -ComputerName $server -Name "sptimerv4")
	    }
    }
}

Function Restart-IISService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Restarting W3WP service on $server"
	     Restart-Service -InputObject (Get-Service -ComputerName $server -Name "w3svc")
	    }
    }
}

Function Stop-IISService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Stopping W3WP service on $server"
	     Stop-Service -InputObject (Get-Service -ComputerName $server -Name "w3svc")
	    }
    }
}

Function Start-IISService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Starting W3WP service on $server"
	     Start-Service -InputObject (Get-Service -ComputerName $server -Name "w3svc")
	    }
    }
}

Function Restart-SPAdminService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Restarting SharePoint Administration service on $server"
	     Restart-Service -InputObject (Get-Service -ComputerName $server -Name "spadminv4")
	    }
    }
}

Function Stop-SPAdminService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Stopping SharePoint Administration service on $server"
	     Stop-Service -InputObject (Get-Service -ComputerName $server -Name "spadminv4")
	    }
    }
}

Function Start-SPAdminService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Starting SharePoint Administration service on $server"
	     Start-Service -InputObject (Get-Service -ComputerName $server -Name "spadminv4")
	    }
    }
}

Function Enable-SPTimerService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Enabling SharePoint Timer service on $server"
	     Set-Service -InputObject (Get-Service -ComputerName $server -Name "sptimerv4") -StartupType Automatic
	    }
    }
}

Function Disable-SPTimerService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Enabling SharePoint Timer service on $server"
	     Set-Service -InputObject (Get-Service -ComputerName $server -Name "sptimerv4") -StartupType Disabled
	    }
    }
}

Function Enable-SPAdminService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Enabling SharePoint Administration service on $server"
	     Set-Service -InputObject (Get-Service -ComputerName $server -Name "spadminv4") -StartupType Automatic
	    }
    }
}

Function Disable-SPAdminService
{
    [CmdletBinding()]
    #region PARAMS
    param (
        [string[]]$ServerNames
    ) 
    #endregion PARAMS
    process {
	    if (!$ServerNames) {$ServerNames = (Get-SPServer | ?{$_.Role -ne [Microsoft.SharePoint.Administration.SPServerRole]::Invalid}).Name}
	    foreach ($server in $ServerNames) {
	     Write-Verbose "Enabling SharePoint Administration service on $server"
	     Set-Service -InputObject (Get-Service -ComputerName $server -Name "spadminv4") -StartupType Disabled
	    }
    }
}


<# 
Export-ModuleMember Restart-TimerServices,
                    Stop-TimerServices, 
                    Start-TimerServices, 
                    Restart-IISServices, 
                    Stop-IISServices, 
                    Start-IISServices, 
                    Restart-SPAdminServices, 
                    Stop-SPAdminServices, 
                    Start-SPAdminServices
                    #>