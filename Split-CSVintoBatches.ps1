Param(
  [Parameter(Mandatory=$true)][string]$inputFile,
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

$objects = @(Import-Csv $inputFile)
$batches = Split-Every $objects $batchesOf

$i = 0;
foreach($batch in $batches){
    $i++;
    $filename  = $outputFilesPath + "\" + $i.ToString() + ".csv"
    $batch | export-csv $filename -NoTypeInformation
}