��cls
@echo off
chcp 65001 >nul
color 5
title Luca's Login and sign up system, Version: 2.4.1

:: Set base directories
set "base_dir=Batch"
set "users_file=%base_dir%\users.txt"
set "messages_dir=%base_dir%\messages"
set "user_files_dir=%base_dir%\user files"
set "admin_messages_dir=%base_dir%\admin_messages"

:: Create directories if they don't exist
if not exist "%base_dir%" mkdir "%base_dir%"
if not exist "%messages_dir%" mkdir "%messages_dir%"
if not exist "%user_files_dir%" mkdir "%user_files_dir%"
if not exist "%admin_messages_dir%" mkdir "%admin_messages_dir%"
if not exist "%base_dir%\devfixes.txt" -=echo Dev fixes log:=- > "%base_dir%\devfixes.txt"
if not exist "%users_file%" echo. > "%users_file%"
attrib +h "%base_dir%"

:menu
cls 
echo [34m ██╗      ██████╗  ██████╗ ██╗███╗   ██╗      ███████╗██╗ ██████╗ ███╗   ██╗██╗   ██╗██████╗ [0m
echo [94m ██║     ██╔═══██╗██╔════╝ ██║████╗  ██║      ██╔════╝██║██╔════╝ ████╗  ██║██║   ██║██╔══██╗[0m
echo [80m ██║     ██║   ██║██║  ███╗██║██╔██╗ ██║█████╗███████╗██║██║  ███╗██╔██╗ ██║██║   ██║██████╔╝[0m
echo [34m ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════╝╚════██║██║██║   ██║██║╚██╗██║██║   ██║██╔═══╝ [0m
echo [94m ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║      ███████║██║╚██████╔╝██║ ╚████║╚██████╔╝██║     [0m
echo [96m ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝      ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     [0m
                                                                                            


echo [96m                         VERSION 2.4.1 [0m
echo =========================================
echo Here are some options: (type number of option to select)
echo =========================================
echo 1. Login
echo 2. Signup
echo 3. Help
echo 4. Admin controls
echo 5. View Users
echo 6. Exit
echo.
set /p "choice=Guest>> "

if %choice%==1 goto login
if %choice%==2 goto signup
if %choice%==3 goto help
if %choice%==4 goto admin_password
if %choice%==5 goto view_users
if %choice%==6 exit
goto menu

:login
cls
echo [96m Login [0m
echo =====
set /p "username=Username: "
set /p "password=Password: "

findstr /i /c:"%username%:%password%" "%users_file%" > nul
if %errorlevel%==0 (
    echo Login successful!
    pause
    goto user_menu
) else (
    echo Invalid username or password.
    pause
    goto menu
)

:signup
cls
echo [96m Signup [0m
echo ======
set /p "new_username=Username: "
set /p "new_password=Password: "

findstr /i /c:"%new_username%:" "%users_file%" > nul
if %errorlevel%==0 (
    echo Username already exists.
    pause
    goto menu
) else (
    echo %new_username%:%new_password% >> "%users_file%"
    echo Account created successfully!
    pause
    goto menu
)

:help
cls
echo [96m Help section [0m
echo =============
echo - This was made by Luca Hernandez.
echo You can ask him in person to fix a bug, or report a bug by pressing 1 and enter.
echo.
echo - Last update: 17/3/2025 2.4.1 [Type: small update]
echo Added: "I have added a pop of colour on the top line of each section."
echo "Signed Luca."
echo.
echo - future update ideas: make this program to be accessable by every account on a computer.
echo =============
echo 1. Report a bug
echo 2. Go back to main menu
set /p "choice=Guest>> "
if %choice%==1 goto report_bug
if %choice%==2 goto menu
goto help

:report_bug
cls
echo [96m Report a Bug [0m
echo ===============
set /p "bug_description=Enter bug description: "
set "bug_file=%admin_messages_dir%\bug_%random%.txt"
echo Description: %bug_description% >> "%bug_file%"
echo Bug report submitted successfully!
pause
goto menu

:view_users
cls
echo [96m Registered Users [0m
echo ==================
for /f "tokens=1 delims=:" %%A in (%users_file%) do (
    echo:%%A
)
pause
goto menu

:user_menu
cls
echo [96m User Menu: Welcome %username%! [0m
echo ==============================
echo The time is:
date /t
time /t
echo ==============================
echo options:
echo 1. Reload page
echo 2. Create a new file
echo 3. View a file
echo 4. Delete a file
echo 5. Change password
echo 6. Play Rock, Paper, Scissors
echo 7. Create Mail
echo 8. View Mail
echo 9. Delete Mail
echo 10. Logout
echo.
set /p "choice=%username%>> "

if %choice%==1 goto user_menu
if %choice%==2 goto create_file
if %choice%==3 goto view_file
if %choice%==4 goto delete_file
if %choice%==5 goto change_password
if %choice%==6 goto play_rps
if %choice%==7 goto create_mail
if %choice%==8 goto view_mail
if %choice%==9 goto delete_mail
if %choice%==10 goto menu
goto user_menu

:create_file
cls
echo [96m Create a new file [0m 
echo =================
set /p "filename=Enter a filename: "
echo. > "%user_files_dir%\%username%_%filename%.txt"
echo File created successfully!
pause
goto user_menu

:view_file
cls
echo [96m View a file [0m 
echo ==========
set /p "filename=Enter a filename: "
if exist "%user_files_dir%\%username%_%filename%.txt" (
    cmd /c notepad.exe "%user_files_dir%\%username%_%filename%.txt"
    pause
) else (
    echo File not found.
    pause
)
goto user_menu

:delete_file
cls
echo [96m Delete a file [0m 
echo =============
set /p "filename=Enter a filename: "
if exist "%user_files_dir%\%username%_%filename%.txt" (
    del /q "%user_files_dir%\%username%_%filename%.txt"
    echo File deleted successfully!
    pause
) else (
    echo File not found.
    pause
)
goto user_menu

:change_password
cls
echo [96m Change Password [0m 
echo ===============
set /p "new_password=Enter new password: "
findstr /v /i /c:"%username%:" "%users_file%" > temp.txt
echo %username%:%new_password% >> temp.txt
move /y temp.txt "%users_file%"
echo Password changed successfully!
pause
goto user_menu

:play_rps
cls
echo [96m Play Rock, Paper, Scissors [0m 
echo ==========================
echo Enter choice: rock (1), paper (2), scissors (3)
set /p "choice=%username%>> "

set /a comp_choice=%random% %% 3 + 1

if %comp_choice%==1 set comp_pick=rock
if %comp_choice%==2 set comp_pick=paper
if %comp_choice%==3 set comp_pick=scissors

if %choice%==1 (
    set user_pick=rock
) else if %choice%==2 (
    set user_pick=paper
) else if %choice%==3 (
    set user_pick=scissors
) else (
    echo Invalid choice. Returning to user menu.
    pause
    goto user_menu
)

if %user_pick%==rock if %comp_pick%==rock (
    echo It's a tie! They picked rock.
    goto play_rps_menu
)
if %user_pick%==rock if %comp_pick%==paper (
    echo Womp womp! They picked paper.
    goto play_rps_menu
)
if %user_pick%==rock if %comp_pick%==scissors (
    echo You win! They picked scissors.
    goto play_rps_menu
)
if %user_pick%==paper if %comp_pick%==rock (
    echo You win! They picked rock.
    goto play_rps_menu
)
if %user_pick%==paper if %comp_pick%==paper (
    echo It's a tie! They picked paper.
    goto play_rps_menu
)
if %user_pick%==paper if %comp_pick%==scissors (
    echo Womp womp! They picked scissors.
    goto play_rps_menu
)
if %user_pick%==scissors if %comp_pick%==rock (
    echo Womp womp! They picked rock.
    goto play_rps_menu
)
if %user_pick%==scissors if %comp_pick%==paper (
    echo You win! They picked paper.
    goto play_rps_menu
)
if %user_pick%==scissors if %comp_pick%==scissors (
    echo It's a tie! They picked scissors.
    goto play_rps_menu
)

:play_rps_menu
echo.
echo 1. Play again
echo 2. Go back to user menu
set /p "choice=%username%>> "

if %choice%==1 goto play_rps
if %choice%==2 goto user_menu
goto play_rps_menu

:create_mail
cls
echo [96m Create Mail [0m 
echo ===========
set /p "recipient=Enter the username of the recipient: "
set /p "title=Enter the title: "
set /p "message=Enter the message: "
set "mail_file=%messages_dir%\mail_%random%.txt"
echo From: %username% > "%mail_file%"
echo To: %recipient% >> "%mail_file%"
echo Title: %title% >> "%mail_file%"
echo Message: %message% >> "%mail_file%"
echo Mail sent successfully!
pause
goto user_menu

:view_mail
cls
echo [96m View Mail [0m 
echo =========
setlocal enabledelayedexpansion
for %%F in ("%messages_dir%\mail_*.txt") do (
    findstr /i /c:"From: %username%" "%%F" >nul
    if !errorlevel! equ 0 (
       echo ----------------------------------------------------------------
       type "%%F"
       echo [Mail Type: Sent]
       echo ----------------------------------------------------------------
    ) else (
       findstr /i /c:"To: %username%" "%%F" >nul
       if !errorlevel! equ 0 (
          echo ----------------------------------------------------------------
          type "%%F"
          echo [Mail Type: Received]
          echo ----------------------------------------------------------------
       )
    )
)
endlocal
pause
goto user_menu

:delete_mail
cls
echo [96m Delete Mail [0m 
echo ===========
echo 1. Delete a mail
echo 2. Go back to User Menu
set /p "choice=%username%>> "
if %choice%==1 goto delete_specific_mail
if %choice%==2 goto user_menu
goto delete_mail

:delete_specific_mail
cls
echo [96m Delete Mail: [0m 
echo =============
setlocal enabledelayedexpansion
for %%F in ("%messages_dir%\mail_*.txt") do (
    rem Show only mails related to current user
    findstr /i /c:"From: %username%" "%%F" >nul
    if !errorlevel! equ 0 (
       echo ----------------------------------------------------------------
       echo %%~nxF
       echo ----------------------------------------------------------------
    ) else (
       findstr /i /c:"To: %username%" "%%F" >nul
       if !errorlevel! equ 0 (
          echo ----------------------------------------------------------------
          echo %%~nxF
          echo ----------------------------------------------------------------
       )
    )
)
endlocal
set /p "filename=Enter the file name to delete (include extension): "
if exist "%messages_dir%\%filename%" (
    del /q "%messages_dir%\%filename%"
    echo Mail deleted successfully!
) else (
    echo File not found.
)
pause
goto user_menu

:admin_password
cls
set /p "password=Enter admin password: "
if "%password%"=="9487" (
    goto admin_panel
) else (
    echo Invalid password.
    pause
    goto menu
)

:admin_panel
cls
echo [96m Admin Panel [0m
echo ==========
echo options:
echo 1. View user list
echo 2. Delete users
echo 3. View user files
echo 4. Delete user files
echo 5. View reports
echo 6. Delete all reports
echo 7. View user mail
echo 8. Delete user mail
echo 9. Exit
echo.
set /p "choice=Admin>> "

if %choice%==1 goto view_user_list
if %choice%==2 goto delete_users
if %choice%==3 goto view_user_files
if %choice%==4 goto delete_user_files
if %choice%==5 goto view_reports
if %choice%==6 goto delete_all_reports
if %choice%==7 goto admin_view_mail
if %choice%==8 goto admin_delete_mail
if %choice%==9 goto menu
goto admin_panel

:view_user_list
cls
echo [96m Viewing user list... [0m 
echo =================
type "%users_file%"
pause
goto admin_panel

:delete_users
cls
echo [96m Delete Users [0m 
echo ===========
echo Enter the username of the user you want to delete:
set /p "username=Username: "

findstr /i /c:"%username%:" "%users_file%" > nul
if %errorlevel%==0 (
    findstr /v /i /c:"%username%:" "%users_file%" > temp.txt
    move /y temp.txt "%users_file%"
    echo User deleted successfully!
    pause
    goto admin_panel
) else (
    echo User not found.
    pause
    goto admin_panel
)

:view_user_files
cls
echo [96m View User Files [0m 
echo ===============
set /p "user_files_username=Enter the username: "
for %%F in ("%user_files_dir%\%user_files_username%_*.txt") do (
    echo ----------------------------------------------------------------
    type "%%F"
    echo ----------------------------------------------------------------
)
pause
goto admin_panel

:view_reports
cls
echo [96m Viewing reports. [0m 
echo ===============
setlocal enabledelayedexpansion
for %%F in ("%admin_messages_dir%\bug_*.txt") do (
    echo ----------------------------------------------------------------
    type "%%F"
    echo ----------------------------------------------------------------
)
endlocal
pause
goto admin_panel

:delete_user_files
cls
echo [96m Delete User Files [0m 
echo =================
set /p "user_files_username=Enter the username: "
for %%F in ("%user_files_dir%\%user_files_username%_*.txt") do (
    del /q "%%F"
)
echo User files deleted succesully!
pause
goto admin_panel

:delete_all_reports
cls
    del /q "%admin_messages_dir%\bug_*.txt"
    echo All reports deleted successfully!
pause
goto admin_panel

:admin_view_mail
cls
echo [96m Admin Mail Viewer [0m 
set /p "username=Enter the username to view mail: "
setlocal enabledelayedexpansion
for %%F in ("%messages_dir%\mail_*.txt") do (
    findstr /i /c:"From: %username%" "%%F" >nul
    if !errorlevel! equ 0 (
       echo ----------------------------------------------------------------
       type "%%F"
       echo [Mail Type: Sent]
       echo ----------------------------------------------------------------
    ) else (
       findstr /i /c:"To: %username%" "%%F" >nul
       if !errorlevel! equ 0 (
          echo ----------------------------------------------------------------
          type "%%F"
          echo [Mail Type: Received]
          echo ----------------------------------------------------------------
       )
    )
)
endlocal
pause
goto admin_panel

:admin_delete_mail
cls
echo [96m Admin Mail Deletion [0m 
set /p "username=Enter the username to delete mail for: "
setlocal enabledelayedexpansion
for %%F in ("%messages_dir%\mail_*.txt") do (
    findstr /i /c:"From: %username%" "%%F" >nul
    if !errorlevel! equ 0 (
        echo ----------------------------------------------------------------
        echo File: %%~nxF
        findstr "Title:" "%%F"
        echo ----------------------------------------------------------------
    ) else (
        findstr /i /c:"To: %username%" "%%F" >nul
        if !errorlevel! equ 0 (
            echo ----------------------------------------------------------------
            echo File: %%~nxF
            findstr "Title:" "%%F"
            echo ----------------------------------------------------------------
        )
    )
)
endlocal
set /p "filename=Enter the mail filename to delete (include extension): "
if exist "%messages_dir%\%filename%" (
    del /q "%messages_dir%\%filename%"
    echo Mail deleted successfully!
) else (
    echo Mail not found.
)
pause
goto admin_panel 