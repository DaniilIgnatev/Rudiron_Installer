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

#include "qqml.h"
#include "distributive.h"
#include "qtcreatorconfig.h"
#include "editenv/editenv.hpp"


class InstallerMenuVM : public QObject
{
    Q_OBJECT
private:

    QtCreatorConfig* qtCreatorOptions = new QtCreatorConfig(this);


    bool _pathAdded = false;


    bool _qtCreatorInstalled = false;


    bool _pythonInstalled = false;


    void runZadig();


    void installJlink();

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


    void addPATH();


    void installQTCreator();


    void installDriver();


    void enableBareMetalPlugin();


    void createOpenOCDDebugProvider();


    void createBareMetalDevice();


    void createCmakeTools();


    void installPython();


    void addDebugger();


    void addToolchain();


    void addKit();

};

#endif // INSTALLERMENU_H
