QT -= gui
QT += testlib
QT += network

DEFINES += QUAZIP_STATIC

CONFIG += c++11 console
QT += widgets
CONFIG -= app_bundle

INCLUDEPATH += "../zlib-1.2.11"
INCLUDEPATH += "../quazip-0.7.3"

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        ../distributive.cpp \
        ../filesystemapi.cpp \
        ../packagesdownloader/packagesdownloader.cpp \
        ../quazip-0.7.3/JlCompress.cpp \
        ../quazip-0.7.3/qioapi.cpp \
        ../quazip-0.7.3/quaadler32.cpp \
        ../quazip-0.7.3/quacrc32.cpp \
        ../quazip-0.7.3/quagzipfile.cpp \
        ../quazip-0.7.3/quaziodevice.cpp \
        ../quazip-0.7.3/quazip.cpp \
        ../quazip-0.7.3/quazipdir.cpp \
        ../quazip-0.7.3/quazipfile.cpp \
        ../quazip-0.7.3/quazipfileinfo.cpp \
        ../quazip-0.7.3/quazipnewinfo.cpp \
        ../quazip-0.7.3/unzip.c \
        ../quazip-0.7.3/zip.c \
        ../zlib-1.2.11/adler32.c \
        ../zlib-1.2.11/compress.c \
        ../zlib-1.2.11/crc32.c \
        ../zlib-1.2.11/deflate.c \
        ../zlib-1.2.11/gzclose.c \
        ../zlib-1.2.11/gzlib.c \
        ../zlib-1.2.11/gzread.c \
        ../zlib-1.2.11/gzwrite.c \
        ../zlib-1.2.11/infback.c \
        ../zlib-1.2.11/inffast.c \
        ../zlib-1.2.11/inflate.c \
        ../zlib-1.2.11/inftrees.c \
        ../zlib-1.2.11/trees.c \
        ../zlib-1.2.11/uncompr.c \
        ../zlib-1.2.11/zutil.c \
        ../webapi/webapi.cpp \
        ../webapi/webapi_task.cpp \
        ../webapi/yandexdiskapi.cpp \
        main.cpp \
        packagesdownloadertests.cpp \
        testsmedaitor.cpp \

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    packagesdownloadertests.h \
    testsmedaitor.h \
    ../distributive.h \
    ../filesystemapi.hpp \
    ../packagesdownloader/packagesdownloader.hpp \
    ../quazip-0.7.3/JlCompress.h \
    ../quazip-0.7.3/crypt.h \
    ../quazip-0.7.3/ioapi.h \
    ../quazip-0.7.3/quaadler32.h \
    ../quazip-0.7.3/quachecksum32.h \
    ../quazip-0.7.3/quacrc32.h \
    ../quazip-0.7.3/quagzipfile.h \
    ../quazip-0.7.3/quaziodevice.h \
    ../quazip-0.7.3/quazip.h \
    ../quazip-0.7.3/quazip_global.h \
    ../quazip-0.7.3/quazipdir.h \
    ../quazip-0.7.3/quazipfile.h \
    ../quazip-0.7.3/quazipfileinfo.h \
    ../quazip-0.7.3/quazipnewinfo.h \
    ../quazip-0.7.3/unzip.h \
    ../quazip-0.7.3/zip.h \
    ../zlib-1.2.11/crc32.h \
    ../zlib-1.2.11/deflate.h \
    ../zlib-1.2.11/gzguts.h \
    ../zlib-1.2.11/inffast.h \
    ../zlib-1.2.11/inffixed.h \
    ../zlib-1.2.11/inflate.h \
    ../zlib-1.2.11/inftrees.h \
    ../zlib-1.2.11/trees.h \
    ../zlib-1.2.11/zconf.h \
    ../zlib-1.2.11/zlib.h \
    ../zlib-1.2.11/zutil.h \
    ../webapi/webapi.hpp \
    ../webapi/webapi_task.h \
    ../webapi/yandexdiskapi.hpp \

