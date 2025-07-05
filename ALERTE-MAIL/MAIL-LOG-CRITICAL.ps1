# MAIL-LOG-CRITICAL.ps1

# Fonctions du script
    # Envoi un mail à la boîte mail d'équipe si un évènement critique est présent


# Configuration SMTP
$smtpServer = "10.10.1.111"
$smtpPort = "25"
$smtpFrom = "root@PAR-DC-SMTP-01.alpha.local"
$smtpTo = "supporttechnique@projetgrp3.ovh"


# Récupération des événements critiques du journal d'événements système
$events = Get-WinEvent -LogName ForwardedEvents -FilterXPath "*[System[(Level=1)]]" -MaxEvents 1


# Vérification et envoi d'e-mail
if ($events) {

    $messageSubject = "[Critical] $($events.MachineName)"

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
