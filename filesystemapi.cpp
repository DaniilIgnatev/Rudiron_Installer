#include "filesystemapi.hpp"

FileSystemAPI::FileSystemAPI(QObject *parent)
    : QObject{parent}
{

}

QString FileSystemAPI::getFileContent(QString path)
{
    QString result = "";

    QFile *f = new QFile(path);
    f->open(QIODevice::ReadOnly);
    if (f->exists()){
        result = QString(f->readAll());
    }
    f->close();

    return result;
}
