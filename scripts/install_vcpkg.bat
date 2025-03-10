@echo off
setlocal enabledelayedexpansion

echo Installation de vcpkg et SFML 3.0...
echo ===================================

:: Se placer dans le dossier parent (racine du projet)
cd ..

:: Vérifier si vcpkg existe déjà
if exist vcpkg (
    echo [INFO] vcpkg est deja installe.
) else (
    :: Cloner vcpkg
    echo [INFO] Clonage de vcpkg...
    git clone https://github.com/microsoft/vcpkg.git
    
    if !errorlevel! neq 0 (
        echo [ERREUR] Echec du clonage de vcpkg.
        cd scripts
        exit /b 1
    )
    
    :: Exécuter bootstrap
    echo [INFO] Initialisation de vcpkg...
    cd vcpkg
    call bootstrap-vcpkg.bat
    
    if !errorlevel! neq 0 (
        echo [ERREUR] Echec de l'initialisation de vcpkg.
        cd ..\scripts
        exit /b 1
    )
    
    cd ..
    echo [OK] vcpkg a ete installe avec succes.
)

:: Installer SFML 3.0
echo [INFO] Installation de SFML 3.0 via vcpkg...
cd vcpkg
echo !CD!
vcpkg install sfml:x64-windows

if !errorlevel! neq 0 (
    echo [ERREUR] Echec de l'installation de SFML via vcpkg.
    cd ..\scripts
    exit /b 1
)

echo [OK] SFML a ete installe avec succes via vcpkg.

:: Retourner au dossier scripts
cd ..\scripts

exit /b 0