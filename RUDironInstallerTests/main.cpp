#include <QTest>
#include "packagesdownloadertests.h"


int main(int argc, char *argv[])
{
    PackagesDownloaderTests packagesdownloader;
    QTest::qExec(&packagesdownloader,argc,argv);
    return 0;
}
