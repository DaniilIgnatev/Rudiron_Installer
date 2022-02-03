#ifndef YANDEXDISKAPI_H
#define YANDEXDISKAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>


class YandexDiskAPI: QObject
{
    Q_OBJECT
private:

    QNetworkAccessManager *networkManager;

public:

    YandexDiskAPI(QNetworkAccessManager *networkManager, QObject *parent = nullptr);

    QNetworkReply* publicMetainformationRequest(QString url);

    QNetworkReply* publicResouceDownload(QString uri);
};

#endif // YANDEXDISKAPI_H
