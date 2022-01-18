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


    property bool installed: false


    property string title: "Заголовок"


    property var imagesURLList: ["qrc:/slides/qtcreator/2022-01-09_12-02-57.png"]


    property var hintList: ["Нажмите \"Далее\""]


    function length(){
        return imagesURLList.length
    }


    property var installFunction: ({})
    spacing: 15


    Text{
        text: stagesObserver.title

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font.pointSize: 14
        font.family: "Arial"
        font.bold: true

        fontSizeMode: Text.VerticalFit
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        renderType: Text.QtRendering
        textFormat: Text.PlainText

        Layout.topMargin: 15
        Layout.fillWidth: true
        Layout.fillHeight: false
    }

    Text{
        text: "№ " + (stagesObserver.position + 1)

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        topPadding: -5

        font.pointSize: 12
        font.family: "Arial"

        fontSizeMode: Text.VerticalFit
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        renderType: Text.QtRendering
        textFormat: Text.PlainText

        Layout.topMargin: 5
        Layout.fillWidth: true
        Layout.fillHeight: false
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

        opacity: mouseArea.isHovered ? 0.7 : 1.0

        ToolTip.visible: mouseArea.isHovered
        ToolTip.text: qsTr("Открыть в новом окне")

        MouseArea {
            id: mouseArea
            property bool isHovered: false

            anchors.fill: parent
            anchors.topMargin: -5
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onClicked: {
                if (image.source.toString() !== ("qrc:/slides/white.png")){
                    var component = Qt.createComponent("qrc:/ImageWindow.qml")
                    if (component !== null){
                        if (component.status === Component.Ready){
                            var window = component.createObject(stagesObserver)
                            window.imageSource = image.source
                            window.showMaximized()
                        }
                    }
                }
            }
            onEntered: {
                isHovered = true
            }
            onExited: {
                isHovered = false
            }
        }
    }


    Text {
        id: hintText
        text: stagesObserver.hintList[stagesObserver.position]

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        rightPadding: 15
        leftPadding: 15
        font.italic: true

        font.pointSize: 12
        font.family: "Arial"

        fontSizeMode: Text.VerticalFit
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        renderType: Text.QtRendering
        textFormat: Text.PlainText

        Layout.fillWidth: true
        Layout.fillHeight: false
    }


    RowLayout{
        Layout.fillWidth: true
        Layout.fillHeight: false

        Layout.topMargin: 5
        Layout.preferredHeight: 50

        ButtonStyled{
            id: buttonBack
            text: stagesObserver.position > 0 ? "Предыдущий" : "Начало"

            Layout.leftMargin: width / 4
            enabled: stagesObserver.position > 0
            onClicked: {
                stagesObserver.position--
            }
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
        }


        ColumnLayout{
            Layout.preferredWidth: parent.width / 5
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            visible: stagesObserver.position !== length() - 1

            Text{
                Layout.alignment: Qt.AlignHCenter
                text: stagesObserver.installed ? "Повторите действия" : "Ознакомьтесь с действиями"
            }

            ProgressBar{
                Layout.preferredWidth: parent.width
                from: 0.0
                to: 1.0
                value: stagesObserver.position / (stagesObserver.length() - 1)
            }
        }


        ButtonStyled{
            id: buttonInstall
            text: installed ?  "Выполнено" : "Установить"
            font.weight: installed ? Font.Bold : Font.Normal
            visible: stagesObserver.installFunction != null && (stagesObserver.position === length() - 1)
            enabled: (stagesObserver.position === length() - 1) && !stagesObserver.installed
            onClicked: {
                stagesObserver.installFunction()
                stagesObserver.installed = true
                stagesObserver.position = 0
            }
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        ButtonStyled{
            id: buttonForward
            text: (stagesObserver.position !== length() - 1) ? "Следующий" : "Конец"

            Layout.rightMargin: width / 4
            enabled: stagesObserver.position + 1 < stagesObserver.imagesURLList.length
            onClicked: {
                stagesObserver.position++
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:4}D{i:3}D{i:5}D{i:7}D{i:8}
D{i:10}D{i:11}D{i:9}D{i:12}D{i:13}D{i:14}D{i:6}
}
##^##*/
