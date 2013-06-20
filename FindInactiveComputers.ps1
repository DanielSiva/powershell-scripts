Search-ADAccount -AccountInactive -ComputersOnly -TimeSpan 75.00:00:00 | `
  ? {$_.DistinguishedName -notlike "*OU=Disabled,DC=office,DC=orcon,DC=net,DC=nz"} |`
  ft Name,LastLogonDate,DistinguishedName 
  #Move-ADObject -TargetPath 'OU=Disabled,DC=office,DC=orcon,DC=net,DC=nz'
  #Set-ADComputer -Enabled $false 