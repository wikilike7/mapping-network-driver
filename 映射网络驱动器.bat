@echo off
title Mapping network driver script

:: author: 王世超
:: date: 24/03/2016
:: version: v0.1

::welcom message
@echo -------------------------------------------
echo Welcome to use mapping network driver script
@echo -------------------------------------------
@echo -------------------------------------------
@echo -------------------------------------------

set fileserver=\\bjfileserver1\Renesas\Users\%username%
set userid=recn\%username%

:: if paragraph
if exist %fileserver% (goto setup) else (echo Please contact IT create your folder & pause & exit) 


:setup  
set /p password=<nul
call :_getPwd pwd
net use x: %fileserver% "%password%" /user:"%userid%"
timeout /t 5
exit


:: 调用外部的代码，其实我也没看懂。。。
:_getPwd
    REM powershell 
    (powershell /? >nul 2>nul) && powershell -Command $pword = read-host "Enter computer password" -AsSecureString ; ^
        $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword) ; ^
            [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) > .tmp.txt
            
    REM VBS - ScriptPW.Password [C]2010 Spring
    (powershell /? >nul 2>nul) || (
        echo WScript.StdOut.Write CreateObject^("ScriptPW.Password"^).GetPassword > Spring
        cscript -nologo -e:vbs Spring > .tmp.txt
        del Spring
    )
    set /p %1=<.tmp.txt
    del .tmp.txt
    goto :eof