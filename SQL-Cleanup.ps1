# SQL Cleanup Script.  Modify Essential apps as needed
# Josh Seyer/Chat GPT
# v0.0.1 7/11/2023

$essentialApps = @(
    #"Microsoft SQL Server"
    #"SQL Server"
    "SQL Native Client"
)

$uninstallString = 'MsiExec.exe /X "{0}" /qn'

$apps = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*SQL*" -or $_.Description -like "*SQL*" }

foreach ($app in $apps) {
    if ($essentialApps -notcontains $app.Name) {
        Write-Host "Uninstalling $($app.Name)..."
        $uninstallCmd = $uninstallString -f $app.IdentifyingNumber
        Start-Process -FilePath cmd.exe -ArgumentList "/C $uninstallCmd" -Wait
    }
}

Write-Host "Uninstallation complete."
