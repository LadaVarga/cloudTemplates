$url = "https://downloads.solarwinds.com/solarwinds/OnlineInstallers/RTM/NPM/Solarwinds-Orion-NPM.exe"
$urlSilentConfig = "https://github.com/LadaVarga/cloudTemplates/blob/master/Azure/silentconfig.xml"
$output = "c:\temp\Solarwinds-Orion-NPM.exe"
$outputsilent = "C:\temp\silentconfig.xml"
$start_time = Get-Date
#test
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($urlSilentConfig ,$outputsilent)
#OR
(New-Object System.Net.WebClient).DownloadFile($urlSilentConfig, $outputsilent)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

start /wait c:\temp\Solarwinds-Orion-NPM.exe /s /notests /ConfigFile="C:\temp\silentconfig.xml"