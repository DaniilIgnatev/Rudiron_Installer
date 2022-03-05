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


    void addPATH_Linux();


    void addCompilerVariables();


    void addCombilerVariables_Windows();


    void addCombilerVariables_Linux();


    void installQTCreator(QString destination, QString uri);


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

};

#endif // INSTALLERMENU_H
