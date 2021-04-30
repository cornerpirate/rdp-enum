# Created by cornerpirate 30/04/2021/
# Based on https://www.mvps.net/docs/how-to-secure-remote-desktop-rdp/ 
# Run this locally on a Windows machine and it will check best practices for RDP configurations
function Green
{
    process { Write-Host $_ -ForegroundColor Green }
}

function Red
{
    process { Write-Host $_ -ForegroundColor Red }
}

Write-Output "Checking: $env:computername " 

# Check if the PortNumber is not 3389
$port = (Get-ItemProperty  HKLM:\SYSTEM\CurrentControlSet\Control\Termin*Server\WinStations\RDP*CP\).PortNumber
if ( $port -eq 3389 )
{
    Write-Output "[*] PortNumber  `t: Malware will look for 3389 by default. Consider altering this." | Red
} 
else 
{
    Write-Output "[*] PortNumber  `t: Congratulations you have modified the default port." | Green
}

# Check TLS implementation
# 0 - "Low" security 
# 1 - "Medium" security is default
# 2 - "High" security is recommended
$tlsImplementation=(Get-ItemProperty  HKLM:\SYSTEM\CurrentControlSet\Control\Termin*Server\WinStations\RDP*CP\).SecurityLayer

if ( $tlsImplementation -ne 2 )
{
    Write-Output "[*] SecurityLayer`t: was not set to 'High'." | Red
}
else 
{
    Write-Output "[*] SecurityLayer`t: You are using the most secure TLS implementation." | Green
}


# Check Encryption Levels
# 1 - "Low" - data from client encrypted with 56-bit cipher, data from server is unencrypted.
# 2 - "Medium" - data encrypted with cipher suite of maximum key strength supported by client. For legacy clients.
# 3 - "High" - uses 128-bit cipher suites. Excludes legacy clients
# 4 - "FIPS-Compliant" - This is the maximum supported level. Will exclude clients that do not support it.
$encryption=(Get-ItemProperty  HKLM:\SYSTEM\CurrentControlSet\Control\Termin*Server\WinStations\RDP*CP\).MinEncryptionLevel

if ( $encryption -ne 4 )
{
    Write-Output "[*] MinEncryptionLevel`t: Encryption levels are not set to 'FIPS-Compliant'." | Red
}
else 
{
    Write-Output "[*] MinEncryptionLevel`t: You are using FIPS-Compliant encryption." | Green
}