@echo off

set attr=%~a1

if %attr:~0,1%==d (
    exit 1
) else if "%~x1" == ".xlsx"  (
    xdoc2txt -8 "%1"
) else if "%~x1" == ".xls" (
    xdoc2txt -8 "%1"
) else (
    cat "%1"
) 

