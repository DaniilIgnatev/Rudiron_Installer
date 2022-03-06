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

import com.dibot 1.0
import com.PackagesDownloader 1.0


ColumnLayout{
    id: root


    property var filtredPackageIDs: []


    onVisibleChanged: {
        if (root.visible){
            buildTabs()
            root.tabs[0].checked = true
            updateContent()
        }
    }

    InstallerMenuVM{
        id: installerVM
    }


    property var tabs: []

    function tabChecked(pos){
        console.log("tab" + pos + " checked")
        selectedPos = pos

        for (var i = 0; i < root.tabs.length; i++){
            var tab = root.tabs[i];
            if (tab.position !== pos){
                tab.checked = false
            }
        }
    }

    function buildTabs(){
        root.tabs = getFiltredTabs()
        root.spacing = 70 / root.tabs.length
        updateTabsVisibility()
        updateTabsPosition()
    }

    function getFiltredTabs(){
        var filtred_tabs = []
        var isWindows = (Qt.platform.os === "windows")

        if (filtredPackageIDs.includes("python") && isWindows){
            filtred_tabs.push(tab_python27)
        }
        if (filtredPackageIDs.includes("jlink")){
            filtred_tabs.push(tab_jlink)
            if (isWindows){
                filtred_tabs.push(tab_zadig)
            }
        }
        if (filtredPackageIDs.includes("qt")){
            filtred_tabs.push(tab_qtcreator)
            filtred_tabs.push(tab_qtcreator_toolchain)
            filtred_tabs.push(tab_qtcreator_manual)
        }
        if (filtredPackageIDs.includes("vscode")){

        }

        return filtred_tabs
    }

    function updateTabsVisibility(){
        root.tabs.forEach(e => {
            e.visible = true
        })
    }

    function updateTabsPosition(){
        var i = 0
        root.tabs.forEach(e => {
            e.position = i
            i++
        })
    }


    PackagesInstallTab{
        id: tab_jlink
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 0
        text: "JLink"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "../slides/jlink/1.png",
                    "../slides/jlink/2.png",
                    "../slides/jlink/3.png",
                    "../slides/jlink/4.png",
                    "../slides/jlink/5.png"
                ],
                hintList: [
                    "Нажмите \"Next\".",
                    "Нажмите \"I Agree\".",
                    "Нажмите \"Install\".",
                    "Нажмите \"Ok\".",
                    "Нажмите \"Finish\"."
                ],
                installFunction: function(){
                    installerVM.installJlink()
                }
            }]
    }


    PackagesInstallTab{
        id: tab_zadig
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 1
        text: "Zadig"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "../slides/zadig/jlink.png",
                    "../slides/zadig/1.png",
                    "../slides/zadig/2.png",
                    "../slides/zadig/3.png",
                    "../slides/zadig/4.png"
                ],
                hintList: [
                    "Подключите JLink-совместимый программатор к компьютеру",
                    "Нажмите \"Options\".",
                    "Нажмите \"List All Devices\".",
                    "Выберите устройство \"BULK interface\" и драйвер \"WinUSB\", нажмите \"Replace Driver\".",
                    "Процесс замены драйвера может занять занять нескольтко минут."
                ],
                installFunction: function(){
                    installerVM.runZadig()
                }
            }]
    }


    PackagesInstallTab{
        id: tab_python27
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 2
        text: "Python 2.7"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "../slides/python27/1.png",
                    "../slides/python27/2.png",
                    "../slides/python27/3.png",
                    "../slides/python27/4.png"
                ],
                hintList: [
                    "Нажмите \"Next\".",
                    "Нажмите \"Next\".",
                    "Нажмите \"Next\".",
                    "Нажмите \"Finish\"."
                ],
                installFunction: function(){
                    installerVM.installPython()
                }
            }]
    }


    PackagesInstallTab{
        id: tab_qtcreator
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 3
        text: "Qt Creator"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "../slides/qtcreatorinstall/2022-01-09_12-02-57.png",
                    "../slides/qtcreatorinstall/2022-01-09_12-03-46.png",
                    "../slides/qtcreatorinstall/2022-01-09_12-03-54.png",
                    "../slides/qtcreatorinstall/2022-01-09_12-04-32.png",
                    "../slides/qtcreatorinstall/2022-01-09_12-04-55.png",
                    "../slides/qtcreatorinstall/2022-01-09_12-07-32.png",
                    "../slides/qtcreatorinstall/2022-01-09_12-07-42.png",
                    "../slides/qtcreatorinstall/2022-01-09_12-07-55.png",
                    "../slides/qtcreatorinstall/2022-01-09_12-08-10.png",
                ],
                hintList: [
                    "Предлагается онлайн установщик Qt Creator. Войдите в или создайте учетную запись Qt. Нажмите \"Далее\".",
                    "Отметьте оба условия соглашения. Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Выберите предоставлять ли анонимную информацию разработчикам Qt Creator. Нажмите \"Далее\".",
                    "Вы можете изменить каталог или добавить компоненты Qt. Нажмите \"Далее\".",
                    "Все опции необязательны для разработки под данный микроконтроллер. Нажмите \"Далее\".",
                    "Примите лицензионное соглашение. Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Установить\".",
                ],
                installFunction: function(){
                    var qtpackage = PackagesDownloader.getPackage("qt")
                    var destination = qtpackage.getDestination()
                    var uri = qtpackage.getURI();
                    installerVM.installQTCreator(destination, uri)
                }
            }]
    }


    PackagesInstallTab{
        id: tab_qtcreator_toolchain
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 4
        text: "Инструментарий"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: false,
                imagesURLList: [
                    "../slides/qtcreatortoolchain/qt_logo_green_rgb_whitespace.png",
                    "../slides/qtcreatortoolchain/1.png",
                    "../slides/qtcreatortoolchain/2.png",
                    "../slides/qtcreatortoolchain/3.png",
                    "../slides/qtcreatortoolchain/4.png",
                    "../slides/qtcreatortoolchain/5.png",
                    "../slides/qtcreatortoolchain/6.png",
                    "../slides/qtcreatortoolchain/7.png",
                    "../slides/qtcreatortoolchain/8.png"
                ],
                hintList: [
                    "Перед первой установкой откройте и закройте Qt Creator.",
                    "Установщик активирует плагин BareMetal.",
                    "Установщик создает отладочный интерфейс.",
                    "Установщик создает отладочное устройство.",
                    "Установщик регистрирует cmake.",
                    "Установщик регистрирует отладчик arm gdb.",
                    "Установщик регистрирует компилятор arm gcc.",
                    "Установщик регистрирует компилятор arm g++.",
                    "Установщик добавляет инструментарий разработки под ARM."
                ],
                installFunction: function(){
                    installerVM.enableBareMetalPlugin()
                    installerVM.createOpenOCDDebugProvider()
                    installerVM.createBareMetalDevice()
                    installerVM.createCmakeTools()
                    installerVM.addDebugger()
                    installerVM.addToolchain()
                    installerVM.addKit()
                }
            }]
    }


    PackagesInstallTab{
        id: tab_qtcreator_manual
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 5
        text: "Руководство"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: false,
                imagesURLList: [
                    "../slides/qtcreatorguide/2022-01-10_11-47-06.png",
                    "../slides/qtcreatorguide/2022-01-10_11-47-46.png",
                    "../slides/qtcreatorguide/2022-01-08_19-23-57.png",
                    "../slides/qtcreatorguide/2022-01-08_19-25-10.png",
                    "../slides/qtcreatorguide/2022-01-08_19-26-07.png",
                    "../slides/qtcreatorguide/2022-01-09_20-58-03.png",
                    "../slides/qtcreatorguide/2022-01-09_21-15-30.png",
                    "../slides/qtcreatorguide/2022-01-09_20-58-18.png",
                    "../slides/qtcreatorguide/2022-01-09_19-46-40.png",
                    "../slides/qtcreatorguide/2022-01-09_13-46-53.png",
                    "../slides/qtcreatorguide/2022-01-09_13-47-02.png",
                    "../slides/qtcreatorguide/2022-01-09_13-47-38.png",
                    "../slides/qtcreatorguide/2022-01-09_13-47-51.png",
                    "../slides/qtcreatorguide/2022-01-09_20-58-56.png",
                    "../slides/qtcreatorguide/2022-01-09_21-02-29.png",
                    "../slides/qtcreatorguide/2022-01-09_13-52-50.png",
                    "../slides/qtcreatorguide/2022-01-09_21-03-12.png",
                    "../slides/qtcreatorguide/2022-01-09_21-03-42.png",
                    "../slides/qtcreatorguide/2022-01-09_21-04-23.png",
                    "../slides/qtcreatorguide/2022-01-09_21-05-13.png",
                ],
                hintList: [
                    "Запустите Qt Creator. Во вкладке \"Файл\" выберите \"открыть проект\".",
                    "Откройте qbs файл DIRonTemplate проекта. Ссылка на гитхаб: https://github.com/Guvernant/DIRonTemplate",
                    "При первом запуске, если появилось предупреждение, нажмите \"ОК\".",
                    "Выберите только комплект \"1986be92qi_arm\", нажмите \"Configure project\".",
                    "Вкладка \"Проекты\". Можно изменить каталог сборки.",
                    "Вкладка \"Редактор\". В файле app.cpp пишется код программы",
                    "Вкладка \"Редактор\". В файле board.hpp нужно раскомментировать версию платы.",
                    "Вкладка \"diron_qbs\". Можно переключать сборку между отладкой и выпуском.",
                    "Для сборки проекта нажмите на иконку молотока.",
                    "Подключите программатор к контроллеру. Пример команды проверки связи с платой.",
                    "Запустится сервер, к которому можно подключиться через gdb или telnet.",
                    "Пример команды программирования напрямую через openocd и JLink.",
                    "Микроконтроллер успешно прошит.",
                    "Прошивка и отладка возможна через Qt Creator. Зеленая стрелка внизу слева.",
                    "У микроконтроллера ограничение в 6 точек останова. При превышении возникнет ошибка.",
                    "Управление отладчиком производится через кнопки в центре экрана.",
                    "Активируйте обзоры \"Регистры\" и \"Регистры периферии\".",
                    "В окне \"Регистры периферии\" правой кнопкой мыши выберите группу регистров PORTA.",
                    "Правой кнопкой мыши выберите двоичный формат.",
                    "Установка выделенного бита в 1 зажгет светодиод.",
                    ],
                installFunction: null
            }]
    }


    property int selectedPos: 0


    onSelectedPosChanged: {
        updateContent()
    }


    function updateContent(){
        var qmlStr = root.tabs[selectedPos].contentQML
        if (qmlStr === "contentUI/StagesObserverUI.qml"){
            var selectedTab = root.tabs[selectedPos]
            var model = selectedTab.model[0]
            installerui_content.updateContent(qmlStr, model)
        }
        else{
            installerui_content.updateContent(qmlStr, null)
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:620;width:130}D{i:1}D{i:2}D{i:3}D{i:4}
D{i:5}D{i:6}D{i:7}D{i:8}D{i:9}
}
##^##*/
