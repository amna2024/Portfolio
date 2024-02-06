# PowerShell Script Description

This PowerShell script defines variables used to create a network security rule allowing RDP traffic in an Azure Network Security Group (NSG).

## Variables

- **$namerdp**: Specifies the name of the security rule.
- **$allowrdp**: Specifies whether RDP traffic is allowed.
- **$nsg**: Specifies the name of the Network Security Group (NSG).
- **$protocal**: Specifies the protocol for the security rule.
- **$proto**: Specifies the TCP protocol.
- **$direction**: Specifies the direction of traffic flow.
- **$bound**: Specifies inbound traffic.
- **$prior**: Specifies the priority of the security rule.
- **$provalue**: Specifies the priority value (200 in this case).
- **$sourceaddpre**: Specifies the source address prefix.
- **$starvalue**: Specifies all source addresses.
- **$sourceportrang**: Specifies the source port range.
- **$desaddpref**: Specifies the destination address prefix.
- **$destportrang**: Specifies the destination port range.
- **$valuedestport**: Specifies the destination port value (3389 for RDP).
- **$access**: Specifies the type of access (Allow or Deny).
- **$valaccess**: Specifies the value for allowing traffic (in this case, 'Allow').

This script can be further utilized to configure Azure NSG rules for managing inbound RDP traffic.
```
