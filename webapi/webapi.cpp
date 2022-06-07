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
