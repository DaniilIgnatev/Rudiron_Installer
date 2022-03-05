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

    function setExcludePackageIDs(){
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

    property alias withJLink: radio2.checked

    property alias withVSCode: radio3.checked

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
            Layout.topMargin: 0

            ColumnLayout {
                Layout.fillWidth: true
                RadioButton {
                    id: radio1
                    text: "Вариант установки без JLink-совместимого программатора"
                    Layout.fillWidth: true
                    checked: true
                    font.family: "Arial"
                    Layout.topMargin: 5
                }

                RadioButton {
                    id: radio2
                    text: "Вариант установки с JLink-совместимым программатором (для продвинутых пользователей)"
                    Layout.fillWidth: true
                    checked: false
                    font.family: "Arial"
                    Layout.topMargin: 0
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        Text {
            property string jlink_description: "Будет доступна прошивка через интерфейс SWD, отладка в реальном времени, просмотр и редактирование значений регистров процессора и периферии"
            property string com_description: "Будет доступная прошивка через встроенный UART загрузчик"

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
                    text: "Вариант установки с IDE Visual Studio Code"
                    Layout.fillWidth: true
                    checked: true
                    font.family: "Arial"
                    Layout.topMargin: 0
                }

                RadioButton {
                    id: radio4
                    text: "Вариант установки с IDE QtCreator (для продвинутых пользователей)"
                    Layout.fillWidth: true
                    checked: false
                    font.family: "Arial"
                    Layout.topMargin: 5
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        Text {
            property string vscode_description: "Будет установлен универсальный редактор исходного кода от Microsoft"
            property string qtcreator_description: "Будет установлена свободная IDE для разработки на С, C++, JavaScript и QML"

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
                setExcludePackageIDs()
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
