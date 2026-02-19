install-module -name DnsClient -verbose
import-module -name ExchangeOnlineManagement -Verbose

function makePSline
{
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [System.Object] $mbxObj,

         [Parameter(Mandatory=$true, Position=1)]
         [string] $domain2use
    )
    #
    #   build the line identification
    #
    $rc=@(); $global:lineID++
    $thisLineID='{0:d5}' -f $global:lineID
    #
    #   build the user identification 
    #       Key UPN Constraints:
    #           Total Length: Maximum 113 characters.
    #           Username Part: Maximum 64 characters.
    #           Domain Part: Maximum 48 characters.
    #           Characters Allowed: A-Z, a-z, 0-9, ' . - _ ! # ^ ~.

    #
    $thisInitialUPN=$mbxObj.userprincipalname
    #
    # build the emailaddresses attribute - potentially new SMTP,SIP - scrap all smtp: - keep SPO, x500 and X500
    #

    #
    # build the new UPN
    #
    $thisNewUserpart = "$($mbxObj.userprincipalname.replace('@','#').replace('.','_'))" 
    
    $thisUPN = "$thisNewUserpart + '@' + $domain2use"

    $rc+=" <#$thisLineID doIT#> <#$thisInitialUPN#> set-mailbox -identity '$($mbxObj.ExchangeObjectId.guid)'  -userprincipalname '$thisUPN' -emailaddresses @()"
    $rc+="#<#$thisLineID unDO#> <#$thisInitialUPN#> set-mailbox -identity '$($mbxObj.ExchangeObjectId.guid)'  -userprincipalname '$($mbxObj.userprincipalname)' -emailaddresses @()"
    return($rc)

}

$global:lineID=0


makePSline -mbxObj $flegleMbx -domain2use $strDomaintoConvertTo




Connect-ExchangeOnline -DelegatedOrganization becdk.onmicrosoft.com -BypassMailboxAnchoring -Verbose


#domain to convert to
Set-Variable strDomaintoConvertTo -Option ReadOnly -Value "becdk.onmicrosoft.com" -Verbose
#
# get mailboxes in scope
#
$mbxSinScope = get-exomailbox -PropertySets All
$mbxSinScope.count
#
#
# 

Set-Mailbox -EmailAddresses 

$mbxSinScope|fl userpr*,emailadd*,prima*,*sync*
$grp_isDirSynced = @($mbxSinScope|group-Object -Property isdirsynced)[1].group
$grp_isDirSynced |select-Object -Property userp*,disp*,email*,prima*,*syn*|Format-Table -AutoSize


$grp_isDirSynced[0].emailaddresses
#
# mention SMTP: smtp: SIP: keey SPO and X500
#

makePSline -mbxObj $flegleMbx -domain2use $strDomaintoConvertTo


foreach($mbx in $mbxSinScope)
{
    makePSline -mbxObj $mbx -domain2use $strDomaintoConvertTo
}

$global:lineID


$flegleMbx = get-exomailbox 'flegle*' -PropertySets ALL
$flegleMbx.EmailAddresses


$mbxSinScope|Where-Object {$_.displayName -match 'røssumlect-Object -Property userp*,disp*,email*,prima*,*syn*|Format-Table -AutoSize
$mbxSinScope.emailaddresses | %{($_ -split ':')[0]} | group-object -CaseSensitive |sort-object -property name

get-help group-object





