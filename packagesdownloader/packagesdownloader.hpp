#ifndef PACKAGESDOWNLOADER_H
#define PACKAGESDOWNLOADER_H

#include <QObject>
#include <QList>
#include "../webapi/webapi.hpp"
#include "../distributive.h"

class QQmlEngine;
class QJSEngine;


struct PackageDescriptor {
public:
    static const QString type_application;
    static const QString type_installer;
    static const QString type_archive;
    static const QString type_script;
private:
    Q_GADGET
    Q_PROPERTY(QString id MEMBER id)
    Q_PROPERTY(QString type MEMBER type)
    Q_PROPERTY(QString description MEMBER description)
    Q_PROPERTY(QString url MEMBER url)
    Q_PROPERTY(QString destination MEMBER destination)
    Q_PROPERTY(QList<QString> contents MEMBER contents)
    Q_PROPERTY(int percentage MEMBER percentage)
    Q_PROPERTY(bool completed MEMBER completed)
public:
       QString id;
       QString type;
       QString description;
       QString url;
       QString destination;
       QList<QString> contents;
       int percentage;
       bool completed;
};


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

    QList<PackageDescriptor> *packages = new QList<PackageDescriptor>();

public:
    QList<PackageDescriptor> *getPackages() const;

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

    void packageDownloadStatusChanged(const PackageDescriptor &descriptor);

};

#endif // PACKAGESDOWNLOADER_H
