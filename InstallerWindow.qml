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



import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Window {

    id: app
    title: "Установщик ДИРОН"
    visible: true

    minimumWidth: 800
    minimumHeight: minimumWidth * 3 / 4

    maximumWidth: minimumWidth
    maximumHeight: minimumHeight

    InstallerUI{

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:600;width:800}D{i:1}
}
##^##*/
