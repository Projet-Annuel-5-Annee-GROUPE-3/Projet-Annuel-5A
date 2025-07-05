# MAIL-LOG-ID-RISQUE-MOYEN-3.ps1


# Fonctions du script
    # Envoi un mail à la boîte mail d'équipe si un évènement supervisé est présent



# Configuration SMTP
$smtpServer = "10.10.1.111"
$smtpPort = "25"
$smtpFrom = "root@PAR-DC-SMTP-01.alpha.local"
$smtpTo = "supporttechnique@projetgrp3.ovh"

# Liste des ID à surveiller :
$eventIds = 4978,4983,4984,5027,5028,5029,5030,5035,5037,5038,5120,5121,5122,5123,5376,5377,5453,5480,5483,5484



# Récupération des événements $eventIds dans le journal d'événements
$events = Get-WinEvent -MaxEvents 1 -FilterHashtable @{LogName = "ForwardedEvents" ; ID = $eventIds}


# Vérification et envoi d'e-mail
if ($events) {

    $messageSubject = "[Moyen] $($events.MachineName)"

    $body = "<b>Nom de la machine:</b> $($events.MachineName)<br>"
    $body += "<b>Date:</b> $($events.TimeCreated)<br>"
    $body += "<b>Evenement:</b> $($events.ProviderName)<br>"
    $body += "<b>ID:</b> $($events.Id)<br>"
    $body += "<b>Message:</b> $($events.Message)<br>"

    # Envoi de l'e-mail
    $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
    $smtp.Port = $smtpPort
    $message = New-Object Net.Mail.MailMessage($smtpFrom, $smtpTo, $messageSubject, $body)
    $message.IsBodyHtml = $true
    $smtp.Send($message)
}