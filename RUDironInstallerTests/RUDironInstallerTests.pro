QT -= gui
QT += testlib
QT += network

CONFIG += c++11 console
QT += widgets
CONFIG -= app_bundle

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        ../distributive.cpp \
        ../filesystemapi.cpp \
        ../packagesdownloader/packagesdownloader.cpp \
        ../webapi/webapi.cpp \
        ../webapi/webapi_task.cpp \
        ../webapi/yandexdiskapi.cpp \
        main.cpp \
        packagesdownloadertests.cpp \
        testsmedaitor.cpp

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    ../distributive.h \
    ../filesystemapi.hpp \
    ../packagesdownloader/packagesdownloader.hpp \
    ../webapi/webapi.hpp \
    ../webapi/webapi_task.h \
    ../webapi/yandexdiskapi.hpp \
    packagesdownloadertests.h \
    testsmedaitor.h
