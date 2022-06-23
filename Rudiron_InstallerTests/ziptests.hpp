#ifndef ZIPTESTS_HPP
#define ZIPTESTS_HPP

#include <QObject>
#include <QSignalSpy>
#include <QtTest>
#include "JlCompress.h"

class ZipTests : public QObject
{
    Q_OBJECT
public:
    explicit ZipTests(QObject *parent = nullptr);

private slots:
    void testUnzip();

};

#endif // ZIPTESTS_HPP
