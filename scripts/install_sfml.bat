@REM @echo off
@REM setlocal enabledelayedexpansion
@REM echo Installation locale de SFML 2.6...
@REM echo ================================

@REM :: Créer le dossier external s'il n'existe pas
@REM if not exist ..\external mkdir ..\external

@REM :: Définir le chemin de destination
@REM set SFML_DIR=..\external\SFML-2.6.0

@REM :: Vérifier si SFML est déjà téléchargé
@REM if exist %SFML_DIR% (
@REM     echo [INFO] SFML 2.6 est deja installe dans %SFML_DIR%
@REM ) else (
@REM     :: Télécharger SFML 2.6
@REM     echo [INFO] Telechargement de SFML 2.6...
    
@REM     :: URL de téléchargement fixe (sans utiliser de variables dans PowerShell)
@REM     powershell -Command "Invoke-WebRequest -Uri 'https://www.sfml-dev.org/files/SFML-2.6.0-windows-vc17-64-bit.zip' -OutFile '..\external\sfml.zip'"
    
@REM     if !errorlevel! neq 0 (
@REM         echo [ERREUR] Echec du telechargement de SFML.
@REM         exit /b 1
@REM     )
    
@REM     :: Extraire le ZIP
@REM     echo [INFO] Extraction de SFML...
@REM     powershell -Command "Expand-Archive -Path '..\external\sfml.zip' -DestinationPath '..\external'"
    
@REM     if !errorlevel! neq 0 (
@REM         echo [ERREUR] Echec de l'extraction de SFML.
@REM         exit /b 1
@REM     )
    
@REM     :: Nettoyer
@REM     del ..\external\sfml.zip
    
@REM     echo [OK] SFML 2.6 a ete telecharge et extrait.
@REM )

@REM :: Vérifier si l'installation a réussi
@REM if not exist %SFML_DIR%\lib\cmake\SFML\SFMLConfig.cmake (
@REM     echo [ERREUR] Installation de SFML 2.6 incomplete ou invalide.
@REM     exit /b 1
@REM )

@REM echo [INFO] SFML 2.6 est pret a etre utilise.

@REM exit /b 0