/*
Copyright (C) THEDATE Ignatev Daniil
This file is part of RudironInstaller <https://github.com/>.

RudironInstaller is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

RudironInstaller is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with RudironInstaller. If not, see <http://www.gnu.org/licenses/>.
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

QStringList InstallerMenuVM::get_PATH_elements()
{
    QString gccFullPath = Distributive::absoluteComponentPath(Distributive::gccBinDirPath);
    QString openocdFullPath = Distributive::absoluteComponentPath(Distributive::openocd_binDirPath);
    QString cmakeFullPath = Distributive::absoluteComponentPath(Distributive::cmake_binDirPath);
    QString programmerFullPath = Distributive::absoluteComponentPath(Distributive::programmerDirPath);
    QString terminalFullPath = Distributive::absoluteComponentPath(Distributive::terminalDirPath);

    return { gccFullPath, openocdFullPath, cmakeFullPath, programmerFullPath, terminalFullPath};
}

QString InstallerMenuVM::get_ArduinoLibrary_Path()
{
    QString rudironLibPath = Distributive::absoluteComponentPath(Distributive::arduino_core_rudiron_DirPath);
    return rudironLibPath;
}


void InstallerMenuVM::addPATH()
{
    QtConcurrent::run(QThreadPool::globalInstance(), [=](){
#ifdef _WIN32
        addPATH_Windows();
#elif __linux__
        addPATH_Unix("/.bashrc");
#elif __APPLE__
        addPATH_Unix("/.zshrc");
#endif
    });
}


void InstallerMenuVM::addPATH_Windows(){
    QSettings registry("HKEY_CURRENT_USER\\Environment", QSettings::NativeFormat);
    QString RD_current = registry.value("RudironDistributive", "").toString();
    qDebug() << "\nCurrent RudironDistributive: " << RD_current;

    QString appendRD = "";

    QStringList pathes = get_PATH_elements();
    foreach (auto path, pathes) {
        if (appendRD != ""){
            appendRD.append(";");
        }

        if (path != "" && path != ";"){
            appendRD.append(path);
        }
    }

    qDebug() << "\nAppend RudironDistributive: " << appendRD;

    if (!appendRD.isEmpty()){
        QString newRD = appendRD;
        qDebug() << "\nNew RudironDistributive: " << newRD;

        QString prog = "setx";
        QProcess *process_RD = new QProcess;
        QStringList args{"RudironDistributive", newRD};
        process_RD->start(prog, args);
        process_RD->waitForFinished();
        process_RD->deleteLater();

        QSettings registry("HKEY_CURRENT_USER\\Environment", QSettings::NativeFormat);
        QString path_value = registry.value("Path", "").toString();
        qDebug() << "\nCurrent Path: " << path_value;

        if (!path_value.contains("%RudironDistributive%")){
            if (path_value != ""){
                path_value.append(";%RudironDistributive%");
            }
            else{
                path_value.append("%RudironDistributive%");
            }
        }

        qDebug() << "\nNew Path value: " << path_value;
        QProcess *process_path = new QProcess;
        QStringList args_path{"Path", path_value };
        process_path->start(prog, args_path);
        process_path->waitForFinished();
        process_path->deleteLater();
    }

    QString libraryPath = get_ArduinoLibrary_Path();
    QString LP_current = registry.value("Arduino_Core_Rudiron_Path", "").toString();
    qDebug() << "\nCurrent rudiron library path: " << LP_current;
    QString LP_new = libraryPath;
    qDebug() << "\nNew rudiron library path: " << LP_new;
    QString prog = "setx";
    QProcess *process_RD = new QProcess;
    QStringList args{"Arduino_Core_Rudiron_Path", LP_new};
    process_RD->start(prog, args);
    process_RD->waitForFinished();
    process_RD->deleteLater();
}


void InstallerMenuVM::addPATH_Unix(QString rcFileName){
    QString bashrc_path = QDir::toNativeSeparators(QDir::homePath() + rcFileName);
    QFile *bashrc_file = new QFile(bashrc_path);
    bashrc_file->open(QIODevice::ReadOnly);
    QString currect_bashrc = bashrc_file->readAll();
    bashrc_file->close();
    delete bashrc_file;

    QString appendPath = "";

    QStringList pathes = get_PATH_elements();
    foreach (auto path, pathes) {
        if (!currect_bashrc.contains(path)){
            appendPath.append(":");
            appendPath.append(path);
        }
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
    QtConcurrent::run(QThreadPool::globalInstance(), [=](){
#ifdef _WIN32
        addCombilerVariables_Windows();
#else
        addCompilerVariables_Unix();
#endif
    });
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


void InstallerMenuVM::addCompilerVariables_Unix(){

}


void InstallerMenuVM::installCp210x()
{
    QString path = Distributive::absoluteComponentPath(Distributive::cp210xBinPath);
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


void InstallerMenuVM::install(QString destination, QString uri)
{
    QString path = Distributive::absoluteComponentPath(destination + "/" + uri);
    QDesktopServices::openUrl(QUrl("file:///" + path, QUrl::TolerantMode));
}


bool InstallerMenuVM::isDebug()
{
#ifdef QT_DEBUG
    return true;
#else
    return false;
#endif
}


