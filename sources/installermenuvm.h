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

#ifndef INSTALLERMENU_H
#define INSTALLERMENU_H

#include <QObject>
#include <QProcess>
#include <QFile>
#include <QIODevice>
#include <QProcessEnvironment>
#include <QList>
#include <QDebug>
#include <QDesktopServices>
#include <QSysInfo>

#include <QtConcurrent/QtConcurrent>

#include "qqml.h"
#include "distributive.h"
#include "qtcreatorconfig.h"


class InstallerMenuVM : public QObject
{
    Q_OBJECT
private:

    QtCreatorConfig* qtCreatorOptions = new QtCreatorConfig(this);


    bool _pathAdded = false;


    bool _qtCreatorInstalled = false;


    bool _pythonInstalled = false;

public:

    Q_PROPERTY(bool pathAdded READ pathAdded WRITE setPathAdded NOTIFY pathAddedChanged)


    Q_PROPERTY(bool qtCreatorInstalled READ qtCreatorInstalled WRITE setQtCreatorInstalled NOTIFY qtCreatorInstalledChanged)


    Q_PROPERTY(bool pythonInstalled READ pythonInstalled WRITE setPythonInstalled NOTIFY pythonInstalledChanged)


    explicit InstallerMenuVM(QObject *parent = nullptr);


    bool pathAdded();


    void setPathAdded(bool value);


    bool qtCreatorInstalled();


    void setQtCreatorInstalled(bool value);


    bool pythonInstalled();


    void setPythonInstalled(bool value);


signals:

    void pathAddedChanged();


    void qtCreatorInstalledChanged();


    void pythonInstalledChanged();


public slots:


    QString printPathes();


    void addPATH();


    void addPATH_Windows();


    void addPATH_Unix(QString rcFileName);


    void addCompilerVariables();


    void addCombilerVariables_Windows();


    void addCompilerVariables_Linux();


    void installCp210x();


    void installJlink();


    void runZadig();


    void enableBareMetalPlugin();


    void createOpenOCDDebugProvider();


    void createBareMetalDevice();


    void createCmakeTools();


    void installPython();


    void addDebugger();


    void addToolchain();


    void addKit();


    void install(QString destination, QString uri);

};

#endif // INSTALLERMENU_H
