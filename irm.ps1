Write-Host "Run malicious code or don't, we don't care anyways." -ForegroundColor Red
Start-Sleep -Seconds 2
Start-Process cmd -ArgumentList "/k curl ascii.live/as"
