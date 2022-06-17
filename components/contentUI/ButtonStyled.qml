import QtQuick 2.6
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Button{
    id: button

    property string color_disabled: "#993D00"

    property string color_default: "#E35B00"

    property string color_hovered: "#FF6600"

    property string color_pressed: "#FF6600"

    Layout.preferredHeight: 40
    Layout.preferredWidth: 90

    text: "Button"
    //font.letterSpacing: 1
    font.hintingPreference: Font.PreferDefaultHinting
    font.weight: Font.Normal
    font.pointSize: 10
    font.family: "Arial"
    font.bold: true

    background: Rectangle{
        anchors.fill: parent

        color: {
            if (enabled){
                if (hovered){
                    return parent.color_hovered
                }
                else{
                    return parent.pressed ? parent.color_pressed : parent.color_default
                }
            }
            else{
                return parent.color_disabled
            }
        }

        border.color: "#26282a"
        border.width: 1
        radius: 4
    }
}

/*##^##
Designer {
    D{i:0;height:50;width:100}
}
##^##*/
