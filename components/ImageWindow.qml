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

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.2
import QtQml 2.12

import "contentUI"

Window {
    id: imagewindow_root

    width: 800; height: 600
    minimumWidth: 800
    minimumHeight: 600

    property int highestZ: 0
    property real defaultSize: 1000
    property var currentFrame: undefined
    property real surfaceViewportRatio: 1.0

    property string imageSource: "qrc:/components/slides/jlink/1.png"

    ColumnLayout{
        anchors.fill: parent
        anchors.topMargin: 0
        anchors.bottomMargin: 15
        spacing: 15

        Flickable {
            id: flick
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width * surfaceViewportRatio
            contentHeight: height * surfaceViewportRatio

            Rectangle {
                id: photoFrame
                width: flick.width
                height: flick.height
                scale: defaultSize / Math.max(image.sourceSize.width, image.sourceSize.height)
                //                Behavior on scale { NumberAnimation { duration: 200 } }
                Behavior on x { NumberAnimation { duration: 200 } }
                Behavior on y { NumberAnimation { duration: 200 } }
                //                border.color: "black"
                //                border.width: 2

                transformOrigin: Item.Center
                smooth: true
                antialiasing: true

                Component.onCompleted: {
                    x = 0
                    y = 0
                    rotation = 0
                }

                focus: true

                Keys.enabled: true
                Keys.onEscapePressed: {
                    imagewindow_root.close()
                }

                Image {
                    id: image
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    source: imagewindow_root.imageSource
                    antialiasing: true
                }

                PinchArea {
                    anchors.fill: parent
                    pinch.target: photoFrame
                    pinch.minimumRotation: -360
                    pinch.maximumRotation: 360
                    pinch.minimumScale: 1
                    pinch.maximumScale: 10
                    pinch.dragAxis: Pinch.XAndYAxis
                    property real zRestore: 0
                    onSmartZoom: {
                        if (pinch.scale > 0) {
                            photoFrame.rotation = 0;
                            flick.scale = Math.min(imagewindow_root.width, imagewindow_root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
                            photoFrame.x = flick.contentX + (flick.width - photoFrame.width) / 2
                            photoFrame.y = flick.contentY + (flick.height - photoFrame.height) / 2
                            zRestore = photoFrame.z
                            photoFrame.z = ++imagewindow_root.highestZ;
                        } else {
                            photoFrame.rotation = pinch.previousAngle
                            flick.scale = pinch.previousScale
                            photoFrame.x = pinch.previousCenter.x - photoFrame.width / 2
                            photoFrame.y = pinch.previousCenter.y - photoFrame.height / 2
                            photoFrame.z = zRestore
                            --imagewindow_root.highestZ
                        }
                    }

                    MouseArea {
                        id: dragArea
                        hoverEnabled: true
                        anchors.fill: parent
                        drag.target: photoFrame
                        scrollGestureEnabled: false  // 2-finger-flick gesture should pass through to the Flickable
                        onHoveredChanged: {
                            console.log("onHoveredChanged")
                        }

                        onPressed: {
                            photoFrame.z = ++imagewindow_root.highestZ;
                        }
                        onWheel: (wheel) => {
                                     if (wheel.modifiers & Qt.ControlModifier) {
                                         photoFrame.rotation += wheel.angleDelta.y / 120 * 5;
                                         if (Math.abs(photoFrame.rotation) < 4)
                                         photoFrame.rotation = 0;
                                     } else {
                                         photoFrame.rotation += wheel.angleDelta.x / 120;
                                         if (Math.abs(photoFrame.rotation) < 0.6)
                                         photoFrame.rotation = 0;
                                         var scaleBefore = flick.scale;
                                         flick.scale += flick.scale * wheel.angleDelta.y / 120 / 10;
                                     }
                                 }
                    }
                }
            }
        }


        Timer { id: scrollFadeTimer; interval: 1000; onTriggered: { hfade.start(); vfade.start() } }

        RowLayout{
            Item{
                Layout.fillWidth: true
                Layout.fillHeight: false
            }

            ButtonStyled{
                id: buttonClose
                text: "Закрыть"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                onClicked: {
                    imagewindow_root.close()
                }
            }

            Item{
                Layout.fillWidth: true
                Layout.fillHeight: false
            }
        }
    }



    Rectangle {
        id: verticalScrollDecorator
        anchors.right: parent.right
        anchors.margins: 2
        color: "black"
        border.color: "gray"
        border.width: 1
        width: 5
        radius: 2
        antialiasing: true
        height: flick.height * (flick.height / flick.contentHeight) - (width - anchors.margins) * 2
        y: (flick.contentY - flick.originY) * (flick.height / flick.contentHeight)
        NumberAnimation on opacity { id: vfade; to: 0; duration: 500 }
        onYChanged: { opacity = 1.0; scrollFadeTimer.restart() }
    }

    Rectangle {
        id: horizontalScrollDecorator
        anchors.bottom: parent.bottom
        anchors.margins: 2
        color: "black"
        border.color: "gray"
        border.width: 1
        height: 5
        radius: 2
        antialiasing: true
        width: flick.width * (flick.width / flick.contentWidth) - (height - anchors.margins) * 2
        x: (flick.contentX - flick.originY) * (flick.width / flick.contentWidth)
        NumberAnimation on opacity { id: hfade; to: 0; duration: 500 }
        onXChanged: { opacity = 1.0; scrollFadeTimer.restart() }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2}D{i:7}D{i:8}D{i:1}D{i:12}D{i:13}
}
##^##*/
