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
import com.PackageDescriptor 1.0
import "contentUI"


ColumnLayout{
    id: root

    signal buttonNext

    property var excludePackageIDs: ["jlink", "qt"]

    property alias withJLink: radio2.checked

    property alias withVSCode: radio3.checked

    function updateExcludePackageIDs(){
        excludePackageIDs = []
        if (!withJLink){
            excludePackageIDs.push("jlink")
        }
        if (withVSCode){
            excludePackageIDs.push("qt")
        }
        else{
            excludePackageIDs.push("vscode")
        }
    }

    property var skipDownloadPackageIDs: []

    property alias downloadToolchain: downloadToolchain_CheckBox.checked

    property alias downloadIDE: downloadIDE_CheckBox.checked

    function updateSkipDownloadPackageIDs(){
        skipDownloadPackageIDs = []

        if (!downloadToolchain){
            skipDownloadPackageIDs.push("cp210x")
            skipDownloadPackageIDs.push("cmake")
            skipDownloadPackageIDs.push("openocd")
            skipDownloadPackageIDs.push("gcc")
            skipDownloadPackageIDs.push("python")
            skipDownloadPackageIDs.push("jlink")
        }

        if (!downloadIDE){
            skipDownloadPackageIDs.push("qt")
            skipDownloadPackageIDs.push("vscode")
        }
    }

    spacing: 0

    Text {
        color: "#e35b00"
        Layout.fillWidth: true
        Layout.topMargin: 10

        text: "<h2>Выбор параметров установки</h2>"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Arial"

        renderType: Text.QtRendering
        font.pointSize: 14

        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
        textFormat: Text.RichText
    }

    Item {
        id: filler1
        Layout.fillWidth: true
        Layout.minimumHeight: 40
    }

    ColumnLayout{
        RowLayout {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.rightMargin: 15
            Layout.leftMargin: 15

            ColumnLayout {
                Layout.fillWidth: true
                RadioButton {
                    id: radio1
                    text: "Вариант установки без JLink-совместимого программатора (для большинства пользователей)"
                    Layout.fillWidth: true
                    checked: true
                    font.family: "Arial"
                }

                RadioButton {
                    id: radio2
                    text: "Вариант установки с JLink-совместимым программатором (для продвинутых пользователей)"
                    Layout.fillWidth: true
                    checked: false
                    font.family: "Arial"
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.rightMargin: 15
            Layout.leftMargin: 15

            ColumnLayout {
                Layout.fillWidth: true
                CheckBox {
                    id: downloadToolchain_CheckBox
                    text: "На компьютере отсутствует данный инструментарий и я хочу загрузить его в папку \"components\""
                    Layout.fillWidth: true
                    checked: true
                    font.family: "Arial"
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        Text {
            property string jlink_description: downloadToolchain_CheckBox.checked ? "Будет доступна прошивка и отладка в реальном времени через интерфейс SWD" : "Будет продемонстрирована прошивка и отладка в реальном времени через интерфейс SWD"
            property string com_description: downloadToolchain_CheckBox.checked ? "Будет доступна прошивка через встроенный UART загрузчик" : "Будет продемонстрирована прошивка через встроенный UART загрузчик"

            Layout.leftMargin: 20
            Layout.fillWidth: true

            id: textbox_jlink
            font.pointSize: 10
            text: withJLink ? jlink_description : com_description

            font.family: "Arial"
            wrapMode: Text.WordWrap
            Layout.topMargin: 0
            font.italic: true
            fontSizeMode: Text.Fit
            textFormat: Text.RichText
        }
    }

    Item {
        Layout.fillWidth: true
        Layout.minimumHeight: filler1.height
    }

    ColumnLayout{
        RowLayout {
            Layout.fillWidth: true
            Layout.rightMargin: 15
            Layout.leftMargin: 15

            ColumnLayout {
                Layout.fillWidth: true
                RadioButton {
                    id: radio3
                    text: "Вариант установки с Visual Studio Code (для большинства пользователей)"
                    Layout.fillWidth: true
                    checked: true
                    font.family: "Arial"
                }

                RadioButton {
                    id: radio4
                    text: "Вариант установки с IDE QtCreator (для продвинутых пользователей)"
                    Layout.fillWidth: true
                    checked: false
                    font.family: "Arial"
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.rightMargin: 15
            Layout.leftMargin: 15

            ColumnLayout {
                Layout.fillWidth: true
                CheckBox {
                    id: downloadIDE_CheckBox
                    text: "На компьютере отсутствует данная программа и я хочу загрузить её в папку \"components\""
                    Layout.fillWidth: true
                    checked: true
                    font.family: "Arial"
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        Text {
            property string vscode_description: downloadIDE_CheckBox.checked ? "Будет загружен универсальный редактор исходного кода от Microsoft" : "Будет продемонстрирована работа в универсальном редакторе исходного кода от Microsoft"
            property string qtcreator_description: downloadIDE_CheckBox.checked ? "Будет загружена свободная IDE для разработки на С, C++, JavaScript и QML" : "Будет продемонстрирована работа в свободной IDE для разработки на С, C++, JavaScript и QML"

            Layout.leftMargin: 20
            Layout.fillWidth: true

            id: textbox_ide
            font.pointSize: 10
            text: withVSCode ? vscode_description : qtcreator_description

            font.family: "Arial"
            wrapMode: Text.WordWrap
            Layout.topMargin: 0
            font.italic: true
            fontSizeMode: Text.Fit
            textFormat: Text.RichText
        }
    }

    Item {
        id: filler2
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.rightMargin: 15
        Layout.bottomMargin: 15

        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
        }

        ButtonStyled {
            text: "Далее"
            enabled: true
            onPressed: {
                updateExcludePackageIDs()
                updateSkipDownloadPackageIDs()
                root.buttonNext()
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:4}D{i:9}D{i:3}D{i:10}D{i:12}
D{i:15}D{i:11}D{i:16}D{i:17}D{i:19}D{i:20}D{i:18}
}
##^##*/
