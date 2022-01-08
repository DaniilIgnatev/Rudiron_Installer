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


const QString Distributive::debugPath =  "debug";


QDir Distributive::dibotDir()
{
    return QDir::current();
}


const QString Distributive::softDirPath = "components";


const QString Distributive::svdFilePath = softDirPath + "/MDR32F9Q1.svd";


QDir Distributive::softDir()
{
    return QDir(softDirPath);
}


const QString Distributive::qtCreatorInstallerPath = softDirPath + "/qt-creator.exe";


const QString Distributive::jlinkBinPath = softDirPath + "/JLink.exe";


const QString Distributive::zadigBinPath = softDirPath + "/zadig.exe";


const QString Distributive::gccDirPath = softDirPath + "/gcc-arm-none-eabi";


QDir Distributive::gccDir()
{
    return QDir(gccDirPath);
}


const QString Distributive::gccBinDirPath = gccDirPath + "/bin";


QDir Distributive::gccBinDir()
{
    return QDir(gccBinDirPath);
}


const QString Distributive::openocdDirPath = softDirPath + "/openocd";


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


const QString Distributive::openocd_scriptsDirPath = openocdDirPath + "/share/openocd/scripts";


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


const QString Distributive::cmakeBinPath = softDirPath + "/cmake/bin/cmake.exe";


const QString Distributive::cmakeQchPath = softDirPath + "/cmake/doc/cmake/CMake.qch";


const QString Distributive::pythonInstallerPath = softDirPath + "/python-2.7.msi";


const QString Distributive::gdbBinPath = gccBinDirPath + "/arm-none-eabi-gdb-py.exe";


const QString Distributive::gccBinPath = gccBinDirPath + "/arm-none-eabi-gcc.exe";


const QString Distributive::gppBinPath = gccBinDirPath + "/arm-none-eabi-g++.exe";

