import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt5Compat.GraphicalEffects
import com.dibot 1.0
import com.FileSystemAPI 1.0
import "contentUI"


ColumnLayout{
    id: intro_root

    signal buttonNext

    Text {
        color: "#e35b00"
        Layout.fillWidth: true
        padding: 10

        text: "<h2>Вас приветствует установщик ДИРОН</h2>"
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

        FileSystemAPI{
            id: file_system_api
        }

        clip: true
        wheelEnabled: true

        Component.onCompleted: {
            var html = file_system_api.getFileContent(":/contentUI/overview.html")
            textbox.text = html
        }

        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.interactive: false
        ScrollBar.vertical.interactive: true

        ColumnLayout{
            Text {
                id: textbox
                width: scrollableBox.width
                font.pointSize: 10

                text: "<b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i><b>Описание</b> <i>продукта.</i>"
                font.family: "Arial"
                wrapMode: Text.WordWrap
                Layout.bottomMargin: 15
                Layout.topMargin: 15
                Layout.leftMargin: 15
                fontSizeMode: Text.Fit
                textFormat: Text.RichText
            }

            RowLayout{
                Layout.preferredWidth: scrollableBox.width - 50

                Layout.bottomMargin: 15
                Layout.topMargin: 0
                Layout.leftMargin: 15
                Layout.rightMargin: 15


                ColumnLayout{

                    RadioButton{
                        id: radioLicence
                        text: "Имеется JLink-совместимый программатор"
                        Layout.topMargin: 0
                        font.family: "Arial"
                    }
                    RadioButton{
                        text: "Отсутствует JLink-совместимый программатор"
                        Layout.topMargin: 5
                        font.family: "Arial"
                        checked: true
                    }
                }

                Item{
                    Layout.fillWidth: true
                }

                ButtonStyled{
                    text: "Далее"
                    onPressed: {
                        intro_root.buttonNext()
                    }
                }
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:3}D{i:5}D{i:8}D{i:9}D{i:7}D{i:10}
D{i:11}D{i:6}D{i:4}D{i:2}
}
##^##*/
