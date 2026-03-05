#
# prepare the environment by installing required modules
#

get-installedmodule

Install-Module -name Microsoft.Graph.Groups -verbose
Install-Module -name Az.Accounts -verbose
Install-Module -name Microsoft.Graph.Users -verbose
Install-Module -name Microsoft.Graph.Identity.SignIns -verbose
Install-Module -name Microsoft.Graph.Identity.Governance -verbose
Install-Module -name Microsoft.Graph.Identity.DirectoryManagement -verbose
Install-Module -name Microsoft.Graph.Authentication -verbose

install-module -name PIMActivation -verbose
import-module -name PIMActivation -verbose

Start-PIMActivation -TenantId "BECDK.onmicrosoft.com" -IncludeEntraRoles -scriptblock { get-prosess }

