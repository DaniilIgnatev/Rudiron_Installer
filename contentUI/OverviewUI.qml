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
import com.FileSystemAPI 1.0



ColumnLayout{

    FileSystemAPI{
        id: file_system_api
    }

    Component.onCompleted: {
        readOverviewFile()
    }


    function readOverviewFile(){
        var html = file_system_api.getFileContent(":/contentUI/overview.html")
        textOverview.text = html
    }


    Text{
        id: textOverview
        text: "<b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i>"

        wrapMode: Text.Wrap
        padding: 10
        font.pointSize: 12
        fontSizeMode: Text.Fit
        textFormat: Text.RichText
        font.family: "Arial"
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:600}D{i:1}D{i:2}
}
##^##*/
