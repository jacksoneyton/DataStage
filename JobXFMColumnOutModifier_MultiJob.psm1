Function Set-ColumnModifications {
    Param(
    [parameter(Mandatory=$true)]
    [Xml]
    $XmlMod
    )
    $ColumnMenu = @"
ID    Type`r
__    ______________`r
-9    NVarChar`r
-8    NChar`r
-7    Bit`r
-6    TinyInt`r
-5    BigInt`r
-4    LongVarBinary`r
-3    VarBinary`r
-2    Binary`r
-1    LongVarChar`r
 0    Unkown`r
 1    Char`r
 2    Numeric`r
 3    Decimal`r
 4    Integer`r
 5    SmallInt`r
 6    Float`r
 7    Real`r
 8    Double`r
 9    Date`r
10    Time`r
11    Timestamp`r
12    VarChar`r
`n
"@
    $SourceColumnTypeID = Read-Host ($ColumnMenu + "Please enter the Column Type ID you would like to modify")
    $DestColumnTypeID = Read-Host ($ColumnMenu + "Please enter the Column Type ID you wish to change to")
    $ColPrecision = Read-Host "Column Length"
    $ColScale = Read-Host "Column Scale (If no scale, enter 0)"
    $XmlJobs = $XmlMod.DSExport.Job
    Foreach ($job in $XmlJobs) {
        $TrxOutput = $job.Record | Where-Object {$_.Type -Match "TrxOutput"}
        $OutputColumn = $TrxOutput.Collection | Where-Object {$_.Type -Match "OutputColumn"}

        Foreach ($SubRecord in $OutputColumn.SubRecord) {
            $SqlType = $SubRecord.Property | Where-Object {$_.Name -eq 'SqlType'}
            $Precision = $SubRecord.Property | Where-Object {$_.Name -eq 'Precision'}
            $Scale = $SubRecord.Property | Where-Object {$_.Name -eq 'Scale'}
            $Extended = $SubRecord.Property |Where-Object {$_.Name -eq 'ExtendedPrecision' }

            If ($SqlType.InnerXml -eq $SourceColumnTypeID) {
                $SqlType.InnerXml = $DestColumnTypeID
                $Precision.InnerXml = $ColPrecision

                If ((($DestColumnTypeID -eq '3') -or ($DestColumnTypeID -eq '2')) -and ($Scale.InnerXml -gt '0')) {
                    $Scale.InnerXml = $ColScale
                }
                Elseif ((($DestColumnTypeID -eq '3') -or ($DestColumnTypeID -eq '2')) -and ($Scale.InnerXml -eq '0')) {
                    
                }
                Else {
                    $Scale.InnerXml = $ColScale
                }
                
                If (($DestColumnTypeID -eq '12') -and ($Extended.InnerXml -gt '0')) {
                $Extended.InnerXml = '0'
                }
            }
        }
    }
$Continue = Read-Host "Would you like to make any further modifications?"
If (($Continue -eq 'y') -or ($Continue -eq 'Y') -or ($Continue -eq 'yes') -or ($Continue -eq 'Yes') -or ($Continue -eq 'YES')) {
        $XmlMod = Set-ColumnModifications -XmlMod $XmlMod
    }
	
return $XmlMod
}



function Set-DSColumns {
#Collect File Info
$InputFileStr = Read-Host "Please enter the path to the DataStage XML file"
$InputFile = Get-Item $InputFileStr.Replace('"','')
$OutputFile = Read-Host "Please enter the full file path to save the modified DataStage XML File"
[xml]$XmlSource = Get-Content $InputFile.FullName

$XmlOut = Set-ColumnModifications -XmlMod $XmlSource

$XmlOut.Save($OutputFile.replace('"',''))
}
