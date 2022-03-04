#ifndef WEBAPIHPP_H
#define WEBAPIHPP_H

#include <QObject>
#include <QNetworkAccessManager>
#include "webapi_task.h"

#include "yandexdiskapi.hpp"

class QQmlEngine;
class QJSEngine;

class WebAPI : public QObject
{
    Q_OBJECT
private:

    explicit WebAPI(QObject *parent = nullptr);

    QNetworkAccessManager *networkManager = new QNetworkAccessManager(this);

    YandexDiskAPI *yandexDisk = new YandexDiskAPI(networkManager, this);

public:

    static WebAPI *instance();

    QNetworkReply* request(const QUrl &uri);

    YandexDiskAPI* getYandexDiskClient() const;

public slots:

};


#endif // WEBAPIHPP_H
