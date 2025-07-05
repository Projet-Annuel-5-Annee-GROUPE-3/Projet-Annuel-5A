# MAIL-LOG-ID-RISQUE-FAIBLE-1.ps1


# Fonctions du script
    # Envoi un mail à la boîte mail d'équipe si un évènement supervisé est présent
    # Rajout d'une fonction pour ne pas envoyer de mail si l'event 4610 contient une chaîne spécifique

# Configuration SMTP
$smtpServer = "10.10.1.111"
$smtpPort = "25"
$smtpFrom = "root@PAR-DC-SMTP-01.alpha.local"
$smtpTo = "supporttechnique@projetgrp3.ovh"

# Liste des ID à surveiller :
$eventIds = 4610,4615,4622,4646,4720,4722,4728,4729,4730,4731,4732,4733,4734,4744,4745,4746,4747,4726



# Récupération des événements $eventIds dans le journal d'événements
$events = Get-WinEvent -MaxEvents 1 -FilterHashtable @{LogName = "ForwardedEvents" ; ID = $eventIds}


# Vérification et envoi d'e-mail
if ($events) {
    # Vérifier si le message contient la chaîne spécifique pour l'event 4610
    if ($events.Id -eq 4610 -and $events.Message -like "*C:\windows\system32\msv1_0.DLL*") {
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