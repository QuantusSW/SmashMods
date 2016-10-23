@ECHO OFF

::To copy files to new directory with new name:
::copy /y "addons\SIL\..." "workspace\content\patch\data\ui\replace\chr\..."

CD /D %~dp0

@setlocal enabledelayedexpansion

IF not exist "exempt" mkdir exempt
set thermowar=0
set pacman=0
set initials=N/A
set vanillabaseID=64
set vanillafighterID=0
set vanillaslotID=0
set vanillaoffsetID=0

call:title

echo.&pause&goto:eof

:title

set E=0

ECHO.
ECHO ---------------------------------------
ECHO         Automatic Mass TexIDFix
ECHO        by Munomario and Zarklord
ECHO ---------------------------------------
IF %pacman%==1 (
    echo.
    echo    HIGH SCORES
    echo.
    echo !initials!       3333360
)
ECHO.
if not exist "workspace\content\patch\data\fighter\" (
	call:errorcode "WARNING This script is in the wrong place."
	call:errorcode "Place the files from the download into the main sm4shexplorer folder."
	call:errorcode "Alternatively the workspace folder may have the wrong name. It must be called workspace."
	ECHO.
)
ECHO This script will automatically fix the IDs of any skins that are in your workspace folder.
ECHO Except for Robin, and Pacman, they're weird and don't like to be idfixed. (yet)
ECHO Make sure that this script is placed inside Sm4shExplorer's main folder, along with the other files!
ECHO Also make sure that all the skins you want to fix have both model.nud and model.nut.
ECHO.
ECHO Also, you can do some other stuff with this too. Here's a list of commands:
ECHO.
ECHO To fix all characters, press ENTER.
ECHO To fix a specific character's body folder, type the character's internal name and press ENTER.
ECHO To view a list of characters for which you have installed skins, type "list" and press ENTER.
::ECHO To replace missing portraits with silhouettes, type "silhouette" and press ENTER. (requires addon SIL)
ECHO To fix all characters, launch Explorer, and then close this script, type "theworks" and press ENTER.
ECHO.
ECHO To backup your workspace folder in case of an error, type "backup" and press ENTER.
ECHO To view information about the exempt feature, type "exemptinfo" and press ENTER.
ECHO To launch Sm4shExplorer, type "explorer" and press ENTER. (requires addon S4E)
ECHO To open the integration with GFD's Inject Pack, type "GFD" and press ENTER. (requires addon GFD)
ECHO.
ECHO To view a list of addons which will add functionality to the script, type "addons" and press ENTER.
ECHO To view the script's page on Gamebanana, type "gamebanana" and press ENTER.
ECHO To end the script, type "exit" and press ENTER.
ECHO.
set /p choice=Your choice: || set choice=NothingChosen
ECHO.

