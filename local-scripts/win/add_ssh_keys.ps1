# List of VM IP addresses or hostnames
$ipFile = "..\ips.txt"

# Path to the public key
$PUBLIC_KEY_PATH = "$env:USERPROFILE\.ssh\id_rsa.pub"

# Read the public key
if (-not (Test-Path $PUBLIC_KEY_PATH)) {
    Write-Host "Public key not found at $PUBLIC_KEY_PATH"
    exit 1
}

$PUBLIC_KEY = Get-Content $PUBLIC_KEY_PATH

# Function to add SSH key to a VM
function Add-SSHKey-From-Dev-Box-To-Node {
    param (
        [string]$vm
    )
    ssh root@$vm "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '$PUBLIC_KEY' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully added key to $vm"
    } else {
        Write-Host "Failed to add key to $vm"
    }
}

# Read the IP file line by line
foreach ($ip in Get-Content $ipFile) {
    Add-SSHKey-From-Dev-Box-To-Node $ip
}

Write-Host "SSH key addition complete."
