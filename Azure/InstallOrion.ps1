$url = "https://downloads.solarwinds.com/solarwinds/OnlineInstallers/RTM/NPM/Solarwinds-Orion-NPM.exe"
$urlSilentConfig = "https://raw.githubusercontent.com/LadaVarga/cloudTemplates/master/Azure/silentconfig.xml"
$output = "c:\temp\Solarwinds-Orion-NPM.exe"
$outputsilent = "C:\temp\silentconfig.xml"
$start_time = Get-Date

New-Item -ItemType "directory" -path c:\temp -force
set-location c:\temp

$wc = (New-Object System.Net.WebClient)
$wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)

#$wc2 = New-Object System.Net.WebClient
$wc.DownloadFile($urlSilentConfig ,$outputsilent)
#OR
#(New-Object System.Net.WebClient).DownloadFile($urlSilentConfig, $outputsilent)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

start -Wait -FilePath "c:\temp\Solarwinds-Orion-NPM.exe" -ArgumentList "/s /notests /ConfigFile=`"C:\temp\silentconfig.xml`""