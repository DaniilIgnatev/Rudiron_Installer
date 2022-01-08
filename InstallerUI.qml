import QtQuick 2.0
import QtQuick.Layouts 1.15
import "contentUI"
import com.dibot 1.0

RowLayout  {
    id: installerui_root
    anchors.fill: parent
    spacing: 20

    property bool licenceAccepted: false


    InstallerMenuVM{
        id: installerVM
    }


    onLicenceAcceptedChanged: {
        if (licenceAccepted){
            console.log("Edit PATH");
            installerVM.addPATH()
        }
    }


    TabBar {
        id: installerui_tabbar
        Layout.fillHeight: true
        Layout.fillWidth: false
        width: 120
        Layout.leftMargin: 10
    }


    Item{
        id: installerui_content
        Layout.bottomMargin: 10
        Layout.topMargin: 10
        Layout.fillWidth: true
        Layout.fillHeight: true

        function getContent(){
            return children[0]
        }


        function updateContent(qmlStr, stagesModel){
            var component = Qt.createComponent(qmlStr)

            if (component !== null){
                if (component.status === Component.Ready){
                    for (var i = 0; i < this.children.length;i++){
                        this.children[i].destroy()
                    }

                    switch (qmlStr){
                    case "contentUI/StagesObserverUI.qml":
                        component.createObject(this, {
                                                   width: this.width,
                                                   height: this.height,
                                                   imagesURLList: stagesModel.imagesURLList,
                                                   hintList: stagesModel.hintList,
                                                   installFunction: stagesModel.installFunction
                                               })
                        break
                    case "contentUI/LicenceUI.qml":
                        var view = component.createObject(this, {width: this.width, height: this.height})
                        view.licenceAccepted = installerui_root.licenceAccepted
                        view.licenceAcceptedSignal.connect((newValue) => {
                            installerui_root.licenceAccepted = newValue
                        })
                        break
                    default:
                        component.createObject(this, {width: this.width, height: this.height})
                        break
                    }
                }
                else if (component.status === Component.Error) {
                    console.log("Error loading component:", component.errorString());
                }
            }
        }

        OverviewUI {
            id: overviewUI
            anchors.fill: parent
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:600;width:800}D{i:1}D{i:3}D{i:2}
}
##^##*/
