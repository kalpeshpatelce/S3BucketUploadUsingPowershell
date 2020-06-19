# SQL Backup File from Local to S3 Bucket using Multi Thread Technology in Powershell
Upload the SQL Backup File from Local to S3 Bucket using Multi Thread Technology. Multiple Job running at a time to upload multiple file which is Controlled by  ThrottleLimit. 

# Scenario
one of the my Project need to required as below
1) Everyday 400 files Backup from SQL Server & Stored in E:\SQLBackup.
2) All the 400 Files must upload at S3 Bucket at 11:00 PM Everyday.
3) All the 400 Files must be copied in Folder.
4) Folder Must be Created Based on Current Date in s3 Bucket.

# Solution:
1) Created Powershell Script. which take care of everything which mentioned in requirement
2) Create Task Scheduler in Windows which Execute this script Everyday at 11:00 PM.

# Prerequisite to run Script
Install PowershellGallery Repository to Create Multi Thread
Steps are as below
1) Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord #for 64 Bit OS
***************************************************************OR********************************************************************
2) Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord #32Bit OS
3) [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 #to Communicationg with PSGallery
4) Register-PSRepository -Name "PSGallery" –SourceLocation "https://www.powershellgallery.com/api/v2/" -InstallationPolicy Trusted
5) Find-PackageProvider -Name "Nuget" -AllVersions
6) Install-PackageProvider -Name "Gistprovider" -Verbose
7) Install-Module -Name ThreadJob -RequiredVersion 2.0.0 # Refer "https://www.powershellgallery.com/packages/ThreadJob/2.0.0"

After Installing Above prerequisite You can run Powershell Script at your Server
