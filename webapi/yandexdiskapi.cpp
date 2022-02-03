#include "yandexdiskapi.hpp"

YandexDiskAPI::YandexDiskAPI(QNetworkAccessManager *networkManager, QObject *parent)
    : QObject{parent}
{
    this->networkManager = networkManager;
}

void YandexDiskAPI::publicMetainformationRequest()
{

}

void YandexDiskAPI::publicResouceDownload()
{

}

