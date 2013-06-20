Import-Module ActiveDirectory
#Get Domain Base 
$searchbase = Get-ADDomain | ForEach {  $_.DistinguishedName } 
$ParentContainer = 'OU=Groups'
$Source_Group = Read-Host 'What is the source group?' #"Premium.Support"

Try 
{ 
  #Check if the Source Group exists 
  $exists = Get-ADGroup $Source_Group 
  Write-Host "Group '$($Source_Group)' found."

  $Destination_Group = Read-Host 'What is the destination group?'  #'G_Spark_Premium_Support'

  Try 
  { 
  #Check if the Group already exists 
  $exists = Get-ADGroup $Destination_Group 
  Write-Host "Group $($Destination_Group) already exists! Group creation skipped" 
  }
  Catch 
  { 
  #Create the group if it doesn't exist 
  New-ADGroup -Name $Destination_Group -GroupScope 'Global' -Path ($($ParentContainer)+","+$($searchbase)) -Description 'Spark group'
  Write-Host "Group $($Destination_Group) created"
  }

  #Copy group members to the new group
  $Target = Get-ADGroupMember -Identity $Source_Group 
  foreach ($Person in $Target) { 
    Add-ADGroupMember -Identity $Destination_Group -Members $Person.distinguishedname
    Write-Host "$($Person.name) added"
  }
  Write-Host "Operation completed."
}
Catch 
{ 
  #Source Group doesn't exist
  Write-Host "Group $($Source_Group)  does not exist, please check the name. Cancelling operation."
}





