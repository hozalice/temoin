@echo off
setlocal enabledelayedexpansion

:: Déclaration des variables
set "work=D:\L3\MrNaina\Sprint\MySpring"
set "work_dir=."
set "temp=%work_dir%\temp"
set "lib=%work_dir%\lib"
set "src=%work_dir%\src"
set "web_xml=%work_dir%\web.xml"
set "web_apps=C:\Program Files\Apache Software Foundation\apache-tomcat-10.1.31-windows-x64\apache-tomcat-10.1.31\webapps"
set "war_name=Meinesprint"

echo Copie des fichiers JAR du framework...
xcopy /s /y "%work%\lib\*.jar" "%lib%"

:: Effacer le dossier [temp]
if exist "%temp%" (
    echo Suppression du dossier temp existant...
    rd /s /q "%temp%"
)

:: Creation de la structure de dossier temporaire
echo Création de la structure de dossiers...
mkdir "%temp%\WEB-INF\lib"
mkdir "%temp%\WEB-INF\classes"

:: Copie de web.xml vers temp/WEB-INF...
echo Copie du web.xml...
xcopy /y "%web_xml%" "%temp%\WEB-INF"

:: Copie des fichiers JSP
echo Copie des fichiers JSP...
xcopy /y "%work_dir%\web\*.jsp" "%temp%"

:: Copie des fichiers .jar dans lib vers le dossier temporaire...
echo Copie des fichiers JAR...
xcopy /s /y "%lib%\*.jar" "%temp%\WEB-INF\lib"

echo Compilation des fichiers Java...
:: Compilation des fichiers.java dans src
dir /s /B "%src%\*.java" > sources.txt
if not exist sources.txt (
    echo Aucun fichier.java trouvé dans le répertoire src.
    exit /b 1
)

:: Création d'un fichier temporaire pour stocker les chemins des fichiers.jar
dir /s /B "%lib%\*.jar" > libs.txt

:: Construire le classpath
set "classpath="
for /F "delims=" %%i in (libs.txt) do set "classpath=!classpath!.;%%i;"

:: Vérification de l'existence de javac
where javac >nul 2>nul
if %errorlevel% neq 0 (
    echo Erreur: javac n'est pas trouvé dans le PATH.
    exit /b 1
)

:: Exécuter la commande javac
javac -d "%temp%\WEB-INF\classes" -cp "%classpath%" @sources.txt

:: Supprimer les fichiers sources.txt et libs.txt après la compilation
del sources.txt
del libs.txt

:: Créer un fichier.war nommé [war_name].war à partir du dossier [temp]
echo Création du fichier WAR...
cd "%temp%"
jar -cvf "%work_dir%\%war_name%.war" *
cd %work_dir%

:: Effacer le fichier.war dans [web_apps] s'il existe
if exist "%web_apps%\%war_name%.war" (
    echo Suppression de l'ancien WAR...
    del /f /q "%web_apps%\%war_name%.war"
)

:: Copier le fichier.war vers [web_apps]
echo Copie du WAR vers Tomcat...
copy /y "%work_dir%\%war_name%.war" "%web_apps%"

:: Nettoyage
del /f /q "%work_dir%\%war_name%.war"

echo Déploiement terminé avec succès !
echo Les fichiers JSP ont été copiés dans le WAR.
pause
