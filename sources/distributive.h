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

#ifndef DISTRIBUTIVE_H
#define DISTRIBUTIVE_H

#include <QObject>
#include <QDir>
#include <QFile>
#include <QFileInfo>



class Distributive : public QObject
{
public:


    explicit Distributive(QObject *parent = nullptr);


    //DIBOT


    static QString absoluteComponentPath(QDir componentDir);


    static QString absoluteComponentPath(QString componentPath);


    static QDir dibotDir();



    //DEBUG

    static const QString debugPath;



    //SVD

    static const QString svdFilePath;



    //SOFT

    static const QString componentsDirPath;


    static QDir softDir();


    //DRIVER

    static const QString cp210xBinPath;


    static const QString jlinkBinPath;


    static const QString zadigBinPath;


    //GCC

    static const QString gccDirPath;


    static QDir gccDir();


    static const QString gccBinDirPath;


    static QDir gccBinDir();



    //OPENOCD

    static const QString openocdDirPath;


    static QDir openocdDir();


    static const QString openocd_binDirPath;


    static QDir openocd_binDir();


    static const QString openocd_binFilePath;


    static const QString openocd_scriptsDirPath;


    static QDir openocd_scriptsDir();


    static const QString openocd_interfaceDirPath;


    static QDir openocd_interfaceDir();


    static const QString openocd_interfaceFilePath;



    //PATH

    static const QString pathValueFilePath;


    static QFile* pathValueFile();



    //CMAKE

    static const QString cmake_binDirPath;


    static QDir cmake_binDir();


    static const QString cmakeAppPath;


    static const QString cmakeQchPath;



    //PYTHON

    static const QString pythonStandartFolderPath;


    static const QString pythonStandartBinPath;


    static QDir pythonStandartFolderDir();


    static const QString pythonInstallerPath;



    //GDB

    static const QString gdbBinPath;


    //TOOLCHAIN

    static const QString gccBinPath;


    static const QString gppBinPath;

};

#endif // DISTRIBUTIVE_H
