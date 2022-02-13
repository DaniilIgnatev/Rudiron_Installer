#include "packagesdownloader.hpp"


const QString PackageDescriptor::type_application = "application";
const QString PackageDescriptor::type_installer = "installer";
const QString PackageDescriptor::type_archive = "archive";
const QString PackageDescriptor::type_script = "script";


PackagesDownloader::PackagesDownloader(QObject *parent)
    : QObject{parent}
{
    this->yandexapi = WebAPI::instance()->getYandexDisk();
}

PackagesDownloader::~PackagesDownloader()
{
    delete this->packages;
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
    WebAPI_Task* task = yandexapi->downloadPublicResource("https://disk.yandex.ru/d/nh4bE3Rcb59D9w");
    connect(task, &WebAPI_Task::reply_changed, this, [=](QNetworkReply &reply){
        connect(&reply, &QNetworkReply::finished, this, [=,&reply]{
            QString json_string = reply.readAll();
            parseSources(json_string);
            emit sourceFetched();
            task->deleteLater();
        });
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

const QString &PackagesDownloader::getSources_url() const
{
    return sources_url;
}

const QString &PackagesDownloader::getSources_platform() const
{
    return sources_platform;
}

void PackagesDownloader::fetchPackages()
{
    WebAPI_Task* task = yandexapi->downloadPublicResource(this->sources_url);
    connect(task, &WebAPI_Task::reply_changed, this, [=](QNetworkReply &reply){
        connect(&reply, &QNetworkReply::finished, this, [=,&reply]{
            QString json_string = reply.readAll();
            parsePackages(json_string);
            emit packagesFetched();
            task->deleteLater();
        });
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
    this->packages->clear();

    for(const auto &package:packagesArray){
        auto package_object = package.toObject();
        const auto contents_array = package_object["contents"].toArray();
        QList<QString> contents;
        for (const auto &c:contents_array){
            contents.append(c.toString());
        }

        PackageDescriptor descriptor{
            package_object["id"].toString(),
                    package_object["type"].toString(),
                    package_object["description"].toString(),
                    package_object["url"].toString(),
                    package_object["destination"].toString(),
                    contents,
                    0,
                    false
        };
        this->packages->append(descriptor);
    }
}


QList<PackageDescriptor> *PackagesDownloader::getPackages() const
{
    return packages;
}

void PackagesDownloader::downloadPackage(PackageDescriptor &descriptor)
{    
    if (descriptor.type == PackageDescriptor::type_script){
        descriptor.completed = true;
        descriptor.percentage = 100;
        emit packageDownloadFinished(descriptor);
    }
    else{
        WebAPI_Task* task = yandexapi->downloadPublicResource(descriptor.url);
        connect(task, &WebAPI_Task::reply_changed, this, [=,&descriptor](QNetworkReply &reply){
            QString destination_path;
            if (descriptor.type != PackageDescriptor::type_application){
                destination_path = Distributive::absoluteComponentPath(descriptor.destination) + "/" + task->name;
            }
            else{
                destination_path = descriptor.destination;
            }
            qDebug() << "destination_path: " << destination_path;

            connect(&reply, &QNetworkReply::readyRead, this, [=,&reply,&descriptor]{
                 //qDebug("Ready read");
                 //создать файл
             });
             connect(&reply, &QNetworkReply::downloadProgress, this, [=,&descriptor](quint64 bytesReceived, quint64 bytesTotal){
                 int percentage = bytesReceived / bytesTotal;
                 qDebug() << "Download progress: " << bytesReceived << "bytes of " << bytesTotal << " bytes";
                 descriptor.percentage = percentage;
             });
            connect(&reply, &QNetworkReply::finished, this, [=,&reply,&descriptor]{
                QByteArray data = reply.readAll();

                if (descriptor.type == PackageDescriptor::type_archive){
                    //сохранить на диск скаченный файл
                    QFile file(destination_path);
                    file.open(QIODevice::WriteOnly);
                    file.write(data);
                    file.close();
                    //распаковать архив

                    //удалить архив
                }
                else{
                    //переименовать
                }

                descriptor.completed = true;
                descriptor.percentage = 100;
                emit packageDownloadFinished(descriptor);
                task->deleteLater();
            });
        });
    }
}

