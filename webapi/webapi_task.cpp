/*
Copyright (C) THEDATE Ignatev Daniil
This file is part of RudironInstaller <https://github.com/>.

RudironInstaller is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

RudironInstaller is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with RudironInstaller. If not, see <http://www.gnu.org/licenses/>.
*/

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
