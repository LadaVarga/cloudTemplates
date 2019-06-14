foreach($r in Get-AWSRegion)
{
    foreach($ami in @(Get-SSMParametersByPath -Path "/aws/service/ami-windows-latest" -region $r.Region | Where {$_.Name -match "2016-English-Full-Base"}))
    {
        write-host $r.Region : $ami.Value
    }
}