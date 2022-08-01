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

#include <QGuiApplication>
#include <QObject>
#include <QQmlComponent>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QSurfaceFormat>
#include <QQuickStyle>

#ifdef _WIN32
#include "QCrashHandler"
#endif

#include <QStandardPaths>

#include "installermenuvm.h"
#include "filesystemapi.hpp"
#include "packagesdownloader/packagesdownloader.hpp"
#include "packagesdownloader/packagedescriptor.hpp"

// Main wrapper program.
// Special handling is needed when using Qt Quick Controls for the top window.
// The code here is based on what qmlscene does.

int main(int argc, char ** argv)
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QCoreApplication::setApplicationName("Rudiron Installer");
    QCoreApplication::setApplicationVersion("1.1.1");

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/icon.ico"));

#ifdef _WIN32
    Breakpad::CrashHandler::instance()->Init(qApp->applicationDirPath());
#endif
    // Register our component type with QML.
    qmlRegisterType<InstallerMenuVM>("com.dibot",1, 0,"InstallerMenuVM");
    qmlRegisterType<FileSystemAPI>("com.FileSystemAPI",1, 0,"FileSystemAPI");
    qmlRegisterType<PackageDescriptor>("com.PackageDescriptor",1, 0,"PackageDescriptor");
    qmlRegisterSingletonType<PackagesDownloader>("com.PackagesDownloader", 1, 0, "PackagesDownloader", &PackagesDownloader::qmlInstance);

    qRegisterMetaType<PackageDescriptor*>("PackageDescriptor*");
    qRegisterMetaType<PackageDescriptorModel*>("PackageDescriptorModel*");
    qRegisterMetaType<QList<PackageDescriptor*>>("QList<PackageDescriptor*>");

    QQmlApplicationEngine engine;
    QObject::connect(&engine, SIGNAL(quit()), QCoreApplication::instance(), SLOT(quit()));

    QQmlComponent *component = new QQmlComponent(&engine);
    component->loadUrl(QUrl("qrc:/components/InstallerWindow.qml"));

    if (!component->isReady() ) {
        qWarning("%s", qPrintable(component->errorString()));
        return -1;
    }

    QObject *topLevel = component->create();
    QQuickWindow *window = qobject_cast<QQuickWindow*>(topLevel);
    QSurfaceFormat surfaceFormat = window->requestedFormat();
    window->setFormat(surfaceFormat);
    window->show();

    int rc = app.exec();

    delete component;
    return rc;
}