IF /i "%choice%"=="NothingChosen" (
   call:fixall
   set model=model
) ELSE IF /i "%choice%"=="theworks" (
   call:infocode "On it."
   echo.
   call:fixall
   start "" Sm4shFileExplorer.exe
   exit
) ELSE IF /i "%choice%"=="reflet" (
   echo Robin is currently not supported due to issues with his book.
   echo He cannot currently be idfixed without causing the game to crash.
) ELSE IF /i "%choice%"=="pacman" (
   echo Pacman is not currently supported, as idfixing his extra slots causes issues.
) ELSE IF /i "%choice%"=="exit" (
   exit
) ELSE IF /i "%choice%"=="GFD" (
   call:GFD
) ELSE IF /i "%choice%"=="addons" (
   call:addons
   call:title
) ELSE IF /i "%choice%"=="list" (
   call:fighterlist
) ELSE IF /i "%choice%"=="add" (
   call:installmod
) ELSE IF /i "%choice%"=="gamebanana" (
   start "" http://gamebanana.com/gamefiles/4689
) ELSE IF /i "%choice%"=="explorer" (
   start "" Sm4shFileExplorer.exe
   echo Didn't work? Make sure the .exe is still called Sm4shFileExplorer.exe!
) ELSE IF /i "%choice%"=="debug" (
   call:debug
) ELSE IF /i "%choice%"=="exemptinfo" (
   echo The exempt feature allows you to exclude certain skins from the mass idfix.
   echo This means that if idfixing a skin breaks it, you can just exclude it from the idfix to avoid breaking the skin.
   echo To enable it, place the mod files you want to exclude inside the "exempt" folder.
   echo Make sure to include the full file structure, as if the exempt folder were your workspace folder.
   echo Also, be aware that it only applies if you choose to idfix all characters at once.
   echo But, you can activate it at any time by typing "exempt" and pressing ENTER.
   pause
) ELSE IF /i "%choice%"=="backup" (
   call:backup
) ELSE IF /i "%choice%"=="exempt" (
   call:exempt
) ELSE IF /i "%choice%"=="bruh" (
   start "" http://vignette1.wikia.nocookie.net/ssb/images/8/8d/Bruh.jpg/revision/latest?cb=20141104062201
   echo BRUH
) ELSE IF /i "%choice%"=="ridley" (
   echo ERROR: FILE EXCEEDS MAXIMUM FILE SIZE
) ELSE IF /i "%choice%"=="goku" (
   start "" http://nintendo.wikia.com/wiki/Goku
   echo confirmed for smash
) ELSE IF /i "%choice%"=="3333360" (
   start "" https://www.youtube.com/watch?v=ZrwnAdqBCg0
   set pacman=1
   echo NEW HIGH SCORE
   set /p initials=INITIALS: || set initials=N/A
) ELSE IF /i "%choice%"=="yoda" (
   echo "Yoda: %USERNAME%^!"
   timeout /t 3 >nul 2>&1
   echo "%USERNAME%: ...Yes Yoda?"
   timeout /t 3 >nul 2>&1
   echo "Yoda: I have a joke for you^!"
   timeout /t 3 >nul 2>&1
   set /p yoda="Yoda: What is a Jedi's favorite Italian desert?": || set yoda=NothingChosen
   echo "Yoda: Obi Wan Cannolis^!"
   timeout /t 2 >nul 2>&1
   echo "HRRMMMMMMM^! FUNNYYYYY JOKE^!"
) ELSE IF /i "%choice%"=="merth" (
   start "" https://www.youtube.com/watch?v=7GcBoxZEcko
   echo nina, ni tettegleh
) ELSE IF /i "%choice%"=="shrek" (
   echo pls
) ELSE IF /i "%choice%"=="meow meow mario" (
   echo I'm a big fan!
) ELSE IF /i "%choice%"=="color-a-dinosaur" (
   echo Unable to color a dinosaur
) ELSE IF /i "%choice%"=="sudo color-a-dinosaur" (
   echo WE COLORING, GRAB THE CRAYONS!
   timeout /t 3
   echo.
   start "" https://youtu.be/EXl4qHiirT0?t=41s
) ELSE IF /i "%choice%"=="global thermonuclear war" (
   IF %thermowar%==0 (
      echo Wouldn't you prefer a good game of chess?
      set thermowar=1
      timeout /t 2
   ) ELSE IF %thermowar%==1 (
      echo Fine.
      timeout /t 2
      start "" https://www.youtube.com/watch?v=8p8BCsrrpVE
      echo.
      echo A strange game. The only winning move is not to play.
      echo.
      echo How about a nice game of chess?
   )
) ELSE IF /i "%choice%"=="chess" (
   echo ERROR: CHESS.EXE COULD NOT BE LOCATED
) ELSE IF /i "%choice%"=="tasbot" (
   echo ERROR: TASBOT HAS BECOME SELF-AWARE AND IS TEMPORARILY UNAVAILABLE
) ELSE IF /i "%choice%"=="BUTTONS" (
   start "" https://youtu.be/j0BBGzfw0pQ?t=30m47s
   echo revolutionary
) ELSE IF /i "%choice%"=="for glory" (
   start "" https://youtu.be/zFR_Vyq1OQ0
) ELSE (
   echo Note that this will only affect %choice%'s body folder.
   echo To fix extra model folders, perform a mass fix ^(to fix all characters at once^).
   call:fix %choice% body
   IF !E! gtr 0 (
      call:errorcode "Warning: one or more skins could not be IDfixed. It may be compressed, or one of the model files may be missing."
   )
) 

call:title

goto:eof

:fighterlist

call:infocode "List of all fighter folders with mods installed:"
echo.
for /d %%X in (workspace\content\patch\data\fighter\*) do echo %%~nX

goto:eof

:backup

IF EXIST "backup" (
    rmdir "backup\content" /s /q
	call:infocode "Old backup deleted."
) ELSE IF not exist "backup" (
    mkdir "backup"
    call:infocode "Backup directory created."
)
echo Backing up workspace folder. Depending on the contents of the folder, this may take a while...
xcopy "%~dp0\workspace\*.*" "%~dp0\backup" /c /s /r /d /y /i > "%~dp0\backup\xcopy.log"
call:infocode "Backup complete."

goto:eof

:debug

