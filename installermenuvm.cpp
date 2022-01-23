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
    #ifdef _WIN32
        addPATH_Windows();
    #elif __linux__
        addPATH_Linux();
    #endif
}


void InstallerMenuVM::addPATH_Windows(){
    QSettings registry("HKEY_CURRENT_USER\\Environment", QSettings::NativeFormat);
    QString path_current = registry.value("Path", "").toString();
    qDebug() << "\nCurrent Path: " << path_current;

    QString appendPath = "";

    QString gccFullPath = Distributive::absoluteComponentPath(Distributive::gccBinDirPath);
    if (!path_current.contains(gccFullPath)){
        appendPath.append(";");
        appendPath.append(gccFullPath);
    }

    QString openocdFullPath = Distributive::absoluteComponentPath(Distributive::openocd_binDirPath);
    if (!path_current.contains(openocdFullPath)){
        appendPath.append(";");
        appendPath.append(openocdFullPath);

    }

    QString cmakeFullPath = Distributive::absoluteComponentPath(Distributive::cmake_binDirPath);
    if (!path_current.contains(cmakeFullPath)){
        appendPath.append(";");
        appendPath.append(cmakeFullPath);
    }

    qDebug() << "\nAppend Path: " << appendPath;

    if (!appendPath.isEmpty()){
        QString newPath = path_current + appendPath;
        qDebug() << "\nNew Path: " << newPath;

        QProcess *process = new QProcess;
        QString prog = "setx";
        QStringList args{"PATH", newPath};
        process->start(prog, args);
        process->waitForFinished();
    }
}


void InstallerMenuVM::addPATH_Linux(){
    QString bashrc_path = QDir::toNativeSeparators(QDir::homePath() + "/.bashrc");
    QFile bashrc_file = QFile(bashrc_path);
    bashrc_file.open(QIODeviceBase::ReadOnly);
    QString currect_bashrc = bashrc_file.readAll();
    bashrc_file.close();

    QString appendPath = "";

    QString gccFullPath = Distributive::absoluteComponentPath(Distributive::gccBinDirPath);
    if (!currect_bashrc.contains(gccFullPath)){
        appendPath.append(":");
        appendPath.append(gccFullPath);
    }

    QString openocdFullPath = Distributive::absoluteComponentPath(Distributive::openocd_binDirPath);
    if (!currect_bashrc.contains(openocdFullPath)){
        appendPath.append(":");
        appendPath.append(openocdFullPath);

    }

    QString cmakeFullPath = Distributive::absoluteComponentPath(Distributive::cmake_binDirPath);
    if (!currect_bashrc.contains(cmakeFullPath)){
        appendPath.append(":");
        appendPath.append(cmakeFullPath);
    }

    qDebug() << "\nAppend Path: " << appendPath;

    if (!appendPath.isEmpty()){
        QString export1 = "export PATH=\"";
        QString export2 = "$PATH" + appendPath + "\"";

        QProcess *process = new QProcess;
        process->start("sh");
        process->waitForStarted();

        QString bash_command1 = QString("echo ") + "'" + export1 + "' >> " + bashrc_path;
        process->write(bash_command1.toUtf8());

        QString bash_command2 = QString("echo ") + "'" + export2 + "' >> " + bashrc_path + "\n";
        process->write(bash_command2.toUtf8());

        process->write("exit\n");
        process->waitForFinished();
    }
}


void InstallerMenuVM::addCompilerVariables()
{
    #ifdef _WIN32
        addCombilerVariables_Windows();
    #elif __linux__
        addCombilerVariables_Linux();
    #endif
}


void InstallerMenuVM::addCombilerVariables_Windows(){
    QSettings registry("HKEY_CURRENT_USER\\Environment", QSettings::NativeFormat);

    QString CC_current_value = registry.value("CC", "").toString();
    qDebug() << "\nCurrent CC: " << CC_current_value;
    QString CC_new_value = "arm-none-eabi-gcc.exe";

    if (!CC_current_value.contains(CC_new_value)){
        QProcess *proc = new QProcess;
        QString prog = "setx";
        QStringList args{"CC", CC_new_value};
        proc->start(prog, args);
        proc->waitForFinished();
    }

    QString CXX_current_value = registry.value("CXX", "").toString();
    qDebug() << "\nCurrent CXX: " << CXX_current_value;
    QString CXX_new_value = "arm-none-eabi-g++.exe";

    if (!CXX_current_value.contains(CXX_new_value)){
        QProcess *proc = new QProcess;
        QString prog = "setx";
        QStringList args{"CXX", CXX_new_value};
        proc->start(prog, args);
        proc->waitForFinished();
    }
}


void InstallerMenuVM::addCombilerVariables_Linux(){

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


