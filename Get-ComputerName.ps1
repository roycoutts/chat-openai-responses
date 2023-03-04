<#
    HUMAN:
    powershell get computer name
#>
<#
    AI:
    To get the computer name of a Windows machine using PowerShell, you can use the `$env:COMPUTERNAME` variable. This 
    variable stores the name of the computer as it is configured in the System Properties.

    Here's an example of how you can use it:
#>

$computerName = $env:COMPUTERNAME
Write-Output "Computer name: $computerName"

<#
    AI:
    This will output the computer name to the console. You can also use the `Write-Host` cmdlet to display the computer 
    name on the console:
#>

Write-Host "Computer name: $computerName"

<#
    AI:
    You can also use the `Get-WmiObject` cmdlet to retrieve the computer name using WMI 
    (Windows Management Instrumentation). Here's an example:
#>

$computerName = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty Name
Write-Output "Computer name: $computerName"

<#
    AI:
    This will also output the computer name to the console.
#>
