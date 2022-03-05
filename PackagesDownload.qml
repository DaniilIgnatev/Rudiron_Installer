import QtQuick 2.6
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
//import Qt5Compat.GraphicalEffects

import com.dibot 1.0
import com.FileSystemAPI 1.0
import "contentUI"
import com.PackageDescriptor 1.0
import com.PackagesDownloader 1.0


ColumnLayout{
    id: root

    property var excludePackageIDs: []

    property var filtredPackageIDs: []

    onVisibleChanged: {
        if (root.visible){
            PackagesDownloader.fetchSource()
        }
    }

    property int packagesToDownload: -1

    Connections{
        target: PackagesDownloader
        onSourceFetched: {
            var sources_platform = PackagesDownloader.getSources_platform()
            var sources_url = PackagesDownloader.getSources_url()

            console.log("sources_platform: " + sources_platform)
            console.log("sources_url: " + sources_url)

            PackagesDownloader.fetchPackages()
        }
        onPackagesFetched: {
            console.log("Exclude packages: ", root.excludePackageIDs)
            root.filtredPackageIDs = PackagesDownloader.getFiltredPackagesIDs(root.excludePackageIDs)
            console.log("Filtred packages: ", root.filtredPackageIDs)
            var descriptors = PackagesDownloader.getPackages(root.excludePackageIDs)
            packagesToDownload = descriptors.count()
            descriptors_ui.model = descriptors
        }
    }

    signal buttonNext

    Text {
        color: "#e35b00"
        Layout.fillWidth: true
        Layout.topMargin: 10

        text: "<h2>Загрузка пакетов</h2>"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Arial"

        renderType: Text.QtRendering
        font.pointSize: 14

        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
        textFormat: Text.RichText
    }

    Component {
        id: packageDelegate

        ColumnLayout{
            id: root

            Component.onCompleted: {
                dataObject.completedChanged.connect((newValue) => {
                                                        if (newValue){
                                                            packagesToDownload = packagesToDownload - 1;
                                                        }
                                                    })
                PackagesDownloader.downloadPackage(dataObject)
            }

            signal buttonNext

            spacing: 0

            width: parent.width

            RowLayout {
                id: rowLayout

                Layout.preferredHeight: 50
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10

                BusyIndicator {
                    id: busyIndicator
                    Layout.fillHeight: false
                    Layout.preferredWidth: 50
                    running: !dataObject.completed && !dataObject.error
                    visible: running
                }

                ColumnLayout{
                    RowLayout {
                        Layout.fillWidth: true

                        Item{
                            Layout.fillWidth: true
                        }

                        Label {
                            id: label_status
                            text: dataObject.completed ? qsTr("Загрузка завершена: ") : qsTr("Выполняется загрузка: ")
                            horizontalAlignment: Text.AlignHCenter
                            visible: !dataObject.error
                        }
                        Label {
                            id: label_error
                            text: qsTr("Возникла ошибка: ") + dataObject.errorDescription
                            horizontalAlignment: Text.AlignHCenter
                            visible: dataObject.error
                        }
                        Label {
                            id: label_description
                            text: dataObject.description
                            horizontalAlignment: Text.AlignHCenter
                            font.italic: true
                            font.pointSize: 9
                            font.bold: false
                        }

                        Item{
                            Layout.fillWidth: true
                        }
                    }

                    ProgressBar {
                        id: progressBar
                        Layout.fillWidth: true
                        from: 0.0
                        value: dataObject.percentage
                        to: 100.0
                    }
                }
            }
        }
    }

    ListView{
        id: descriptors_ui
        pixelAligned: false
        boundsBehavior: Flickable.StopAtBounds
        interactive: false
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        delegate: packageDelegate

        Layout.topMargin: 15
        Layout.preferredWidth: parent.width
        Layout.fillHeight: true

        orientation: ListView.Vertical
        spacing: 0
    }

    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.rightMargin: 15
        Layout.bottomMargin: 27

        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
        }

        ButtonStyled {
            text: "Далее"
            enabled: root.packagesToDownload === 0
            onPressed: {
                root.buttonNext()
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:14}D{i:15}D{i:17}D{i:18}
D{i:16}
}
##^##*/
