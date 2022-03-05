import QtQuick 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12

import "contentUI"
import com.dibot 1.0



RowLayout  {
    id: root
    spacing: 20
    anchors.fill: parent

    InstallerMenuVM{
        id: installerVM
    }

    property var excludePackageIDs: []

    property var filtredPackageIDs: []

    onVisibleChanged: {
        if (root.visible){
            installerVM.addPATH()
            installerVM.addCompilerVariables()
        }
    }

    PackagesInstallTabBar {
        id: installerui_tabbar
        filtredPackageIDs: root.filtredPackageIDs
        Layout.fillHeight: true
        Layout.fillWidth: false
        width: 120
        Layout.leftMargin: 10
    }

    Item{
        id: installerui_content
        Layout.topMargin: 10
        Layout.bottomMargin: 10
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
                                                   title: stagesModel.title,
                                                   imagesURLList: stagesModel.imagesURLList,
                                                   hintList: stagesModel.hintList,
                                                   installFunction: stagesModel.installFunction,
                                                   showAgain: stagesModel.showAgain
                                               })
                        break
                    case "contentUI/LicenceUI.qml":
                        var view = component.createObject(this, {width: this.width, height: this.height})
                        if (Qt.platform.os == "linux"){
                            view.anchors.fill = this
                        }
                        view.licenceAccepted = root.licenceAccepted
                        view.licenceAcceptedSignal.connect((newValue) => {
                                                               root.licenceAccepted = newValue
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
    }
}
