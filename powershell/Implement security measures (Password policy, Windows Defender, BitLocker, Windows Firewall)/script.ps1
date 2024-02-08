# Set password policy
$PasswordPolicy = @{
    "MinimumPasswordLength" = 15
    "MaximumPasswordAge" = 0  # Set to 0 for "never expires"
    "PasswordComplexity" = $true
    "LockoutThreshold" = 5
    "LockoutDuration" = (New-TimeSpan -Minutes 15)
    "LockoutObservationWindow" = (New-TimeSpan -Minutes 15)
}
Set-LocalUser -Name "Administrator" -PasswordPolicy $PasswordPolicy

# Enable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $false

# Enable BitLocker for the C: drive (assuming TPM chip is available)
Enable-BitLocker -MountPoint "C:"

# Configure Windows Firewall
# Example: Allow inbound traffic on port 80 (HTTP) for the Domain profile
New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow -Profile Domain
