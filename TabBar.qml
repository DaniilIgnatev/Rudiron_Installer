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
        text: "QT Creator"
        contentQML: "contentUI/StagesObserverUI.qml"
        enabled: installerui_root.licenceAccepted
        model: [{
                imagesURLList: ["../slides/qtcreator/1.png", "../slides/qtcreator/2.png", "../slides/qtcreator/3.png", "../slides/qtcreator/4.png", "../slides/qtcreator/5.png", "../slides/qtcreator/6.png", "../slides/qtcreator/7.png", "../slides/qtcreator/8.png", "../slides/qtcreator/9.png"],
                hintList: ["Нажмите \"Next\"", "Нажмите \"Next\"", "Нажмите \"Далее\"", "Нажмите \"Далее\"", "Нажмите \"Далее\"", "Нажмите \"Далее\"", "Нажмите \"Далее\"", "Нажмите \"Далее\"", "Нажмите \"Установить\""],
                installFunction: function(){
                    console.log("Install QT Creator");
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
                //ДОБАВИТЬ НАДПИСЬ "ПЕРЕД УСТАНОВКОЙ ЗАКРОЙТЕ QT CREATOR"
                imagesURLList: ["../slides/toolchain/1.png", "../slides/toolchain/2.png", "../slides/toolchain/3.png", "../slides/toolchain/4.png", "../slides/toolchain/5.png", "../slides/toolchain/6.png", "../slides/toolchain/7.png", "../slides/toolchain/8.png"],
                hintList: ["Установщик активирует плагин BareMetal", "Установщик создает отладочный интерфейс", "Установщик создает отладочное устройство", "Установщик регистрирует cmake", "Установщик регистрирует отладчик arm gdb", "Установщик регистрирует компилятор arm gcc", "Установщик регистрирует компилятор arm g++", "Установщик добавляет инструментарий разработки под ARM"],
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
                imagesURLList: ["../slides/guide/26.png", "../slides/guide/1.png", "../slides/guide/2.png", "../slides/guide/3.png", "../slides/guide/4.png", "../slides/guide/5.png", "../slides/guide/6.png", "../slides/guide/7.png", "../slides/guide/8.png", "../slides/guide/9.png", "../slides/guide/10.png", "../slides/guide/11.png", "../slides/guide/12.png", "../slides/guide/13.png", "../slides/guide/14.png", "../slides/guide/15.png", "../slides/guide/16.png", "../slides/guide/17.png", "../slides/guide/18.png", "../slides/guide/19.png", "../slides/guide/20.png", "../slides/guide/21.png", "../slides/guide/22.png", "../slides/guide/23.png", "../slides/guide/24.png", "../slides/guide/25.png", "../slides/guide/27.png", "../slides/guide/28.png", "../slides/guide/29.png"],
                hintList: ["На кладке \"Проекты\" можно изменить каталог сборки", "На вкладке \"Начало\" выберете \"Настроить\" сессию","Нажмите \"Новая\"","Введите название и нажмите \"Создать\"","Выберите созданную сессию и нажмите \"Активировать\"","Нажмите \"Открыть файл или проект\"","Откройте .qbs файл проекта","Раскройте дерево проектов до \"app.cpp\"","Окно запуска программы","Окно предупреждений и ошибок","Окно поиска в проекте","Окно стандартного потока вывода","Информация о ходе сборки программы","Стек вызовов функций","Точки останова","Слева от порядкового номера строки выставляются точки останова","Окно локальных переменных","Окно регистров","В окне регистров переферии нажмите ПКМ","Список регистров выбранной переферии","Нажмите ПКМ для выбора формата отображения значений","Наведите на регистр для подробного вывода значения","Нажмите ПКМ для точного выставления точки останова","Продолжение отладки программы","Завершение отладки программы","Переключение отладчика в режим дизассемблера","Для настройки QtCreator перейдите в \"Инструменты->Параметры\"","Настройки текстового редактора","Рекомендуется шрифт DejaVu Sans Mono"],
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
