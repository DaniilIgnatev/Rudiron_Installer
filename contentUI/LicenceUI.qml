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



ColumnLayout{

    id: root

    property var leftMargin: 5

    property alias licenceAccepted: radioLicence.checked

    onLicenceAcceptedChanged: {
        parent.parent.licenceAccepted = licenceAccepted
    }

    Component.onCompleted: {
        licenceAccepted = parent.parent.licenceAccepted
    }

    Text {
        text: "Лицензионное соглашение"
        wrapMode: Text.NoWrap
        font.bold: true
        textFormat: Text.PlainText
        font.family: "Arial"
        Layout.leftMargin: root.leftMargin
    }

    Text {
        text: "Пожалуйста, прочтите следующую важную информацию перед тем, как продолжить."
        wrapMode: Text.Wrap
        textFormat: Text.PlainText
        font.family: "Arial"
        Layout.fillWidth: true
        Layout.leftMargin: root.leftMargin
    }

    Item {
        Layout.preferredHeight: 20
        Layout.fillWidth: true
        Layout.leftMargin: root.leftMargin
    }

    Text {
        text: "Любое использование приобретенного Программногопродукта, в том числе его установка и запуск, означает согласие с условиями приведенного ниже Лицензионногосоглашения."
        font.family: "Arial"
        wrapMode: Text.Wrap
        textFormat: Text.PlainText
        Layout.fillWidth: true
        Layout.leftMargin: root.leftMargin
    }

    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: false
        border.width: 1
        border.color: "black"
        Layout.leftMargin: root.leftMargin
        Layout.preferredWidth: parent.width - root.leftMargin

        ScrollView{
            id: scrollableBox
            clip: true

            width: parent.width
            height: parent.height

            property bool scrollEnd: false

            ScrollBar.vertical.onPositionChanged: {
                var position = ScrollBar.vertical.position
                if (position > 0.9){
                    scrollEnd = true
                }
            }

            function readTextFile(){
                var xhr = new XMLHttpRequest;
                xhr.open("GET", "licence.html"); // set Method and File
                xhr.onreadystatechange = function () {
                    if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
                        var response = xhr.responseText;

                        textbox.text = response
                    }
                }
                xhr.send(); // begin the request
            }

            Component.onCompleted: {
                readTextFile()
            }

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true



            Text {
                id: textbox
                //color: root.licenceAccepted ? "green" : "red"
                leftPadding: 5
                width: root.width - 20
                text: "Лицензионное соглашение"
                font.family: "Arial"
                wrapMode: Text.Wrap
                textFormat: Text.RichText
            }
        }
    }


    RowLayout{
        ColumnLayout{
            Layout.leftMargin: root.leftMargin
            RadioButton{
                id: radioLicence
                text: "Я принимаю условия соглашения"
                font.family: "Arial"
                enabled: scrollableBox.scrollEnd
                Layout.fillWidth: true
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
    D{i:0;autoSize:true;height:480;width:400}
}
##^##*/