echo Debug mode activated. Type the name of a function with the necessary arguments and then press ENTER to run it.
echo Only use this if you know what you are doing.
echo To exit debug mode, press ENTER.
set /p debug=Your choice: || set debug=NothingChosen
IF "%debug%"=="NothingChosen" (
	call:title
) ELSE (
	call:!debug!
)

goto:eof

:addons

if not exist "addons" mkdir "addons"

echo Here, you can find a list of other utilities you can download in order to enhance the script.
echo Installing these will allow the script to perform additional functions.
echo.
echo To go to a download page, type the codename (three letters) for the addon and press ENTER.
echo Unzip the download, and place the files from the download into the "addons" folder.
echo The files from each download should be directly inside a folder within "addons,"
echo and this folder should match the addon's codename.
echo For example, GFD's Inject Pack should be in a folder called "GFD" inside the addons folder.
echo.
call:infocode "GFD: Enhanced Inject Pack by GFD"
echo ---This handy tool pack has support within this batch script, in that you can access all of
echo ---its scripts from within this script.
::echo ---This is used for rearranging costumes within this batch script.
::echo ---Additionally, the other features of the pack can be accessed from within this script,
::echo ---but they are not directly integrated into the main features of this script.
echo.
::call:infocode "SIL: Silhouette Portrait Pack by Brecert"
::echo ---This is used to fill in missing character portraits when installing character skins.
::echo ---Without this utility, missing portraits will appear as red X's ingame.
::echo.
::call:infocode "MGA: Make Models Go Away by Rando (?)"
::echo ---This is used when adding stages to the game. It hides models that are "left over" when
::echo ---porting stages to new slots.
::echo.
call:infocode "S4E: Sm4shExplorer by deinonychus71"
echo ---This is required to install mods. You should already have this, but if not... here you go.
echo ---Do NOT place this in the addons folder! Instead, once Sm4shExplorer has been installed,
echo ---place this batch script and the files that came with it into Sm4shExplorer's main folder.
echo.
echo To return to the main menu, type "exit" and press ENTER.
echo To open the addons folder, type "open" and press ENTER.
echo.
set /p choice=Your choice: 
echo.
if /i "%choice%"=="exit" (
	call:title
) else if /i "%choice%"=="open" (
	explorer "addons"
) else if /i "%choice%"=="GFD" (
	start "" https://drive.google.com/file/d/0Bwe__lLr0Q8xRmlZOWxQSm1Yak0/view
::) else if "%choice%"=="SIL" (
::	start "" http://gamebanana.com/guis/download/31523
) else if /i "%choice%"=="S4E" (
	start "" https://gbatemp.net/attachments/sm4shexplorer-0-07-1-zip.51784/
) else (
	echo test
)

goto:eof

:GFD

echo test1

if not exist "addons\GFD\*.cmd" (
	echo test2
	if not exist "addons\GFD" (
		echo test3
		mkdir "addons\GFD"
	)
	echo test4
	call:errorcode "Addon GFD not present. Type addons at the main menu, then follow the instructions."
	echo.
	pause
	call:title
	echo test5
)

echo test6

echo Here you can utilize all of GFD's scripts. Type one of the following:
echo.
call:infocode "ChangeTexID"
echo ---Changes the texture ID of a single fighter.
call:infocode "Extract"
echo ---Extracts a NUT file into editable DDS textures.
call:infocode "ExtractToFolders"
echo ---Extracts multiple NUT files into editable DDS textures.
call:infocode "FixAllBodyTexIDs"
echo ---Fixes all texture IDs of all fighters, much like this script does.
call:infocode "Inject"
echo ---Injects an edited DDS file into a NUT file.
call:infocode "MaterialExtract"
echo ---Exports material data of model files in a CSV format.
call:infocode "MaterialInject"
echo ---Injects material data in a CSV format into model files.
call:infocode "MoveCostumeSlots"
echo ---Moves a costume to another slot while rearranging other skins.
echo.
call:infocode "Folder"
echo ---Opens the folder for the injectpack. Place files to inject / extract here.
call:infocode "Exit"
echo ---Exits the GFD GUI and returns to the main menu.
call:infocode "Info"
echo ---Go to the Gamebanana page, with more detailed documentation.
echo.
call:errorcode "NOTE: Some scripts are not supported at the moment."
echo.
set /p script=Your choice:
echo.
if /i "%script%" == "Folder" (
	explorer "addons\GFD"
	goto:GFD
) else if /i "%script%" == "exit" (
	goto:title
) else if /i "%script%" == "info" (
	start "" http://gamebanana.com/tuts/12063
) else (
	if exist "addons\GFD\~%script%.cmd" (
		start "" "addons\GFD\~%script%.cmd"
		if /i "%script%" == "MoveCostumeSlots" (
			explorer "addons\GFD\~CostumeSlotsPreview"
		)
	) else (
		call:errorcode "That script does not exist."
		pause
	)
	goto:GFD
)

