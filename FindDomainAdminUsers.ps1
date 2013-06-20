Search-ADAccount -UsersOnly - | `
  ? {$_.DistinguishedName -notlike "*OU=Disabled,DC=office,DC=orcon,DC=net,DC=nz" -and `
     $_.DistinguishedName -notlike "*OU=Sortme,OU=Managed Users,DC=office,DC=orcon,DC=net,DC=nz" -and `
     $_.DistinguishedName -notlike "*CN=Users,DC=office,DC=orcon,DC=net,DC=nz" -and `
     $_.DistinguishedName -notlike "*OU=Managed Service Accounts,DC=office,DC=orcon,DC=net,DC=nz"} |`
  ft Name,LastLogonDate,DistinguishedName 
  #Move-ADObject -TargetPath 'OU=Disabled,DC=office,DC=orcon,DC=net,DC=nz'
  #Set-ADUser -Enabled $false 