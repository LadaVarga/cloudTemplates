Add-Content $env:windir\System32\drivers\etc\hosts "10.110.68.107 product-catalog.swdev.local"
Add-Content $env:windir\System32\drivers\etc\hosts "10.110.68.107 product-catalog.dev.local"
Add-Content $env:windir\System32\drivers\etc\hosts "10.110.66.139 licenseserver.solarwinds.com"
Add-Content $env:windir\System32\drivers\etc\hosts "10.110.66.139 licensestatusserver.solarwinds.com"
Add-Content $env:windir\System32\drivers\etc\hosts "127.0.0.2 cdn.pendo.io"

$url = "http://product-catalog.swdev.local/api/installer/?stage=Stable"
$urlSilentConfig = "https://raw.githubusercontent.com/LadaVarga/cloudTemplates/master/Azure/silentconfigEval.xml"
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

Start-Process -wait -FilePath "c:\windows\temp\Solarwinds-Orion-NPM.exe" -ArgumentList "/s /notests /ConfigFile=`"c:\windows\temp\silentconfig.xml`""