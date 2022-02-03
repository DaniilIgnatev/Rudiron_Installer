#ifndef COMPONENTSDOWNLOADER_H
#define COMPONENTSDOWNLOADER_H

#include <QObject>

class QQmlEngine;
class QJSEngine;


class ComponentsDownloader : public QObject
{
    Q_OBJECT

private:
    static ComponentsDownloader* singleton;

    explicit ComponentsDownloader(QObject *parent = nullptr);

public:

    static ComponentsDownloader* instance();

    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
signals:

};

#endif // COMPONENTSDOWNLOADER_H
