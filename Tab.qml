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

    property string text: button.text

    onTextChanged: {
        button.text = text
    }

    property bool checked: button.checked

    onCheckedChanged: {
        button.checked = checked
    }


    property bool statusEnabled: false


    property bool installStatus: false


    property var model: {({})}


    Button {

        property string color_default: "#41729F"

        property string color_hover: "#5885AF"

        property string color_checked: "#274472"

        property string color: color_default
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        font.weight: Font.Light
        font.family: "Arial"
        font.bold: true
        font.pointSize: 10

        id: button

        checkable: true

        Layout.fillWidth: true
        Layout.fillHeight: false

        //Layout.preferredWidth: 100
        Layout.preferredHeight: width / 2

        background:
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: button.color
                border.color: "#26282a"
                border.width: 1
                radius: 4
            }



        states: [
            State{
                name: "NORMAL"
                PropertyChanges {
                    target: button
                    color: color_default
                }
            },
            State{
                name: "CHECKED"
                PropertyChanges {
                    target: button
                    color: color_checked
                }
            },
            State {
                name: "HOVER"
                PropertyChanges {
                    target: button
                    color: color_hover
                }
            }
        ]


        onHoveredChanged: {
            if (!checked){
                if (button.hovered){
                    state = "HOVER"
                    console.log("tab button #" + position + " HOVER state")
                }
                else{
                    state = "NORMAL"
                    console.log("tab button #" + position + " NORMAL state")
                }
            }
        }


        onCheckedChanged: {
            if (checked){
                tab_root.parent.selectedPos = tab_root.position

                state = "CHECKED"
                console.log("tab button #" + position + " CHECKED state")
            }
            else{
                state = "NORMAL"
                console.log("tab button #" + position + " NORMAL state")
            }

            tab_root.checked = checked
        }


        onClicked: {
            checked = true
        }
    }

//    Rectangle {
//        visible: tab_root.statusEnabled
//        Layout.fillWidth: false
//        Layout.fillHeight: false
//        Layout.preferredWidth: 1
//        Layout.margins: 2
//        Layout.preferredHeight: parent.height * 3 / 4
//        color: "black"
//    }

//    Rectangle{
//        color: tab_root.installStatus ? "green" : "red"
//        visible: tab_root.statusEnabled
//        Layout.fillWidth: false
//        Layout.fillHeight: false
//        Layout.preferredWidth: 10
//        Layout.preferredHeight: Layout.preferredWidth
//        radius: width / 2
//        Layout.leftMargin: 0
//        Layout.rightMargin: 5
//    }
}






/*##^##
Designer {
    D{i:0;height:50;width:100}
}
##^##*/
