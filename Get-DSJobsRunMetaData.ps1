param (
    [string]$project,
    [string]$outputFolder,
    [string]$csvOutputFolder
)

# Create the CSV output folder if it doesn't exist
New-Item -ItemType Directory -Force -Path $csvOutputFolder

# Execute the external executable and capture the output in the $jobs variable
$jobs = Invoke-Expression "D:\IBM\InformationServer\Server\DSEngine\bin\dsjob.exe -ljobs $project"

# Loop through each job and run the command to generate XML files
foreach ($job in $jobs) {
    $outputFile = Join-Path $outputFolder "${project}_${job}.xml"
    $command = "D:\IBM\InformationServer\Server\DSEngine\bin\dsjob.exe -report $project $job XML > $outputFile"
    Write-Host "Running command for job: $job"
    Invoke-Expression $command
}

Write-Host "All jobs processed."

# Function to convert only parent items of the <Job> element to CSV
function Convert-XmlToCsv {
    param (
        [string]$xmlFilePath,
        [string]$csvOutputFolder
    )
    $xml = [xml](Get-Content $xmlFilePath)

    $jobName = $xml.Job.Name
    $status = $xml.Job.Status
    $startDateTime = $xml.Job.StartDateTime
    $endDateTime = $xml.Job.EndDateTime
    $elapsedTime = $xml.Job.ElapsedTime
    $elapsedSecs = $xml.Job.ElapsedSecs

    $paramObj = New-Object PSObject -Property @{
        "JobName" = $jobName
        "Status" = $status
        "StartDateTime" = $startDateTime
        "EndDateTime" = $endDateTime
        "ElapsedTime" = $elapsedTime
        "ElapsedSecs" = $elapsedSecs
    }

    $csvFileName = Join-Path $csvOutputFolder "${jobName}.csv"
    $paramObj | Export-Csv -Path $csvFileName -NoTypeInformation
}

# Loop through each generated XML file and convert it to CSV
$xmlFiles = Get-ChildItem -Path $outputFolder -Filter "${project}_*.xml"
foreach ($xmlFile in $xmlFiles) {
    Write-Host "Converting XML to CSV for file: $($xmlFile.Name)"
    Convert-XmlToCsv -xmlFilePath $xmlFile.FullName -csvOutputFolder $csvOutputFolder
}

Write-Host "All XML files have been converted to CSV."
