#include "ziptests.hpp"

ZipTests::ZipTests(QObject *parent)
    : QObject{parent}
{

}

void ZipTests::testUnzip()
{
    QString filePath = "D:/cmake.zip";
//    QuaZip qua(filePath);
//    qua.open(QuaZip::mdUnzip);
    JlCompress::extractDir(filePath);
//    qua.close();
}
