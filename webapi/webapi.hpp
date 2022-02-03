#ifndef WEBAPIHPP_H
#define WEBAPIHPP_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

#include "yandexdiskapi.hpp"


class QQmlEngine;
class QJSEngine;



class WebAPI : public QObject
{
    Q_OBJECT
private:

    explicit WebAPI(QObject *parent = nullptr);

    static WebAPI* singleton;

    QNetworkAccessManager *networkManager = new QNetworkAccessManager(this);

    YandexDiskAPI *yandexDisk = new YandexDiskAPI(networkManager, this);

public:

    static WebAPI *instance();

    YandexDiskAPI *getYandexDisk() const;

public slots:

};


#endif // WEBAPIHPP_H
