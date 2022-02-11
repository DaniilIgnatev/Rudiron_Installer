#include "packagesdownloader.hpp"

PackagesDownloader* PackagesDownloader::singleton = new PackagesDownloader();


PackagesDownloader::PackagesDownloader(QObject *parent)
    : QObject{parent}
{
    this->yandexapi = WebAPI::instance()->getYandexDisk();
}

PackagesDownloader *PackagesDownloader::instance()
{
    return PackagesDownloader::singleton;
}

QObject *PackagesDownloader::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    return instance();
}

PackagesDownloader::~PackagesDownloader()
{
    delete this->components;
}

void PackagesDownloader::loadSources()
{
    auto reply = yandexapi->publicMetainformationRequest("https://disk.yandex.ru/d/nh4bE3Rcb59D9w");
    connect(reply, &QNetworkReply::finished, this, [=]() {
        QByteArray metadata_data = reply->readAll();
        QJsonDocument metadataJson = QJsonDocument::fromJson(metadata_data);
        QJsonObject metadata = metadataJson.object();

        QString architecture = QSysInfo::buildCpuArchitecture();
        QString os_type = QSysInfo::kernelType();

        if (os_type == "winnt"){
            this->sourcesURI = metadata["win_x64"].toString();
        }
        else if (os_type == "darwin"){
            this->sourcesURI = metadata["macOS_x64"].toString();
        }
        else{
            if (architecture == "arm64"){
                this->sourcesURI = metadata["linux_arm64"].toString();
            }
            else{
                this->sourcesURI = metadata["linux_x64"].toString();
            }
        }
    }
    );
}

void PackagesDownloader::download()
{

}

ComponentDescriptor PackagesDownloader::currentComponentStatus()
{
    return components->at(current_component_id);
}
