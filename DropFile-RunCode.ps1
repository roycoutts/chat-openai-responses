<#
    HUMAN:
    i need a powershell script that will watch a drop folder for new powershell scripts that will be dropped there. 
    when the new file is found, the powershell script in the file will be executed
#>
<#
    AI:
    Here's an example PowerShell script that watches a drop folder for new PowerShell scripts and executes them when 
    they are dropped:
#>

# Set the path to the drop folder
$dropFolderPath = "C:\DropFolder"

# Create a FileSystemWatcher object to watch for changes to the drop folder
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $dropFolderPath
$watcher.Filter = "*.ps1"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# Define the action to take when a new file is dropped in the folder
$action = {
    # Get the path of the new file
    $path = $Event.SourceEventArgs.FullPath

    # Execute the PowerShell script in the new file
    Invoke-Expression (Get-Content $path -Raw)
}

# Register the action with the FileSystemWatcher object
$watcher.Add_Changed($action)

# Wait for the script to be interrupted
try {
    while ($true) {
        Start-Sleep -Seconds 1
    }
} finally {
    # Clean up the FileSystemWatcher object
    $watcher.Dispose()
}

<#
    AI:
    In this script, a `FileSystemWatcher` object is created to watch for changes to the drop folder. When a new file 
    with a `.ps1` extension is created in the folder, the script in the file is executed using the `Invoke-Expression` 
    cmdlet.

    The action to take when a new file is created is defined using a script block, and is registered with the 
    `Add_Changed` method of the `FileSystemWatcher` object.

    The script waits for the script to be interrupted using a `try`/`finally` block, and cleans up the 
    `FileSystemWatcher` object when the script exits.
#>
