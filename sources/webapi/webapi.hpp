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

#ifndef WEBAPIHPP_H
#define WEBAPIHPP_H

#include <QObject>
#include <QNetworkAccessManager>
#include "webapi_task.h"

#include "yandexdiskapi.hpp"

class QQmlEngine;
class QJSEngine;

class WebAPI : public QObject
{
    Q_OBJECT
private:

    explicit WebAPI(QObject *parent = nullptr);

    QNetworkAccessManager *networkManager = new QNetworkAccessManager(this);

    YandexDiskAPI *yandexDisk = new YandexDiskAPI(networkManager, this);

public:

    static WebAPI *instance();

    QNetworkReply* request(const QUrl &uri);

    YandexDiskAPI* getYandexDiskClient() const;

public slots:

};


#endif // WEBAPIHPP_H
