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
#include <QSettings>



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


QString InstallerMenuVM::printPathes()
{
    QString qtprojectDir = this->qtCreatorOptions->qtprojectDir.path();
    QString qtcreatorDir = this->qtCreatorOptions->qtcreatorDir.path();

    QString pathes = qtprojectDir.append("\n").append(qtcreatorDir);
    return pathes;
}


void InstallerMenuVM::addPATH()
{
    QSettings registry("HKEY_CURRENT_USER\\Environment", QSettings::NativeFormat);
    QString pathVal = registry.value("Path", "").toString();
    qDebug() << "\nCurrent Path: " << pathVal;

    QString appendPath = "";
    QString gccFullPath = Distributive::absoluteComponentPath(Distributive::gccBinDirPath);
    if (!pathVal.contains(gccFullPath)){
        appendPath.append(";");
        appendPath.append(gccFullPath);
    }

    QString openocdFullPath = Distributive::absoluteComponentPath(Distributive::openocd_binDirPath);

    if (!pathVal.contains(openocdFullPath)){
        appendPath.append(";");
        appendPath.append(openocdFullPath);

    }

    qDebug() << "\nAppend Path: " << appendPath;

    if (!appendPath.isEmpty()){
        QString newPath = pathVal + appendPath;
        qDebug() << "\nNew Path: " << newPath;

        QProcess *proc = new QProcess;
        QString prog = "setx";
        QStringList args{"PATH", newPath};
        proc->start(prog, args);
        proc->waitForFinished();
    }
}


void InstallerMenuVM::installQTCreator()
{
    QString path = Distributive::absoluteComponentPath(Distributive::qtCreatorInstallerPath);
    QDesktopServices::openUrl(QUrl("file:///" + path, QUrl::TolerantMode));
}


void InstallerMenuVM::installJlink()
{
    QString path = Distributive::absoluteComponentPath(Distributive::jlinkBinPath);
    QDesktopServices::openUrl(QUrl("file:///" + path, QUrl::TolerantMode));
}


void InstallerMenuVM::runZadig()
{
    QString path = Distributive::absoluteComponentPath(Distributive::zadigBinPath);
    QDesktopServices::openUrl(QUrl("file:///" + path, QUrl::TolerantMode));
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
    QString path = Distributive::absoluteComponentPath(Distributive::pythonInstallerPath);
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


