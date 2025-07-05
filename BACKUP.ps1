# BACKUP.ps1
# Script version

	

##### Création des variables ####

# Création des variables
$backupFolderPath = "D:\LOG_WEC"
$currentDate = Get-Date
$backupPath= Join-Path -Path $backupFolderPath -ChildPath $currentDate.ToString("yyyy-MM-dd")
$logNames = @("ForwardedEvents")
$daysToKeep = 365



# création du dossier backup si il n'existe pas
if (!(Test-Path -Path $backupPath)) {
    New-Item -Path $backupPath -ItemType Directory | Out-Null
}

foreach ($logName in $logNames) {
    $exportFileName = "$logName-$($currentDate.ToString("yyyy-MM-dd")).evtx"
    $exportFilePath = Join-Path -Path $backupPath -ChildPath $exportFileName

# Exportation des logs
    Write-Host "Exportation des logs d'évènements $logName dans $exportFilePath"
    wevtutil epl $logName $exportFilePath


# Suppression des logs
    Write-Host "Suppression des logs d'évènements $logName"
    wevtutil cl $logName
}

# Suppression des dossiers qui ont plus de 365 jours

Get-ChildItem -Path $backupFolderPath -Directory | Where-Object {
    $folderDate = [datetime]::ParseExact($_.Name, "yyyy-MM-dd", $null)
    ($currentDate - $folderDate).Days -gt $daysToKeep
} | Remove-Item -Recurse -Force

