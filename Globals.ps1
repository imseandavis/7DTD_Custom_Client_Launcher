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

function Test-RegistryValue
{
	param (
		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		$Path,
		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		$Value
	)
	
	try
	{
		Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
		return $true
	}
	
	catch
	{
		return $false
	}
}

#Set Path Of 7 Days To Die Folder
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

# Create EAC and Cache Mode Registry Entries If They Don't Already Exist'
If (!(Test-RegistryValue -Path 'HKCU:\Software\CindarLoader' -Value "EAC"))
{
	Set-ItemProperty -Path "HKCU:\SOFTWARE\CindarLoader" -Name 'EAC' -Value "True" -Type "String"
}

If (!(Test-RegistryValue -Path 'HKCU:\Software\CindarLoader' -Value "CacheMode"))
{
	Set-ItemProperty -Path "HKCU:\SOFTWARE\CindarLoader" -Name 'CacheMode' -Value "True" -Type "String"
}
	