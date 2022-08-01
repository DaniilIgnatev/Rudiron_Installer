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
import com.FileSystemAPI 1.0
import "contentUI"
import com.PackageDescriptor 1.0
import com.PackagesDownloader 1.0


ColumnLayout{
    id: root

    property var excludePackageIDs: []

    property var skipDownloadPackageIDs: []

    property var filtredPackageIDs: []

    onVisibleChanged: {
        if (root.visible){
            PackagesDownloader.fetchSource()
        }
    }

    property int packagesToDownload: -1

    onPackagesToDownloadChanged: {
        console.log("onPackagesToDownloadChanged")
        console.log(packagesToDownload)
    }

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
            console.log("Skip download packages: ", root.skipDownloadPackageIDs)
            PackagesDownloader.applySkipDownload(root.skipDownloadPackageIDs)
            root.filtredPackageIDs = PackagesDownloader.getFiltredPackagesIDs(root.excludePackageIDs)
            console.log("Filtred packages: ", root.filtredPackageIDs)
            var descriptors = PackagesDownloader.getPackages(root.excludePackageIDs)

            if (descriptors.count() !== 0){
                packagesToDownload = descriptors.count()
            }

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

    RowLayout {
        id: rowLayout
        visible: packagesToDownload === -1

        Layout.fillWidth: true
        Layout.fillHeight: true

        Layout.leftMargin: 15
        Layout.rightMargin: 15

        Item{
            Layout.fillWidth: true
        }


        ColumnLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true

            Item{
                Layout.fillHeight: true
            }

            RowLayout {
                BusyIndicator {
                    id: busyIndicator
                    Layout.fillHeight: false
                    Layout.preferredWidth: 50
                    Layout.topMargin: 13
                    running: true
                }

                Label {
                    id: label_fetchngPackages
                    text: "Ожидание ответа от сервера..."
                    horizontalAlignment: Text.AlignHCenter
                    topPadding: 10
                    font.italic: false
                    font.pointSize: 16
                    font.bold: false
                }
            }

            Item{
                Layout.fillHeight: true
            }
        }


        Item{
            Layout.fillWidth: true
        }
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

                Layout.fillWidth: true
                Layout.leftMargin: 15
                Layout.rightMargin: 15
                Layout.minimumHeight: 50

                BusyIndicator {
                    id: busyIndicator
                    Layout.fillHeight: false
                    Layout.preferredWidth: 50
                    Layout.topMargin: 13
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
                            id: label_description
                            text: "'" + dataObject.description + "'"
                            horizontalAlignment: Text.AlignHCenter
                            font.italic: false
                            font.pointSize: 10
                            font.bold: false
                        }

                        Label {
                            id: label_error
                            text: "Ошибка: " + dataObject.errorDescription
                            horizontalAlignment: Text.AlignHCenter
                            font.italic: false
                            font.pointSize: 10
                            font.bold: false
                            visible: dataObject.error
                        }

                        Label {
                            id: label_status
                            text: dataObject.completed ? " — загрузка завершена" : " — выполняется загрузка: "
                            horizontalAlignment: Text.AlignHCenter
                            font.italic: false
                            font.pointSize: 10
                            font.bold: false
                            visible: !dataObject.error
                        }

                        Label {
                            id: label_progress
                            text: "(" + dataObject.percentage.toString() + "%: " + dataObject.bytesReceived.toString() + " МБайт из " + dataObject.bytesTotal.toString() + " МБайт)"
                            horizontalAlignment: Text.AlignHCenter
                            font.italic: false
                            font.pointSize: 10
                            font.bold: false
                            visible: !dataObject.completed && !dataObject.error
                        }

//                        Label {
//                            id: labelstatus_complete_end
//                            text: qsTr(" ")
//                            horizontalAlignment: Text.AlignHCenter
//                            visible: dataObject.completed
//                        }

                        Item{
                            Layout.fillWidth: true
                        }
                    }

                    ProgressBar {
                        id: progressBar
                        Layout.topMargin: 2
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
        interactive: true
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
        Layout.bottomMargin: 15

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
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:2000}
}
##^##*/
