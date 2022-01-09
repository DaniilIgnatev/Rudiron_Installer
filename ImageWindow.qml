import QtQuick 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15


Window {
    id: imagewindow_root
    width: 800; height: 600
    minimumWidth: 800
    minimumHeight: 600

    property string imageSource: "qrc:/slides/jlink/1.png"

    Image {
        id: borderImage
        anchors.fill: parent
        source: imagewindow_root.imageSource
        fillMode: Image.PreserveAspectFit
    }
}

