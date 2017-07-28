<#
.SYNOPSIS
Robert Allen @TheMasterPrawn
Splits a csv file into a number of files each containing N batches.

.PARAMETER filePath
The path to the CSV file you need to extract the batches from.

.PARAMETER batchesOf
How many rows from the input CSV do you want in each file.

.PARAMETER outputFilesPath
Path to the directory containing the files containing the batches. 

.EXAMPLE

.\Split-CSVintoBatches -filePath c:\someplace\somefile.csv 
Takes c:\someplace\somefile.csv and creates files with 5 entries each (default) in the current working directory

.EXAMPLE
.\Split-CSVintoBatches -filePath c:\someplace\somefile.csv -batchesOf 100
Takes c:\someplace\somefile.csv and creates files with 100 entries each in the current working directory

.EXAMPLE
.\Split-CSVintoBatches -filePath c:\someplace\somefile.csv -batchesOf 100 -outputFilesPath c:\someplace\batches
Takes c:\someplace\somefile.csv and creates files with 100 entries each in c:\someplace\batches
#>

Param(
  [Parameter(Mandatory=$true)][string]$filePath,
  [Parameter(Mandatory=$false)][int]$batchesOf=5,
  [Parameter(Mandatory=$false)][string]$outputFilesPath=(Get-Location).Path)
 

#Function that splits an array into multiple arrays
#The % (modulus operator) will deal with the remainder. 
#A simple modulus , all kudos to http://stackoverflow.com/questions/13888253/powershell-break-a-long-array-into-a-array-of-array-with-length-of-n-in-one-line
Function Split-Every($list, $count) {
    $aggregateList = @()

    $blocks = [Math]::Floor($list.Count / $count) # see http://msdn.microsoft.com/en-us/library/system.math.floor.aspx
    $leftOver = $list.Count % $count
    for($i=0; $i -lt $blocks; $i++) {
        $end = $count * ($i + 1) - 1

        $aggregateList += @(,$list[$start..$end])
        $start = $end + 1
    }    
    if($leftOver -gt 0) {
        $aggregateList += @(,$list[$start..($end+$leftOver)])
    }

    $aggregateList    
};

$objects = @(Import-Csv $filePath)
$batches = Split-Every $objects $batchesOf

$i = 0;
foreach($batch in $batches){
    $i++;
    $filename  = $outputFilesPath + "\" + $i.ToString() + ".csv"
    $batch | export-csv $filename -NoTypeInformation
}