goto:eof

:exempt

call:infocode "Copying exempted files to workspace..."
xcopy /s /h /k /y exempt workspace >nul 2>&1

goto:eof

:fixall


set firstExtraModel=true
set custombaseID=65
set customfighterID=0
set customslotID=0
set customoffsetID=0
call:fix bayonetta all
call:fix captain all
call:fix dedede all
call:fix diddy all
call:fix donkey all
call:fix duckhunt all
call:fix falco all
call:fix fox all
call:fix gamewatch all
call:fix ganon all
call:fix gekkouga all
call:fix ike all
call:fix kamui all
call:fix kirby all
call:fix koopa all
call:fix koopajr all
call:fix link all
call:fix littlemac all
call:fix lizardon all
call:fix lucario all
call:fix lucas all
call:fix lucina all
call:fix luigi all
call:fix mario all
call:fix mariod all
call:fix marth all
call:fix metaknight all
call:fix mewtwo all
call:fix murabito all
call:fix ness all
call:fix palutena all
call:fix peach all
call:fix pikachu all
call:fix pikmin all
call:fix pit all
call:fix pitb all
call:fix purin all
call:fix robot all
call:fix rockman all
call:fix rosetta all
call:fix roy all
call:fix ryu all
call:fix samus all
call:fix sheik all
call:fix shulk all
call:fix sonic all
call:fix szerosuit all
call:fix toonlink all
call:fix wario all
call:fix wiifit all
call:fix yoshi all
call:fix zelda all
call:exempt
ECHO.
ECHO MISHUN COMPREE
ECHO.
IF !E! gtr 0 (
    call:errorcode "Warning: one or more skins could not be IDfixed. It may be compressed, or one of the model files may be missing."
)
goto:eof

:errorcode

%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor Red %1

goto:eof

:infocode

%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor Green %1

goto:eof

:installmod

IF not exist "_install" mkdir _install
echo What type of mod would you like to install? Choices:
echo.
echo skin
echo stage
echo misc
echo.
set /p modtype=Your choice: 
echo.
if /i "%modtype%" == "skin" (
	call:installskin
) else if /i "%modtype%" == "stage" (
	call:installstage
) else if /i "%modtype%" == "misc" (
	call:installmisc
) else (
	echo That is not a valid mod type.
)
	
goto:eof

:installskin

echo Place your skin into the _install folder. Give it its own folder, and put the contents inside.
echo Also, only one skin at a time please.
echo.
:installskin-1
set /p skinfolder=Please enter the name of the skin folder:
echo.
if not exist "_install\%skinfolder%" (
	echo That folder does not exist.
	goto:installskin-1
) else (
	call:skininstall
)

goto:eof

:skininstall

if not exist "_install\%skinfolder%\*\chr_*.nut" (
	if not exist "_install\%skinfolder%\chr_*.nut" (
		call:nonut
	)
)

modellocation = blank
nudpresent = 0
nutpresent = 0
etcpresent = 0
asktoreplace = 0

call:checkmodelfile model nut
call:checkmodelfile model nud

if nudpresent = 0 (
	call:errorcode "Warning, no model.nud was found!"
	asktoreplace = 1
)

if nutpresent = 0 (
	call:errorcode "Warning, no model.nut was found!"
	asktoreplace = 1
)

echo Now choose a costume slot for the skin to be installed to.
echo Type a slot, e.g. 06, then press ENTER.

goto:eof

:nonut

	echo This skin doesn't seem to have any portraits!
	echo That's fine, but you'll need to specify which character it's for.
	echo If you have the SIL addon, the costume's portraits will be silhouettes.
	echo If not, they'll be black boxes with red X's.
	echo To go back to the title screen, just press ENTER.
	echo Anyway, which character is this skin for? Use the internal name.
	echo For example, Megaman's is Rockman.
	echo.
	set /p char=Your choice: || set char=NothingChosen
	echo.
	if %char%=="NothingChosen" (
		call:title
	)
	
goto:eof
	
:checkmodelfile

for /r %%a in (_install\%skinfolder%) do @if exist "%%~fa\%1.%2" (
	if %1 = "model" (
		set %2present = 1
		modellocation = %%~fa
	) else (
		set etcpresent = 1
	)
)

goto:eof

:installstage



goto:eof

