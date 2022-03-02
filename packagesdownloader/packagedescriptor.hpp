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

    explicit PackageDescriptor(QObject *parent = nullptr);


    explicit PackageDescriptor(QString id,
                               QString type,
                               QString description,
                               QString url,
                               QString destination,
                               QList<QString> contents,
                               QObject *parent = nullptr);

private:
    QString _ID;

public:
    Q_PROPERTY(QString ID READ ID WRITE setID NOTIFY IDChanged)
    QString ID();
    void setID(QString newValue);

private:
    QString _Type;

public:
    //тип пакета: приложение, установщик, архив, shell скрипт
    Q_PROPERTY(QString Type READ Type WRITE setType NOTIFY TypeChanged)
    QString Type();
    void setType(QString newValue);

    //описание
    Q_PROPERTY(QString Description MEMBER Description)
    QString Description;

    //ссылка для скачивания
    Q_PROPERTY(QString URL MEMBER URL)
    QString URL;

    //папка, куда будет перемещен пакет
    Q_PROPERTY(QString Destination MEMBER Destination)
    QString Destination;

    //содержимое пакета
    Q_PROPERTY(QList<QString> Contents MEMBER Contents)
    QList<QString> Contents;

    //прогресс получения содержимого пакета
    Q_PROPERTY(int Percentage MEMBER Percentage)
    int Percentage;

    //пакет готов
    Q_PROPERTY(bool Completed MEMBER Completed)
    bool Completed;

    //ошибка
    Q_PROPERTY(bool Error MEMBER Error)
    bool Error;

signals:
    void IDChanged();

    void TypeChanged();
};

#endif // PACKAGEDESCRIPTOR_HPP
