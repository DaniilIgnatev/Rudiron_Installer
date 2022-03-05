#ifndef PACKAGESDOWNLOADER_H
#define PACKAGESDOWNLOADER_H

#include <QObject>
#include <QList>
#include <QFile>

#include "../webapi/webapi.hpp"
#include "../distributive.h"

//#include "AWS/s3/listobjectsrequest.h"
//#include "AWS/s3/listobjectsresponse.h"

#include "quazip.h"
#include "packagedescriptormodel.hpp"
#include "JlCompress.h"


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

    QStringList getFiltredPackagesIDs(QStringList excludeID);

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
