#include "yandexdiskapi.hpp"

YandexDiskAPI::YandexDiskAPI(QNetworkAccessManager *networkManager, QObject *parent)
    : QObject{parent}
{
    this->networkManager = networkManager;
}


QNetworkReply* YandexDiskAPI::publicMetainformationRequest(QString resourceURL)
{
    QString requestUrl = "https://cloud-api.yandex.net/v1/disk/public/resources?public_key=" + resourceURL;
    QNetworkRequest request(requestUrl);
    return this->networkManager->get(request);
}


QNetworkReply* YandexDiskAPI::publicResourceDownloadInfo(QString resourceKey)
{
    QString encoded_uri = QUrl::toPercentEncoding(resourceKey);
    QString requestUrl = "https://cloud-api.yandex.net/v1/disk/public/resources/download?public_key=" + encoded_uri;
    QNetworkRequest request(requestUrl);
    return this->networkManager->get(request);
}


WebAPI_Task* YandexDiskAPI::downloadPublicResource(QString resourceURL)
{
    WebAPI_Task *task = new WebAPI_Task(resourceURL);

    QNetworkReply* metaInfoReply = publicMetainformationRequest(resourceURL);
    connect(metaInfoReply, &QNetworkReply::finished, this, [=]() {
        QByteArray reply_data = metaInfoReply->readAll();
        QJsonDocument reply_Json = QJsonDocument::fromJson(reply_data);
        QJsonObject metadata = reply_Json.object();

        QString resourceKey = metadata["public_key"].toString();
        task->fileName = metadata["name"].toString();

        QNetworkReply* downloadInfoReply = publicResourceDownloadInfo(resourceKey);
        connect(downloadInfoReply, &QNetworkReply::finished, this, [=]() {
            QByteArray reply_data = downloadInfoReply->readAll();
            QJsonDocument reply_Json = QJsonDocument::fromJson(reply_data);
            QJsonObject downloadInfo = reply_Json.object();

            QString href = downloadInfo["href"].toString();
            const QNetworkRequest request(href);
            qDebug() << href;
            QNetworkReply* downloadReply = this->networkManager->get(request);
            task->setReply(downloadReply);

            downloadInfoReply->deleteLater();
        });

        metaInfoReply->deleteLater();
    }
    );

    return task;
}
