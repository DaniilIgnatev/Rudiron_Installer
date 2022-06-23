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

#ifndef WEBAPI_TASK_H
#define WEBAPI_TASK_H


#include <QObject>
#include <QtDebug>

#include <QNetworkRequest>
#include <QNetworkReply>

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>


class WebAPI_Task : public QObject
{
    Q_OBJECT
public:
    explicit WebAPI_Task(QString URL, QObject *parent = nullptr);

private:
    ~WebAPI_Task();
    QString originalUrl;
    QNetworkReply* reply = nullptr;
public:
    QNetworkReply& getReply();
    void setReply(QNetworkReply *newReply);
    QString fileName;

private slots:
    void reply_redirected(const QUrl &uri);

signals:
    void reply_changed(QNetworkReply &reply);

};

#endif // WEBAPI_TASK_H
