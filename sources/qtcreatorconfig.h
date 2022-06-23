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

#ifndef QTCREATOROPTIONS_H
#define QTCREATOROPTIONS_H

#include "distributive.h"

#include <QObject>
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QTextStream>
#include <QtDebug>

#include <QtXml/QDomDocument>
#include <QtXml/QDomAttr>
#include <QtXml/QDomNodeList>
#include <QtXml/QDomNode>
#include <QtXml/QDomElement>
#include <QXmlStreamReader>

#include "installstatus.h"

#include "pugixml-master/src/pugixml.hpp"
#include <iostream>



class QtCreatorConfig : public QObject
{
    Q_OBJECT
protected:


    //BARE METAL PLUGIN

    InstallStatus bareMetalPluginStatus;


    QString qtcreator_ini_path();



    //OPENOCD
    static const QString debugServerProvider_name;


    static const QString debugServerProvider_id;


    InstallStatus debugServerProviderStatus;


    QString debugServerProviders_xml_path();



    //BARE METAL DEVICE
    static const QString bareMetalDevice_name;


    static const QString bareMetalDevice_id;


    InstallStatus bareMetalDeviceStatus;


    QString devices_xml_path();



    //CMAKE
    static const QString cmake_name;


    static const QString cmake_id;


    InstallStatus cmaketoolStatus;


    QString cmaketools_xml_path();



    //GDB

    static const QString debugger_name;


    static const QString debugger_id;


    InstallStatus debuggerStatus;


    QString debuggers_xml_path();



    //TOOLCHAIN

    static const QString gcc_name;


    static const QString gcc_id;


    InstallStatus gccStatus;


    static const QString gpp_name;


    static const QString gpp_id;


    InstallStatus gppStatus;


    QString toolchain_xml_path();



    //KIT

    static const QString kit_name;


    static const QString kit_id;


    InstallStatus kit_status;


    QString profiles_xml_path();

public:

    //qtproject
    QDir qtprojectDir;

    //qtcreator
    QDir qtcreatorDir;


    static const QString toolchain_name;


    static const QString device_name;


    explicit QtCreatorConfig(QObject *parent = nullptr);


    bool qtCreatorInstalled();


    void enableBareMetalPlugin();


    void createOpenOCDDebugProvider();


    void createBareMetalDevice();


    void addCmake();


    void addDebugger();


    void addToolchain();


    void addKit();
};

#endif // QTCREATOROPTIONS_H
