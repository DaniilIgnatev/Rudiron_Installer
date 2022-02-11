#ifndef PACKAGESDOWNLOADER_H
#define PACKAGESDOWNLOADER_H

#include <QObject>
#include <QList>
#include "../webapi/webapi.hpp"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>

class QQmlEngine;
class QJSEngine;


struct ComponentDescriptor {
private:
    Q_GADGET
    Q_PROPERTY(QString id MEMBER id)
    Q_PROPERTY(QString file_name MEMBER file_name)
    Q_PROPERTY(QString description MEMBER description)
    Q_PROPERTY(QString url MEMBER url)
    Q_PROPERTY(QList<QString> contents MEMBER contents)
    Q_PROPERTY(int percentage MEMBER percentage)
    Q_PROPERTY(bool completed MEMBER completed)
public:
       QString id;
       QString file_name;
       QString description;
       QString url;
       QList<QString> contents;
       int percentage;
       bool completed;
};


class PackagesDownloader : public QObject
{
    Q_OBJECT
private:
    static PackagesDownloader* singleton;

    explicit PackagesDownloader(QObject *parent = nullptr);

    ~PackagesDownloader();

    YandexDiskAPI *yandexapi;

    int current_component_id = 0;

    QList<ComponentDescriptor> *components = new QList<ComponentDescriptor>();

    QString sourcesURI = nullptr;

    void loadSources();

    void download();

public:

    static PackagesDownloader* instance();

    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);

    ComponentDescriptor currentComponentStatus();

public slots:

signals:
    void currentComponentStatusChanged(ComponentDescriptor status);

};

#endif // PACKAGESDOWNLOADER_H
