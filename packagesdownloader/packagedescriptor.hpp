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

    static const QString package_id_cmake;
    static const QString package_id_openocd;
    static const QString package_id_gcc;
    static const QString package_id_jlink;
    static const QString package_id_qt;
    static const QString package_id_vscode;

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
    Q_PROPERTY(QString ID READ getID WRITE setID NOTIFY IDChanged)
    QString getID();
    void setID(QString newValue);

private:
    QString _type;

public:
    ///тип пакета: приложение, установщик, архив, shell скрипт
    Q_PROPERTY(QString type READ getType WRITE setType NOTIFY typeChanged)
    QString getType();
    void setType(QString newValue);

private:
    QString _description;

public:
    ///описание пакета
    Q_PROPERTY(QString description READ getDescription WRITE setDescription NOTIFY descriptionChanged)
    QString getDescription();
    void setDescription(QString newValue);

public:
    ///ссылка для скачивания
    QString URL;

    ///папка, куда будет перемещен пакет
    QString Destination;

    ///содержимое пакета
    QList<QString> Contents;

private:
    int _percentage;

public:
    ///прогресс получения содержимого пакета
    Q_PROPERTY(int percentage READ getPercentage WRITE setPercentage NOTIFY percentageChanged)
    bool getPercentage();
    void setPercentage(int newValue);

private:
    bool _completed;

public:
    ///пакет готов
    Q_PROPERTY(bool completed READ getCompleted WRITE setCompleted NOTIFY completedChanged)
    bool getCompleted();
    void setCompleted(bool newValue);

private:
    bool _error;

public:
    ///Ошибка
    Q_PROPERTY(bool error READ getError WRITE setError NOTIFY errorChanged)
    bool getError();
    void setError(bool newValue);

private:
    QString _errorDescription;

public:
    ///Описание ошибки
    Q_PROPERTY(QString errorDescription READ getErrorDescription WRITE setErrorDescription NOTIFY errorDescriptionChanged)
    QString getErrorDescription();
    void setErrorDescription(QString newValue);

signals:
    void IDChanged();

    void typeChanged();

    void descriptionChanged();

    void percentageChanged(int value);

    void completedChanged(bool value);

    void errorChanged(bool value);

    void errorDescriptionChanged(QString value);
};

#endif // PACKAGEDESCRIPTOR_HPP
