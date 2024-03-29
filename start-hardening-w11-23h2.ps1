#Import de Hardening Kitty
Import-Module .\HardeningKitty.psm1

#######################
### Phase de backup ###
#######################
#Backup des paramètres utilisateurs
Invoke-HardeningKitty -Mode Config -Backup -BackupFile ".\Backup_$($env:COMPUTERNAME)_$(Get-Date -Format yyyyMMdd-hhmm)_Machine.csv" -FileFindingList ".\lists\finding_list_msft_security_baseline_windows_11_23h2_machine.csv"

#Backup des paramètres de la machine
Invoke-HardeningKitty -Mode Config -Backup -BackupFile ".\Backup_$($env:COMPUTERNAME)_$(Get-Date -Format yyyyMMdd-hhmm)_User.csv" -FileFindingList ".\lists\finding_list_msft_security_baseline_windows_11_23h2_user.csv"

#####################
### Phase d'audit ###
#####################

# Audit des paramètres machine
Invoke-HardeningKitty -Mode Audit -Log -Report -FileFindingList ".\lists\finding_list_msft_security_baseline_windows_11_23h2_machine.csv"

# Audit des paramètres utilisateur
Invoke-HardeningKitty -Mode Audit -Log -Report -FileFindingList ".\lists\finding_list_msft_security_baseline_windows_11_23h2_user.csv"

######################
### Phase de patch ###
######################
#Renforcer les paramètres ordinateur
Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList ".\lists\finding_list_msft_security_baseline_windows_11_23h2_machine.csv" -SkipRestorePoint

#Renforcer les paramètres utilisateur
Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList ".\lists\finding_list_msft_security_baseline_windows_11_23h2_user.csv" -SkipRestorePoint