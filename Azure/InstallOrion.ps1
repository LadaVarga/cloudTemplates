$url = "https://downloads.solarwinds.com/solarwinds/OnlineInstallers/RTM/NPM/Solarwinds-Orion-NPM.exe"
$urlSilentConfig = "https://raw.githubusercontent.com/LadaVarga/cloudTemplates/master/Azure/silentconfig.xml"
$output = "c:\windows\temp\Solarwinds-Orion-NPM.exe"
$outputsilent = "c:\windows\temp\silentconfig.xml"
$start_time = Get-Date


Set-location C:\windows\Temp

$wc = (New-Object System.Net.WebClient)
$wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)

#$wc2 = New-Object System.Net.WebClient
$wc.DownloadFile($urlSilentConfig ,$outputsilent)
#OR
#(New-Object System.Net.WebClient).DownloadFile($urlSilentConfig, $outputsilent)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

start -Wait -FilePath "c:\windows\temp\Solarwinds-Orion-NPM.exe" -ArgumentList "/s /notests /ConfigFile=`"c:\windows\temp\silentconfig.xml`""