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

#ifndef PACKAGESDOWNLOADER_H
#define PACKAGESDOWNLOADER_H

#include <QObject>
#include <QList>
#include <QFile>

#include "../webapi/webapi.hpp"
#include "../distributive.h"

#include "quazip.h"
#include "packagedescriptormodel.hpp"
#include "JlCompress.h"

#include <QFile>
#include <QIODevice>
#include <QTemporaryFile>


class QQmlEngine;
class QJSEngine;


class PackagesDownloader : public QObject
{
    Q_OBJECT
public:
    explicit PackagesDownloader(QObject *parent = nullptr);

    static PackagesDownloader* instance();

    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
private:
    ~PackagesDownloader();

    YandexDiskAPI *yandexapi;

private:
    QString trimDestination(QString destination);

private:
    QString sources_platform;
    QString sources_url;

public slots:
    void fetchSource();

private:
    void parseSources(QString json_string);

private:
    int packages_cursor = 0;

    QList<PackageDescriptor*> packages;

public slots:
    PackageDescriptorModel* getPackages(QStringList excludeID);

    PackageDescriptor *getPackage(QString ID);

    QStringList getFiltredPackagesIDs(QStringList excludeID);

    void applySkipDownload(QStringList skipDownloadID);

public slots:
    const QString getSources_platform();

    const QString getSources_url();

private:
    void parsePackages(QString json_string);

public slots:
    void fetchPackages();

private:
    void packageError(PackageDescriptor* descriptor, QString description);

public slots:
    void downloadPackage(PackageDescriptor* descriptor);

signals:
    void sourceFetched();

    void packagesFetched();

    void errorFetching(QString description);

    void packageDownloadFinished(const PackageDescriptor* descriptor);

    void packageDownloadError(const PackageDescriptor* descriptor, QString description);

    void packageDownloadChanged(const PackageDescriptor* descriptor);

};

#endif // PACKAGESDOWNLOADER_H
