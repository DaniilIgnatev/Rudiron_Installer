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


//black "#262730"
//blue "#5171A5"
//violet "#3F3047"
//silversand "#BBC8CA"
//magnolia "#FFFAFF"
//jet "#303036"
//indigoblue "#16425B"

RowLayout{
    id: tab_root

    property int position: 0

    property string contentQML: ""

    property alias text: button.text

    property alias checked: button.checked

    property bool statusEnabled: false

    property bool installStatus: false

    property var model: {({})}


    TabButtonUI{
        id: button

        Layout.fillWidth: true
        Layout.fillHeight: false

        Layout.preferredHeight: width / 2
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/
