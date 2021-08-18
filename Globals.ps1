#--------------------------------------------
# Declare Global Variables and Functions here
#--------------------------------------------


#Sample function that provides the location of the script
function Get-ScriptDirectory
{
<#
	.SYNOPSIS
		Get-ScriptDirectory returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
#>
	[OutputType([string])]
	param ()
	if ($null -ne $hostinvocation)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}

#Sample variable that provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory

#Default Path Of 7 Days To Die Folder

If (Test-Path -Path 'HKCU:\SOFTWARE\CindarLoader')
{
	$global:7DTDPath = Get-ItemPropertyValue 'HKCU:\Software\CindarLoader' -Name "GamePath"
}
else
{
	New-Item -Path "HKCU:\SOFTWARE\CindarLoader"
	Set-ItemProperty -Path "HKCU:\SOFTWARE\CindarLoader" -Name 'GamePath' -Value 'C:\Program Files (x86)\Steam\steamapps\common\7 Days To Die' -Type "String"
	$global:7DTDPath = Get-ItemPropertyValue 'HKCU:\Software\CindarLoader' -Name "GamePath"
}

	