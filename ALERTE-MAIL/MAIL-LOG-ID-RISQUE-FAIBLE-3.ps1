# MAIL-LOG-ID-RISQUE-FAIBLE-3.ps1


# Fonctions du script
    # Envoi un mail à la boîte mail d'équipe si un évènement supervisé est présent
    # Rajout d'une fonction pour ne pas envoyer de mail si les events 4616 et 4697 contiennent une chaîne spécifique

# Configuration SMTP
$smtpServer = "10.10.1.111"
$smtpPort = "25"
$smtpFrom = "root@PAR-DC-SMTP-01.alpha.local"
$smtpTo = "supporttechnique@projetgrp3.ovh"

# Liste des ID à surveiller :
$eventIds = 4782,4657,4909,4910,5039,5632,6008,4697,4725,4740


# Récupération des événements $eventIds dans le journal d'événements
$events = Get-WinEvent -MaxEvents 1 -FilterHashtable @{LogName = "ForwardedEvents" ; ID = $eventIds}


# Vérification et envoi d'e-mail
if ($events) {
    # Vérifier si le message contient la chaîne spécifique pour l'event 4616 et  4697
    if (($events.Id -eq 4616 -and $events.Message -like "*LOCAL SERVICE*" -or $events.Message -like "*SERVICE LOCAL*") -or
	($events.Id -eq 4697 -and $events.Message -like "*LocalSystem*" -or $events.Message -like "*LocalService*" -or $events.Message -like "*NetworkService*")) {
	# Ne pas envoyer le mail si la condition est vraie
	return
    }

    $messageSubject = "[Faible] $($events.MachineName)"

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