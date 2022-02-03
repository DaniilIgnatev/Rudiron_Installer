#include "componentsdownloader.hpp"

ComponentsDownloader* ComponentsDownloader::singleton = new ComponentsDownloader();


ComponentsDownloader::ComponentsDownloader(QObject *parent)
    : QObject{parent}
{

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
