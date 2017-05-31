Import-Module .\USC-Citrix.psm1
$ReportEmail = 'jpharris@usc.edu.au'
#Create a HTML Report
$HTMLReport = Get-CtxProductionMachines | ForEach-Object { Get-CtxXenAppStatus -ComputerName $_ } | ConvertTo-Html

Send-MailMessage -BodyAsHtml -Body ($HTMLReport|Out-String) -From 'wcn-appdev5@usc.internal' -To $ReportEmail -SmtpServer mail.usc.edu.au -Subject 'Citrix Report'