<#
    HUMAN:
    I need a powershell script to pull the history of reboots on a server
#>
<#
    AI:
    You can use the following script to get the reboot history of a Windows server:
#>

Get-EventLog -LogName System -Source User32 -After (Get-Date).AddDays(-30) | 
Where-Object {$_.EventID -eq '1074'} | 
Select-Object TimeGenerated, Message | 
Format-Table -AutoSize

<#
    AI:
    This script retrieves all the `1074` events from the `System` event log with the `User32` source that occurred in 
    the past 30 days. The `1074` event indicates that the system was shut down or restarted. The `Message` property of 
    the event log entry contains details about the shutdown or restart, including the reason and the user who 
    initiated it.

    You can adjust the number of days in the `AddDays()` method to specify a different time period. For example, to get 
    the reboot history for the past 90 days, you can use `AddDays(-90)`.

    You can also use the `-ComputerName` parameter of the `Get-EventLog` cmdlet to specify a remote computer. 
    For example:
#>

Get-EventLog -LogName System -Source User32 -ComputerName server1 -After (Get-Date).AddDays(-30) | 
Where-Object {$_.EventID -eq '1074'} | 
Select-Object TimeGenerated, Message | 
Format-Table -AutoSize

<#
    AI:
    This script retrieves the reboot history for the `server1` computer.
#>
