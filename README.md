###################################################### tmcmil #####################################################
#                                                   ip2urldns.ps1                                                 #
#                                   Resolve DNS and landing page of an ip hostlist                                #
###################################################################################################################

1. Import your ip hostlist as a csv file with the column headers IP with all your ips, URL and Hostname both left blank.
2. Modify script with the file path of the csv hostlist.

#####
Optionally modify $ie.Visible = $false to $true to see the webpages launch in IE. May need to modify Do{Start-Sleep 1} to 5 or more to see the pages.
 
