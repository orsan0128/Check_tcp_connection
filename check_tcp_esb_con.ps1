<#
.SYNOPSIS 
 This Script Will Count the TCP connection and state is Established

.NOTES
     Author     : Orsan Hsu

.PARAMETER Server
    Server Full Address or Machine Name

.PARAMETER warning , w 
	Warning Threshold

.PARAMETER critical , c 
	Critical Threshold	

.EXAMPLE
   .\check_tcp_esb_con.ps1 -Server 127.0.0.1 -warning 50 -critical 80
   .\check_tcp_esb_con.ps1 -s 127.0.0.1 -w 50 -c 80

#>

param (
	[String] $Server,
	[String] $s,
	[int] $warning,
	[int] $w,
	[int] $critical,
	[int] $c
)
$Server = $s
$warning = $w
$critical = $c

$Counter =  (Get-NetTCPConnection -State Established).Count
#$Counter = 'abc'


if([String]::IsNullOrEmpty($Counter))

{
   Write-Host "The Counter is null , please check ."
   exit 3

}
else
{
	if ($Counter -isnot [int])
	{
		Write-Host "The Counter is not int , please check ."
		exit 3
	}
	else
	{
		if ($Counter -lt $warning)
		{
			Write-Host "OK : TCP Concurrent connection $Counter"
			exit 0
		}
		elseif ($Counter -ge $warning)
		{
			if($Counter -ge $critical)
			{
				Write-Host "Critical :  TCP Concurrent connection $Counter"
				exit 2
			}
			
			Write-Host "Warning :  TCP Concurrent connection $Counter"
			exit 1
		}
		else
		{
			Write-Host "Unknown: Unknown Status"
			exit 3
		}	
	}
}

