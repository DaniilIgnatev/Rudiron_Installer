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

#include "packagesdownloader.hpp"


PackagesDownloader::PackagesDownloader(QObject *parent)
    : QObject{parent}
{
    this->yandexapi = WebAPI::instance()->getYandexDiskClient();
}

PackagesDownloader::~PackagesDownloader()
{

}

PackagesDownloader *PackagesDownloader::instance()
{
    static PackagesDownloader singleton;
    return &singleton;
}

QObject *PackagesDownloader::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    return instance();
}

void PackagesDownloader::fetchSource()
{
    QNetworkReply* reply = WebAPI::instance()->request(QUrl("http://95.104.194.120:25564/sources.json"));
    connect(reply, &QNetworkReply::finished, this, [=]{
        QString json_string = reply->readAll();
        parseSources(json_string);
        emit sourceFetched();
    });
}

void PackagesDownloader::parseSources(QString json_string)
{
    auto json_document = QJsonDocument::fromJson(json_string.toUtf8());
    auto json_object = json_document.object();

    QString architecture = QSysInfo::buildCpuArchitecture();
    QString os_type = QSysInfo::kernelType();

    QString sourceURL;

    if (os_type == "winnt"){
        sources_platform = "win_x64";
        sourceURL = json_object[sources_platform].toString();
    }
    else if (os_type == "darwin"){
        sources_platform = "macOS_x64";
        sourceURL = json_object[sources_platform].toString();
    }
    else{
        if (architecture == "arm64"){
            sources_platform = "linux_arm64";
            sourceURL = json_object[sources_platform].toString();
        }
        else{
            sources_platform = "linux_x64";
            sourceURL = json_object[sources_platform].toString();
        }
    }

    this->sources_url = sourceURL;
}

const QString PackagesDownloader::getSources_url()
{
    return sources_url;
}

const QString PackagesDownloader::getSources_platform()
{
    return sources_platform;
}

void PackagesDownloader::fetchPackages()
{
    QNetworkReply* reply = WebAPI::instance()->request(QUrl(this->sources_url));
    connect(reply, &QNetworkReply::finished, this, [=]{
        QString json_string = reply->readAll();
        parsePackages(json_string);
        emit packagesFetched();
    });
}

void PackagesDownloader::parsePackages(QString json_string)
{
    if (json_string == ""){
        emit errorFetching("Пакеты по указанному URL" + this->sources_url + " не найдены");
        return;
    }
    const QJsonObject packagesObject = QJsonDocument::fromJson(json_string.toUtf8()).object();

    QString fetchedPlatform = packagesObject["platform"].toString();
    if (this->sources_platform != fetchedPlatform){
        emit errorFetching("Целевая платформы " + this->sources_platform + " и " + fetchedPlatform + " не совпадают");
        return;
    }

    const QJsonArray packagesArray = packagesObject["packages"].toArray();
    this->packages.clear();

    for(const auto &package:packagesArray){
        auto package_object = package.toObject();
        const auto contents_array = package_object["contents"].toArray();
        QList<QString> contents;
        for (const auto &c:contents_array){
            contents.append(c.toString());
        }

        PackageDescriptor* descriptor = new PackageDescriptor(
                    package_object["id"].toString(),
                package_object["type"].toString(),
                package_object["description"].toString(),
                package_object["url"].toString(),
                package_object["destination"].toString(),
                contents,
                this
                );
        this->packages.append(descriptor);
    }
}


PackageDescriptorModel* PackagesDownloader::getPackages(QStringList excludeID)
{
    QList<PackageDescriptor*> filtredPackages;

    for (int i = 0; i < packages.count();i++){
        if (!excludeID.contains(packages[i]->getID())){
            filtredPackages.append(packages[i]);
        }
    }

    return new PackageDescriptorModel(filtredPackages, this);
}

PackageDescriptor *PackagesDownloader::getPackage(QString ID)
{
    for (int i = 0; i < packages.count();i++){
        if (packages[i]->getID() == ID){
            return packages[i];
        }
    }

    return nullptr;
}

