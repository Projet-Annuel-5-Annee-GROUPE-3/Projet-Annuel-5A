# Configuration des informations de l'e-mail
$smtpServer = "10.10.1.111"
$smtpFrom = "root@LXC-Test.alpha.local"
$smtpTo = "evan.quere@projetgrp3.ovh"
#$smtpTo = "supporttechnique@projetgrp3.ovh"
$subject = "test tache planifiée"
$body = "test par evan tache planifiéé"


# Envoi de l'email
Send-MailMessage -From $smtpFrom -To $smtpTo -Subject $subject -Body $body -SmtpServer $smtpServer -Port 25

