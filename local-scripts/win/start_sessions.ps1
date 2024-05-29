# Path to the IP file
$ipFile = "..\ips.txt"

# Check if the IP file exists
if (-Not (Test-Path $ipFile)) {
    Write-Host "IP file $ipFile does not exist."
    exit 1
}

# Function to open a new PowerShell window and run SSH
function Open-TerminalTab {
    param (
        [string]$ip
    )

    # Create a new PowerShell window
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "ssh root@$ip; pause"
}

# Read the IP file line by line and open a new PowerShell window for each IP
Get-Content $ipFile | ForEach-Object {
    Open-TerminalTab -ip $_
}

Write-Host "Remote sessions started..."
