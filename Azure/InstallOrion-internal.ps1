Add-Content $env:windir\System32\drivers\etc\hosts "10.110.68.107 product-catalog.swdev.local"
Add-Content $env:windir\System32\drivers\etc\hosts "10.110.68.107 product-catalog.dev.local"
Add-Content $env:windir\System32\drivers\etc\hosts "10.110.66.139 licenseserver.solarwinds.com"
Add-Content $env:windir\System32\drivers\etc\hosts "10.110.66.139 licensestatusserver.solarwinds.com"
Add-Content $env:windir\System32\drivers\etc\hosts "127.0.0.2 cdn.pendo.io"

$url = "http://product-catalog.swdev.local/api/installer/?stage=Stable"

$output = "c:\windows\temp\Solarwinds-Orion-NPM.exe"
$xmlEval=
[xml]'<?xml version="1.0" encoding="utf-8"?>
<SilentConfig>
  <InstallerConfiguration>
    <ProductsToInstall>NPM</ProductsToInstall>
     <InstallPath></InstallPath>
    <AdvancedInstallMode>False</AdvancedInstallMode>
  </InstallerConfiguration>
  </SilentConfig>'

 $xml | Out-File -FilePath "C:\windows\Temp\silentconfigEval.xml"

$start_time = Get-Date


Set-location C:\windows\Temp

$wc = (New-Object System.Net.WebClient)
$wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)



Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"




$executable = "c:\windows\temp\Solarwinds-Orion-NPM.exe"
$installerparameters = "/s /notests /ConfigFile=`"c:\windows\temp\silentconfig.xml`""
$installertimeoutsec = 7200
try{

            write-host "starting orion installer: `"$executable`" `"$installerparameters`""
            $process = [system.diagnostics.process]::start($executable, $installerparameters)
            write-host "pid $($process.id) - waiting"
            wait-process -id ($process.id) -timeout ([int]::parse($installertimeoutsec))

            if (-not $process.hasexited)
            {
                write-host "product `"$installername`": installer is still running after time out."
                throw "product `"$installername`": installer timed out"
            }

            if (($process.exitcode) -ne 0)
            {
                $exitcode = $process.exitcode
                write-host "product `"$installername`": installer finished with following exit code: $exitcode"
                throw "product `"$installername`": installer finished with error"
            }

            $installerstartedevent = (get-param $productconfig "installerstartedscript" "")
            if ($installerstartedevent) { invoke-expression $installerstartedevent }
            
            }
            catch
    {
        # something went wrong
        # take screenshot
       Write-host "Installation failed"

        throw $_
    }



#Start-Process -wait -FilePath "c:\windows\temp\Solarwinds-Orion-NPM.exe" -ArgumentList "/s /notests /ConfigFile=`"c:\windows\temp\silentconfig.xml`""

#cmd start /wait "c:\windows\temp\Solarwinds-Orion-NPM.exe" /s /ConfigFile="c:\windows\temp\silentconfig.xml"