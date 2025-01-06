@echo off
:: Wrapper script for sshm.sh
:: Requires Bash to be installed

:: Path to your sshm.sh script, Change it!
set SSHM_SCRIPT_PATH=%~dp0\sshm.sh

:: Forward all arguments to sshm.sh
sh "%SSHM_SCRIPT_PATH%" %*
