#ifndef PACKAGESDOWNLOADERTESTS_H
#define PACKAGESDOWNLOADERTESTS_H

#include <QObject>

class PackagesDownloaderTests : public QObject
{
    Q_OBJECT
public:
    explicit PackagesDownloaderTests(QObject *parent = nullptr);

private slots:
    void test();
};

#endif // PACKAGESDOWNLOADERTESTS_H
