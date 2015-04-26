import-module grouppolicy
Get-GPOReport -All -ReportType Html -Path c:\scripts\gporeport.html

#Set email variables
$EmailFrom = "example@domain.tld"
$EmailTo = "example@domain.tld"
$Subject = "[ACTIVE DIRECTORY] GPO Report"
$body = "Monthly GPO Report"
$SMTPServer = "smtp.domain.tld"
$report = "C:\scripts\gporeport.html"


#Email the log files.
Send-MailMessage -Subject $Subject -Body $body -SmtpServer $SMTPServer -Priority High -To $EmailTo -From $EmailFrom -Attachments $report

# Remove logs
Remove-Item $report
