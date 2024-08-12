@echo off
setlocal

REM Default values
set "algorithm=SHA256"
set "expected_checksum="
set "file_path="
set "show_help=false"

REM Help menu function
:show_help_menu
echo Usage: check_checksum --filepath file_path [--expected checksum] [--algorithm algo]
echo        or: check_checksum -f file_path [-e checksum] [-a algo]
echo Options:
echo   --filepath, -f  : Path to the file to check.
echo   --expected, -e  : Expected checksum to compare against.
echo   --algorithm, -a : Hashing algorithm to use (e.g., SHA256, SHA1, MD5). Default is SHA256.
echo   --help, -h      : Display this help menu.
goto :EOF

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
) else if "%~1"=="--help" (
    set "show_help=true"
    shift
    goto :parse_args
) else if "%~1"=="-h" (
    set "show_help=true"
    shift
    goto :parse_args
) else (
    echo Unknown argument: %~1
    exit /b 1
)

:args_done

REM Display help menu if requested
if "%show_help%"=="true" (
    if not "%file_path%"=="" (
        echo Help menu was requested. Do you want to run the command with the provided arguments? [y/n]
        set /p "confirm=Your choice: "
        if /i "%confirm%"=="y" (
            goto :run_command
        ) else (
            goto :show_help_menu
        )
    ) else (
        goto :show_help_menu
    )
)

:run_command

REM Validate the required argument
if "%file_path%"=="" (
    echo Missing required argument: --filepath or -f
    goto :show_help_menu
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
