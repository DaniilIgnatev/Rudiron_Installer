#include "testsmedaitor.h"

TestsMedaitor::TestsMedaitor(QObject *parent)
    : QObject{parent}
{

}

void TestsMedaitor::runTests(){
    PackagesDownloaderTests packagesDownloaderTests;
    QTest::qExec(&packagesDownloaderTests);
    ZipTests ziptests;
    QTest::qExec(&ziptests);
}

void TestsMedaitor::planTests(){
    this->testsTimer = new QTimer(this);
    this->testsTimer->setSingleShot(true);
    this->testsTimer->setInterval(100);
    this->connect(testsTimer, &QTimer::timeout, this, [=] {
        this->runTests();
    });
    this->testsTimer->start();
}
