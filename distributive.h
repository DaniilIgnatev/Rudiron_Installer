#ifndef DISTRIBUTIVE_H
#define DISTRIBUTIVE_H

#include <QObject>
#include <QDir>
#include <QFile>
#include <QFileInfo>



class Distributive : public QObject
{
public:


    explicit Distributive(QObject *parent = nullptr);


    //DIBOT

    static const QString dibotDirPath;


    static QDir dibotDir();



    //DEBUG

    static const QString debugPath;



    //SVD

    static const QString svdFilePath;



    //SOFT

    static const QString softDirPath;


    static QDir softDir();



    //QT_Creator_installer

    static const QString qtCreatorInstallerPath;



    //DRIVER

    static const QString jlinkBinPath;


    static const QString zadigBinPath;


    //GCC

    static const QString gccDirPath;


    static QDir gccDir();


    static const QString gccBinDirPath;


    static QDir gccBinDir();



    //OPENOCD

    static const QString openocdDirPath;


    static QDir openocdDir();


    static const QString openocd_binDirPath;


    static QDir openocd_binDir();


    static const QString openocd_binFilePath;


    static const QString openocd_scriptsDirPath;


    static QDir openocd_scriptsDir();


    static const QString openocd_interfaceDirPath;


    static QDir openocd_interfaceDir();


    static const QString openocd_interfaceFilePath;



    //PATH

    static const QString pathValueFilePath;


    static QFile* pathValueFile();



    //CMAKE

    static const QString cmakeBinPath;


    static const QString cmakeQchPath;



    //PYTHON

    static const QString pythonStandartFolderPath;


    static const QString pythonStandartBinPath;


    static QDir pythonStandartFolderDir();


    static const QString pythonInstallerPath;



    //GDB

    static const QString gdbBinPath;


    //TOOLCHAIN

    static const QString gccBinPath;


    static const QString gppBinPath;

};

#endif // DISTRIBUTIVE_H
