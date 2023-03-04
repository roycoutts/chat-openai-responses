<#
    HUMAN:
    i need a powershell script that can act as a listener for other powershell scripts to send request to and return 
    the results back to the requesting script
#>
<#
    AI:
    To create a PowerShell script listener, you can use the `Register-EngineEvent` cmdlet to register an event handler 
    for the `New-Event` cmdlet. This event will be triggered whenever a new event is created in PowerShell.

    Here's an example PowerShell script listener that listens for events named "MyEvent", executes the script block 
    in the event message, and returns the result back to the calling script:
#>

# Register an event handler for the "MyEvent" event
Register-EngineEvent -SourceIdentifier "MyEvent" -Action {
    $event = $event.MessageData

    # Execute the script block from the event message
    $result = Invoke-Command -ScriptBlock $event.ScriptBlock
    
    # Return the result back to the calling script
    $event.Sender | Out-Default -InputObject $result
}

# Wait for incoming events
while ($true) {
    # Do nothing, just wait for events
    Start-Sleep -Seconds 1
}

<#
    AI:
    To send a request to the listener and receive the result back, you can use the `New-Event` cmdlet to create a new 
    event with a script block containing your request, and use the `-Wait` parameter to wait for the result to be 
    returned:
#>

# Send a request to the listener
$result = New-Event -SourceIdentifier "MyEvent" -MessageData @{
    ScriptBlock = {
        # Your script code goes here...
        "Hello, world!"
    }
} -Wait

# Display the result returned from the listener
Write-Host "Result: $result"

<#
    AI:
    In this example, replace the script block in the `New-Event` cmdlet with the code you want to execute on the 
    listener. The result returned by the listener will be stored in the `$result` variable. Note that the `-Wait` 
    parameter is used to wait for the result to be returned.
#>

