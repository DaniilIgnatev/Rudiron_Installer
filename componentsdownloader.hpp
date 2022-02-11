#ifndef COMPONENTSDOWNLOADER_H
#define COMPONENTSDOWNLOADER_H

#include <QObject>
#include <QList>
#include "webapi/webapi.hpp"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>

class QQmlEngine;
class QJSEngine;


struct ComponentStatus {
private:
    Q_GADGET
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(int percentage MEMBER percentage)
    Q_PROPERTY(bool completed MEMBER completed)
public:
       QString name;
       int percentage;
       bool completed;
};


class ComponentsDownloader : public QObject
{
    Q_OBJECT
private:
    static ComponentsDownloader* singleton;

    explicit ComponentsDownloader(QObject *parent = nullptr);

    ~ComponentsDownloader();

    YandexDiskAPI *yandexapi;

    int current_component_id = 0;

    QList<ComponentStatus> *components = new QList<ComponentStatus>();

    QString sourcesURI = nullptr;

    void loadSources();

    void download();

public:

    static ComponentsDownloader* instance();

    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);

    ComponentStatus currentComponentStatus();

public slots:

signals:
    void currentComponentStatusChanged(ComponentStatus status);

};

#endif // COMPONENTSDOWNLOADER_H
