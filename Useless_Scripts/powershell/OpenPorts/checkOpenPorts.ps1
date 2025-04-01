# Port Usage Analyzer

Write-Output "Scanning active network connections..."

# Retrieve netstat output and parse
$connections = netstat -ano | ForEach-Object {
    $fields = $_ -split "\s+"
    if ($fields.Count -ge 5 -and $fields[0] -match "^(TCP|UDP)$") {
        $protocol = $fields[0]
        $localAddress = $fields[1]
        $remoteAddress = $fields[2]
        $state = if ($protocol -eq "TCP") { $fields[3] } else { "N/A" }
        $pid = $fields[-1]
        $process = Get-Process -Id $pid -ErrorAction SilentlyContinue
        $processName = if ($process) { $process.ProcessName } else { "Unknown" }
        
        [PSCustomObject]@{
            Protocol      = $protocol
            LocalAddress  = $localAddress
            RemoteAddress = $remoteAddress
            State         = $state
            PID           = $pid
            Process       = $processName
        }
    }
}

# Filter by specific port if needed
$portFilter = Read-Host "Enter a port number to filter (or press Enter for all)"
if ($portFilter -match "^\d+$") {
    $connections = $connections | Where-Object { $_.LocalAddress -match ":$portFilter$" }
}

# Display results in a table
if ($connections) {
    $connections | Format-Table -AutoSize
} else {
    Write-Output "No active connections found."
}
