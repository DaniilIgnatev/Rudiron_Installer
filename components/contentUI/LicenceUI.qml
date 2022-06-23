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



import QtQuick 2.6
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import com.FileSystemAPI 1.0


ColumnLayout{

    id: licenceUI_root

    FileSystemAPI{
        id: file_system_api
    }

    property alias licenceAccepted: radioLicence.checked


    signal licenceAcceptedSignal(var newValue)


    Text {
        text: "Лицензионное соглашение"
        wrapMode: Text.Wrap
        font.pointSize: 12
        font.bold: true
        textFormat: Text.PlainText
        font.family: "Arial"
        Layout.leftMargin: licenceUI_root.leftMargin
    }

    Text {
        text: "Пожалуйста, прочтите следующую важную информацию перед тем, как продолжить."
        wrapMode: Text.Wrap
        font.pointSize: 12
        textFormat: Text.PlainText
        font.family: "Arial"
        Layout.fillWidth: true
        Layout.leftMargin: licenceUI_root.leftMargin
    }

    Item {
        Layout.preferredHeight: 20
        Layout.fillWidth: true
        Layout.leftMargin: licenceUI_root.leftMargin
    }

    Text {
        text: "Любое использование приобретенного Программного продукта, в том числе его установка и запуск, означает согласие с условиями приведенного ниже Лицензионного соглашения."
        font.family: "Arial"
        wrapMode: Text.Wrap
        font.pointSize: 10
        textFormat: Text.PlainText
        Layout.fillWidth: true
        Layout.leftMargin: licenceUI_root.leftMargin
    }

    Rectangle{
        id: rectangle
        Layout.fillHeight: true
        Layout.fillWidth: true
        border.width: 1
        Layout.bottomMargin: 0
        border.color: "black"

        ScrollView{
            id: scrollableBox
            anchors.fill: parent
            clip: true
            wheelEnabled: true

            property bool scrollEnd: false


            ScrollBar.vertical.onPositionChanged: {
                var position = ScrollBar.vertical.position
                if (position > 0.9){
                    scrollEnd = true
                }
            }

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true


            Text {
                id: textbox
                padding: 10

                text: file_system_api.getFileContent(":/contentUI/licence.html")
                font.family: "Arial"
                wrapMode: Text.Wrap
                fontSizeMode: Text.Fit
                textFormat: Text.RichText
            }
        }
    }


    RowLayout{
        Layout.margins: 5
        Layout.topMargin: 3
        Layout.leftMargin: 5
        Layout.bottomMargin: 3
        ColumnLayout{
            Layout.leftMargin: licenceUI_root.leftMargin
            RadioButton{
                id: radioLicence
                text: "Я принимаю условия соглашения"
                font.family: "Arial"
                enabled: scrollableBox.scrollEnd
                Layout.fillWidth: true
                onCheckedChanged: {
                    licenceUI_root.licenceAcceptedSignal(radioLicence.checked)
                }
            }
            RadioButton{
                text: "Я не принимаю условия соглашения"
                font.family: "Arial"
                checked: true
                enabled: checked
                Layout.fillWidth: true
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:600;width:600}D{i:1}D{i:2}D{i:3}D{i:4}D{i:5}D{i:7}D{i:6}
D{i:10}D{i:9}
}
##^##*/
