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



RowLayout{
    id: installerUI


    property bool licenceAccepted: false


    TabBar{
        id: tabBar

        Layout.fillHeight: true
        Layout.fillWidth: false
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        Layout.preferredWidth: 130
    }


    Rectangle{
        color: "#262730"
        radius: 2
        Layout.topMargin: 0
        Layout.bottomMargin: Layout.topMargin
        Layout.leftMargin: 2
        Layout.rightMargin: Layout.leftMargin
        Layout.preferredWidth: 2
        Layout.fillHeight: true
    }


    Item{
        id: tabContent

        Layout.margins: 2

        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}
}
##^##*/
