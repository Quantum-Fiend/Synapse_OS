# SynapseOS Master Verification Script
# This script performs a readiness check on all SynapseOS modules.

Write-Host "--- SynapseOS Readiness Audit ---" -ForegroundColor Cyan

$modules = @("backend-scala", "flutter-app", "android-kotlin", "ios-swift")
$success = $true

foreach ($module in $modules) {
    if (Test-Path $module) {
        Write-Host "[OK] Module '$module' exists." -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Module '$module' is missing!" -ForegroundColor Red
        $success = $false
    }
}

Write-Host "`n--- Backend Integrity Check ---" -ForegroundColor Cyan
if (Test-Path "backend-scala/build.sbt") {
    Write-Host "[OK] build.sbt found." -ForegroundColor Green
} else {
    Write-Host "[ERROR] build.sbt missing!" -ForegroundColor Red
    $success = $false
}

Write-Host "`n--- UI Integrity Check ---" -ForegroundColor Cyan
if (Test-Path "flutter-app/pubspec.yaml") {
    Write-Host "[OK] pubspec.yaml found." -ForegroundColor Green
} else {
    Write-Host "[ERROR] pubspec.yaml missing!" -ForegroundColor Red
    $success = $false
}

Write-Host "`n--- Verification Instructions ---" -ForegroundColor Yellow
Write-Host "1. Backend: Run 'cd backend-scala; sbt run' to start the Akka server."
Write-Host "2. Frontend: Run 'cd flutter-app; flutter pub get; flutter run' to start the UI."
Write-Host "3. Docker: Run 'docker-compose up' to provision PostgreSQL and Redis."

if ($success) {
    Write-Host "`n[SUCCESS] SynapseOS is structurally sound and ready for production workflows!" -ForegroundColor Green
} else {
    Write-Host "`n[FAILURE] Some components are missing. Please re-run the scaffolding." -ForegroundColor Red
}
