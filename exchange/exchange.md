EXCHANGE   
Servers are installed with GUI

\>AD server  
\>Exchange server  
\>Pfsense  
\>Programs;

* . Net framework 4.7/4.8   
* Visual C++ 2013  
* Install-windowsfeature RSAT-ADDS  
* Unified communications managed API 4.0 runtime  
* URL rewrite

# AD server x1

| COMPUTER 	name |  ad01 |
| :---- | :---- |
| domain | Mstile.com |
| Hardware | Hard disk:127 gb RAM :2048 CPU: 2 |
| network |  IP Address:         192.168.100.10 default gateway: 192.168.100.1 Dns:                     8.8.8.8 |
| Role:  |   Active directory  |

# Exchange server:

| COMPUTER 	name |  ex01 |
| :---- | :---- |
| domain | Mstile.com |
| Hardware | Hard disk:127 gb RAM :5000 CPU: 2 Hard disk:100gb hard disk which is 100 gb i have put these of the following programs:            Visual C++ 2013  . Net framework 4.7/4.8  Unified communications managed API 4.0 runtime URL rewrite DVD:exchange.iso  |
| network |  IP Address:         192.168.100.11 default gateway: 192.168.100.1 Dns:                     192.168.100.10 |

# Pfsense:

pfsense should be set with rules i.e  unclick the reserved network  
![][image1]

and then set interface\>NAT  
![][image2]

![][image3]  
and then save.

\*[HTTPS://wan](HTTPS://wan)address/owa

always use 

# Step1\#

\>Since AD server have AD roles and are connected with IP addresses and also we have Exchange server connected dns with ad server.Remember to shut down the firewall on both server.turn off the all three domain,publick,private.  
so in EXchange server we will mount the hard disk and start installation of the programmes.

* Visual C++ 2013  
*  . Net framework 4.7/4.8   
* Unified communications managed API 4.0 runtime  
* URL rewrite  
  ![][image4]


\>.net framework:next ,finish and then restart the system.  
\>visual code++2013  
\>microsoft unified communication managed API 4.0  
![][image5]

now we need to Install the Remote Server Administration Toolkit and other required components via elevated PowerShell using the below command.

* Install-WindowsFeature Server-Media-Foundation, NET-Framework-45-Features, RPC-over-HTTP-proxy, RSAT-Clustering, RSAT-Clustering-CmdInterface, RSAT-Clustering-Mgmt, RSAT-Clustering-PowerShell, WAS-Process-Model, Web-Asp-Net45, Web-Basic-Auth, Web-Client-Auth, Web-Digest-Auth, Web-Dir-Browsing, Web-Dyn-Compression, Web-Http-Errors, Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Lgcy-Mgmt-Console, Web-Metabase, Web-Mgmt-Console, Web-Mgmt-Service, Web-Net-Ext45, Web-Request-Monitor, Web-Server, Web-Stat-Compression, Web-Static-Content, Web-Windows-Auth, Web-WMI, Windows-Identity-Foundation, RSAT-ADDS

\>after that we will install a rewrite module. and then restart the system.

# Install exchange server 2019

so now we need to install the setup. but before that we need to prepare the schema and Active directory.

so we can go to powershell and use invoke-command in our physical computer or we can use powershell directly from an exchange server.   
 

  .\\Setup.exe /IAcceptExchangeServerLicenseTerms\_DiagnosticDataON /PrepareSchema  
        .\\Setup.exe /IAcceptExchangeServerLicenseTerms\_DiagnosticDataON /PrepareAD /OrganizationName:"Mstile"

now click on dvd and open exchange.iso file .then go to Setup and start the process  
micrsoftexhange.iso\>setup\>license\>i agree\>next\>use recommended settings\>Choose Mailbox Role and check ‘Automatically install Windows Server roles and features required to install Exchange Server.’ Then click ‘next´\>Select the location where you want to install the Exchange Server and click ‘next.’ Prefer location other than the system drive.i.e (e,f…)\>write the organization name:”mstile”\>check the readiness and then install.  
![][image6]

## SETUP OUTLOOK\!

Login to EAC(exchange admin center) and go to servers\>edit\>outlook anywhere\>negotiate\>your external and internal url “ex01.mstile.com.”

# setting service connection point:SCP

SCP\>powershell of exchange management shell\>  
Set-ClientAccessService –Identity NameOfExchange2019Server –AutoDiscoverServiceInternalUri [https://mail.YourDomainName.com/Autodiscover/Autodiscover.xml](https://mail.YourDomainName.com/Autodiscover/Autodiscover.xml)

After fixing the pfsense firewall rules use the wan address on your local host to see are we able to connect with owa.


