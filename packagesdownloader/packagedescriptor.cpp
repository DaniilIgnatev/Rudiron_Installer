#include "packagedescriptor.hpp"


PackageDescriptor::PackageDescriptor(QString id, QString type, QString description, QString url, QString destination, QList<QString> contents, QObject *parent): QObject(parent)
{
    this->id = id;
    this->type = type;
    this->description = description;
    this->url = url;
    this->destination = destination;
    this->contents = contents;

    this->completed = false;
    this->percentage = 0;
    this->error = false;
}
