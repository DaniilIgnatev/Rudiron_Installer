/*
Copyright (C) THEDATE Ignatev Daniil
This file is part of DIBotInstaller <https://github.com/>.

DIBotInstaller is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

DIBotInstaller is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with DIBotInstaller. If not, see <http://www.gnu.org/licenses/>.
*/



#include "installermenuvm.h"



void InstallerMenuVM::runZadig()
{
    QString path = QDir(Distributive::zadigBinPath).canonicalPath();
    QDesktopServices::openUrl(QUrl("file:///" + path, QUrl::TolerantMode));
}


void InstallerMenuVM::installJlink()
{
    QString path = QDir(Distributive::jlinkBinPath).canonicalPath();
    QDesktopServices::openUrl(QUrl("file:///" + path, QUrl::TolerantMode));
}


InstallerMenuVM::InstallerMenuVM(QObject *parent) : QObject(parent)
{
    this->setPathAdded(pathAdded());
    this->setQtCreatorInstalled(this->qtCreatorOptions->qtCreatorInstalled());
    this->setPythonInstalled(this->pythonInstalled());
}


bool InstallerMenuVM::pathAdded()
{
    QProcessEnvironment e = QProcessEnvironment::systemEnvironment();
    QString path = QDir::toNativeSeparators(e.value("Path"));
    qDebug() << path;

    QString gccPath = QDir::toNativeSeparators(Distributive::gccBinDirPath);
    QString openocdPath = QDir::toNativeSeparators(Distributive::openocd_binDirPath);


    bool gcc = path.contains(gccPath);
    bool openocd = path.contains(openocdPath);

    return gcc && openocd;
}


void InstallerMenuVM::setPathAdded(bool value)
{
    this->_pathAdded = value;
    emit pathAddedChanged();
}


bool InstallerMenuVM::qtCreatorInstalled()
{
    return this->_qtCreatorInstalled;
}


void InstallerMenuVM::setQtCreatorInstalled(bool value)
{
    this->_qtCreatorInstalled = value;
    emit qtCreatorInstalledChanged();
}


bool InstallerMenuVM::pythonInstalled()
{
    QString path = Distributive::pythonStandartBinPath;
    return QFile::exists(path);
}


void InstallerMenuVM::setPythonInstalled(bool value)
{
    this->_pythonInstalled = value;
    emit pythonInstalledChanged();
}


void InstallerMenuVM::installQTCreator()
{
    QString path = QDir(Distributive::qtCreatorInstallerPath).canonicalPath();
    QDesktopServices::openUrl(QUrl("file:///" + path, QUrl::TolerantMode));
}


void InstallerMenuVM::installDriver()
{
    if(QSysInfo::kernelType().contains("winnt")){
        installJlink();
        runZadig();
    }
    else{
        installJlink();
    }
}


void InstallerMenuVM::addPATH()
{
    /*
     * QString defaultPath = "C:\\Qt\\Qt5.12.10\\5.12.10\\mingw73_64\\bin;"
                          "C:\\Qt\\Qt5.12.10\\Tools\\mingw730_64\\bin;"
                          "C:\\Qt\\Qt5.12.10\\5.12.10\\mingw73_64\\bin;"
                          "C:\\Qt\\Qt5.12.10\\Tools\\mingw730_64\\bin;"
                          "C:\\Windows\\System32;"
                          "C:\\Users\\Professional\\AppData\\Local\\Microsoft\\WindowsApps;"
                          "C:\\Users\\Professional\\AppData\\Local\\GitHubDesktop\\bin;"
                          "C:\\Users\\Professional\\AppData\\Local\\Programs\\Microsoft VS Code\\bin;"
                          "C:\\Users\\Professional\\.dotnet\\tools;"
                          "C:\\Users\\Professional\\yandex-cloud\\bin;";
    */

    QProcessEnvironment e = QProcessEnvironment::systemEnvironment();
    //    e.remove("Path");


    //    qDebug() << "Path overriden with: " << defaultPath;
    //    QProcess *proc1 = new QProcess;
    //    QString prog1 = "setx";
    //    QStringList args1{"Path", defaultPath};
    //    proc1->start(prog1, args1);
    //    proc1->waitForFinished();

//    e = QProcessEnvironment::systemEnvironment();
//    QString path = e.value("Path");
//    qDebug() << path;
    //    QFile* pathValueFile = Distributive::pathValueFile();
    //    pathValueFile->open(QIODevice::WriteOnly | QIODevice::Text);
    //    pathValueFile->write(path.toUtf8());
    //    pathValueFile->close();
    //    pathValueFile->deleteLater();

    char *pValue;
    size_t len;
    errno_t err = _dupenv_s( &pValue, &len, "PATH" );
    if (err) return;

    QString path = QString(pValue);
    qDebug() << "Path value: " << path;

    QString appendPath = "";

    QString gccFullPath = Distributive::absoluteDibotPath(Distributive::gccBinDirPath);
    if (!path.contains(gccFullPath)){
        appendPath.append(gccFullPath);

    }

    QString openocdFullPath = Distributive::absoluteDibotPath(Distributive::openocd_binDirPath);

    if (!path.contains(openocdFullPath)){
        appendPath.append(";");
        appendPath.append(openocdFullPath);

    }
    appendPath.append(";");
    qDebug() << "Append Path: " << appendPath;

    pathAdd(es_user, L"HELLO");

//    if (appendPath != ";"){
//        QString newPath = appendPath + path;
//        qDebug() << "New Path: " << newPath;

//        QProcess *proc = new QProcess;
//        QString prog = "setx";
//        QStringList args{"PATH", "%PATH%" + newPath};
//        proc->start(prog, args);
//        proc->waitForFinished();
//    }
}


void InstallerMenuVM::enableBareMetalPlugin()
{
    this->qtCreatorOptions->enableBareMetalPlugin();
}


void InstallerMenuVM::createOpenOCDDebugProvider()
{
    this->qtCreatorOptions->createOpenOCDDebugProvider();
}


void InstallerMenuVM::createBareMetalDevice()
{
    this->qtCreatorOptions->createBareMetalDevice();
}


void InstallerMenuVM::createCmakeTools()
{
    this->qtCreatorOptions->addCmake();
}


void InstallerMenuVM::installPython()
{
    QString path = QDir(Distributive::pythonInstallerPath).canonicalPath();
    QDesktopServices::openUrl(QUrl("file:///" + path, QUrl::TolerantMode));
}


void InstallerMenuVM::addDebugger()
{
    this->qtCreatorOptions->addDebugger();
}


void InstallerMenuVM::addToolchain()
{
    this->qtCreatorOptions->addToolchain();
}


void InstallerMenuVM::addKit()
{
    this->qtCreatorOptions->addKit();
}


