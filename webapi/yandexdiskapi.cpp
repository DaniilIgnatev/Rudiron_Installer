#include "yandexdiskapi.hpp"

YandexDiskAPI::YandexDiskAPI(QNetworkAccessManager *networkManager, QObject *parent)
    : QObject{parent}
{
    this->networkManager = networkManager;
}

QNetworkReply* YandexDiskAPI::publicMetainformationRequest(QString url)
{
    QString requestUrl = "https://cloud-api.yandex.net/v1/disk/public/resources?public_key=" + url;
    QNetworkRequest request(requestUrl);
    return this->networkManager->get(request);
}

QNetworkReply* YandexDiskAPI::publicResouceDownload(QString uri)
{
    QString encoded_uri = QUrl::toPercentEncoding(uri);
    QString requestUrl = "https://cloud-api.yandex.net/v1/disk/resources/download?public_key=" + encoded_uri;
    QNetworkRequest request(requestUrl);
    return this->networkManager->get(request);
}

