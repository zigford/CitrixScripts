function Get-CtxXenAppStatus {
[CmdletBinding()]
Param($ComputerName)
    $OS = gwmi -comp $ComputerName -class win32_operatingsystem
    [PSCustomObject]@{
        'ComputerName' = $ComputerName
        'CacheSpaceFree' = "{0:N0}" -f ((gwmi -ComputerName $ComputerName -Query 'Select FreeSpace From Win32_LogicalDisk Where DeviceID = "D:"').FreeSpace /1gb)
        'Uptime' = 	$OS.ConvertToDateTime($OS.LastBootUpTime)
        'Sessions' = (gwmi -comp $ComputerName -class win32_userprofile|?{$_.Loaded -eq 'True' -and $_.LocalPath -notmatch 'Ctx' -and $_.LocalPath -notmatch 'Citrix' -and $_.LocalPath -match 'Users'} | Measure-Object).Count
    }#| ?{(Get-Date $_.Uptime) -lt (Get-Date).AddDays(-7)}
}


for ($i=3;$i -le 26;$i++) {
    Get-CtxXenAppStatus -ComputerName "vxa-ctxstu$($i.ToString("00"))" 
}

for ($i=3;$i -le 4;$i++) {
    Get-CtxXenAppStatus -ComputerName "vxa-ctxstf$($i.ToString("00"))"
}

for ($i=3;$i -le 4;$i++) {
    Get-CtxXenAppStatus -ComputerName "vxa-ctxits$($i.ToString("00"))"
}
