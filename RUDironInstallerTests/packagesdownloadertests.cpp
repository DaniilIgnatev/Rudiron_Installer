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
        QVERIFY(package.description != "");
        QVERIFY(package.url != "");
        QVERIFY(package.destination != "");
        QVERIFY(!package.contents.empty());
        QVERIFY(package.percentage == 0);
        QVERIFY(package.completed == false);
    }
}