:installmisc

echo Alright, put the mod files into _install\something.
echo "something" can be whatever you want.
echo Type the name of the mod folder: (or just press ENTER to cancel)
:installmisc-1
echo.
set /p modfolder=Your choice: || set modfolder=NothingChosen
echo.
if %modfolder%=="NothingChosen" (
	call:title
) else (
	if not exist "_install\%modfolder%" (
		echo That folder does not exist.
		goto:installmisc-1
	)
	echo.
	echo From here, you have a few options.
	echo.
	echo Type "search" to try and find a directory in the game files that has
	echo the same files as the mod folder. It can only find files that you've
	echo extracted from Explorer, though!
	echo.
	echo Type "directory" to give a directory that the files should be put in.
	echo This directory should use the workspace as a base, e.g. content\patch\data\fighter.
	echo.
	echo Or just leave the field blank to copy the files to the root of the workspace.
	echo.
	set /p choice=Your choice: || set choice = NothingChosen
	echo.
	if /i %choice%=="search" (
		
	) else if /i %choice=="directory" (
		echo Please type a directory in which to install the mods:
		echo.
		set /p installplace=Your choice:
		echo Copying _install\%skinfolder% to workspace\%installplace%...
		xcopy "%~dp0\_install\%skinfolder%\*.*" "%~dp0\workspace\%installplace%" /c /s /r /d /y /i > "%~dp0\_install\xcopy.log"
		echo Copying complete, mod(s) installed.
	) else (
		echo Copying _install\%skinfolder% to workspace...
		xcopy "%~dp0\_install\%skinfolder%\*.*" "%~dp0\workspace" /c /s /r /d /y /i > "%~dp0\_install\xcopy.log"
		echo Copying complete, mod(s) installed.
	)
)

goto:eof

