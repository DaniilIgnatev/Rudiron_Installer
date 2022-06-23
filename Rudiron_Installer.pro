QT += quick xml
QT += quickcontrols2
QT += network
QT += widgets
QT += gui

DEFINES += QUAZIP_STATIC
DEFINES += QTAWS_STATIC

macx{
    ICON = icon.icns
}
else{
    RC_ICONS = icon.ico
}

INCLUDEPATH += "sources"
INCLUDEPATH += "sources/zlib-1.2.11"
INCLUDEPATH += "sources/quazip-0.7.3"

# windows
win32 {
    include($$PWD/sources/QCrashHandler-master/src/qcrashhandler.pri)

    CONFIG(debug, debug|release) {
        TARGET = RudironInstallerDebug
    } else {
        TARGET = RudironInstaller
        # create debug symbols for release builds
        CONFIG *= force_debug_info
        QMAKE_CXXFLAGS_RELEASE_WITH_DEBUGINFO -= -O2
    }
}

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
    sources/distributive.cpp \
    sources/filesystemapi.cpp \
    sources/installermenuvm.cpp \
    sources/main.cpp \
    sources/packagesdownloader/packagedescriptor.cpp \
    sources/packagesdownloader/packagedescriptormodel.cpp \
    sources/packagesdownloader/packagesdownloader.cpp \
    sources/pugixml-master/src/pugixml.cpp \
    sources/qtcreatorconfig.cpp \
    sources/quazip-0.7.3/JlCompress.cpp \
    sources/quazip-0.7.3/qioapi.cpp \
    sources/quazip-0.7.3/quaadler32.cpp \
    sources/quazip-0.7.3/quacrc32.cpp \
    sources/quazip-0.7.3/quagzipfile.cpp \
    sources/quazip-0.7.3/quaziodevice.cpp \
    sources/quazip-0.7.3/quazip.cpp \
    sources/quazip-0.7.3/quazipdir.cpp \
    sources/quazip-0.7.3/quazipfile.cpp \
    sources/quazip-0.7.3/quazipfileinfo.cpp \
    sources/quazip-0.7.3/quazipnewinfo.cpp \
    sources/quazip-0.7.3/unzip.c \
    sources/quazip-0.7.3/zip.c \
    sources/webapi/webapi.cpp \
    sources/webapi/webapi_task.cpp \
    sources/webapi/yandexdiskapi.cpp \
    sources/zlib-1.2.11/adler32.c \
    sources/zlib-1.2.11/compress.c \
    sources/zlib-1.2.11/crc32.c \
    sources/zlib-1.2.11/deflate.c \
    sources/zlib-1.2.11/gzclose.c \
    sources/zlib-1.2.11/gzlib.c \
    sources/zlib-1.2.11/gzread.c \
    sources/zlib-1.2.11/gzwrite.c \
    sources/zlib-1.2.11/infback.c \
    sources/zlib-1.2.11/inffast.c \
    sources/zlib-1.2.11/inflate.c \
    sources/zlib-1.2.11/inftrees.c \
    sources/zlib-1.2.11/trees.c \
    sources/zlib-1.2.11/uncompr.c \
    sources/zlib-1.2.11/zutil.c



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
    sources/QCrashHandler-master/src/QCrashHandler \
    sources/QCrashHandler-master/src/qcrashhandler.h \
    sources/distributive.h \
    sources/filesystemapi.hpp \
    sources/installermenuvm.h \
    sources/installstatus.h \
    sources/packagesdownloader/packagedescriptor.hpp \
    sources/packagesdownloader/packagedescriptormodel.hpp \
    sources/packagesdownloader/packagesdownloader.hpp \
    sources/pugixml-master/src/pugiconfig.hpp \
    sources/pugixml-master/src/pugixml.hpp \
    sources/qtcreatorconfig.h \
    sources/quazip-0.7.3/JlCompress.h \
    sources/quazip-0.7.3/crypt.h \
    sources/quazip-0.7.3/ioapi.h \
    sources/quazip-0.7.3/quaadler32.h \
    sources/quazip-0.7.3/quachecksum32.h \
    sources/quazip-0.7.3/quacrc32.h \
    sources/quazip-0.7.3/quagzipfile.h \
    sources/quazip-0.7.3/quaziodevice.h \
    sources/quazip-0.7.3/quazip.h \
    sources/quazip-0.7.3/quazip_global.h \
    sources/quazip-0.7.3/quazipdir.h \
    sources/quazip-0.7.3/quazipfile.h \
    sources/quazip-0.7.3/quazipfileinfo.h \
    sources/quazip-0.7.3/quazipnewinfo.h \
    sources/quazip-0.7.3/unzip.h \
    sources/quazip-0.7.3/zip.h \
    sources/webapi/webapi.hpp \
    sources/webapi/webapi_task.h \
    sources/webapi/yandexdiskapi.hpp \
    sources/zlib-1.2.11/crc32.h \
    sources/zlib-1.2.11/deflate.h \
    sources/zlib-1.2.11/gzguts.h \
    sources/zlib-1.2.11/inffast.h \
    sources/zlib-1.2.11/inffixed.h \
    sources/zlib-1.2.11/inflate.h \
    sources/zlib-1.2.11/inftrees.h \
    sources/zlib-1.2.11/trees.h \
    sources/zlib-1.2.11/zconf.h \
    sources/zlib-1.2.11/zlib.h \
    sources/zlib-1.2.11/zutil.h


FORMS +=

DISTFILES += \
    sources/QCrashHandler-master/src/qcrashdumper \
    sources/QCrashHandler-master/src/qcrashhandler.pri \
    sources/QCrashHandler-master/src/qpostprocess.pri \
    sources/QCrashHandler-master/src/qpreprocess.pri

