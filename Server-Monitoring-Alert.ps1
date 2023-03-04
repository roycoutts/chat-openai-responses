<#
    HUMAN:
    i need a powershell script that continuously monitors a server for common issues and provides early warning alerts 
    before the server experiences any performance issues or crashes
#>
<#
    AI:
    Sure! Here's an example PowerShell script that continuously monitors a server for common issues and sends early 
    warning alerts if any issues are detected:
#>

# Set up email alerting
$smtpServer = "smtp.gmail.com"  # Replace with your SMTP server
$smtpPort = 587  # Replace with the SMTP server port
$username = "youremail@gmail.com"  # Replace with your email address
$password = "yourpassword"  # Replace with your email password
$from = "youremail@gmail.com"  # Replace with your email address
$to = "youremail@gmail.com"  # Replace with the email address you want to receive alerts

# Set up monitoring parameters
$cpuThreshold = 80  # Percentage of CPU usage above which an alert is triggered
$memoryThreshold = 80  # Percentage of memory usage above which an alert is triggered
$diskThreshold = 80  # Percentage of disk usage above which an alert is triggered

# Continuously monitor the server
while ($true) {
    # Get current CPU usage
    $cpuUsage = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
    if ($cpuUsage -ge $cpuThreshold) {
        # Send CPU usage alert
        Send-MailMessage -SmtpServer $smtpServer -Port $smtpPort -UseSsl -Credential (New-Object System.Net.NetworkCredential($username, $password)) -From $from -To $to -Subject "High CPU usage detected" -Body "Current CPU usage is $cpuUsage%."
    }
    
    # Get current memory usage
    $memoryUsage = (Get-Counter '\Memory\% Committed Bytes In Use').CounterSamples.CookedValue
    if ($memoryUsage -ge $memoryThreshold) {
        # Send memory usage alert
        Send-MailMessage -SmtpServer $smtpServer -Port $smtpPort -UseSsl -Credential (New-Object System.Net.NetworkCredential($username, $password)) -From $from -To $to -Subject "High memory usage detected" -Body "Current memory usage is $memoryUsage%."
    }
    
    # Get current disk usage
    $diskUsage = (Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object -ExpandProperty FreeSpace) / (Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object -ExpandProperty Size) * 100
    if ($diskUsage -ge $diskThreshold) {
        # Send disk usage alert
        Send-MailMessage -SmtpServer $smtpServer -Port $smtpPort -UseSsl -Credential (New-Object System.Net.NetworkCredential($username, $password)) -From $from -To $to -Subject "High disk usage detected" -Body "Current disk usage is $diskUsage%."
    }
    
    # Wait for 5 minutes before checking again
    Start-Sleep -Seconds 300
}

<#
    AI:
    This script uses three performance counters (`'\Processor(_Total)\% Processor Time'`, 
    `'\Memory\% Committed Bytes In Use'`, and `Win32_LogicalDisk`) to monitor CPU, memory, and disk usage, 
    respectively. If any usage exceeds the specified thresholds (`$cpuThreshold`, `$memoryThreshold`, and 
    `$diskThreshold`), an email alert is sent to the specified recipient (`$to`) using the specified email credentials 
    (`$smtpServer`, `$smtpPort`, `$username`, and `$password`). The script then waits for 5 minutes before checking 
    again. You can customize the script by changing the email settings, monitoring parameters
#>
