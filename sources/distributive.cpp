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

#include "distributive.h"


Distributive::Distributive(QObject *parent) : QObject(parent)
{

}


QString Distributive::absoluteComponentPath(QDir componentDir)
{
    QString os_type = QSysInfo::kernelType();
    QString dironPath = Distributive::dibotDir().path();

    if (os_type == "darwin"){
        dironPath = dironPath.remove("/Rudiron Installer.app/Contents/MacOS", Qt::CaseInsensitive);
    }

    dironPath = dironPath.remove("installer", Qt::CaseInsensitive);

    QString componentPath = componentDir.path();
    QString fixedComponentPath = componentPath.remove("../");

    QString fullPath = QDir::toNativeSeparators(dironPath + "/" + fixedComponentPath);
    return fullPath;
}


QString Distributive::absoluteComponentPath(QString componentPath)
{
    QString os_type = QSysInfo::kernelType();
    QString dironPath = Distributive::dibotDir().path();

    if (os_type == "darwin"){
        dironPath = dironPath.remove("/Rudiron Installer.app/Contents/MacOS", Qt::CaseInsensitive);
    }

    dironPath = dironPath.remove("installer", Qt::CaseInsensitive);

    QString fixedComponentPath = componentPath.remove("../");

    QString fullPath = QDir::toNativeSeparators(dironPath + "/" + fixedComponentPath);
    return fullPath;
}


const QString Distributive::debugPath =  "debug";


QDir Distributive::dibotDir()
{
    return QDir::current();
}


const QString Distributive::componentsDirPath = "../components";


const QString Distributive::svdFilePath = componentsDirPath + "/MDR32F9Q1.svd";


QDir Distributive::softDir()
{
    return QDir(componentsDirPath);
}


#ifdef _WIN32
const QString Distributive::jlinkBinPath = componentsDirPath + "/JLink.exe";
#else
const QString Distributive::jlinkBinPath = componentsDirPath + "/JLink.deb";
#endif


const QString Distributive::zadigBinPath = componentsDirPath + "/zadig.exe";


const QString Distributive::gccDirPath = componentsDirPath + "/gcc-arm-none-eabi";


QDir Distributive::gccDir()
{
    return QDir(gccDirPath);
}


const QString Distributive::gccBinDirPath = gccDirPath + "/bin";


QDir Distributive::gccBinDir()
{
    return QDir(gccBinDirPath);
}


const QString Distributive::openocdDirPath = componentsDirPath + "/openocd";


QDir Distributive::openocdDir()
{
    return QDir(openocdDirPath);
}


const QString Distributive::openocd_binDirPath = openocdDirPath + "/bin";


QDir Distributive::openocd_binDir()
{
    return QDir(openocd_binDirPath);
}


#ifdef _WIN32
const QString Distributive::openocd_binFilePath = openocd_binDirPath + "/openocd.exe";
#else
const QString Distributive::openocd_binFilePath = openocd_binDirPath + "/openocd";
#endif


const QString Distributive::openocd_scriptsDirPath = openocdDirPath + "/scripts";


QDir Distributive::openocd_scriptsDir()
{
    return QDir(openocd_scriptsDirPath);
}


const QString Distributive::openocd_interfaceDirPath = openocd_scriptsDirPath + "/interface";


QDir Distributive::openocd_interfaceDir()
{
    return QDir(openocd_interfaceDirPath);
}


const QString Distributive::openocd_interfaceFilePath = openocd_interfaceDirPath + "/1986be92_jlink.cfg";


const QString Distributive::pathValueFilePath = debugPath + "/pathcopy.txt";


QFile* Distributive::pathValueFile()
{
    return new QFile(pathValueFilePath);
}


const QString Distributive::pythonStandartFolderPath = "C:\\Python27";


const QString Distributive::pythonStandartBinPath = pythonStandartFolderPath + "/python.exe";


QDir Distributive::pythonStandartFolderDir()
{
    return QDir(Distributive::pythonStandartFolderPath);
}


const QString Distributive::cmake_binDirPath = componentsDirPath + "/cmake/bin";


QDir Distributive::cmake_binDir()
{
    return QDir(Distributive::cmake_binDirPath);
}


#ifdef _WIN32
const QString Distributive::cmakeAppPath = Distributive::cmake_binDirPath + "/cmake.exe";
#else
const QString Distributive::cmakeAppPath = Distributive::cmake_binDirPath + "/cmake";
#endif


const QString Distributive::cmakeQchPath = componentsDirPath + "/cmake/doc/cmake/CMake.qch";


const QString Distributive::pythonInstallerPath = componentsDirPath + "/python-2.7.msi";


#ifdef _WIN32
const QString Distributive::gdbBinPath = gccBinDirPath + "/arm-none-eabi-gdb-py.exe";
#else
const QString Distributive::gdbBinPath = gccBinDirPath + "/arm-none-eabi-gdb-py";
#endif


#ifdef _WIN32
const QString Distributive::gccBinPath = gccBinDirPath + "/arm-none-eabi-gcc.exe";
#else
const QString Distributive::gccBinPath = gccBinDirPath + "/arm-none-eabi-gcc";
#endif


#ifdef _WIN32
const QString Distributive::gppBinPath = gccBinDirPath + "/arm-none-eabi-g++.exe";
#else
const QString Distributive::gppBinPath = gccBinDirPath + "/arm-none-eabi-g++";
#endif
