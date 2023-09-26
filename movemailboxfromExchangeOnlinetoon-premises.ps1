Install-Module -Name ExchangeOnlineManagement -RequiredVersion 3.3.0
Import-Module ExchangeOnlineManagement

#Para que funcione bien, hay que verificar esto
Get-ExecutionPolicy
Set-ExecutionPolicy Unrestricted

Connect-ExchangeOnline

Get-MigrationEndpoint | Format-List Identity, RemoteServer
#Copy the RemoteServer URL value as you need it in the next part.


#Move mailbox from Exchange Online with PowerShell
Get-Mailbox -Identity "Jordy.Twin@exoip.com" | New-MoveRequest -OutBound -RemoteTargetDatabase "DB01" -RemoteHostName "mail.exoip.com" -TargetDeliveryDomain "exoip.com" -RemoteCredential (Get-Credential exoip\administrator)

#Move primary mailbox only from Exchange Online with PowerShell
Get-Mailbox -Identity "Jordy.Twin@exoip.com" | New-MoveRequest -OutBound -RemoteTargetDatabase "DB01" -RemoteHostName "mail.exoip.com" -PrimaryOnly -ArchiveDomain "exoip365.mail.onmicrosoft.com" -TargetDeliveryDomain "exoip.com" -RemoteCredential (Get-Credential exoip\administrator)


#Get mailbox move status
Get-MoveRequest -Identity "Jordy.Twin@exoip.com" | Get-MoveRequestStatistics | ft DisplayName,StatusDetail,TotalMailboxSize,TotalArchiveSize,PercentComplete

