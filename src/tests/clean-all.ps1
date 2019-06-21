Get-ChildItem -Filter ".terraform" -ErrorAction SilentlyContinue -Recurse | ForEach-Object {
    $path = [io.path]::GetDirectoryName($_.FullName)
    Set-Location $path
    Write-Output "Cleaning $($path)"

    &terraform init
    &terraform destroy -auto-approve
}

Set-Location $PSScriptRoot
