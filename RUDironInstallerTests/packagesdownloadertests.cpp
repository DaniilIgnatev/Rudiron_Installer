#include "packagesdownloadertests.h"

PackagesDownloaderTests::PackagesDownloaderTests(QObject *parent)
    : QObject{parent}
{

}

void PackagesDownloaderTests::fetchSources()
{
    QSignalSpy spy(packagerDownloader, &PackagesDownloader::sourceFetched);
    packagerDownloader->fetchSource();
    spy.wait(999);

    QString sourceURL = packagerDownloader->getSources_url();
    QVERIFY(sourceURL != "");
    QString sourcePlatform = packagerDownloader->getSources_platform();
    QVERIFY(sourcePlatform != "");
}

void PackagesDownloaderTests::testFetchPackages()
{
    fetchSources();
    QSignalSpy spy(packagerDownloader, &PackagesDownloader::packagesFetched);
    packagerDownloader->fetchPackages();
    spy.wait(999);

    const QList<PackageDescriptor> *packages = packagerDownloader->getPackages();
    for(const PackageDescriptor &package:*packages){
        QVERIFY(package.id != "");
        QVERIFY(package.type != "");
        QVERIFY(package.description != "");
        QVERIFY(package.url != "");
        QVERIFY(package.destination != "");
        QVERIFY(!package.contents.empty());
        QVERIFY(package.percentage == 0);
        QVERIFY(package.completed == false);
    }
}

void PackagesDownloaderTests::testDownloadPackage()
{
    PackageDescriptor descriptor{
        "cmake",//QString id;
        "archive",//QString type;
        "Система автматизации сборки CMake",//QString description;
        "https://disk.yandex.ru/d/ItNlaKchne2dBA",//QString url;
        "../components/",//QString destination;
        QList<QString>{"cmake"},//QList<QString> contents;
        0,//int percentage;
        false,//bool completed;
    };

    QSignalSpy spy(packagerDownloader, &PackagesDownloader::packageDownloadFinished);
    packagerDownloader->downloadPackage(descriptor);

}
