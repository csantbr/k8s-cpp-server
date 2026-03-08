# Script para conectar ao servidor TCP
# Uso: .\connect.ps1 [server] [port]

param(
    [string]$Server = "localhost",
    [int]$Port = 30080
)

try {
    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect($Server, $Port)
    
    $stream = $client.GetStream()
    $reader = New-Object System.IO.StreamReader($stream)
    
    $response = $reader.ReadLine()
    Write-Host "Response: $response" -ForegroundColor Green
    
    $reader.Close()
    $client.Close()
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}
