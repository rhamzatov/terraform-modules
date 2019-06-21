# To run specific test:
# .\apply-tests.ps1 -f .\cw_log\test.tf

# To keep resources:
# .\apply-tests.ps1 -f .\cw_log\test.tf -k

# To run all tests:
# .\apply-tests.ps1

param(
    [switch][Alias("k")]$keepResources,
    [string][Alias("f")]$testFile,
    [switch][Alias("d")]$dry
)

function Test() {
    param([string]$testPath)

    $path = [io.path]::GetDirectoryName($testPath)
    Set-Location $path

    &terraform init

    if ($dry) {
        &terraform plan
    }
    else {
        &terraform apply -auto-approve
    }

    if (!$dry -and !$keepResources) {
        &terraform destroy -auto-approve
    }
}

if ($testFile) {
    Test $testFile
}
else {
    Get-ChildItem ".\*\test.tf" -ErrorAction SilentlyContinue -Recurse | ForEach-Object {
        Test $_
    }
}

Set-Location $PSScriptRoot
