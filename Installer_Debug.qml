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

import com.dibot 1.0



ColumnLayout {

    id: rectangle

    InstallerMenuVM{
        id: vm
    }


    RowLayout{
        spacing: 5
        antialiasing: false
        width: rectangle.width
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true
        Text {
            text: vm.pathAdded ? qsTr("PATH добавлен") : qsTr("Не найден PATH")
            Layout.fillWidth: true
        }
        Button{
            text: "Добавить"
            Layout.maximumWidth: 120
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            enabled: !vm.pathAdded
            onPressed: {
                vm.addPATH()
            }
        }
    }


    RowLayout{
        spacing: 5
        antialiasing: false
        width: rectangle.width
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true
        Text {
            text: vm.qtCreatorInstalled ? qsTr("QT Creator найден") : qsTr("Не найден QT Creator")
            Layout.fillWidth: true
        }
        Button{
            text: "Установить"
            Layout.maximumWidth: 120
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            enabled: !vm.qtCreatorInstalled
            onPressed: {
                vm.installQTCreator()
            }
        }
    }


    Button{
        text: "Установить драйвер"
        onPressed: {
            vm.installDriver()
        }
    }


    Button{
        text: "Активировать baremetal плагин"
        onPressed: {
            vm.enableBareMetalPlugin()
        }
    }


    Button{
        text: "Создать openOCD debug provider"
        onPressed: {
            vm.createOpenOCDDebugProvider();
        }
    }


    Button{
        text: "Создать baremetal device"
        onPressed: {
            vm.createBareMetalDevice()
        }
    }



    Button{
        text: "Создать cmake tools"
        onPressed: {
            vm.createCmakeTools()
        }
    }


    RowLayout{
        spacing: 5
        antialiasing: false
        width: rectangle.width
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true
        Text {
            text: vm.pythonInstalled ? qsTr("Python27 найден") : qsTr("Не найден Python27")
            Layout.fillWidth: true
        }
        Button{
            text: "Установить"
            Layout.maximumWidth: 120
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            enabled: !vm.pythonInstalled
            onPressed: {
                vm.installPython()
            }
        }
    }


    Button{
        text: "Добавить debugger"
        onPressed: {
            vm.addDebugger()
        }
    }


    Button{
        text: "Добавить toolchain"
        onPressed: {
            vm.addToolchain()
        }
    }


    Button{
        text: "Добавить kit"
        onPressed: {
            vm.addKit()
        }
    }


    RowLayout{
        Text {
            id: qtCreatorInstalledText
            text: qsTr("QT Creator status: " + vm.qtCreatorInstalled)
        }
        Text {
            id: pythonInstalledText
            text: qsTr("Python27 status: " + vm.pythonInstalled)
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.8999999761581421;height:700;width:350}
}
##^##*/
