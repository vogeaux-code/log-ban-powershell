function log {

Select-String -Path C:\log\log.txt -Pattern "Adresse du réseau source :" -Context 0,0 > C:\log\log3.txt

$line = get-content "C:\log\log3.txt" | Measure-Object –Line
$li=$line.Lines

If ((Test-Path "C:\log\logfin.txt") -eq $True) 

    {rm "C:\log\logfin.txt"
    Write-Host "Present"
    }


else{Write-Host "Absent"}


$i = 0
while ($i -le $li){


$file=Get-Content -Path C:\log\log3.txt | where { $_ -ne "$null" } | Select-Object -Index $i
$file.Split(":")[-1] >> C:\log\logfin.txt
$i++

$OriginalFile = "C:\log\logfin.txt"
Get-Content $OriginalFile | Sort-Object | Get-Unique > C:\log\logfin2.txt
    }


    }



function ban {

$measure=Get-Content "C:\log\logfin2.txt" 
$lon = $measure.Count
$lo = $lon - 1

$i = 0

while ($i -le $lon){



$file = Get-Content -Path C:\log\logfin2.txt | where { $_ -ne "$null" } | Select-Object -Index $i
 





$filenew=$file -replace("	","")

Write-Host $filenew

New-NetFirewallRule -DisplayName "BLACK LIST" -Direction Inbound -LocalPort 3389 -Protocol TCP -RemoteAddress $filenew -Action Block

$i++

    
    }
    }