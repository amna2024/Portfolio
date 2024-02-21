install-WindowsFeature BitLocker -IncludeManagementTools

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"

#Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}


Set-ItemProperty -Path $registryPath -Name "EnableBDEWithNoTPM" -Value "1" -Type DWord
Set-ItemProperty -Path $registryPath -Name "UseAdvancedStartup" -Value "1" -Type DWord
Set-ItemProperty -Path $registryPath -Name "UseTPM" -Value "2" -Type DWord
Set-ItemProperty -Path $registryPath -Name "UseTPMKey" -Value "2" -Type DWord
Set-ItemProperty -Path $registryPath -Name "UseTPMKeyPIN" -Value "2" -Type DWord
Set-ItemProperty -Path $registryPath -Name "UseTPMPIN" -Value "2" -Type DWord

#Password (Sommar123)
$Pin = ConvertTo-SecureString "Sommar123" -AsPlainText -Force
Enable-BitLocker -MountPoint "C:" -EncryptionMethod Aes256 -PasswordProtector -Password $Pin -SkipHardwareTest
