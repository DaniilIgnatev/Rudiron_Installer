#include "packagesdownloadertests.h"

PackagesDownloaderTests::PackagesDownloaderTests(QObject *parent)
    : QObject{parent}
{

}

void PackagesDownloaderTests::fetchSources()
{
    QSignalSpy spy(packagerDownloader, &PackagesDownloader::sourceFetched);
    packagerDownloader->fetchSource();
    spy.wait();

    QString sourceURL = packagerDownloader->getSources_url();
    QVERIFY(sourceURL != "");
    QString sourcePlatform = packagerDownloader->getSources_platform();
    QVERIFY(sourcePlatform != "");
}

void PackagesDownloaderTests::testFetchPackages()
{
    return;
    fetchSources();
    QSignalSpy spy(packagerDownloader, &PackagesDownloader::packagesFetched);
    packagerDownloader->fetchPackages();
    spy.wait();

    QStringList exclude;
    const QList<PackageDescriptor> *packages = packagerDownloader->getPackages();
    for(const PackageDescriptor &package:*packages){
        QVERIFY(package.getID() != "");
        QVERIFY(package.getType() != "");
        QVERIFY(package.getDescription() != "");
        QVERIFY(package.getURL != "");
        QVERIFY(package.Destination != "");
        QVERIFY(!package.Contents.empty());
        QVERIFY(package.Percentage == 0);
        QVERIFY(package.Completed == false);
    }
}

void PackagesDownloaderTests::testDownloadPackage()
{
    return;
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
    spy.wait(100000);
}
