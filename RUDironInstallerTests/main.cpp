#include "testsmedaitor.h"



int main(int argc, char *argv[]) {
    QApplication a( argc, argv );
    TestsMedaitor tests;
    tests.planTests();
    return a.exec();
}

