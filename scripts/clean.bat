@echo off
echo suppresssion du build, du cmake et du vcpkg pour recommencer l'installation
echo ====================================================================

cd ..
if exist build rmdir /s /q build
echo dossier build supprimer

if exist vcpkg rmdir /s /q vcpkg
echo dossier vcpkg supprimer

if exist cmake rmdir /s /q cmake
echo dossier cmake supprimer

cd scripts

pause
exit /b 0