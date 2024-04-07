<#
    This function named ConvertStringTo-FourCharArrays takes a string input and splits it into an array of substrings, 
    each containing up to 4 characters. It iterates through the input string, extracting substrings of length 4 or less 
    until the entire string is processed. Finally, it returns the resulting array of substrings.

    You can call this function with any string, and it will return an array where each element contains up to 4 characters.

    # Example usage:
        $string = "000000000011000010100001010000100100110010011111101000010100001000000000000000000000"
        $array = ConvertStringTo-FourCharArrays -inputString $string
        Write-Output $array
            0000
            0000
            0011
            0000
            1010
            0001
            0100
            0010
            0100
            1100
            1001
            1111
            1010
            0001
            0100
            0010
            0000
            0000
            0000
            0000
            0000
#>

function ConvertStringTo-FourCharArrays {
    param (
        [string]$inputString
    )
    
    $result = @()
    $length = $inputString.Length
    $startIndex = 0
    
    while ($startIndex -lt $length) {
        $chunk = $inputString.Substring($startIndex, [Math]::Min(4, $length - $startIndex))
        $result += $chunk
        $startIndex += 4
    }
    
    return $result
}
