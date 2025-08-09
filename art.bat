@echo off
setlocal enabledelayedexpansion

REM =========================================
REM Usage: art.bat <foldername> <file.txt>
REM =========================================

if "%~1"=="" ( echo Usage: art.bat foldername file.txt & exit /b )
if "%~2"=="" ( echo Usage: art.bat foldername file.txt & exit /b )
set "name=%~1"
set "input=%~2"
if not exist "%input%" ( echo File not found: %input% & exit /b )

cd /d "%~dp0"
set "setdir=art_%name%"
if not exist "%setdir%" mkdir "%setdir%"

REM --- read file, replace spaces with dots, store lines ---
set /a count=0
for /f "usebackq delims=" %%A in ("%input%") do (
    set "line=%%A"
    set "line=!line: =.!"
    set /a count+=1
    set "line[!count!]=!line!"
)

REM --- generate output_*.cfg (run-once behavior: last line does NOT wrap) ---
for /l %%i in (1,1,%count%) do (
    set /a next=%%i+1

    if %%i LSS %count% (
        REM middle lines: say + advance to the next on 7; 8 resets
        >"%setdir%\output_%%i.cfg" (
            echo say !line[%%i]!
            echo bind 7 exec %setdir%/output_!next!
	    echo bind F7 exec %setdir%/output_!next!
            echo bind 8 exec %setdir%/output_1
	    echo bind F8 exec %setdir%/select
        )
    ) else (
    	REM last line: say + STOP (7/F7 become no-ops until reset); 8 resets
    	>"%setdir%\output_%%i.cfg" (
            echo say !line[%%i]!
            echo echo ^[done^] ^(press 8 to reset^)
            echo bind 7 "echo ^[done^]"
            echo bind F7 "echo ^[done^]"
            echo bind 8 exec %setdir%/select
	    echo bind F8 exec %setdir%/select
        )
    )
)

REM --- meta + selector ---
>"%setdir%\meta.txt" echo %count%
>"%setdir%\select.cfg" (
    echo bind 7 "exec %setdir%/output_1"
    echo bind F7 "exec %setdir%/output_1"
    echo bind 8 "exec %setdir%/select"
    echo bind F8 "exec %setdir%/select"
    echo echo Selected: %name% ^(7/F7=advance, 8/F8=reset^)
)

echo Created %setdir% with %count% lines.

REM =========================================================
REM Rebuild art_select.cfg and art_menu.cfg (one-color table)
REM =========================================================

REM --- art_select.cfg ---
>"art_select.cfg" echo alias art.menu "exec art_menu"
set "list="
for /f "delims=" %%D in ('dir /b /ad "art_*" 2^>nul') do (
    set "pretty=%%D"
    set "pretty=!pretty:art_=!"
    if defined list ( set "list=!list! !pretty!" ) else ( set "list=!pretty!" )
    >>"art_select.cfg" echo alias %%D "exec %%D/select"
)
if defined list (
    >>"art_select.cfg" echo alias art.list "echo Available art: !list!"
) else (
    >>"art_select.cfg" echo alias art.list "echo Available art: [none]"
)
>>"art_select.cfg" echo alias art.help "echo 1^)^ art.menu  ^|  2^)^ type command shown \(e.g. art_pepe\)  ^|  3^)^ press 7 to cycle, 8 to reset"

REM --- one color (magenta/pink) + reset (RGBA) ---
set "CLR_ONE=FF66CCFF"   REM pink/magenta
set "CLR_RST=FFFFFFFF"   REM white

REM spacing + widths
set "SP=                                "
set /a W_CMD=20, W_NAME=18, W_LINES=10

REM --- build art_menu.cfg (single color set once) ---
>"art_menu.cfg" (
  echo log_color Console %CLR_ONE%
  echo echo ===============================================================
  echo echo ASCII ART SELECT
  echo echo ---------------------------------------------------------------
  echo echo ^| Command             ^| Name               ^| Lines     ^|
  echo echo +--------------------+--------------------+-----------+
)

for /f "delims=" %%D in ('dir /b /ad "art_*" 2^>nul') do (
  set "pretty=%%D"
  set "pretty=!pretty:art_=!"
  set "lines=?"
  if exist "%%D\meta.txt" for /f "usebackq delims=" %%L in ("%%D\meta.txt") do set "lines=%%L"

  set "cmdcol=%%D%SP%"        & set "cmdcol=!cmdcol:~0,%W_CMD%!"
  set "namecol=!pretty!%SP%"  & set "namecol=!namecol:~0,%W_NAME%!"
  set "linescol=!lines! lines%SP%" & set "linescol=!linescol:~0,%W_LINES%!"

  >>"art_menu.cfg" echo echo ^| !cmdcol! ^| !namecol! ^| !linescol! ^|
)

>>"art_menu.cfg" echo echo +--------------------+--------------------+-----------+
>>"art_menu.cfg" echo echo Usage: Type the ^"Command^" shown, e.g. art_pepe
>>"art_menu.cfg" echo log_color Console %CLR_RST%

echo.
echo Updated art_select.cfg and art_menu.cfg
echo In CS2 console:  exec art_select   ^&^&   art.menu
echo (9 bound to to 'exec autoexec.cfg', so press 9 -> refresh changes without restarting the game.)
echo.

endlocal
