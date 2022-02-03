#include "webapi.hpp"



WebAPI* WebAPI::singleton = new WebAPI();


WebAPI::WebAPI(QObject *parent)
    : QObject{parent}
{

}

WebAPI *WebAPI::instance()
{
    return WebAPI::singleton;
}

YandexDiskAPI *WebAPI::getYandexDisk() const
{
    return yandexDisk;
}
