<#
    HUMAN:
    powershell convert csv into pscustomobject
#>
<#
    AI:
    You can use the `Import-Csv` cmdlet in PowerShell to convert a CSV file into an object, and then use the 
    `Select-Object` cmdlet to convert the object into a `PSCustomObject`. Here's an example of how you can do this:
#>

$csv = Import-Csv -Path 'path\to\your.csv'
$customObject = $csv | Select-Object *

<#
    AI:
    In this example, `Import-Csv` is used to read the CSV file at the specified path and convert its contents into an 
    object. The `Select-Object` cmdlet is then used to convert the object into a `PSCustomObject`.

    You can also use the -Header Parameter of the Import-Csv cmdlet to change the Column names of your pscustomobject.
#>

$csv = Import-Csv -Path 'path\to\your.csv' -Header 'Col1','Col2','Col3'

<#
    AI:
    This way, you can customize the column names as per your requirement.
#>
<#
    HUMAN:
    I'm getting an error. 
    'Import-Csv :  The member "Created By" is already present. '
#>
<#
    AI:
    The error message you're seeing is indicating that one or more column headers in your CSV file are not unique.
    `Import-Csv` cmdlet compares the headers of the CSV file with the properties of the `PSCustomObject` class. When it 
    finds a column header that matches the name of a property of the `PSCustomObject` class, it will use that column's 
    data to populate the corresponding property of the object.

    If the column headers are not unique, PowerShell will not be able to determine which column to use to populate a 
    particular property.

    You can either change the headers of your CSV file to be unique, or you can use the `-Header` parameter when you 
    call `Import-Csv` to specify the names of the columns.

    Another way is to use the '-Force' parameter in Import-Csv, which will ignore the column already existing in 
    pscustomobject class and import the data to that column.
#>

$csv = Import-Csv -Path 'path\to\your.csv' -Header 'Col1','Col2','Col3' -Force

<#
    AI:
    This way you can import the csv even if the headers are not unique and do not match the properties of the 
    `PSCustomObject` class.
#>
