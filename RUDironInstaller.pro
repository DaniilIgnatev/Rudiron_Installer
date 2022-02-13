QT += quick xml
QT += quickcontrols2
QT += network

DEFINES += QUAZIP_STATIC

RC_ICONS = icon.ico
CONFIG += c++11

INCLUDEPATH += "zlib-1.2.11"
INCLUDEPATH += "quazip-0.7.3/quazip"

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        distributive.cpp \
        filesystemapi.cpp \
        installermenuvm.cpp \
        main.cpp \
    packagesdownloader/packagesdownloader.cpp \
        pugixml-master/src/pugixml.cpp \
        qtcreatorconfig.cpp \
    quazip-0.7.3/quazip/JlCompress.cpp \
    quazip-0.7.3/quazip/qioapi.cpp \
    quazip-0.7.3/quazip/quaadler32.cpp \
    quazip-0.7.3/quazip/quacrc32.cpp \
    quazip-0.7.3/quazip/quagzipfile.cpp \
    quazip-0.7.3/quazip/quaziodevice.cpp \
    quazip-0.7.3/quazip/quazip.cpp \
    quazip-0.7.3/quazip/quazipdir.cpp \
    quazip-0.7.3/quazip/quazipfile.cpp \
    quazip-0.7.3/quazip/quazipfileinfo.cpp \
    quazip-0.7.3/quazip/quazipnewinfo.cpp \
    quazip-0.7.3/quazip/unzip.c \
    quazip-0.7.3/quazip/zip.c \
        webapi/webapi.cpp \
    webapi/webapi_task.cpp \
        webapi/yandexdiskapi.cpp \
    zlib-1.2.11/adler32.c \
    zlib-1.2.11/compress.c \
    zlib-1.2.11/crc32.c \
    zlib-1.2.11/deflate.c \
    zlib-1.2.11/gzclose.c \
    zlib-1.2.11/gzlib.c \
    zlib-1.2.11/gzread.c \
    zlib-1.2.11/gzwrite.c \
    zlib-1.2.11/infback.c \
    zlib-1.2.11/inffast.c \
    zlib-1.2.11/inflate.c \
    zlib-1.2.11/inftrees.c \
    zlib-1.2.11/trees.c \
    zlib-1.2.11/uncompr.c \
    zlib-1.2.11/zutil.c

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    distributive.h \
    filesystemapi.hpp \
    installermenuvm.h \
    installstatus.h \
    packagesdownloader/packagesdownloader.hpp \
    pugixml-master/src/pugiconfig.hpp \
    pugixml-master/src/pugixml.hpp \
    qtcreatorconfig.h \
    quazip-0.7.3/quazip/JlCompress.h \
    quazip-0.7.3/quazip/crypt.h \
    quazip-0.7.3/quazip/ioapi.h \
    quazip-0.7.3/quazip/quaadler32.h \
    quazip-0.7.3/quazip/quachecksum32.h \
    quazip-0.7.3/quazip/quacrc32.h \
    quazip-0.7.3/quazip/quagzipfile.h \
    quazip-0.7.3/quazip/quaziodevice.h \
    quazip-0.7.3/quazip/quazip.h \
    quazip-0.7.3/quazip/quazip_global.h \
    quazip-0.7.3/quazip/quazipdir.h \
    quazip-0.7.3/quazip/quazipfile.h \
    quazip-0.7.3/quazip/quazipfileinfo.h \
    quazip-0.7.3/quazip/quazipnewinfo.h \
    quazip-0.7.3/quazip/unzip.h \
    quazip-0.7.3/quazip/zip.h \
    webapi/webapi.hpp \
    webapi/webapi_task.h \
    webapi/yandexdiskapi.hpp \
    zlib-1.2.11/crc32.h \
    zlib-1.2.11/deflate.h \
    zlib-1.2.11/gzguts.h \
    zlib-1.2.11/inffast.h \
    zlib-1.2.11/inffixed.h \
    zlib-1.2.11/inflate.h \
    zlib-1.2.11/inftrees.h \
    zlib-1.2.11/trees.h \
    zlib-1.2.11/zconf.h \
    zlib-1.2.11/zlib.h \
    zlib-1.2.11/zutil.h

DISTFILES += \
    pugixml-master/.codecov.yml \
    pugixml-master/.gitattributes \
    pugixml-master/.gitignore \
    pugixml-master/CMakeLists.txt \
    pugixml-master/LICENSE.md \
    pugixml-master/README.md \
    pugixml-master/appveyor.yml \
    pugixml-master/readme.txt \
    quazip-0.7.3/quazip/CMakeLists.txt \
    quazip-0.7.3/quazip/debian/libquazip0.symbols \
    quazip-0.7.3/quazip/doc/faq.dox \
    quazip-0.7.3/quazip/doc/index.dox \
    quazip-0.7.3/quazip/doc/usage.dox \
    quazip-0.7.3/quazip/quazip.pri \
    quazip-0.7.3/quazip/quazip.sln \
    quazip-0.7.3/quazip/quazip.vcproj \
    quazip-0.7.3/quazip/quazip.vcxproj \
    quazip-0.7.3/quazip/quazip.vcxproj.filters \
    quazip-0.7.3/quazip/run_moc.bat \
    zlib-1.2.11/CMakeLists.txt \
    zlib-1.2.11/ChangeLog \
    zlib-1.2.11/FAQ \
    zlib-1.2.11/INDEX \
    zlib-1.2.11/README \
    zlib-1.2.11/configure \
    zlib-1.2.11/make_vms.com \
    zlib-1.2.11/treebuild.xml \
    zlib-1.2.11/zlib.3 \
    zlib-1.2.11/zlib.3.pdf \
    zlib-1.2.11/zlib.map \
    zlib-1.2.11/zlib.pc.cmakein \
    zlib-1.2.11/zlib.pc.in \
    zlib-1.2.11/zlib2ansi

SUBDIRS += \
    quazip-0.7.3/quazip/quazip.pro

