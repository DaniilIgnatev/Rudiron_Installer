#ifndef TESTSMEDAITOR_H
#define TESTSMEDAITOR_H

#include <QObject>
#include <QTest>
#include <QTimer>
#include "packagesdownloadertests.h"

class TestsMedaitor : public QObject
{
    Q_OBJECT
public:
    explicit TestsMedaitor(QObject *parent = nullptr);
private:
    QTimer* testsTimer;
    void runTests();
public:
    void planTests();
};

#endif // TESTSMEDAITOR_H
