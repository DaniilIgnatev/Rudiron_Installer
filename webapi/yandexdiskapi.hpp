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

#ifndef YANDEXDISKAPI_H
#define YANDEXDISKAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

#include "webapi_task.h"


class YandexDiskAPI: QObject
{
    Q_OBJECT
private:

    QNetworkAccessManager *networkManager;

    QNetworkReply* publicMetainformationRequest(QString resourceURL);

    QNetworkReply* publicResourceDownloadInfo(QString resourceKey);

public:

    YandexDiskAPI(QNetworkAccessManager *networkManager, QObject *parent = nullptr);

    WebAPI_Task* downloadPublicResource(QString resourceURL);

};

#endif // YANDEXDISKAPI_H
