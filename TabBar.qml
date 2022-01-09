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
import QtQuick.Layouts 1.15
import com.dibot 1.0


ColumnLayout{
    id: tabbar_root


    Component.onCompleted: {
        tab0.checked = true
        updateContent()
    }


    spacing: 10


    InstallerMenuVM{
        id: installerVM
    }


    Tab{
        id: tab0
        onCheckedChanged: tabbar_root.tabChecked(position)
        position: 0
        text: "Описание"
        contentQML: "contentUI/OverviewUI.qml"
    }

    Tab{
        id: tab1
        onCheckedChanged: tabbar_root.tabChecked(position)
        position: 1
        text: "Лицензия"
        contentQML: "contentUI/LicenceUI.qml"
    }

    Tab{
        id: tab2
        onCheckedChanged: tabbar_root.tabChecked(position)
        position: 2
        text: "Qt Creator"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: installerui_root.licenceAccepted
        model: [{
                imagesURLList: [
                    "../slides/qtcreator/2022-01-09_12-02-57.png",
                    "../slides/qtcreator/2022-01-09_12-03-46.png",
                    "../slides/qtcreator/2022-01-09_12-03-54.png",
                    "../slides/qtcreator/2022-01-09_12-04-32.png",
                    "../slides/qtcreator/2022-01-09_12-04-55.png",
                    "../slides/qtcreator/2022-01-09_12-07-32.png",
                    "../slides/qtcreator/2022-01-09_12-07-42.png",
                    "../slides/qtcreator/2022-01-09_12-07-55.png",
                    "../slides/qtcreator/2022-01-09_12-08-10.png",
                ],
                hintList: [
                    "Предлагается онлайн установщик Qt Creator. Укажите учетную запись Qt. Нажмите \"Далее\".",
                    "Отметьте оба условия соглашения. Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Выберите предоставлять ли анонимную информацию разработчикам Qt Creator. Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Все опции необязательны для разработки под данный микроконтроллер. Нажмите \"Далее\".",
                    "Примите лицензионное соглашение. Нажмите \"Далее\".",
                    "Нажмите \"Далее\".",
                    "Нажмите \"Установить\".",
                ],
                installFunction: function(){
                    console.log("Install Qt Creator");
                    installerVM.installQTCreator()}
            }]
    }

    Tab{
        id: tab3
        onCheckedChanged: tabbar_root.tabChecked(position)
        position: 3
        text: "JLink"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: installerui_root.licenceAccepted
        model: [{
                imagesURLList: ["../slides/jlink/1.png", "../slides/jlink/2.png", "../slides/jlink/3.png", "../slides/jlink/4.png", "../slides/jlink/5.png"],
                hintList: ["Нажмите \"Next\"", "Нажмите \"I Agree\"", "Нажмите \"Install\"", "Нажмите \"Ok\"", "Нажмите \"Finish\""],
                installFunction: function(){
                    console.log("installJlink");
                    installerVM.installJlink()
                }
            }]
    }

    Tab{
        id: tab4
        onCheckedChanged: tabbar_root.tabChecked(position)
        position: 4
        text: "Zadig"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: installerui_root.licenceAccepted
        model: [{
                imagesURLList: ["../slides/zadig/1.png", "../slides/zadig/2.png", "../slides/zadig/3.png", "../slides/zadig/4.png"],
                hintList: ["Нажмите \"Options\"", "Нажмите \"List All Devices\"", "Выберите устройство \"BULK interface\" и драйвер \"WinUSB\", нажмите \"Replace Driver\"", "Процесс замены драйвера может занять занять нескольтко минут"],
                installFunction: function(){
                    console.log("runZadig");
                    installerVM.runZadig()
                }
            }]
    }

    Tab{
        id: tab5
        onCheckedChanged: tabbar_root.tabChecked(position)
        position: 5
        text: "Python 2.7"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: installerui_root.licenceAccepted
        model: [{
                imagesURLList: ["../slides/python27/1.png", "../slides/python27/2.png", "../slides/python27/3.png", "../slides/python27/4.png"],
                hintList: ["Нажмите \"Next\"", "Нажмите \"Next\"", "Нажмите \"Next\"", "Нажмите \"Finish\""],
                installFunction: function(){
                    console.log("Install Python27");
                    installerVM.installPython()
                }
            }]
    }


    Tab{
        id: tab6
        onCheckedChanged: tabbar_root.tabChecked(position)
        position: 6
        text: "Инструментарий"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: installerui_root.licenceAccepted
        model: [{
                imagesURLList: [
                    "qrc:/slides/white.png",
                    "../slides/toolchain/1.png",
                    "../slides/toolchain/2.png",
                    "../slides/toolchain/3.png",
                    "../slides/toolchain/4.png",
                    "../slides/toolchain/5.png",
                    "../slides/toolchain/6.png",
                    "../slides/toolchain/7.png",
                    "../slides/toolchain/8.png"
                ],
                hintList: [
                    "Перед установкой откройте и закройте Qt Creator",
                    "Установщик активирует плагин BareMetal",
                    "Установщик создает отладочный интерфейс",
                    "Установщик создает отладочное устройство",
                    "Установщик регистрирует cmake",
                    "Установщик регистрирует отладчик arm gdb",
                    "Установщик регистрирует компилятор arm gcc",
                    "Установщик регистрирует компилятор arm g++",
                    "Установщик добавляет инструментарий разработки под ARM"
                ],
                installFunction: function(){
                    console.log("Install Toolkit");
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

    Tab{
        id: tab7
        onCheckedChanged: tabbar_root.tabChecked(position)
        position: 7
        text: "Руководство"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: installerui_root.licenceAccepted
        model: [{
                imagesURLList: [
                    "../slides/guide/2022-01-08_19-23-57.png",
                    "../slides/guide/2022-01-08_19-25-10.png",
                    "../slides/guide/2022-01-08_19-26-07.png",
                    "../slides/guide/2022-01-09_13-40-28.png",
                    "../slides/guide/2022-01-09_13-40-58.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                    "../slides/guide/.png",
                ],
                hintList: [
                    "При первом запуске возможно появится предупреждение, нажмите \"ОК\"",
                    "Выберите только комплект \"1986be92qi_arm\", нажмите \"Configure project\"",
                    "При необходимости можно изменить каталог сборки, там будут elf, bin и hex файлы прошивки",
                    "Вкладка \"Редактор\". В файле app.cpp пишется код программы",
                    "Вкладке \"diron_qbs\". Можно переключать сборку между отладкой и выпуском",
                    ],
                installFunction: null
            }]
    }


    property int selectedPos: 0

    property var tabs: [tab0, tab1, tab2, tab3, tab4, tab5, tab6, tab7]


    function tabChecked(pos){
//        console.log("tab" + pos + " checked")

        for (var i = 0; i < tabs.length; i++){
            var tab = tabs[i];
            if (tab.position !== pos){
                tab.checked = false
            }
        }
    }


    onSelectedPosChanged: {
        updateContent()
    }


    function updateContent(){
        var qmlStr = tabs[selectedPos].contentQML
        if (qmlStr === "contentUI/StagesObserverUI.qml"){
            var selectedTab = tabs[selectedPos]
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
