import QtQuick 2.0
import QtQuick.Layouts 1.15
import "contentUI"

RowLayout  {
    id: installerui_root
    anchors.fill: parent
    spacing: 5

    property bool licenceAccepted: false

    TabBar {
        id: installerui_tabbar
        Layout.fillHeight: true
        Layout.fillWidth: false
        width: 120

    }


    Item{
        id: installerui_content
        Layout.fillWidth: true
        Layout.fillHeight: true

        function updateContent(qmlStr, stagesModel){
            var component = Qt.createComponent(qmlStr)

            if (component !== null){
                if (component.status === Component.Ready){
                    for (var i = 0; i < this.children.length;i++){
                        this.children[i].destroy()
                    }

                    if (stagesModel !== null){
                        component.createObject(this, {
                                                   width: this.width,
                                                   height: this.height,
                                                   imagesURLList: model.imagesURLList,
                                                   hintList: model.hintList,
                                                   installFunction: model.installFunction
                                               })
                    }
                    else{
                        component.createObject(this, {width: this.width, height: this.height})
                    }
                }
                else if (component.status === Component.Error) {
                    console.log("Error loading component:", component.errorString());
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:600;width:800}D{i:1}D{i:2}
}
##^##*/
