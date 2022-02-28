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
