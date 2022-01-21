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



#include "distributive.h"


Distributive::Distributive(QObject *parent) : QObject(parent)
{

}


QString Distributive::absoluteComponentPath(QDir componentDir)
{
   QString dironPath = Distributive::dibotDir().path();
   dironPath = dironPath.remove("installer", Qt::CaseInsensitive);

   QString componentPath = componentDir.path();
   QString fixedComponentPath = componentPath.remove("../");

   QString fullPath = QDir::toNativeSeparators(dironPath + "/" + fixedComponentPath);
   return fullPath;
}


QString Distributive::absoluteComponentPath(QString componentPath)
{
   QString dironPath = Distributive::dibotDir().path();
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


const QString Distributive::qtCreatorInstallerPath = componentsDirPath + "/qt-unified-windows-x86-online.exe";


const QString Distributive::jlinkBinPath = componentsDirPath + "/JLink.exe";


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


const QString Distributive::openocd_binFilePath = openocd_binDirPath + "/openocd.exe";


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


const QString Distributive::cmakeAppPath = Distributive::cmake_binDirPath + "/cmake.exe";


const QString Distributive::cmakeQchPath = componentsDirPath + "/cmake/doc/cmake/CMake.qch";


const QString Distributive::pythonInstallerPath = componentsDirPath + "/python-2.7.msi";


const QString Distributive::gdbBinPath = gccBinDirPath + "/arm-none-eabi-gdb-py.exe";


const QString Distributive::gccBinPath = gccBinDirPath + "/arm-none-eabi-gcc.exe";


const QString Distributive::gppBinPath = gccBinDirPath + "/arm-none-eabi-g++.exe";

