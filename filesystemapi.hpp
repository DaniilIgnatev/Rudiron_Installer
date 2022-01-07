#ifndef FILESYSTEMAPI_HPP
#define FILESYSTEMAPI_HPP

#include <QObject>
#include <QString>
#include <QFile>
#include <QUrl>

class FileSystemAPI : public QObject
{
    Q_OBJECT
public:
    explicit FileSystemAPI(QObject *parent = nullptr);

public slots:
    QString getFileContent(QString path);
};

#endif // FILESYSTEMAPI_HPP
