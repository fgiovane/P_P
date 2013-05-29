@echo off
del versionfile.txt 2>nul

REM Minimum JAVA version number required
SET version2="1.6"

REM Filename and extension to be searched for in PATH
SET fname=java
SET fext=exe

REM if there is a second argument given cd to that directory
if "%3" NEQ "" (
	cd /D %3
)


if DEFINED JAVA_HOME (

	if EXIST "%JAVA_HOME%"/bin/java.exe goto JAVA_HOME_E else ( 

			echo JAVA_HOME incorrectly set no java binary found, the JSK will continue using the JSK provided JDK.  
			set JAVA_BIN=NULL
			goto JAVA_NE
		) 


) else goto JAVA_HOME_NE




REM JAVA_HOME IS NOT DEFINED
:JAVA_HOME_NE
SET JH=

for %%g in ("%fname%.%fext%") do (

	if EXIST "%%~$PATH:g" (

		SET JH=%%~$PATH:g 

	) else goto JAVA_NE

)



REM USE the enclosed copy of a JDK
set JAVA_HOME=%CD%\windowsJDK

echo JAVA_HOME not set, using default JSK provided JDK located at: %JAVA_HOME%

set JAVA_BIN=%JAVA_HOME%\bin

del versionfile.txt 2>nul
goto RUNJSK



REM JAVA doesn't exist
:JAVA_NE
set JAVA_HOME=%CD%\windowsJDK

echo JAVA_HOME not set using default JSK provided JDK located at: %JAVA_HOME%

set JAVA_BIN=%JAVA_HOME%\bin

del versionfile.txt 2>nul
goto RUNJSK



REM JAVA_HOME IS DEFINED
:JAVA_HOME_E

set JAVA_BIN=%JAVA_HOME%/bin/java

echo JAVA_HOME is set, using the one located at:%JAVA_HOME%

del versionfile.txt 2>nul
goto RUNJSK



:VERSIONCHK
echo JDK version is less than 1.5, Please upgrade to 1.5 or higher
echo.
set JAVA_BIN=NULL

del versionfile.txt 2>nul
goto END



:RUNJSK
echo .
REM Create a TEMP directory as we need one one Windows as teh default may conatin a link
mkdir %CD%\temp
echo %CD%\temp

REM Ensure that temp for anything inherting from the JSK uses the local temp
set TEMP=%CD%\temp
set TMP=%CD%\temp

REM set the PATH to include the KeyView binaries
set PATH=%PATH%;%CD%\ContentServer\11.1.1.6.1\bin

if "%2" NEQ "" (
	"%JAVA_HOME%\bin\java" -Xms128m -Xmx512m -Dfile.encoding=UTF-8 -Djava.io.tmpdir=%CD%\temp -DSystemRoot=%SystemRoot% %1=%2 -cp JSK_Data\log4j-1.2.16.jar;JumpStartKit-11.1.1.6.1.jar com.fatwire.jsk.Execute
) else (
	"%JAVA_HOME%\bin\java" -Xms128m -Xmx512m -Dfile.encoding=UTF-8 -Djava.io.tmpdir=%CD%\temp -DSystemRoot=%SystemRoot% -cp JSK_Data\log4j-1.2.16.jar;JumpStartKit-11.1.1.6.1.jar com.fatwire.jsk.Execute
)

goto END



rem Single exit point
:END