:fixer
for /f %%f in ('dir /b "workspace\content\patch\data\fighter\%1\model\%2"') do (
set isError=false
    if EXIST "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" (
        if EXIST "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" (
            call:setcorrectIDs %1 %2 %%f
            if "%2"=="body" (
                TexIDfix.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" !vanillabaseID! !vanillafighterID! !vanillaslotID! !vanillaoffsetID! >nul 2>&1
                IF errorlevel 1 (
                    ver > nul
                    call:errorcode "Warning: the model.nud and model.nut in %1\model\%2\%%f was unable to be IDfixed. It may be compressed, or there is some other issue."
                    IF EXIST zlibCheck.py (
                        set decompedOne=0
                        call:infocode "Info: attempting to decompress the compressed files in %1\model\%2\%%f."
                        zlibCheck.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" >nul 2>&1
                        IF errorlevel 1 (
                            ver > nul
                            zlibDecompress.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" >nul 2>&1
                            call:infocode "Info: decompressed %model%.nud in %1\model\%2\%%f."
                            set decompedOne=1
                        )
                        zlibCheck.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" >nul 2>&1
                        IF errorlevel 1 (
                            ver > nul
                            zlibDecompress.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" >nul 2>&1
                            call:infocode "Info: decompressed model.nut in %1\model\%2\%%f."
                            set decompedOne=1
                        )
                        IF "!decompedOne!"=="1" (
                            call:infocode "Info: attempting to IDfix once more."
                            TexIDfix.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" !vanillabaseID! !vanillafighterID! !vanillaslotID! !vanillaoffsetID! >nul 2>&1
                            IF errorlevel 1 (
                                ver > nul
                                call:errorcode "Warning: the model.nud or model.nut in %1\model\%2\%%f was still unable to be IDfixed. one of those two files may be missing."
                                set /a E=%E% + 1
                            ) ELSE (
                                call:infocode "Info: Success`^! the model.nud and model.nut in %1\model\%2\%%f are now IDFixed."
                            )
                        )
                    )
                )
                if EXIST "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" (
                    TexIDfix-NUD.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" !vanillabaseID! !vanillafighterID! !vanillaslotID! !vanillaoffsetID! >nul 2>&1
                    if errorlevel 1 (
                        ver > nul
                        zlibCheck.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" >nul 2>&1
                        IF errorlevel 1 (
                            ver > nul
                            zlibDecompress.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" >nul 2>&1
                            call:infocode "Info: decompressed metal.nud in %1\model\%2\%%f."
                            set decompedOne=1
                            call:infocode "Info: attempting to IDfix once more."
                            TexIDfix-NUD.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" !vanillabaseID! !vanillafighterID! !vanillaslotID! !vanillaoffsetID! >nul 2>&1
                         )
                    )
                )
            ) ELSE (
                TexIDfix.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" !custombaseID! !customfighterID! !customslotID! !customoffsetID! >nul 2>&1
                IF errorlevel 1 (
                    ver > nul
                    call:errorcode "Warning: the model.nud and model.nut in %1\model\%2\%%f was unable to be IDfixed. It may be compressed, or there is some other issue."
                    IF EXIST zlibCheck.py (
                        set decompedOne=0
                        call:infocode "Info: attempting to decompress the compressed files in %1\model\%2\%%f."
                        zlibCheck.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" >nul 2>&1
                        IF errorlevel 1 (
                            ver > nul
                            zlibDecompress.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" >nul 2>&1
                            call:infocode "Info: decompressed %model%.nud in %1\model\%2\%%f."
                            set decompedOne=1
                        )
                        zlibCheck.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" >nul 2>&1
                        IF errorlevel 1 (
                            ver > nul
                            zlibDecompress.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" >nul 2>&1
                            call:infocode "Info: decompressed model.nut in %1\model\%2\%%f."
                            set decompedOne=1
                        )
                        IF "!decompedOne!"=="1" (
                            call:infocode "Info: attempting to IDfix once more."
                            TexIDfix.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nud" "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" !custombaseID! !customfighterID! !customslotID! !customoffsetID! >nul 2>&1
                            IF errorlevel 1 (
                                ver > nul
                                call:errorcode "Warning: the model.nud or model.nut in %1\model\%2\%%f was still unable to be IDfixed. one of those two files may be missing."
                                set /a E=%E% + 1
                            ) ELSE (
                                call:infocode "Info: Success`^! the model.nud and model.nut in %1\model\%2\%%f are now IDFixed."
                            )
                        )
                    )
                )
                if EXIST "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" (
                    TexIDfix-NUD.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" !custombaseID! !customfighterID! !customslotID! !customoffsetID! >nul 2>&1
                    if errorlevel 1 (
                        ver > nul
                        zlibCheck.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" >nul 2>&1
                        IF errorlevel 1 (
                            ver > nul
                            zlibDecompress.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" >nul 2>&1
                            call:infocode "Info: decompressed metal.nud in %1\model\%2\%%f."
                            set decompedOne=1
                            call:infocode "Info: attempting to IDfix once more."
                            TexIDfix-NUD.py "workspace\content\patch\data\fighter\%1\model\%2\%%f\metal.nud" !custombaseID! !customfighterID! !customslotID! !customoffsetID! >nul 2>&1
                         )
                    )
                )
            )                    
        ) ELSE (
            call:errorcode "Warning: the model.nud and model.nut in %1\model\%2\%%f was unable to be IDfixed. the model.nut does not exist."
            set /a E=%E% + 1
        )
    ) ELSE IF EXIST "workspace\content\patch\data\fighter\%1\model\%2\%%f\model.nut" (
        call:errorcode "Warning: the model.nud and model.nut in %1\model\%2\%%f was unable to be IDfixed. the model.nud does not exist."
        set /a E=%E% + 1
    )
)
 
goto:eof

