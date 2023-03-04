<#
    HUMAN:
    powershell get ip address
#>
<#
    AI:
    To get the IP address of a Windows machine using PowerShell, you can use the `Get-NetIPAddress` cmdlet. This cmdlet 
    is part of the `NetTCPIP` module, which is included in Windows by default.

    Here's an example of how you can use it:
#>

Get-NetIPAddress | Select-Object -Property InterfaceAlias, IPAddress

<#
    AI:
    This will display a list of all the IP addresses assigned to the machine, along with the interface alias 
    (e.g., "Ethernet" or "Wi-Fi") for each address.

    You can also use the `Get-WmiObject` cmdlet to retrieve the IP address using WMI 
    (Windows Management Instrumentation). Here's an example:
#>

Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object {$_.IPAddress -ne $null} | Select-Object -Property Description, IPAddress

<#
    AI:
    This will display a list of all the IP addresses assigned to the machine, along with the description 
    (e.g., "Intel(R) Ethernet Connection I217-LM") of the network adapter for each address.

    You can also use the `Get-NetIPConfiguration` cmdlet to retrieve the IP address and other IP configuration 
    information. This cmdlet is part of the `NetTCPIP` module as well. Here's an example:
#>

Get-NetIPConfiguration | Select-Object -Property InterfaceAlias, IPv4Address

<#
    AI:
    This will display a list of all the IPv4 addresses assigned to the machine, along with the interface alias for 
    each address.
#>
