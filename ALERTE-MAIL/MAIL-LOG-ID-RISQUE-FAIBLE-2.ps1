# MAIL-LOG-ID-RISQUE-FAIBLE-2.ps1


# Fonctions du script
    # Envoi un mail à la boîte mail d'équipe si un évènement supervisé est présent
    # Rajout d'une fonction pour ne pas envoyer d'e-mail si les events 4717 et 4718 contiennent une chaîne spécifique

# Configuration SMTP
$smtpServer = "10.10.1.111"
$smtpPort = "25"
$smtpFrom = "root@PAR-DC-SMTP-01.alpha.local"
$smtpTo = "supporttechnique@projetgrp3.ovh"


# Liste des ID à surveiller :
$eventIds = 4748,4749,4750,4751,4752,4753,4756,4757,4758,4759,4760,4761,4762,4767,4781,4717,4718



# Récupération des événements $eventIds dans le journal d'événements
$events = Get-WinEvent -MaxEvents 1 -FilterHashtable @{LogName = "ForwardedEvents" ; ID = $eventIds}


# Vérification et envoi d'e-mail
if ($events) {

    # Vérifier si le message contient la chaîne spécifique pour l'event 4717
    if (($events.Id -eq 4717 -or $events.Id -eq 4718) -and $events.Message -like "*S-1-5-18*") {
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