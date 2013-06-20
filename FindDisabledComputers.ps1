Search-ADAccount -accountdisabled -computersonly | `
  ? {$_.DistinguishedName -notlike "*OU=Disabled,DC=office,DC=orcon,DC=net,DC=nz"} |`
  ft Name,LastLogonDate,DistinguishedName 
  #Move-ADObject -TargetPath 'OU=Disabled,DC=office,DC=orcon,DC=net,DC=nz'