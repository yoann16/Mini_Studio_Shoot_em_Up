@echo off
echo === Configuration du projet ShootemUp avec SFML 3.0 ===

cd scripts

:: Verification des prerequis
echo [INFO] Verification des outils necessaires...
call check_prerequisites.bat
if %errorlevel% neq 0 (
    echo [ERREUR] Verification des prerequis echouee.
    pause
    exit /b 1
)

:: Installation de vcpkg et SFML 3.0
echo [INFO] Installation de vcpkg et SFML 3.0...
call install_vcpkg.bat
if %errorlevel% neq 0 (
    echo [ERREUR] Installation de vcpkg et SFML 3.0 echouee.
    pause
    exit /b 1
)

:: Configuration et compilation du projet
echo [INFO] Configuration et compilation du projet...
call configure_project.bat
if %errorlevel% neq 0 (
    echo [ERREUR] Configuration du projet echouee.
    pause
    exit /b 1
)

cd ..

echo === Installation terminee avec succes! ===
echo.
echo Vous pouvez maintenant lancer le jeu depuis build\Debug\ShootemUp.exe
echo.

pause
exit /b 0