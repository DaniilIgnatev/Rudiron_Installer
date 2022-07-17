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

import com.dibot 1.0
import com.FileSystemAPI 1.0


ColumnLayout{


    Text {
        Layout.fillWidth: true
        padding: 10

        text: "<h2>Внимательно следуйте инструкциям на каждом этапе установки</h2>"
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

        FileSystemAPI{
            id: file_system_api
        }

        clip: true
        wheelEnabled: true

        Component.onCompleted: {
            readTextFile()
        }

        function readTextFile(){
            var html = file_system_api.getFileContent(":/contentUI/overview.html")
            textbox.text = html
        }

        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.interactive: false
        ScrollBar.vertical.interactive: true


        Text {
            id: textbox
            width: scrollableBox.width
            padding: 10
            text: "<b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i>"
            font.family: "Arial"
            font.pointSize: 10
            wrapMode: Text.Wrap
            fontSizeMode: Text.Fit
            textFormat: Text.RichText
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:600}D{i:1}D{i:3}D{i:4}D{i:2}
}
##^##*/
