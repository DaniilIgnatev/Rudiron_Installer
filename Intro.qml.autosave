/*
Copyright (C) THEDATE Ignatev Daniil
This file is part of RudironInstaller <https://github.com/>.

RudironInstaller is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

RudironInstaller is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with RudironInstaller. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.6
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
//import Qt5Compat.GraphicalEffects

import com.dibot 1.0
import com.FileSystemAPI 1.0
import "contentUI"


ColumnLayout{
    id: intro_root

    signal buttonNext

    Text {
        color: "#e35b00"
        Layout.fillWidth: true
        Layout.topMargin: 10

        text: "<h2>Вас приветствует установщик Рудирон</h2>"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Arial"

        renderType: Text.QtRendering
        font.pointSize: 14

        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
        textFormat: Text.RichText
    }

    ScrollView{
        id: scrollableBox
        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.topMargin: 0

        FileSystemAPI{
            id: file_system_api
        }

        clip: true
        wheelEnabled: true

        Component.onCompleted: {
            var html = file_system_api.getFileContent(":/contentUI/overview.html")
            textbox.text = html
        }

//        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.interactive: false
        ScrollBar.vertical.interactive: true

        ColumnLayout{
            Text {
                id: textbox
                Layout.preferredWidth: scrollableBox.width
                font.pointSize: 10

                text: "<b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i>"
                font.family: "Arial"
                wrapMode: Text.WordWrap
                Layout.bottomMargin: 15
                Layout.topMargin: 15
                Layout.leftMargin: 15
                fontSizeMode: Text.Fit
                textFormat: Text.RichText
            }
        }
    }

    Item{
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

    RowLayout{
        Layout.preferredWidth: scrollableBox.width - 50

        Layout.bottomMargin: 15
        Layout.topMargin: 0
        Layout.leftMargin: 0
        Layout.rightMargin: 15

        Item{
            Layout.fillWidth: true
        }

        ButtonStyled{
            text: "Далее"
            enabled: true
            onPressed: {
                intro_root.buttonNext()
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:3}D{i:5}D{i:4}D{i:2}D{i:6}D{i:8}
D{i:9}D{i:7}
}
##^##*/
