/*
Copyright (C) THEDATE Ignatev Daniil
This file is part of DIBotInstaller <https://github.com/>.

DIBotInstaller is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

DIBotInstaller is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with DIBotInstaller. If not, see <http://www.gnu.org/licenses/>.
*/



import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import com.dibot 1.0



ColumnLayout{

    id: stagesObserver

    property int position: 0


    property var imagesURLList: ["../slides/qtcreator/1.png"]


    property var hintList: ["Нажмите \"Далее\""]


    function length(){
        return imagesURLList.length
    }


    property var installFunction: ({})


    onPositionChanged: {
        console.log("position: " + position)
        if (position === length() - 1){
            buttonInstall.enabled = true
        }
    }


    Text{
        text: "Слайд № " + (stagesObserver.position + 1)

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font.pointSize: 14
        font.family: "Arial"

        fontSizeMode: Text.VerticalFit
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        renderType: Text.QtRendering
        textFormat: Text.PlainText

        Layout.fillWidth: false
        Layout.fillHeight: false
        Layout.topMargin: 15
        //Layout.preferredHeight: 50
    }


    Image {
        id: image

        Layout.fillWidth: true
        Layout.fillHeight: true

        source: stagesObserver.imagesURLList[stagesObserver.position]
        asynchronous: false
        cache: true

        Layout.margins: 0

        smooth: true
        fillMode: Image.PreserveAspectFit
    }


    Text {
        id: hintText
        text: stagesObserver.hintList[stagesObserver.position]

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.italic: true

        font.pointSize: 10
        font.family: "Arial"

        fontSizeMode: Text.VerticalFit
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        renderType: Text.QtRendering
        textFormat: Text.PlainText

        Layout.fillWidth: true
        Layout.fillHeight: false

        Layout.topMargin: 5
    }


    ProgressBar{
        Layout.fillWidth: false
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        from: 0.0
        to: 1.0
        value: stagesObserver.position / (stagesObserver.length() - 1)

        Layout.topMargin: 5
        Layout.preferredWidth: parent.width / 5
    }


    RowLayout{

        Layout.fillWidth: true
        Layout.fillHeight: false

        Layout.topMargin: 5
        Layout.preferredHeight: 50

        Button{
            id: buttonBack
            text: "Предыдущий"
            font.weight: Font.Normal
            Layout.leftMargin: width / 4
            enabled: stagesObserver.position > 0
            onClicked: {
                stagesObserver.position--
            }

            font.pointSize: 8
            font.family: "Arial"
            font.bold: true
            Layout.preferredHeight: 40
            Layout.preferredWidth: 90
            background: Rectangle{
                color: parent.pressed ? "#274472" : "#41729f"
                radius: 2
                anchors.bottom: parent.bottom
                anchors.fill: parent
            }
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
        }


        Button{
            property var installed: false

            id: buttonInstall
            text: installed ?  "Выполнено" : "Установить"
            font.weight: installed ? Font.Bold : Font.Normal
            visible: stagesObserver.installFunction != null
            enabled: false
            onClicked: {
                stagesObserver.installFunction()
                installed = true
                enabled = false
            }

            font.pointSize: 8
            font.family: "Arial"
            font.bold: true
            Layout.preferredHeight: 40
            Layout.preferredWidth: 90
            background: Rectangle{
                color: parent.pressed ? "#274472" : "#41729f"
                radius: 2
                anchors.bottom: parent.bottom
                anchors.fill: parent
            }
        }


        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Button{
            id: buttonForward
            text: "Следующий"
            font.weight: Font.Normal
            Layout.rightMargin: width / 4
            enabled: stagesObserver.position + 1 < stagesObserver.imagesURLList.length
            onClicked: {
                stagesObserver.position++
            }

            font.pointSize: 8
            font.family: "Arial"
            font.bold: true
            Layout.preferredHeight: 40
            Layout.preferredWidth: 90
            background: Rectangle{
                color: parent.pressed ? "#274472" : "#41729f"
                radius: 2
                anchors.bottom: parent.bottom
                anchors.fill: parent
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:4}
D{i:6}D{i:8}D{i:9}D{i:11}D{i:12}D{i:5}
}
##^##*/
