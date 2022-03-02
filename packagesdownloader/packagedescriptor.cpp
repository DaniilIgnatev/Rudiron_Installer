#include "packagedescriptor.hpp"


PackageDescriptor::PackageDescriptor(QObject *parent): QObject(parent)
{
    this->_ID = "";
    this->_Type = "";
    this->Description = "";
    this->URL = "";
    this->Destination = "";
    this->Contents = QList<QString>();

    this->Completed = false;
    this->Percentage = 0;
    this->Error = false;
}

PackageDescriptor::PackageDescriptor(QString id, QString type, QString description, QString url, QString destination, QList<QString> contents, QObject *parent): QObject(parent)
{
    this->_ID = id;
    this->_Type = type;
    this->Description = description;
    this->URL = url;
    this->Destination = destination;
    this->Contents = contents;

    this->Completed = false;
    this->Percentage = 0;
    this->Error = false;
}


QString PackageDescriptor::ID(){
    return _ID;
}

void PackageDescriptor::setID(QString newValue){
    _ID = newValue;
    emit IDChanged();
}

QString PackageDescriptor::Type()
{
    return this->_Type;
}

void PackageDescriptor::setType(QString newValue)
{
    this->_Type = newValue;
    emit TypeChanged();
}
