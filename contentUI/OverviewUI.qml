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

    Component.onCompleted: {
        readOverviewFile()
    }


    function readOverviewFile(){
        var xhr = new XMLHttpRequest;
        xhr.open("GET", "overview.html"); // set Method and File
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
                var response = xhr.responseText;

                textOverview.text = response
            }
        }
        xhr.send(); // begin the request
    }


    Text{
        id: textOverview
        text: "<b>Описание</b> <i>продукта.</i>"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignTop
        wrapMode: Text.Wrap
        font.pointSize: 12
        fontSizeMode: Text.Fit
        textFormat: Text.RichText
        font.family: "Arial"
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.topMargin: 10
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.6600000262260437;height:480;width:600}
}
##^##*/
