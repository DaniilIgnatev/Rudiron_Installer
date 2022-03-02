#ifndef PACKAGEDESCRIPTOR_HPP
#define PACKAGEDESCRIPTOR_HPP

#include <QObject>

class PackageDescriptor : public QObject
{
    Q_OBJECT
public:
    static const QString type_application;
    static const QString type_installer;
    static const QString type_archive;
    static const QString type_script;

    explicit PackageDescriptor(QString id,
                               QString type,
                               QString description,
                               QString url,
                               QString destination,
                               QList<QString> contents,
                               QObject *parent = nullptr);

    Q_PROPERTY(QString id MEMBER id)
    QString id;

    //тип пакета: приложение, установщик, архив, shell скрипт
    Q_PROPERTY(QString type MEMBER type)
    QString type;

    //описание
    Q_PROPERTY(QString description MEMBER description)
    QString description;

    //ссылка для скачивания
    Q_PROPERTY(QString url MEMBER url)
    QString url;

    //папка, куда будет перемещен пакет
    Q_PROPERTY(QString destination MEMBER destination)
    QString destination;

    //содержимое пакета
    Q_PROPERTY(QList<QString> contents MEMBER contents)
    QList<QString> contents;

    //прогресс получения содержимого пакета
    Q_PROPERTY(int percentage MEMBER percentage)
    int percentage;

    //пакет готов
    Q_PROPERTY(bool completed MEMBER completed)
    bool completed;

    //ошибка
    Q_PROPERTY(bool error MEMBER error)
    bool error;

signals:

};

#endif // PACKAGEDESCRIPTOR_HPP
