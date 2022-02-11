#include "webapi.hpp"



WebAPI::WebAPI(QObject *parent)
    : QObject{parent}
{

}

WebAPI *WebAPI::instance()
{
    static WebAPI webapi;

    return &webapi;
}

YandexDiskAPI *WebAPI::getYandexDisk() const
{
    return yandexDisk;
}
