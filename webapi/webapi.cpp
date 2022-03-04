#include "webapi.hpp"



WebAPI::WebAPI(QObject *parent)
    : QObject{parent}
{
    networkManager->setRedirectPolicy(QNetworkRequest::RedirectPolicy::UserVerifiedRedirectPolicy);
}

WebAPI *WebAPI::instance()
{
    static WebAPI singleton;
    return &singleton;
}

QNetworkReply *WebAPI::request(const QUrl &uri)
{
    const QNetworkRequest request(uri);
    QNetworkReply* downloadReply = this->networkManager->get(request);
    return downloadReply;
}

YandexDiskAPI* WebAPI::getYandexDiskClient() const
{
    return yandexDisk;
}
