$RootDir = "C:\Dropbox\GitHub.Terraform"
$Dirs = @("Demo_Terraform-GitHub-Actions","Demo_Terraform-Local","TerraformAZDOCLI")
#NewModules
$Dirs | ForEach-Object {Robocopy C:\Dropbox\GitHub.Terraform\TerraformModularity  $(Join-Path -Path $RootDir -ChildPath $_ -AdditionalChildPath modules)  *.tf /s /mir /mt }
$Dirs | ForEach-Object {Robocopy C:\Dropbox\GitHub.Terraform\TerraformRoot\  $(Join-Path -Path $RootDir -ChildPath $_ )  *.tf /mt }
cls
#NewPullFetch
#NewFetchPull
git config --global user.name "Lars.Panzerbjrn"
git config --global user.email "lars@panzerbjrn.eu"
#Update-GitHub -Verbose -Fetch -All
#Update-GitHub -Verbose -Fetch -Ask
#Update-GitHub -Verbose -Fetch -Basename ArchModule
#Update-GitHub -Verbose -Push -CommitMessage "Refreshing" -All
#Update-GitHub -Verbose -Push -CommitMessage "Refreshing" -Ask
#Update-GitHub -Verbose -Push -CommitMessage "Refreshing" -Basename ArchModule
#Start-VersionControl

#Update-GitHub -Fetch -All -Verbose -BaseDir C:\Dropbox\GitHub.Demos\
#Update-GitHub -All -Push -CommitMessage "Refreshing" -Verbose -BaseDir C:\Dropbox\GitHub.Demos\

#$BaseDirs = @("GitHub.Infrequent","GitHub.Demos","GitHub","Github.Bicep","GitHub.Terraform")
$BaseDirs = @("GitHub.Terraform")
$BaseDirs | ForEach-Object {
    Update-GitHub -Fetch -All -Verbose -BaseDir $(Join-Path -Path C:\Dropbox\ -ChildPath $_)
    Update-GitHub -All -Push -CommitMessage "Refreshing" -Verbose -BaseDir $(Join-Path -Path C:\Dropbox\ -ChildPath $_)
}
#Start-VersionControl

###################################################
###################################################
###################################################

#sleep 60
#NewTFPullFetch
#NewTFFetchPull
git config --global user.name "Lars.Panzerbjrn"
git config --global user.email "lars@panzerbjrn.eu"

IF($ENV:ComputerName -eq "SED-3JHKX14"){$RootDir = "C:\ReposLPDemo";$BaseDir = "ReposLPDemo"}
ELSE{$RootDir = "C:\Dropbox\GitHub.Terraform";$BaseDir = "GitHub.Terraform"}

$Dirs = @("Demo_Terraform-GitHub-Actions","Demo_Terraform-Local","Demo_Terraform-AzureDevOps")
$Dirs | ForEach-Object {Robocopy $(Join-Path -Path $RootDir -ChildPath "TerraformModularity")  $(Join-Path -Path $RootDir -ChildPath $_ -AdditionalChildPath modules)  *.tf /s /mir /mt }
$Dirs | ForEach-Object {Robocopy $(Join-Path -Path $RootDir -ChildPath "TerraformRoot")  $(Join-Path -Path $RootDir -ChildPath $_ )  *.tf /mt }

GCI $RootDir -Directory | Where-Object {$_.Name -match "Terraform"} | ForEach-Object {
	Update-GitHub -Fetch -Verbose -BaseDir $RootDir -Basename $_.BaseName
	Update-GitHub -Push -CommitMessage "Refreshing" -Verbose -BaseDir $RootDir -Basename $_.BaseName
}
