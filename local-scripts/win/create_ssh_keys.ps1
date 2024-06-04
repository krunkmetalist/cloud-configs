# List of VM IP addresses
$ipFile = "..\ips.txt"

# Function to create SSH keys on a VM
function New-Ssh-key {
    param (
        [string]$vm
    )
    ssh root@$vm "ssh-keygen -t rsa -N '' -f id_rsa && mv id_rsa ~/.ssh/ && mv id_rsa.pub ~/.ssh/"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully created key for $vm"
    } else {
        Write-Host "Failed to create key for $vm"
    }
}

# Read the IP file line by line
foreach ($ip in Get-Content $ipFile) {
    New-Ssh-key $ip
}

Write-Host "SSH key (rsa) creation complete."
