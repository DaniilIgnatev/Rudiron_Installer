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

    function isDistributivePathLatin(){
        console.log(DistributivePath)
        console.log(/^[a-zA-Z\s., -_]+$/.test(DistributivePath))
        return /^[a-zA-Z\s., -_]+$/.test(DistributivePath)
    }

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

        //      ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.interactive: false
        ScrollBar.vertical.interactive: true

        ColumnLayout{
            anchors.fill: parent

            Text {
                id: textbox

                Layout.fillHeight: true
                Layout.fillWidth: true

                topPadding: 15
                bottomPadding: 15
                leftPadding: 15

                text: file_system_api.getFileContent(":/components/contentUI/overview.html")
                font.pointSize: 12
                font.family: "Arial"
                wrapMode: Text.WordWrap
                fontSizeMode: Text.Fit
                textFormat: Text.RichText
            }

            DebugInfo{
                id: debugInfo
                Layout.leftMargin: 15

                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumHeight: 50
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

        ColumnLayout{
            Layout.fillHeight: true

            Item{
                Layout.fillHeight: true
            }

            Text {
                text: qsTr("Версия ") + Qt.application.version
                font.pixelSize: 8
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                leftPadding: 15
            }
        }

        Item{
            Layout.fillWidth: true
        }

        Text {
            text: intro_root.isDistributivePathLatin() ? "" : qsTr("Путь к дистрибутиву должен содержать только латинские символы!")
            font.pixelSize: 14
            color: "red"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Item{
            Layout.fillWidth: true
        }

        ButtonStyled{
            text: "Далее"
            enabled: intro_root.isDistributivePathLatin()
            onPressed: {
                intro_root.buttonNext()
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
