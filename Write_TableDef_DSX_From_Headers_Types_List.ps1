# Path to reference file (CSV with field names and data types)
$referenceFile = "C:\TEMP\Bank_Data_Fields.csv"

# Define mappings for DataStage SQL Types
$typeMapping = @{
    "VarChar" = "12"      # String (Variable Character)
    "Integer" = "4"       # Integer
    "BigInt" = "-5"       # Big Integer
    "Decimal" = "3"       # Decimal
    "Float" = "6"         # Floating Point
    "Double" = "8"        # Double Precision
    "Date" = "9"          # Date
    "Time" = "10"         # Time
    "Timestamp" = "11"    # Timestamp
    "Binary" = "-2"       # Binary Data
    "Bit" = "-7"          # Boolean
}

# Read reference file and parse field names and types
$fields = Import-Csv -Path $referenceFile

# Define DSX Header
$dsxContent = @"
BEGIN HEADER
   CharacterSet "ENGLISH"
   ExportingTool "IBM InfoSphere DataStage Export"
   ToolVersion "8"
   ServerName "INFOENG2DEV"
   ToolInstanceID "dstagedev1"
   MDISVersion "1.0"
   Date "$(Get-Date -Format 'yyyy-MM-dd')"
   Time "$(Get-Date -Format 'HH.mm.ss')"
   ServerVersion "11.7"
END HEADER
BEGIN DSTABLEDEFS
   BEGIN DSRECORD
      Identifier "Sequential\\BankData\\Bank_Data.csv"
      DateModified "$(Get-Date -Format 'yyyy-MM-dd')"
      TimeModified "$(Get-Date -Format 'HH.mm.ss')"
      OLEType "CMetaTable"
      Readonly "0"
      Category "\\Table Definitions\\Sequential\\BankData"
      Description "Generated from CSV reference file"
      Version "9"
      QuoteChar "000"
      Multivalued "0"
      SPErrorCodes ";"
      Columns "CMetaColumn"
"@

# Loop through fields and add them to DSX
foreach ($field in $fields) {
    $sqlType = $typeMapping[$field.DataType]  # Map data type to SQL type
    if (-not $sqlType) { $sqlType = "12" }   # Default to VarChar if unknown

    $dsxContent += @"
      BEGIN DSSUBRECORD
         Name "$($field.FieldName)"
         SqlType "$sqlType"
         Precision "255"
         Scale "0"
         Nullable "0"
         KeyPosition "0"
         DisplaySize "50"
         LevelNo "0"
         Occurs "0"
         SignOption "0"
         SCDPurpose "0"
         SyncIndicator "0"
         PadChar ""
         ExtendedPrecision "0"
         TaggedSubrec "0"
         OccursVarying "0"
      END DSSUBRECORD
"@
}

# Add DSX Footer
$dsxContent += @"
      SEQ-Delimiter ","
      SEQ-QuoteChar "\""
      SEQ-ColHeaders "1"
      SEQ-FixedWidth "0"
      SEQ-ColSpace "0"
      SEQ-OmitNewLine "0"
      AllowColumnMapping "0"
      Locator "TableType=\"Sequential\"|Computer=\"infoeng2dev\"|SoftwareProduct=\"FileSystem\"|DataStore(Directory)=\"D:\\Data\\Bank\"|DataSchema(File)=\"Bank_Data.csv\"|DataCollection=\"Bank_Data.csv\""
      PadChar "#"
      APTRecordProp "final_delim=end, record_delim='\\n', delim=',', quote=double, padchar='#'"
   END DSRECORD
END DSTABLEDEFS
"@

# Save to File
$dsxFilePath = "C:\TEMP\Bank_Data_Definition.dsx"
$dsxContent | Out-File -Encoding utf8 -FilePath $dsxFilePath

Write-Host "DSX File Generated: $dsxFilePath"
