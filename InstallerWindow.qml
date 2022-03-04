/*
Copyright (C) THEDATE Ignatev Daniil
This file is part of DIBotInstaller <https://github.com/>.

DIBotInstaller is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

DIBotInstaller is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with DIBotInstaller. If not, see <http://www.gnu.org/licenses/>.
*/



import QtQuick 2.6
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.2

import com.dibot 1.0


Window {

    id: app

    title: "Установка Рудирон"
    visible: true

    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    minimumWidth: 800
    minimumHeight: minimumWidth * 3 / 4

    maximumWidth: minimumWidth
    maximumHeight: minimumHeight

    property int currentIndex: 4

    Intro {
        id: intro
        anchors.fill: parent
        visible: currentIndex == 0
        onButtonNext: {
            app.currentIndex = 1
        }
    }

    Licence {
        id: licence
        anchors.fill: parent
        visible: currentIndex == 1
        onButtonNext: {
            app.currentIndex = 2
        }
    }

    PackagesOptions {
        id: packagesOptions
        anchors.fill: parent
        visible: currentIndex == 2
        onButtonNext: {
            app.currentIndex = 3
        }
    }

    PackagesDownload {
        id: packagesDownload
        anchors.fill: parent
        visible: currentIndex == 3
        onButtonNext: {
            app.currentIndex = 4
        }
        excludePackageIDs: packagesOptions.excludePackageIDs
    }

    PackagesInstall {
        id: installerbody
        anchors.fill: parent
        visible: currentIndex == 4
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:4}D{i:5}
}
##^##*/
