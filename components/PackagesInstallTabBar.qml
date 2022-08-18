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

        if (isWindows){
            filtred_tabs.push(tab_cp2102)
        }

        if (filtredPackageIDs.includes("jlink")){
            filtred_tabs.push(tab_jlink)
            if (isWindows){
                filtred_tabs.push(tab_zadig)
            }
        }

        if (filtredPackageIDs.includes("python") && isWindows){
            filtred_tabs.push(tab_python27)
        }

        if (filtredPackageIDs.includes("qt")){
            filtred_tabs.push(tab_qtcreator)
            filtred_tabs.push(tab_qtcreator_toolchain)
            filtred_tabs.push(tab_qtcreator_manual)
        }
        if (filtredPackageIDs.includes("vscode")){
            filtred_tabs.push(tab_vscodeinstall)
            filtred_tabs.push(tab_vscodetoolchain)
            filtred_tabs.push(tab_vscodeguide)
        }

        if (filtredPackageIDs.includes("jlink")){
            filtred_tabs.push(tab_programmer2)
        }

        filtred_tabs.push(tab_terminal)

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


    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true
    }


    PackagesInstallTab{
        id: tab_cp2102
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 2
        text: "Драйвер\nCOM-порта"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "qrc:/slides/cp2102x/1.png",
                    "qrc:/slides/cp2102x/2.png",
                    "qrc:/slides/cp2102x/3.png"
                ],
                hintList: [
                    "Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Готово\"."
                ],
                installFunction: function(){
                    installerVM.installCp210x()
                }
            }]
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
                    "qrc:/slides/jlink/1.png",
                    "qrc:/slides/jlink/2.png",
                    "qrc:/slides/jlink/3.png",
                    "qrc:/slides/jlink/4.png",
                    "qrc:/slides/jlink/5.png",
                    "qrc:/slides/jlink/2022-01-09_13-46-53.png",
                    "qrc:/slides/jlink/2022-01-09_13-47-02.png",
                    "qrc:/slides/jlink/2022-01-09_13-47-38.png",
                    "qrc:/slides/jlink/2022-01-09_13-47-51.png",
                ],
                hintList: [
                    "Нажмите \"Next\".",
                    "Нажмите \"I Agree\".",
                    "Нажмите \"Install\".",
                    "Нажмите \"Ok\".",
                    "Нажмите \"Finish\".",
                    "Пример проверки связи программатора JLink с контроллером.",
                    "Запустился tcp сервер, к которому можно подключиться через gdb или telnet.",
                    "Пример команды программирования контроллера через openocd и JLink.",
                    "Микроконтроллер успешно прошит.",
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
                    "qrc:/slides/zadig/jlink.png",
                    "qrc:/slides/zadig/1.png",
                    "qrc:/slides/zadig/2.png",
                    "qrc:/slides/zadig/3.png",
                    "qrc:/slides/zadig/4.png"
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
                    "qrc:/slides/python27/1.png",
                    "qrc:/slides/python27/2.png",
                    "qrc:/slides/python27/3.png",
                    "qrc:/slides/python27/4.png"
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
                    "qrc:/slides/qtcreatorinstall/offline.png",
                    "qrc:/slides/qtcreatorinstall/2022-03-10_17-44-17.png",
                    "qrc:/slides/qtcreatorinstall/2022-03-10_17-44-25.png",
                    "qrc:/slides/qtcreatorinstall/2022-03-10_17-44-33.png",
                    "qrc:/slides/qtcreatorinstall/2022-03-10_17-44-46.png",
                    "qrc:/slides/qtcreatorinstall/2022-03-10_17-45-00.png",
                    "qrc:/slides/qtcreatorinstall/2022-03-10_17-45-10.png",
                    "qrc:/slides/qtcreatorinstall/2022-03-10_17-45-18.png",
                ],
                hintList: [
                    "Отключите компьютер от интернета.",
                    "Нажмите \"Next\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Установить\".",
                ],
                installFunction: function(){
                    var qtpackage = PackagesDownloader.getPackage("qt")
                    var destination = qtpackage.getDestination()
                    var installer = qtpackage.getInstallerName();
                    installerVM.install(destination, installer)
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
                    "qrc:/slides/qtcreatortoolchain/qt_logo_green_rgb_whitespace.png",
                    "qrc:/slides/qtcreatortoolchain/1.png",
                    "qrc:/slides/qtcreatortoolchain/2.png",
                    "qrc:/slides/qtcreatortoolchain/3.png",
                    "qrc:/slides/qtcreatortoolchain/4.png",
                    "qrc:/slides/qtcreatortoolchain/5.png",
                    "qrc:/slides/qtcreatortoolchain/6.png",
                    "qrc:/slides/qtcreatortoolchain/7.png",
                    "qrc:/slides/qtcreatortoolchain/8.png"
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
        text: "Программирование"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: false,
                imagesURLList: [
                    "qrc:/slides/qtcreatorguide/2022-03-08_19-43-43.png",
                    "qrc:/slides/qtcreatorguide/2022-03-08_19-46-17.png",
                    "qrc:/slides/qtcreatorguide/2022-03-08_19-46-49.png",
                    "qrc:/slides/qtcreatorguide/2022-01-08_19-26-07.png",
                    "qrc:/slides/qtcreatorguide/2022-03-08_19-50-29.png",
                    "qrc:/slides/qtcreatorguide/2022-03-10_16-50-14.png",
                    "qrc:/slides/qtcreatorguide/2022-03-10_16-53-29.png",
                    "qrc:/slides/qtcreatorguide/2022-03-10_16-51-37.png",
                    "qrc:/slides/qtcreatorguide/2022-03-08_19-52-17.png",
                    "qrc:/slides/qtcreatorguide/2022-01-09_13-52-50.png",
                    "qrc:/slides/qtcreatorguide/2022-03-08_19-54-37.png",
                    "qrc:/slides/qtcreatorguide/2022-01-09_21-03-42.png",
                    "qrc:/slides/qtcreatorguide/2022-01-09_21-04-23.png",
                    "qrc:/slides/qtcreatorguide/2022-01-09_21-05-13.png",
                ],
                hintList: [
                    "Запустите Qt Creator. Во вкладке \"Файл\" выберите \"Открыть файл или проект\". Выберите CMakeLists.txt в папке проекта.",
                    "Если появилось данное предупреждение, нажмите \"ОК\".",
                    "Выберите только комплект \"1986be92qi_arm\", нажмите \"Configure project\".",
                    "Вкладка \"Проекты\". Можно изменить каталог сборки.",
                    "Вкладка \"Редактор\". В файле sketch_rudiron.cpp пишется код программы",
                    "В файле \"arm-none-eabi-gcc.cmake\" при необходимости укажите полный путь к компилятору.",
                    "Новые папки нужно добавлять в переменную \"SRC_LIST\".",
                    "Сохраняйте файл \"CMakeLists.txt\" каждый раз при изменении структуры проекта.",
                    "Можно переключать сборку между отладкой и выпуском, собирать или запускать на выполнение.",
                    "Управление отладчиком после запуска из QtCreator производится через панель инструментов в центре экрана.",
                    "Активируйте обзоры \"Регистры\" и \"Регистры периферии\".",
                    "В окне \"Регистры периферии\" правой кнопкой мыши выберите группу регистров PORTA.",
                    "Правой кнопкой мыши выберите двоичный формат.",
                    "Установка 4-го бита в \"1\" включит второй светодиод.",
                ],
                installFunction: null
            }]
    }


    PackagesInstallTab{
        id: tab_vscodeinstall
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 6
        text: "Visual Studio Code"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "qrc:/slides/vscodeinstall/2022-03-06_19-53-07.png",
                    "qrc:/slides/vscodeinstall/2022-03-06_19-53-21.png",
                    "qrc:/slides/vscodeinstall/2022-03-06_19-53-27.png",
                    "qrc:/slides/vscodeinstall/2022-03-06_19-55-44.png",
                    "qrc:/slides/vscodeinstall/2022-03-06_19-56-31.png"
                ],
                hintList: [
                    "Примите условия соглашения. Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Установить\".",
                    "Дождитесь окончания установки.",
                    "Нажмите \"Завершить\".",
                ],
                installFunction: function(){
                    var qtpackage = PackagesDownloader.getPackage("vscode")
                    var destination = qtpackage.getDestination()
                    var installer = qtpackage.getInstallerName();
                    installerVM.install(destination, installer)
                }
            }]
    }


    PackagesInstallTab{
        id: tab_vscodetoolchain
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 7
        text: "Инструментарий"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "qrc:/slides/vscodetoolchain/2022-03-06_19-57-18.png",
                    "qrc:/slides/vscodetoolchain/2022-03-06_19-57-43.png",
                    "qrc:/slides/vscodetoolchain/2022-08-18 в 16.49.54.png",
                    "qrc:/slides/vscodetoolchain/2022-08-18 в 16.50.07.png",
                    "qrc:/slides/vscodetoolchain/2022-08-18 в 16.51.25.png",
                ],
                hintList: [
                    "Установите расширение \"C/C++\".",
                    "Установите расширение \"Cortex-Debug\".",
                    "Установите расширение \"CMake\".",
                    "Установите расширение \"CMake-Tools\".",
                    "Установите расширение \"CMake Language Support\".",
                ],
                installFunction: null
            }]
    }


    PackagesInstallTab{
        id: tab_vscodeguide
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 8
        text: "Программирование"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "qrc:/slides/vscodeguide/2022-03-06_20-23-35.png",
                    "qrc:/slides/vscodeguide/2022-03-06_20-28-22.png",
                    "qrc:/slides/vscodeguide/2022-03-06_20-29-07.png",
                    "qrc:/slides/vscodeguide/2022-03-06_20-44-41.png",
                    "qrc:/slides/vscodeguide/2022-03-06_20-46-38.png",
                    "qrc:/slides/vscodeguide/2022-03-06_20-45-34.png",
                    "qrc:/slides/vscodeguide/2022-03-06_20-54-41.png",
                    "qrc:/slides/vscodeguide/2022-03-06_20-55-06.png",
                    "qrc:/slides/vscodeguide/2022-03-06_21-00-36.png",
                    "qrc:/slides/vscodeguide/2022-07-28_18-14-00.png",
                    "qrc:/slides/vscodeguide/2022-07-28_18-32-06.png",
                    "qrc:/slides/vscodeguide/2022-03-07_18-32-15.png",
                    "qrc:/slides/vscodeguide/2022-03-07_18-34-06.png",
                    "qrc:/slides/vscodeguide/2022-03-07_18-35-33.png",
                    "qrc:/slides/vscodeguide/2022-03-07_18-36-16.png",
                    "qrc:/slides/vscodeguide/2022-03-07_18-37-13.png",
                    "qrc:/slides/vscodeguide/2022-03-07_18-38-11.png",
                ],
                hintList: [
                    "Запустите VS Code. Во вкладке \"Файл\" выберите \"Открыть папку...\", выберите папку с проектом.",
                    "Откройте список комплектов.",
                    "Выберите комплект \"GCC Arm Embedded\".",
                    "В файле \"arm-none-eabi-gcc.cmake\" при необходимости укажите полный путь к компилятору.",
                    "Новые папки нужно добавлять в переменную \"SRC_LIST\".",
                    "Сохраняйте файл \"CMakeLists.txt\" каждый раз при изменении структуры проекта.",
                    "Во вкладке \"Терминал\" выберите \"Запуск задачи\".",
                    "Для сборки проекта нажмите \"Выпуск: собрать\" или CTRL+SHIFT+B.",
                    "В папке \"build\" создадутся bin, elf и hex файлы. В терминале указывается размер сегментов прошивки.",
                    "Для прошивки контроллера запустите задачу \"Загрузить в флеш-память\".",
                    "Пример процесса прошивки.",
                    "Пример запуска отладки через JLink и OpenOCD.",
                    "Пример просмотра регистров периферии через JLink и OpenOCD.",
                    "Поддерживается редактирование значений регистров.",
                    "По нажатию на правую кнопку мыши можно изменить формат представления значения.",
                    "Выберите двоичный формат представления.",
                    "Установка 4-го бита в \"1\" включит второй светодиод.",
                ],
                installFunction: null
            }]
    }


    //    PackagesInstallTab{
    //        id: tab_programmer
    //        visible: false
    //        onCheckedChanged: if (checked) {root.tabChecked(position)}
    //        position: 9
    //        text: "Встроенный\nпрограмматор"
    //        contentQML: "contentUI/StagesObserverUI.qml"
    //        enabled: true
    //        model: [{
    //                title: text,
    //                showAgain: true,
    //                imagesURLList: [
    //                    "qrc:/slides/programmer/2022-03-08_12-21-18.png",
    //                    "qrc:/slides/programmer/2022-03-08_12-23-06.png",
    //                    "qrc:/slides/programmer/2022-03-08_12-24-03.png",
    //                    "qrc:/slides/programmer/2022-03-08_12-26-09.png",
    //                    "qrc:/slides/programmer/2022-03-08_12-36-27.png",
    //                ],
    //                hintList: [
    //                    "Запустите приложение \"1986WSD\" в папке \"tools/programmer\".",
    //                    "Определите COM порт подключенной платы.",
    //                    "Внесите номер порта от 0 до 9 и нажмите \"Enter\".",
    //                    "Нажмите \"Browse\" и выберите hex файл для прошивки. В целях тестирования можно загрузить \"RudironTemplate.hex\".",
    //                    "Нажмите \"Start+Run\".",
    //                ],
    //                installFunction: null
    //            }]
    //    }


    PackagesInstallTab{
        id: tab_programmer2
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 9
        text: "Программатор"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "qrc:/slides/programmer2/0.png",
                    "qrc:/slides/programmer2/1.png",
                    "qrc:/slides/programmer2/2.png",
                ],
                hintList: [
                    "В комплект дистрибутива (директория \"Tools\") входит UART-программатор с возможностями: прошивать, запускать, верифицировать, очищать пользовательскую программу на контроллере",
                    "Пример вывода справки утилиты программирования в Bash терминале.",
                    "Пример прошивки с очисткой памяти, верификацией и запуском."
                ],
                installFunction: null
            }]
    }


    PackagesInstallTab{
        id: tab_terminal
        visible: false
        onCheckedChanged: if (checked) {root.tabChecked(position)}
        position: 9
        text: "Терминал"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: true
        model: [{
                title: text,
                showAgain: true,
                imagesURLList: [
                    "qrc:/slides/terminal/1.png",
                    "qrc:/slides/terminal/2.png",
                    "qrc:/slides/terminal/3.png",
                ],
                hintList: [
                    "В комплект дистрибутива (директория \"Tools\") входит терминал для обмена информацией с контроллером по UART.",
                    "Для начала работы выберите порт во вкладке передатчик.",
                    "После применения настроек порта можно отправлять / принимать сообщения.",
                ],
                installFunction: null
            }]
    }


    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true
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
    D{i:0;autoSize:true;formeditorZoom:0.75;height:620;width:130}
}
##^##*/
