@echo off
set /p p= User Login - <nul
call :_getPwd pwd
echo Password is %pwd%
pause
goto :eof


:_getPwd
    REM powershell 
    (powershell /? >nul 2>nul) && powershell -Command $pword = read-host "Enter password" -AsSecureString ; ^
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