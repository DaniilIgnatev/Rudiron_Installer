import QtQuick 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15


Window {
    id: imagewindow_root
    width: 800; height: 600
    minimumWidth: 800
    minimumHeight: 600

    property string imageSource: "qrc:/slides/jlink/1.png"

    ColumnLayout{
        anchors.fill: parent
        anchors.topMargin: 0
        anchors.bottomMargin: 15
        spacing: 15

        Image {
            id: borderImage
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: imagewindow_root.imageSource
            fillMode: Image.PreserveAspectFit


        }

        RowLayout{
            Item{
                Layout.fillWidth: true
                Layout.fillHeight: false
            }

            Button{
                id: buttonBack
                text: "Закрыть"
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                topPadding: 0
                bottomPadding: 0
                rightPadding: 0
                leftPadding: 0
                font.weight: Font.Normal
                onClicked: {
                    imagewindow_root.close()
                }

                font.pointSize: 14
                font.family: "Arial"
                font.bold: true
                Layout.preferredHeight: 40
                Layout.preferredWidth: 120
                background: Rectangle{
                    color: parent.pressed ? "#274472" : "#41729f"
                    radius: 2
                    anchors.bottom: parent.bottom
                    anchors.fill: parent
                }
            }

            Item{
                Layout.fillWidth: true
                Layout.fillHeight: false
            }
        }
    }
}

