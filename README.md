# rdp-enum
PowerShell script that enumerates RDP security settings

Download onto a machine and then run this simply as ```".\rdp-enum.ps1"```.

Expected output:
```
PS C:\Users\testuser\Desktop> .\rdp-enum.ps1
Checking: RDPServer
[*] PortNumber          : Malware will look for 3389 by default. Consider altering this.
[*] SecurityLayer       : You are using the most secure TLS implementation.
[*] MinEncryptionLevel  : Encryption levels are not set to 'FIPS-Compliant'.
```

It uses a green font for good configurations and red for things that can be worked on.

The checks are based on the information provided here:

https://www.mvps.net/docs/how-to-secure-remote-desktop-rdp/

Which is worth a read.
