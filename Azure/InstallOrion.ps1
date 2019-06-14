$url = "https://downloads.solarwinds.com/solarwinds/OnlineInstallers/RTM/NPM/Solarwinds-Orion-NPM.exe"
$output = "c:\temp\Solarwinds-Orion-NPM.exe"
$start_time = Get-Date

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"