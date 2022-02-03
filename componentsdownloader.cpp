#include "componentsdownloader.hpp"

ComponentsDownloader* ComponentsDownloader::singleton = new ComponentsDownloader();


ComponentsDownloader::ComponentsDownloader(QObject *parent)
    : QObject{parent}
{
    this->yandexapi = WebAPI::instance()->getYandexDisk();
}

ComponentsDownloader *ComponentsDownloader::instance()
{
    return ComponentsDownloader::singleton;
}

QObject *ComponentsDownloader::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    return instance();
}

ComponentsDownloader::~ComponentsDownloader()
{
    delete this->components;
}

void ComponentsDownloader::loadSources()
{
    yandexapi->publicMetainformationRequest();
}

void ComponentsDownloader::download()
{

}

ComponentStatus ComponentsDownloader::currentComponentStatus()
{
    return components->at(current_component_id);
}
