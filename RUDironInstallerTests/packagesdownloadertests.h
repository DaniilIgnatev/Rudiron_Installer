#ifndef PACKAGESDOWNLOADERTESTS_H
#define PACKAGESDOWNLOADERTESTS_H

#include <QObject>
#include <QSignalSpy>
#include <QtTest>
#include "../packagesdownloader/packagesdownloader.hpp"


class PackagesDownloaderTests : public QObject
{
    Q_OBJECT
public:
    PackagesDownloader* packagerDownloader = new PackagesDownloader();

    explicit PackagesDownloaderTests(QObject *parent = nullptr);

private slots:
    void fetchSources();

    void testFetchPackages();

    void testDownloadPackage();
};

#endif // PACKAGESDOWNLOADERTESTS_H