:fix
IF /i [%1]==[bayonetta] set OutputName=Bayonetta
IF /i [%1]==[captain] set OutputName=Captain Falcon
IF /i [%1]==[cloud] set OutputName=Cloud
IF /i [%1]==[dedede] set OutputName=King Dedede
IF /i [%1]==[diddy] set OutputName=Diddy Kong
IF /i [%1]==[donkey] set OutputName=Donkey Kong
IF /i [%1]==[duckhunt] set OutputName=Duck Hunt
IF /i [%1]==[falco] set OutputName=Falco
IF /i [%1]==[fox] set OutputName=Fox
IF /i [%1]==[gamewatch] set OutputName=Game ^& Watch
IF /i [%1]==[ganon] set OutputName=Ganon
IF /i [%1]==[gekkouga] set OutputName=Greninja
IF /i [%1]==[ike] set OutputName=Ike
IF /i [%1]==[kamui] set OutputName=Corrin
IF /i [%1]==[kirby] set OutputName=Kirby
IF /i [%1]==[koopa] set OutputName=Bowser
IF /i [%1]==[koopajr] set OutputName=Bowser Jr.
IF /i [%1]==[link] set OutputName=Link
IF /i [%1]==[littlemac] set OutputName=Little Mac
IF /i [%1]==[lizardon] set OutputName=Charizard
IF /i [%1]==[lucario] set OutputName=Lucario
IF /i [%1]==[lucas] set OutputName=Lucas
IF /i [%1]==[lucina] set OutputName=Lucina
IF /i [%1]==[luigi] set OutputName=Luigi
IF /i [%1]==[mario] set OutputName=Mario
IF /i [%1]==[mariod] set OutputName=Dr. Mario
IF /i [%1]==[marth] set OutputName=Marth
IF /i [%1]==[metaknight] set OutputName=Meta Knight
IF /i [%1]==[mewtwo] set OutputName=Mewtwo
IF /i [%1]==[murabito] set OutputName=Villager
IF /i [%1]==[ness] set OutputName=Ness
IF /i [%1]==[pacman] set OutputName=Pac-Man
IF /i [%1]==[palutena] set OutputName=Palutena
IF /i [%1]==[peach] set OutputName=Peach
IF /i [%1]==[pikachu] set OutputName=Pikachu
IF /i [%1]==[pikmin] set OutputName=Olimar
IF /i [%1]==[pit] set OutputName=Pit
IF /i [%1]==[pitb] set OutputName=Dark Pit
IF /i [%1]==[purin] set OutputName=Jigglypuff
IF /i [%1]==[reflet] set OutputName=Robin
IF /i [%1]==[robot] set OutputName=ROB
IF /i [%1]==[rockman] set OutputName=Megaman
IF /i [%1]==[rosetta] set OutputName=Rosalina ^& Luma
IF /i [%1]==[roy] set OutputName=Roy
IF /i [%1]==[ryu] set OutputName=Ryu
IF /i [%1]==[samus] set OutputName=Samus
IF /i [%1]==[sheik] set OutputName=Sheik
IF /i [%1]==[shulk] set OutputName=Shulk
IF /i [%1]==[sonic] set OutputName=Sonic
IF /i [%1]==[szerosuit] set OutputName=Zero Suit Samus
IF /i [%1]==[toonlink] set OutputName=Toon Link
IF /i [%1]==[wario] set OutputName=Wario
IF /i [%1]==[wiifit] set OutputName=Wii Fit Trainer
IF /i [%1]==[yoshi] set OutputName=Yoshi
IF /i [%1]==[zelda] set OutputName=Zelda

IF EXIST workspace\content\patch\data\fighter\%1 (
    IF /i [%2]==[all] (
        ECHO Beginning %2 folders in !OutputName!...
        for /f %%f in ('dir /b "workspace\content\patch\data\fighter\%1\model"') do (
            call:fixer %1 %%f
    )
    ECHO %2 folders in !OutputName! complete!
        ECHO.
    ) ELSE IF /i [%2]==[extra] (
        ECHO Beginning %2 folders in !OutputName!...
        for /f %%f in ('dir /b "workspace\content\patch\data\fighter\%1\model"') do (
        IF /i NOT [%%f]==[body] (
            call:fixer %1 %%f
        )
    )
    ECHO %2 folders in !OutputName! complete!
        ECHO.
    ) ELSE (
    ECHO Beginning %2 folder in !OutputName!...
    call:fixer %1 %2
    ECHO %2 folder in !OutputName! complete!
    ECHO.
    )
) ELSE (
    ECHO No !OutputName! skins are installed, skipping...
    ECHO.
)

goto:eof

:setcorrectIDs
call:setfighterIDs %1
if "%2"=="body" (
    set val=%3
    set val=!val:~1!
    IF /I !val!==01 set val=1
    IF /I !val!==02 set val=2
    IF /I !val!==03 set val=3
    IF /I !val!==04 set val=4
    IF /I !val!==05 set val=5
    IF /I !val!==06 set val=6
    IF /I !val!==07 set val=7
    IF /I !val!==08 set val=8
    IF /I !val!==09 set val=9
    set /a "val*=4"
    IF /I !val! LSS 255 (
        set /a "mod=val/64"
    )
    IF /I !mod! EQU 1 (
        set /a "val-=63"
    ) ELSE IF /I !mod! EQU 2 (
        set /a "val-=126"
    ) ELSE IF /I !mod! EQU 3 (
        set /a "val-=189"
    ) ELSE IF /I !val! GTR 255 (
        set /a "mod=val/255"
        set /a "val-=(255*mod)"
	    IF /I !mod! EQU 1 (
		set /a "val-=mod"
		set /a "vanillaoffsetID=128*mod"
		set /a "mod=val/64"
		IF /I !mod! EQU 1 (
		set /a "val-=63"
		) ELSE IF /I !mod! EQU 2 (
		set /a "val-=126"
		) ELSE IF /I !mod! EQU 3 (
		set /a "val-=189"
		)
		if !vanillaoffsetID! GTR 128 ( 
		    set /a "vanillaoffsetID-=256"
	            set /a "val+=64"
		)
	    )
    )
    set /a "vanillaslotID=val"
) ELSE (
    IF "!firstExtraModel!"=="true" (
    set firstExtraModel=false
    ) ELSE (
    IF !customoffsetID! NEQ 128 (
        set /a "customoffsetID+=128"
        ) ELSE (
            set /a "customoffsetID=0"
            IF !customslotID! NEQ 255 (
                set /a "customslotID+=1"
            ) ELSE (
                set /a "customslotID=0"
                IF !customfighterID! NEQ 255 (
                    set /a "customfighterID+=1"
                ) ELSE (
                    set /a "customfighterID=0"
                    set /a "custombaseID+=1"
                )
            )
        )
    )
)
 
