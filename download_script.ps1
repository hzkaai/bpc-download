# BPC Download and Extract Script
# Date: 2025-09-26

$downloadUrl = "https://gitflic.ru/project/magnolia1234/bpc_uploads/file/downloadAll?branch=main&format=zip"
$targetFolder = "C:\CMD Tools"
$tempFolder = Join-Path $env:TEMP "bpc_temp_extract"
$zipFileName = "bpc_repository.zip"
$zipFilePath = Join-Path $env:TEMP $zipFileName
$innerZipName = "bypass-paywalls-chrome-clean-master.zip"

# Create target directory if it doesn't exist
if (-not (Test-Path $targetFolder)) {
    Write-Host "Creating target folder: $targetFolder" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $targetFolder -Force | Out-Null
}

# Create temporary folder for extraction
if (Test-Path $tempFolder) {
    Write-Host "Cleaning up existing temporary folder..." -ForegroundColor Yellow
    Remove-Item $tempFolder -Recurse -Force
}
Write-Host "Creating temporary folder: $tempFolder" -ForegroundColor Yellow
New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null

try {
    Write-Host "Starting download..." -ForegroundColor Green
    Write-Host "URL: $downloadUrl" -ForegroundColor Cyan
    Write-Host "Save to: $zipFilePath" -ForegroundColor Cyan
    
    # Download repository zip file
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFilePath -UseBasicParsing
    
    # Check if download was successful
    if (Test-Path $zipFilePath) {
        $fileSize = (Get-Item $zipFilePath).Length
        Write-Host "Download successful! File size: $([math]::Round($fileSize / 1MB, 2)) MB" -ForegroundColor Green
    } else {
        throw "Download failed"
    }
    
    Write-Host "Extracting repository zip to temporary folder..." -ForegroundColor Green
    
    # Extract repository zip file to temporary folder
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFilePath, $tempFolder)
    
    Write-Host "Repository extracted successfully!" -ForegroundColor Green
    
    # Find the inner zip file
    Write-Host "Searching for $innerZipName..." -ForegroundColor Yellow
    $innerZipPath = Get-ChildItem -Path $tempFolder -Recurse -Filter $innerZipName | Select-Object -First 1
    
    if (-not $innerZipPath) {
        throw "Could not find $innerZipName in the extracted files"
    }
    
    Write-Host "Found inner zip file: $($innerZipPath.FullName)" -ForegroundColor Green
    Write-Host "Extracting $innerZipName to: $targetFolder" -ForegroundColor Green
    
    # Extract inner zip file to target folder
    $zip = [System.IO.Compression.ZipFile]::OpenRead($innerZipPath.FullName)
    
    foreach ($entry in $zip.Entries) {
        $entryTargetPath = Join-Path $targetFolder $entry.FullName
        
        # Create directory if needed
        $entryDir = Split-Path $entryTargetPath -Parent
        if ($entryDir -and -not (Test-Path $entryDir)) {
            New-Item -ItemType Directory -Path $entryDir -Force | Out-Null
        }
        
        # Extract file if not directory
        if (-not $entry.FullName.EndsWith("/")) {
            Write-Host "Extracting: $($entry.FullName)" -ForegroundColor Gray
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $entryTargetPath, $true)
        }
    }
    
    $zip.Dispose()
    Write-Host "Final extraction complete!" -ForegroundColor Green
    
    # Delete all temporary files and folders
    Write-Host "Cleaning up temporary files..." -ForegroundColor Yellow
    if (Test-Path $zipFilePath) {
        Remove-Item $zipFilePath -Force
        Write-Host "Deleted repository zip file" -ForegroundColor Gray
    }
    if (Test-Path $tempFolder) {
        Remove-Item $tempFolder -Recurse -Force
        Write-Host "Deleted temporary extraction folder" -ForegroundColor Gray
    }
    Write-Host "Cleanup complete!" -ForegroundColor Green
    
    Write-Host "" -ForegroundColor White
    Write-Host "=======================================" -ForegroundColor Cyan
    Write-Host "Operation completed successfully!" -ForegroundColor Green
    Write-Host "Files extracted to: $targetFolder" -ForegroundColor Cyan
    Write-Host "=======================================" -ForegroundColor Cyan
    
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    
    # Cleanup on error
    Write-Host "Cleaning up temporary files..." -ForegroundColor Yellow
    if (Test-Path $zipFilePath) {
        try {
            Remove-Item $zipFilePath -Force
            Write-Host "Deleted repository zip file" -ForegroundColor Yellow
        } catch {
            Write-Host "Could not delete repository zip file: $zipFilePath" -ForegroundColor Red
        }
    }
    if (Test-Path $tempFolder) {
        try {
            Remove-Item $tempFolder -Recurse -Force
            Write-Host "Deleted temporary folder" -ForegroundColor Yellow
        } catch {
            Write-Host "Could not delete temporary folder: $tempFolder" -ForegroundColor Red
        }
    }
    
    Write-Host "Operation failed. Please check network connection or URL" -ForegroundColor Red
    exit 1
}

# Script completed, no pause needed for auto-close
Write-Host ""
Write-Host "Script execution completed. Window will close automatically." -ForegroundColor Green