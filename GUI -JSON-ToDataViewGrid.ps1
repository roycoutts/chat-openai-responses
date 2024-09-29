# Question to CHAT.OPENAI.COM/CHAT
<#
Can you create a powershell script GUI with the following elements on the form:
- A comboBox with 2 options: "Opt 1", "Opt 2"
- A button when clicked will read the c:\tmp\json.json file
- The form should have the following columns:
      - Column 1 should be labeled: Timestamp
        (This column should show the last 3 records with the newest one on top)
      - Column 2 should be labeled: Val 1
        (This column should show the last 3 records with the newest one on top)
      - Column 3 should be labeled: Change
        (This column should show the change if value from Val 1 from the previous record of Val 1)
      - Column 4 should be labeled: Val 2
        (This column should show the last 3 records with the newest one on top)
      - Column 5 should be labeled: Change
        (This column should show the change if value from Val 2 from the previous record of Val 2)
      - Column 6 should be labeled: Val 3
        (This column should show the last 3 records with the newest one on top)
      - Column 7 should be labeled: Change
        (This column should show the change if value from Val 3 from the previous record of Val 3)
#>
# AI Response
<#
To achieve this in PowerShell with a GUI, we'll use Windows Forms (System.Windows.Forms) to create the UI. 
The following script creates a form with the elements you've requested: a ComboBox, a Button to load the JSON file, 
and a DataGridView that shows the last three records from the json.json file, including changes in values between the records.
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "JSON Data Viewer"
$form.Size = New-Object System.Drawing.Size(700,400)

# Create ComboBox with 2 options
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Items.AddRange(@("Opt 1", "Opt 2"))
$comboBox.Location = New-Object System.Drawing.Point(10, 10)
$comboBox.Size = New-Object System.Drawing.Size(100, 20)

# Create a Button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Load JSON"
$button.Location = New-Object System.Drawing.Point(120, 10)
$button.Size = New-Object System.Drawing.Size(100, 20)

# Create a DataGridView for the columns
$dataGridView = New-Object System.Windows.Forms.DataGridView
$dataGridView.Location = New-Object System.Drawing.Point(10, 50)
$dataGridView.Size = New-Object System.Drawing.Size(660, 300)
$dataGridView.ColumnCount = 7
$dataGridView.Columns[0].Name = "Timestamp"
$dataGridView.Columns[1].Name = "Val 1"
$dataGridView.Columns[2].Name = "Change"
$dataGridView.Columns[3].Name = "Val 2"
$dataGridView.Columns[4].Name = "Change"
$dataGridView.Columns[5].Name = "Val 3"
$dataGridView.Columns[6].Name = "Change"

# Add ComboBox and Button to the form
$form.Controls.Add($comboBox)
$form.Controls.Add($button)
$form.Controls.Add($dataGridView)

# Function to calculate the change between values
function Calculate-Change {
    param($currentValue, $previousValue)
    if ($null -eq $previousValue) {
        return ""
    } else {
        return ($currentValue - $previousValue)
    }
}

# Event handler for the button click
$button.Add_Click({
    $jsonFile = 'c:\tmp\json.json'
    
    if (Test-Path $jsonFile) {
        # Load the JSON file
        $jsonContent = Get-Content -Path $jsonFile -Raw
        $dataList = $jsonContent | ConvertFrom-Json
        
        # Take the last 3 records
        $lastThreeRecords = $dataList | Select-Object -Last 3 | Sort-Object Timestamp -Descending

        # Clear existing rows in DataGridView
        $dataGridView.Rows.Clear()

        # Add the last 3 records to DataGridView
        for ($i = 0; $i -lt $lastThreeRecords.Count; $i++) {
            $record = $lastThreeRecords[$i]

            $previousRecord = if ($i -lt ($lastThreeRecords.Count - 1)) { $lastThreeRecords[$i+1] } else { $null }

            # Calculate changes
            $val1Change = Calculate-Change $record.Val1 ($previousRecord.Val1)
            $val2Change = Calculate-Change $record.Val2 ($previousRecord.Val2)
            $val3Change = Calculate-Change $record.Val3 ($previousRecord.Val3)

            # Add rows to DataGridView
            $dataGridView.Rows.Add(
                $record.Timestamp,
                $record.Val1, $val1Change,
                $record.Val2, $val2Change,
                $record.Val3, $val3Change
            )
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("File not found: $jsonFile")
    }
})

# Run the form
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()
