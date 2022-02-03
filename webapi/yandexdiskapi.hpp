#ifndef YANDEXDISKAPI_H
#define YANDEXDISKAPI_H

#include <QObject>
#include <QNetworkAccessManager>


class YandexDiskAPI: QObject
{
    Q_OBJECT
private:

    QNetworkAccessManager *networkManager;

public:

    YandexDiskAPI(QNetworkAccessManager *networkManager, QObject *parent = nullptr);

    void publicMetainformationRequest();

    void publicResouceDownload();
};

#endif // YANDEXDISKAPI_H
