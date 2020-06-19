#Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
#Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#Register-PSRepository -Name "PSGallery" –SourceLocation "https://www.powershellgallery.com/api/v2/" -InstallationPolicy Trusted
#Find-PackageProvider -Name "Nuget" -AllVersions
#Install-PackageProvider -Name "Gistprovider" -Verbose
#Install-Module -Name ThreadJob -RequiredVersion 2.0.0

$source="E:\SQLBackup"
$FilesPath = "E:\SQLBackup"

#List the File Created or Modified on Current Date
$files= Get-ChildItem -Path $FilesPath -recurse |Where-Object {$_.lastwritetime -gt(get-date).date}

#Get Current Date in 'ddMMyyyy' format to create folder on s3 bucket
$FolderName= "$((Get-Date).ToString('ddMMyyyy'))"

Set-Location $source

foreach($file in $files)
    {
        
    $scriptBlock = {
    param (
    [Parameter(Mandatory=$true)]
    [string]$file,
    [Parameter(Mandatory=$true)]
    [string]$FolderName

    )
    
    $bucket = 'BUCKETNAME'
    $AKey   = 'ACCESSKEY'
    $SKey   = 'SECREATKEY'
    $region = 'us-east-1'

    Set-Location "E:\SQLBackup"
    Initialize-AWSDefaultConfiguration -AccessKey $AKey -SecretKey $SKey -Region $region
    aws s3 cp $file s3://$bucket/$FolderName/$file
       
    }
    #-ThrottleLimit 2 #Set ThrottleLimit to upload no of files simultaneously
     Start-ThreadJob -ScriptBlock $scriptBlock -ArgumentList $file,$FolderName -ThrottleLimit 2
  
     #Invoke-Command -ScriptBlock $sb -ArgumentList $file,$FolderName -ThrottleLimit 2 -AsJob
     #Start-Job -ScriptBlock $scriptBlock -ArgumentList $file,$FolderName #running Successfully
 
    }

   