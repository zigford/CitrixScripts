Start-Transcript -Path "$env:Temp\CitrixReport.log"
$ScriptPath = Split-Path -Path $PSCommandPath -Parent
Import-Module "$ScriptPath\USC-Citrix.psm1"
#$ReportEmail = 'jpharris@usc.edu.au'
$ReportEmail = 'team@if83bu.mailclark.ai'
#Create a HTML Report
$Report = Get-CtxProductionMachines | ForEach-Object { Get-CtxXenAppStatus -ComputerName $_ } | Out-String

Send-MailMessage -Body $Report -From 'wcn-appdev5@usc.internal' -To $ReportEmail -SmtpServer mail.usc.edu.au -Subject 'Citrix Report'
Stop-Transcript