#ifndef PACKAGESDOWNLOADER_H
#define PACKAGESDOWNLOADER_H

#include <QObject>
#include <QList>
#include <QFile>
#include "../webapi/webapi.hpp"
#include "../distributive.h"
#include "quazip.h"
#include "packagedescriptor.hpp"

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

public:
    void fetchSource();

private:
    void parseSources(QString json_string);

private:
    int packages_cursor = 0;

    QList<PackageDescriptor*> *packages = new QList<PackageDescriptor*>();

public:
    QList<PackageDescriptor*> *getPackages() const;

public:
    const QString &getSources_platform() const;

    const QString &getSources_url() const;

private:
    void parsePackages(QString json_string);

public:
    void fetchPackages();

public:
    void downloadPackage(PackageDescriptor &descriptor);

public slots:

signals:
    void sourceFetched();

    void packagesFetched();

    void errorFetching(QString description);

    void packageDownloadFinished(const PackageDescriptor &descriptor);

    void packageDownloadError(const PackageDescriptor &descriptor, QString description);

    void packageDownloadChanged(const PackageDescriptor &descriptor);

};

#endif // PACKAGESDOWNLOADER_H
