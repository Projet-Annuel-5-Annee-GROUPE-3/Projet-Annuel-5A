# MAIL-LOG-ID-RISQUE-ELEVE.ps1


# Fonctions du script
    # Envoi un mail à la boîte mail d'équipe si un évènement supervisé est présent

# Configuration SMTP
$smtpServer = "10.10.1.111"
$smtpPort = "25"
$smtpFrom = "root@PAR-DC-SMTP-01.alpha.local"
$smtpTo = "supporttechnique@projetgrp3.ovh"

# Liste des ID à surveiller :
$eventIds = 4618, 4949, 4719, 4765, 4766, 4794, 4897, 4964, 5124, 550, 1102



# Récupération des événements $eventIds dans le journal d'événements
$events = Get-WinEvent -MaxEvents 1 -FilterHashtable @{LogName = "ForwardedEvents" ; ID = $eventIds}


# Vérification et envoi d'e-mail
if ($events) {

    $messageSubject = "[Elevé] $($events.MachineName)"

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