goto:eof
 
:setfighterIDs
IF /i [%1]==[bayonetta] set /a vanillafighterID=72
IF /i [%1]==[captain] set /a vanillafighterID=0
IF /i [%1]==[cloud] set /a vanillafighterID=71
IF /i [%1]==[dedede] set /a vanillafighterID=1
IF /i [%1]==[diddy] set /a vanillafighterID=2
IF /i [%1]==[donkey] set /a vanillafighterID=3
IF /i [%1]==[duckhunt] set /a vanillafighterID=4
IF /i [%1]==[falco] set /a vanillafighterID=5
IF /i [%1]==[fox] set /a vanillafighterID=6
IF /i [%1]==[gamewatch] set /a vanillafighterID=7
IF /i [%1]==[ganon] set /a vanillafighterID=8
IF /i [%1]==[gekkouga] set /a vanillafighterID=48
IF /i [%1]==[ike] set /a vanillafighterID=9
IF /i [%1]==[kamui] set /a vanillafighterID=71
IF /i [%1]==[kirby] set /a vanillafighterID=57
IF /i [%1]==[koopa] set /a vanillafighterID=11
IF /i [%1]==[koopajr] set /a vanillafighterID=10
IF /i [%1]==[link] set /a vanillafighterID=12
IF /i [%1]==[littlemac] set /a vanillafighterID=13
IF /i [%1]==[lizardon] set /a vanillafighterID=14
IF /i [%1]==[lucario] set /a vanillafighterID=15
IF /i [%1]==[lucas] set /a vanillafighterID=69
IF /i [%1]==[lucina] set /a vanillafighterID=47
IF /i [%1]==[luigi] set /a vanillafighterID=16
IF /i [%1]==[mario] set /a vanillafighterID=17
IF /i [%1]==[mariod] set /a vanillafighterID=46
IF /i [%1]==[marth] set /a vanillafighterID=18
IF /i [%1]==[metaknight] set /a vanillafighterID=19
IF /i [%1]==[mewtwo] set /a vanillafighterID=67
IF /i [%1]==[murabito] set /a vanillafighterID=61
IF /i [%1]==[ness] set /a vanillafighterID=23
IF /i [%1]==[pacman] set /a vanillafighterID=24
IF /i [%1]==[palutena] set /a vanillafighterID=25
IF /i [%1]==[peach] set /a vanillafighterID=26
IF /i [%1]==[pikachu] set /a vanillafighterID=27
IF /i [%1]==[pikmin] set /a vanillafighterID=28
IF /i [%1]==[pit] set /a vanillafighterID=29
IF /i [%1]==[pitb] set /a vanillafighterID=49
IF /i [%1]==[purin] set /a vanillafighterID=30
IF /i [%1]==[reflet] set /a vanillafighterID=31
IF /i [%1]==[robot] set /a vanillafighterID=32
IF /i [%1]==[rockman] set /a vanillafighterID=33
IF /i [%1]==[rosetta] set /a vanillafighterID=34
IF /i [%1]==[roy] set /a vanillafighterID=70
IF /i [%1]==[ryu] set /a vanillafighterID=68
IF /i [%1]==[samus] set /a vanillafighterID=36
IF /i [%1]==[sheik] set /a vanillafighterID=37
IF /i [%1]==[shulk] set /a vanillafighterID=39
IF /i [%1]==[sonic] set /a vanillafighterID=38
IF /i [%1]==[szerosuit] set /a vanillafighterID=40
IF /i [%1]==[toonlink] set /a vanillafighterID=41
IF /i [%1]==[wario] set /a vanillafighterID=42
IF /i [%1]==[wiifit] set /a vanillafighterID=43
IF /i [%1]==[yoshi] set /a vanillafighterID=44
IF /i [%1]==[zelda] set /a vanillafighterID=45
 
goto:eof