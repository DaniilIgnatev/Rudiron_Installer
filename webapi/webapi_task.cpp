#include "webapi_task.h"

WebAPI_Task::WebAPI_Task(QString URL, QObject *parent)
    : QObject{parent}
{
    this->originalUrl = URL;
}

WebAPI_Task::~WebAPI_Task()
{
    if(reply != nullptr){
        reply->deleteLater();
        reply = nullptr;
    }
}

QNetworkReply& WebAPI_Task::getReply()
{
    return *reply;
}

void WebAPI_Task::setReply(QNetworkReply *newReply)
{
    if(reply != nullptr){
        reply->deleteLater();
        reply = nullptr;
    }
    reply = newReply;
    connect(reply, &QNetworkReply::redirected, this, &WebAPI_Task::reply_redirected);

    emit reply_changed(*reply);
}

void WebAPI_Task::reply_redirected(const QUrl &uri)
{
    Q_UNUSED(uri);
    emit reply->redirectAllowed();
}
