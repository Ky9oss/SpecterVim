@echo off


:: cache

:: if

call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
:: vcvars64.bat has something wrong with %INCLUDE% in SSH session. We manual set them.
set INCLUDE=%INCLUDE%;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\include
set INCLUDE=%INCLUDE%;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\ATLMFC\include
set INCLUDE=%INCLUDE%;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include
set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Windows Kits\10\include\10.0.26100.0\ucrt
set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Windows Kits\10\include\10.0.26100.0\um
set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Windows Kits\10\include\10.0.26100.0\shared
set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Windows Kits\10\include\10.0.26100.0\winrt
set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Windows Kits\10\include\10.0.26100.0\cppwinrt
set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um

REM call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
REM set > temp-env.txt
REM findstr /B /R "^[A-Za-z0-9_]*=" temp-env.txt > filtered.txt
REM (for /f "delims=" %%i in (filtered.txt) do @echo set %%i) > "%USERPROFILE%\msvc-cache-x64.bat"
REM del temp-env.txt filtered.txt
REM
REM :: else
REM call "%USERPROFILE%\msvc-cache-x64.bat"

cl /Fa"%USERPROFILE%\_temp_assembly_explorer_msvc.asm" /c /O1 /GS- /guard:cf- /EHs- /EHc- /GR- /MT /Oy- /Ob0 /nologo /Zc:inline- %USERPROFILE%\_temp_assembly_explorer_msvc.c

