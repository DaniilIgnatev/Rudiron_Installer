#ifndef YANDEXDISKAPI_H
#define YANDEXDISKAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

#include "webapi_task.h"


class YandexDiskAPI: QObject
{
    Q_OBJECT
private:

    QNetworkAccessManager *networkManager;

    QNetworkReply* publicMetainformationRequest(QString resourceURL);

    QNetworkReply* publicResourceDownloadInfo(QString resourceKey);

public:

    YandexDiskAPI(QNetworkAccessManager *networkManager, QObject *parent = nullptr);

    WebAPI_Task* downloadPublicResource(QString resourceURL);

};

#endif // YANDEXDISKAPI_H
