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

    this->_bytesReceived = 0;
    this->_bytesTotal = 0;
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

    this->_bytesReceived = 0;
    this->_bytesTotal = 0;
}


QString PackageDescriptor::getID(){
    return _ID;
}

void PackageDescriptor::setID(QString newValue){
    _ID = newValue;
    emit IDChanged();
}

bool PackageDescriptor::getSkipDownload()
{
    return _skipDownload;
}

void PackageDescriptor::setSkipDownload(bool newValue)
{
    this->_skipDownload = newValue;
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

QString PackageDescriptor::getDestination()
{
    return this->Destination;
}

int PackageDescriptor::getPercentage()
{
    return _percentage;
}

void PackageDescriptor::setPercentage(int newValue)
{
    _percentage = newValue;
    emit percentageChanged(newValue);
}

QString PackageDescriptor::getURI()
{
    return this->URL.split("/").last();
}

QString PackageDescriptor::getInstallerName()
{
    return this->Contents.first();
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

int PackageDescriptor::getBytesReceived()
{
    return _bytesReceived;
}

void PackageDescriptor::setBytesReceived(int newValue)
{
    _bytesReceived = newValue;
    emit bytesReceivedChanged(newValue);
}

int PackageDescriptor::getBytesTotal()
{
    return _bytesTotal;
}

void PackageDescriptor::setBytesTotal(int newValue)
{
    _bytesTotal = newValue;
    emit bytesTotalChanged(newValue);
}
