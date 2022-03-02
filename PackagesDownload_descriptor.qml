import QtQuick 2.6
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
//import Qt5Compat.GraphicalEffects

import com.dibot 1.0
import com.FileSystemAPI 1.0
import "contentUI"


ColumnLayout{
    id: root

    signal buttonNext

    property bool withJLink: false
    spacing: 0


    Label {
        id: label_description
        text: qsTr("Описание пакета")
        horizontalAlignment: Text.AlignHCenter
        Layout.topMargin: 5
        font.pointSize: 12
        Layout.fillWidth: true
    }

    RowLayout {
        id: rowLayout
        width: 100
        height: 100
        Layout.fillHeight: true

        BusyIndicator {
            id: busyIndicator
            Layout.fillHeight: true
        }

        ProgressBar {
            id: progressBar
            Layout.fillWidth: true
            value: 0.5
        }

        Label {
            id: label_status
            text: qsTr("Выполняется загрузка...")
            horizontalAlignment: Text.AlignHCenter
            Layout.minimumWidth: 150
            Layout.fillWidth: false
        }
    }

}


/*##^##
Designer {
    D{i:0;autoSize:true;height:100;width:640}D{i:1}D{i:3}D{i:4}D{i:5}D{i:2}
}
##^##*/
