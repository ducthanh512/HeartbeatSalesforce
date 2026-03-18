# check-deploy.ps1
# Run after git push to check if GitHub Actions deploy succeeded or failed

$repo    = "ducthanh512/HeartbeatSalesforce"
$apiBase = "https://api.github.com/repos/$repo"
$headers = @{ "User-Agent" = "sf-check" }

Write-Host ""
Write-Host "Checking latest deploy run..." -ForegroundColor Cyan

$runs = Invoke-RestMethod -Uri "$apiBase/actions/runs?per_page=1" -Headers $headers
$run  = $runs.workflow_runs[0]

$commit = ($run.head_commit.message -split "`n")[0]
$result = if ($run.conclusion) { $run.conclusion } else { "in_progress" }
$runUrl = $run.html_url

$color = switch ($result) {
    "success"     { "Green" }
    "failure"     { "Red" }
    "in_progress" { "Yellow" }
    default       { "Gray" }
}

Write-Host ""
Write-Host ("Run #" + $run.run_number + "  |  " + $result.ToUpper()) -ForegroundColor $color
Write-Host ("Commit : " + $commit)
Write-Host ("URL    : " + $runUrl)
Write-Host ""

if ($result -eq "in_progress") {
    Write-Host "Still running. Re-run this script in ~30 seconds." -ForegroundColor Yellow
    exit 0
}

if ($result -eq "success") {
    Write-Host "DEPLOY SUCCEEDED - your changes are live in the org." -ForegroundColor Green
    exit 0
}

# Failure - fetch step details
Write-Host "DEPLOY FAILED - fetching step details..." -ForegroundColor Red
Write-Host ""

$jobs = Invoke-RestMethod -Uri ("$apiBase/actions/runs/" + $run.id + "/jobs") -Headers $headers
$job  = $jobs.jobs[0]

foreach ($step in $job.steps) {
    $icon = switch ($step.conclusion) {
        "success" { "[OK]  " }
        "failure" { "[FAIL]" }
        "skipped" { "[SKIP]" }
        default   { "[...] " }
    }
    $stepColor = if ($step.conclusion -eq "failure") { "Red" } elseif ($step.conclusion -eq "success") { "Green" } else { "Gray" }
    Write-Host ("  " + $icon + " " + $step.name) -ForegroundColor $stepColor
}

Write-Host ""
Write-Host "--- To reproduce the error locally, run: ---" -ForegroundColor Yellow
Write-Host "sf project deploy start --manifest manifest/package.xml --target-org orgfarm-dev --dry-run" -ForegroundColor White
Write-Host ""
Write-Host "--- Full logs at: ---" -ForegroundColor Yellow
Write-Host $runUrl -ForegroundColor Cyan
Write-Host ""
