# Configuration des informations de l'e-mail
$smtpServer = "10.10.1.111"
$smtpFrom = "root@PAR-DC-SMTP-01.alpha.local"
#$smtpTo = "evan.quere@projetgrp3.ovh"
$smtpTo = "supporttechnique@projetgrp3.ovh"
$subject = "test par evan"
$body = "test par evan"


# Envoi de l'email
Send-MailMessage -From $smtpFrom -To $smtpTo -Subject $subject -Body $body -SmtpServer $smtpServer -Port 25
