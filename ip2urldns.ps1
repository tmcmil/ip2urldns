##################################################################################################################
#                                                   IP2URL.resolve.ps1                                            #
#                                   Resolve DNS  and landing page of an ip spreadsheet                            #
###################################################################################################################
#Set Location of CSV hostlist with column headers "IP" containing all ips and an empty "URL" and "Hostname" column#
###################################################################################################################
$filepath = "Z:\Google Drive\assessment\scripts\powershell\ip_hostlist.csv" 

##############################
#Import File in $ips variable#
##############################
$ips = Import-CSV $filepath

############################################################################################################
#for loop to interate through the ips from the csv IP column assigning each to "$ie.Navigate($ips[$i].IP)".#
#Then browse to each IP with a COM call to IE and record the url of the landing page to "$ips[$i].URL".    #
############################################################################################################
 for ($i = 0; $i -lt $ips.Count; $i++)
 {
 $ie = New-Object -ComObject "InternetExplorer.Application"
    $ie.Visible = $false
    $ie.Silent = $true
    $ie.Navigate($ips[$i].IP)
    Do{Start-Sleep 1}While($ie.Busy -eq $true)
    $ips[$i].URL = $ie.Document.url
    
#############################################################################
#DNS resolution during the for loop for each IP. Writes to $ips[$i].Hostname#
#############################################################################
  $result = $null
  $currentEAP = $ErrorActionPreference
  $ErrorActionPreference = "silentlycontinue"
  $result = [System.Net.Dns]::GetHostByAddress($ips[$i].IP)
  $ErrorActionPreference = $currentEAP
  if ($result)
    {
     $ips[$i].HostName = [string]$result.HostName
    }
###############################################################
#Record values and export to csv file columns URL and Hostname#
###############################################################
 Write-host $ips[$i].URL","$ips[$i].Hostname
 $ips | Export-Csv "$filepath.out.csv"
 Get-Process iexplore | Stop-Process
 }
 echo "Export Complete"
