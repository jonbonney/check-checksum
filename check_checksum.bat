@echo off
setlocal

REM Default values
set "algorithm=SHA256"
set "expected_checksum="
set "file_path="

REM Parse arguments
:parse_args
if "%~1"=="" goto :args_done

if "%~1"=="--filepath" (
    set "file_path=%~2"
    shift
    shift
    goto :parse_args
) else if "%~1"=="-f" (
    set "file_path=%~2"
    shift
    shift
    goto :parse_args
) else if "%~1"=="--algorithm" (
    set "algorithm=%~2"
    shift
    shift
    goto :parse_args
) else if "%~1"=="-a" (
    set "algorithm=%~2"
    shift
    shift
    goto :parse_args
) else if "%~1"=="--expected" (
    set "expected_checksum=%~2"
    shift
    shift
    goto :parse_args
) else if "%~1"=="-e" (
    set "expected_checksum=%~2"
    shift
    shift
    goto :parse_args
) else (
    echo Unknown argument: %~1
    exit /b 1
)

:args_done

REM Validate the required argument
if "%file_path%"=="" (
    echo Usage: check_checksum --filepath file_path [--expected checksum] [--algorithm algo]
    echo        or: check_checksum -f file_path [-e checksum] [-a algo]
    goto :EOF
)

REM Calculate the checksum
for /f %%i in ('certutil -hashfile "%file_path%" %algorithm% ^| findstr /v /c:"CertUtil"') do set "calculated_checksum=%%i"

echo Computed checksum: %calculated_checksum%

REM Compare if expected checksum is provided
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
