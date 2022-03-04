#include "packagedescriptor.hpp"


const QString PackageDescriptor::type_application = "application";
const QString PackageDescriptor::type_installer = "installer";
const QString PackageDescriptor::type_archive = "archive";
const QString PackageDescriptor::type_script = "script";


const QString PackageDescriptor::package_id_cmake = "cmake";
const QString PackageDescriptor::package_id_openocd = "openocd";
const QString PackageDescriptor::package_id_gcc = "gcc";
const QString PackageDescriptor::package_id_jlink = "jlink";
const QString PackageDescriptor::package_id_qt = "qt";
const QString PackageDescriptor::package_id_vscode = "vscode";


PackageDescriptor::PackageDescriptor(QObject *parent): QObject(parent)
{
    this->_ID = "";
    this->_type = "";
    this->_description = "";
    this->URL = "";
    this->Destination = "";
    this->Contents = QList<QString>();

    this->_completed = false;
    this->_percentage = 0;
    this->_error = false;
    this->_errorDescription = "";
}

PackageDescriptor::PackageDescriptor(QString id, QString type, QString description, QString url, QString destination, QList<QString> contents, QObject *parent): QObject(parent)
{
    this->_ID = id;
    this->_type = type;
    this->_description = description;
    this->URL = url;
    this->Destination = destination;
    this->Contents = contents;

    this->_completed = false;
    this->_percentage = 0;
    this->_error = false;
    this->_errorDescription = "";
}


QString PackageDescriptor::getID(){
    return _ID;
}

void PackageDescriptor::setID(QString newValue){
    _ID = newValue;
    emit IDChanged();
}

QString PackageDescriptor::getType()
{
    return this->_type;
}

void PackageDescriptor::setType(QString newValue)
{
    this->_type = newValue;
    emit typeChanged();
}

QString PackageDescriptor::getDescription()
{
   return _description;
}

void PackageDescriptor::setDescription(QString newValue)
{
    _description = newValue;
    emit descriptionChanged();
}

double PackageDescriptor::getPercentage()
{
    return _percentage;
}

void PackageDescriptor::setPercentage(double newValue)
{
    _percentage = newValue;
    emit percentageChanged(newValue);
}

bool PackageDescriptor::getCompleted()
{
    return _completed;
}

void PackageDescriptor::setCompleted(bool newValue)
{
    _completed = newValue;
    emit completedChanged(newValue);
}

bool PackageDescriptor::getError()
{
    return _error;
}

void PackageDescriptor::setError(bool newValue)
{
    _error = newValue;
    emit errorChanged(newValue);
}

QString PackageDescriptor::getErrorDescription()
{
    return _errorDescription;
}

void PackageDescriptor::setErrorDescription(QString newValue)
{
    _errorDescription = newValue;
    emit errorDescriptionChanged(newValue);
}
