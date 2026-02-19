install-module -name DnsClient -verbose
import-module -name ExchangeOnlineManagement -Verbose

Connect-ExchangeOnline -DelegatedOrganization becdk.onmicrosoft.com -BypassMailboxAnchoring -Verbose

Get-AcceptedDomain


$emirp_eu = Get-DnssecStatusForVerifiedDomain -DomainName emirp.eu -Verbose
$emirp_eu.MtaStsValidation
$emirp_eu.MxValidation|fl * # mærkeligt giver  EX003:Priority of MX record did not match the expected one.

Enable-DnssecForVerifiedDomain -DomainName 20011.dk -Verbose

$20011_dk = Get-DnssecStatusForVerifiedDomain -DomainName 20011.dk -Verbose
$20011_dk.DnsValidation

$20011_dk.MxValidation

$20011_dk.ExpectedMxRecord