QStringList PackagesDownloader::getFiltredPackagesIDs(QStringList excludeID)
{
    QStringList filtredPackageIDs;

    for (int i = 0; i < packages.count();i++){
        if (!excludeID.contains(packages[i]->getID())){
            filtredPackageIDs.append(packages[i]->getID());
        }
    }

    return filtredPackageIDs;
}

void PackagesDownloader::packageError(PackageDescriptor *descriptor, QString description)
{
    descriptor->setErrorDescription(description);
    descriptor->setError(true);
    emit packageDownloadError(descriptor, description);
}

void PackagesDownloader::downloadPackage(PackageDescriptor* descriptor)
{    
    if (descriptor->getType() == PackageDescriptor::type_script){
        descriptor->setCompleted(true);
        descriptor->setPercentage(100);
        emit packageDownloadFinished(descriptor);
    }
    else{
        QString resourceName = descriptor->getURI();
        QString destination_folder;
        QString destination_path;//путь сохранения файла
        if (descriptor->getType() != PackageDescriptor::type_application){
            destination_folder = Distributive::absoluteComponentPath(descriptor->Destination);
            destination_path = destination_folder  + "/" + resourceName;//добавить имя файла в дескрипторе
        }
        else{
            destination_folder = descriptor->Destination;
            destination_path = destination_folder + "/" + resourceName;
        }

        destination_path = QDir::toNativeSeparators(destination_path);
        destination_folder = QDir::toNativeSeparators(destination_folder);

        qDebug() << "destination_folder: " << destination_folder;
        qDebug() << "destination_path: " << destination_path;

        bool folder_exists = QFile::exists(destination_folder);
        if (!folder_exists){
            packageError(descriptor, "Директория '" + destination_folder + "' не существует");
        }
        else{
            bool contents_exist = true;
            for (const QString& content : qAsConst(descriptor->Contents)){
                QString content_path = destination_folder + "/" + content;
                contents_exist = contents_exist && QFile::exists(content_path);
            }

            if (contents_exist){
                descriptor->setCompleted(true);
                descriptor->setPercentage(100);
                emit packageDownloadFinished(descriptor);
            }
            else{
                QTemporaryFile* tempFile = new QTemporaryFile();
                tempFile->setAutoRemove(true);

                bool tempFileOpened = tempFile->open();
                if (!tempFileOpened){
                    packageError(descriptor, "Не удалось создать временный файл");
                }

                QString tempFileName = tempFile->fileName();
                QFile* tempFileDescriptor = new QFile(tempFileName);
                tempFileDescriptor->open(QIODevice::WriteOnly);

                QNetworkReply* reply = WebAPI::instance()->request(descriptor->URL);

                connect(reply, &QNetworkReply::readyRead, this, [=]{
                    tempFileDescriptor->write(reply->readAll());
                 });

                connect(reply, &QNetworkReply::downloadProgress, this, [=](quint64 bytesReceived, quint64 bytesTotal){
                    int percentage = (double)bytesReceived / (double)bytesTotal * 100.0;
                    qDebug() << "Download " + descriptor->getID() + " progress: " << percentage << "% " << bytesReceived << " of " << bytesTotal << " bytes";
                    descriptor->setPercentage(percentage);
                    descriptor->setBytesReceived(bytesReceived / 1024 / 1024);
                    descriptor->setBytesTotal(bytesTotal / 1024 / 1024);
                });

                connect(reply, &QNetworkReply::finished, this, [=]{
                    tempFile->close();
                    tempFileDescriptor->close();
                    qDebug() << "Copy " << tempFileName << " to " << destination_path;
                    QFile::copy(tempFile->fileName(), destination_path);
                    tempFile->deleteLater();
                    tempFileDescriptor->deleteLater();

                    if (descriptor->getType() == PackageDescriptor::type_archive){
                        JlCompress::extractDir(destination_path, destination_folder);
                        QFile::remove(destination_path);
                    }

                    descriptor->setCompleted(true);
                    descriptor->setPercentage(100);
                    emit packageDownloadFinished(descriptor);
                    reply->deleteLater();
                });
            }
        }
    }
}

