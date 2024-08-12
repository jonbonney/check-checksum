@echo off
setlocal

REM Set default values
set "algorithm=SHA256"
set "expected_checksum="

REM Parse arguments
if not "%1"=="" set "file_path=%~1"
if not "%2"=="" set "expected_checksum=%~2"
if not "%3"=="" set "algorithm=%~3"

if "%file_path%"=="" (
    echo Usage: check_checksum file_path [expected_checksum] [algorithm]
    goto :EOF
)

for /f %%i in ('certutil -hashfile "%file_path%" %algorithm% ^| findstr /v /c:"CertUtil"') do set "calculated_checksum=%%i"

echo Computed checksum: %calculated_checksum%

if not "%expected_checksum%"=="" (
    if /i "%expected_checksum%"=="%calculated_checksum%" (
        echo Checksum matches.
    ) else (
        echo Checksum does NOT match.
        echo Expected: %expected_checksum%
        echo Got: %calculated_checksum%
    )
)

endlocal
