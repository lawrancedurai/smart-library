@echo off
@REM Smart Library Management System Maven Launcher
setlocal

set "PROJECT_DIR=%~dp0"
set "LOCAL_MVN=%PROJECT_DIR%.tools\apache-maven-3.9.9\bin\mvn.cmd"

if exist "%LOCAL_MVN%" (
    call "%LOCAL_MVN%" %*
) else (
    mvn %*
)
