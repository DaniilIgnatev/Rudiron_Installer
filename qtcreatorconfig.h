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

    //qtproject
    QDir qtprojectDir;



    //qtcreator
    QDir qtcreatorDir;



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
