$PublicPort = 8010
Write-Output "Application:  http://localhost:$PublicPort/"
Write-Output "Debug:        http://localhost:$PublicPort/Debug"
Write-Output "Health check: http://localhost:$PublicPort/healthcheck"
kubectl --namespace default port-forward svc/outlook-integration ${PublicPort}:8080
