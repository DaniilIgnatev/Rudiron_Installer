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


Button {

    property string color_default: "#993D00"

    property string color_hovered: "#FF6600"

    property string color_checked: "#E35B00"

    property string color: color_default
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    font.weight: Font.Light
    font.family: "Arial"
    font.bold: true
    font.pointSize: 10

    id: tab_button_root

    checkable: true

    background:
        Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: tab_button_root.color
        border.color: "#26282a"
        border.width: 1
        radius: 4
    }

    states: [
        State{
            name: "NORMAL"
            PropertyChanges {
                target: tab_button_root
                color: color_default
            }
        },
        State{
            name: "CHECKED"
            PropertyChanges {
                target: tab_button_root
                color: color_checked
            }
        },
        State {
            name: "HOVER"
            PropertyChanges {
                target: tab_button_root
                color: color_hovered
            }
        }
    ]

    onHoveredChanged: {
        if (!checked){
            if (tab_button_root.hovered){
                state = "HOVER"
            }
            else{
                state = "NORMAL"
            }
        }
    }

    onCheckedChanged: {
        if (checked){
            state = "CHECKED"
        }
        else{
            state = "NORMAL"
        }
    }

    onClicked: {
        if (checkable){
            checked = true
        }
    }
}
