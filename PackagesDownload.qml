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

    Component.onCompleted: {
        PackagesDownloader.fetchSource()
    }

    Connections{
        target: PackagesDownloader
        onSourceFetched: {
            var sources_platform = PackagesDownloader.getSources_platform()
            var sources_url = PackagesDownloader.getSources_url()

            console.log("sources_platform: " + sources_platform)
            console.log("sources_url: " + sources_url)

            PackagesDownloader.fetchPackages(root.excludePackageIDs)
        }
        onPackagesFetched: {
            var descriptors = PackagesDownloader.getPackages()
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

            signal buttonNext

            spacing: 0

            width: parent.width - 20

            Component.onCompleted: {
                dataObject.percentageChanged.connect((newValue) => {
                                                         console.log("percentageChanged " + newValue)
                                                     })
                dataObject.completedChanged.connect((newValue) => {
                                                         console.log("completedChanged " + newValue)
                                                     })
                dataObject.errorChanged.connect((newValue) => {
                                                         console.log("errorChanged " + newValue)
                                                     })
                dataObject.errorDescriptionChanged.connect((newValue) => {
                                                         console.log("errorDescriptionChanged " + newValue)                                 })
            }

            Label {
                id: label_description
                text: dataObject.description
                horizontalAlignment: Text.AlignHCenter
                Layout.topMargin: 5
                font.pointSize: 12
                Layout.fillWidth: true
            }

            RowLayout {
                id: rowLayout
                Layout.fillWidth: true

                BusyIndicator {
                    id: busyIndicator
                    Layout.fillHeight: false
                    running: !dataObject.completed
                }

                ColumnLayout{
                    Label {
                        id: label_status
                        text: qsTr("Выполняется загрузка...")
                        horizontalAlignment: Text.AlignHCenter
                        Layout.minimumWidth: 150
                        Layout.fillWidth: true
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

        Layout.preferredWidth: parent.width
        Layout.fillHeight: true

        orientation: ListView.Vertical
        spacing: 0
    }

    Item {
        Layout.fillHeight: false
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
            enabled: true
            onPressed: {
                root.buttonNext()
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:11}D{i:12}D{i:14}D{i:15}
D{i:13}
}
##^##*/
