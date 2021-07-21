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



#include "qtcreatorconfig.h"


using namespace pugi;


QtCreatorConfig::QtCreatorConfig(QObject *parent) : QObject(parent)
{
    QString qtProjectPath = QDir::toNativeSeparators(QStandardPaths::locate(QStandardPaths::HomeLocation,"AppData/Roaming/QtProject",QStandardPaths::LocateOption::LocateDirectory));
    this->qtprojectDir = QDir(qtProjectPath);

    QString qtcreatorPath = QDir::toNativeSeparators(qtProjectPath + "/qtcreator");
    this->qtcreatorDir = QDir(qtcreatorPath);
}


const QString QtCreatorConfig::toolchain_name = "arm";


const QString QtCreatorConfig::device_name = "1986be92qi";



QString QtCreatorConfig::qtcreator_ini_path()
{
    return QDir::toNativeSeparators(qtprojectDir.absolutePath() + "\\QtCreator.ini");
}


bool QtCreatorConfig::qtCreatorInstalled()
{
    if(qtprojectDir.exists() && QFile(qtcreator_ini_path()).exists()){
        return true;
    }

    return false;
}


void QtCreatorConfig::enableBareMetalPlugin()
{
    bareMetalPluginStatus = ::failed;
    const QString plugins = "[Plugins]";
    const QString ignored = "Ignored=@Invalid()";
    const QString forceEnabled = "ForceEnabled=";
    const QString forceEnabledBareMetal = "ForceEnabled=BareMetal";

    QString path = qtcreator_ini_path();

    QFile qtcreatorini_read(path);
    qtcreatorini_read.open(QIODevice::ReadOnly);
    QTextStream qtcreatorini_readStream(&qtcreatorini_read);

    QList<QString> lines;

    int n = 0;
    bool pluginsDetected = false;

    while(!qtcreatorini_readStream.atEnd()){
        QString readLine = qtcreatorini_readStream.readLine();
        QString writeLine = readLine;

        if (readLine.contains(plugins)){
            pluginsDetected = true;
        }

        if (readLine.contains(forceEnabled)){
            if (readLine.contains("@Invalid()")){
                writeLine = forceEnabledBareMetal;
                bareMetalPluginStatus = ::added;
            }
            else{
                if (!readLine.contains("BareMetal")){
                    writeLine.append(", BareMetal");
                    bareMetalPluginStatus = ::added;
                }
                else{
                    bareMetalPluginStatus = ::existed;
                }
            }
        }

        lines.append(writeLine);
        n++;
    }

    if (!pluginsDetected){
        lines.append("\n");
        lines.append(plugins);
        lines.append(ignored);
        lines.append(forceEnabledBareMetal);
        bareMetalPluginStatus = ::added;
    }
    qtcreatorini_read.close();


    if (bareMetalPluginStatus != ::failed){
        QFile qtcreatorini_write(path);
        qtcreatorini_write.open(QIODevice::WriteOnly);
        qtcreatorini_write.resize(0);

        QTextStream qtcreatorini_writeStream(&qtcreatorini_write);
        foreach (QString s, lines) {
            qtcreatorini_writeStream << s << "\n";
        }
        qtcreatorini_write.close();
    }
}


const QString QtCreatorConfig::debugServerProvider_name = "openocd_" + device_name;


const QString QtCreatorConfig::debugServerProvider_id = "{cd6d56fd-2070-49b7-ab01-f8df06d07844}";


QString QtCreatorConfig::debugServerProviders_xml_path()
{
    return QDir::toNativeSeparators(qtcreatorDir.absolutePath() + "\\debugserverproviders.xml");
}


void QtCreatorConfig::createOpenOCDDebugProvider()
{
    debugServerProviderStatus = ::failed;
    QString path = debugServerProviders_xml_path();

    QString debugProvider = "<data>\
            <variable>DebugServerProvider.0</variable>\
            <valuemap type=\"QVariantMap\">\
            <value type=\"QString\" key=\"BareMetal.GdbServerProvider.InitCommands\">\
            set remote hardware-breakpoint-limit 6\n\
            set remote hardware-watchpoint-limit 4\n\
            monitor reset halt\n\
            load\n\
            monitor reset halt\n\
            </value>\
            <value type=\"int\" key=\"BareMetal.GdbServerProvider.Mode\">0</value>\
            <value type=\"QString\" key=\"BareMetal.GdbServerProvider.PeripheralDescriptionFile\">";
    debugProvider.append(Distributive::svdFilePath);
    debugProvider += "</value>\
            <value type=\"QString\" key=\"BareMetal.GdbServerProvider.ResetCommands\">monitor reset halt</value>\
            <value type=\"bool\" key=\"BareMetal.GdbServerProvider.UseExtendedRemote\">false</value>\
            <value type=\"QString\" key=\"BareMetal.IDebugServerProvider.DisplayName\">";
    debugProvider.append(QtCreatorConfig::debugServerProvider_name);
    debugProvider += "</value>\
            <value type=\"int\" key=\"BareMetal.IDebugServerProvider.EngineType\">1</value>\
            <value type=\"QString\" key=\"BareMetal.IDebugServerProvider.Id\">BareMetal.GdbServerProvider.OpenOcd:";
    debugProvider.append(QtCreatorConfig::debugServerProvider_id);
    debugProvider +="</value>\
            <value type=\"QString\" key=\"BareMetal.OpenOcdGdbServerProvider.AdditionalArguments\"></value>\
            <value type=\"QString\" key=\"BareMetal.OpenOcdGdbServerProvider.ConfigurationPath\">";
    debugProvider.append(Distributive::openocd_interfaceFilePath);
    debugProvider += "</value>\
            <value type=\"QString\" key=\"BareMetal.OpenOcdGdbServerProvider.ExecutableFile\">";
    debugProvider.append(Distributive::openocd_binFilePath);
    debugProvider += "</value>"\
                     "<value type=\"QString\" key=\"BareMetal.OpenOcdGdbServerProvider.Host\">localhost</value>\
            <value type=\"int\" key=\"BareMetal.OpenOcdGdbServerProvider.Port\">3333</value>\
            <value type=\"QString\" key=\"BareMetal.OpenOcdGdbServerProvider.RootScriptsDir\">";
    debugProvider.append(Distributive::openocd_scriptsDirPath);
    debugProvider += "</value>\
            </valuemap>\
            </data>";

            pugi::xml_document doc;

    if (doc.load_file(path.toUtf8())){
        pugi::xml_node qtcreatorNode = doc.child("qtcreator");
        pugi::xml_object_range<pugi::xml_named_node_iterator> dataNodes = qtcreatorNode.children("data");

        QList<xml_node> serverProviderList;

        xml_node countNode;
        int serverProviderCount = 0;

        //        xml_node versionNode;
        //        int version = 0;


        for (pugi::xml_node dataNode: dataNodes){
            pugi::xml_node variable = dataNode.child("variable");
            xml_node value = dataNode.child("value");
            if (QString(variable.text().as_string()) == "DebugServerProvider.Count"){
                serverProviderCount = value.text().as_int();
                countNode = dataNode;
            }
            else
                //                if (QString(variable.text().as_string()) == "Version"){
                //                    version = value.text().as_int();
                //                    versionNode = dataNode;
                //                }
                //                else
                if (QString(variable.text().as_string()).contains("DebugServerProvider")){
                    serverProviderList.append(dataNode);
                }
        }


        for(xml_node providerNode: serverProviderList){
            xml_node valueMap = providerNode.child("valuemap");
            xml_node idNode = valueMap.find_child([](xml_node n){return QString(n.attribute("key").as_string()) == "BareMetal.IDebugServerProvider.Id";});
            if (QString(idNode.text().as_string()) == "BareMetal.GdbServerProvider.OpenOcd:" + QtCreatorConfig::debugServerProvider_id){
                debugServerProviderStatus = ::existed;
            }
        }

        if (debugServerProviderStatus != ::existed){
            qtcreatorNode.append_buffer(debugProvider.toUtf8(), debugProvider.size());
            serverProviderCount++;
            countNode.child("value").first_child().set_value(QString::number(serverProviderCount).toUtf8());
            debugServerProviderStatus = ::added;
        }

        if (debugServerProviderStatus != ::failed){
            doc.save_file(path.toUtf8());
        }
    }
}


const QString QtCreatorConfig::bareMetalDevice_name = "baremetal_" + device_name;


const QString QtCreatorConfig::bareMetalDevice_id = "{b794b519-c355-4cff-ac14-7e9d35d6589d}";


QString QtCreatorConfig::devices_xml_path()
{
    return QDir::toNativeSeparators(qtcreatorDir.absolutePath() + "\\devices.xml");
}


void QtCreatorConfig::createBareMetalDevice()
{
    bareMetalDeviceStatus = ::failed;
    QString path = devices_xml_path();

    QString devStr = "<valuemap type=\"QVariantMap\">\
            <value type=\"int\" key=\"Authentication\">0</value>\
            <value type=\"QString\" key=\"DebugServerKey\"></value>\
            <valuemap type=\"QVariantMap\" key=\"ExtraData\"/>\
            <value type=\"QString\" key=\"FreePortsSpec\">10000-10100</value>\
            <value type=\"QString\" key=\"Host\"></value>\
            <value type=\"int\" key=\"HostKeyChecking\">2</value>\
            <value type=\"QString\" key=\"IDebugServerProviderId\">BareMetal.GdbServerProvider.OpenOcd:" + QtCreatorConfig::debugServerProvider_id + "</value>\
            <value type=\"QString\" key=\"InternalId\">";
    devStr.append(QtCreatorConfig::bareMetalDevice_id);
    devStr +="</value>\
            <value type=\"QString\" key=\"KeyFile\"></value>\
            <value type=\"QString\" key=\"Name\">" + QtCreatorConfig::bareMetalDevice_name + "</value>\
            <value type=\"int\" key=\"Origin\">0</value>\
            <value type=\"QString\" key=\"OsType\">BareMetalOsType</value>\
            <value type=\"QString\" key=\"QmlsceneKey\"></value>\
            <value type=\"int\" key=\"SshPort\">0</value>\
            <value type=\"int\" key=\"Timeout\">0</value>\
            <value type=\"int\" key=\"Type\">0</value>\
            <value type=\"QString\" key=\"Uname\"></value>\
            <value type=\"int\" key=\"Version\">0</value>\
            </valuemap>";

            pugi::xml_document doc;
    if (doc.load_file(path.toUtf8())){
        pugi::xml_node qtcreatorNode = doc.child("qtcreator");
        pugi::xml_node dataNode = qtcreatorNode.child("data");
        pugi::xml_node DeviceManagerNode = dataNode.child("valuemap");

        pugi::xml_node DefaultDevicesNode = DeviceManagerNode.child("valuemap");
        QString defDevStr = "<value type=\"QString\" key=\"BareMetalOsType\">" + QtCreatorConfig::bareMetalDevice_id + "</value>";

        xml_node bareMetalDefaultNode;
        bool hasDefault = false;
        for(pugi::xml_node defDevNode: DefaultDevicesNode.children()){
            xml_attribute deviceOSType = defDevNode.attribute("key");
            if (QString(deviceOSType.as_string()) == "BareMetalOsType"){
                hasDefault = true;
                bareMetalDefaultNode = defDevNode;
            }
        }

        if (!hasDefault){
            DefaultDevicesNode.append_buffer(defDevStr.toUtf8(),defDevStr.size());
        }
        else{
            bareMetalDefaultNode.first_child().set_value(bareMetalDevice_id.toUtf8());
        }


        pugi::xml_node DeviceListNode = DeviceManagerNode.child("valuelist");


        bool hasDev = false;

        for(pugi::xml_node dev: DeviceListNode.children()){
            for(pugi::xml_node devTag: dev.children()){
                if (QString(devTag.text().as_string()) == QtCreatorConfig::bareMetalDevice_id){
                    hasDev = true;
                }
            }
        }

        if (hasDev){
            bareMetalDeviceStatus = ::existed;
        }
        else{
            DeviceListNode.append_buffer(devStr.toUtf8(), devStr.size());
            bareMetalDeviceStatus = ::added;
        }


        if (bareMetalDeviceStatus != ::failed){
            doc.save_file(path.toUtf8());
        }
    }
}



const QString QtCreatorConfig::cmake_name = "cmake_" + toolchain_name;


const QString QtCreatorConfig::cmake_id = "{e85693af-06ac-40a9-a963-2efe187cb350}";


QString QtCreatorConfig::cmaketools_xml_path()
{
    return QDir::toNativeSeparators(qtcreatorDir.absolutePath() + "\\cmaketools.xml");;
}


void QtCreatorConfig::addCmake()
{
    cmaketoolStatus = ::failed;
    QString path = cmaketools_xml_path();

    QString cmaketoolStr = "<valuemap type=\"QVariantMap\">\
            <value type=\"bool\" key=\"AutoCreateBuildDirectory\">false</value>\
            <value type=\"bool\" key=\"AutoDetected\">false</value>\
            <value type=\"bool\" key=\"AutoRun\">true</value>\
            <value type=\"QString\" key=\"Binary\">" + Distributive::cmakeBinPath + "</value>\
            <value type=\"QString\" key=\"DisplayName\">" + QtCreatorConfig::cmake_name + "</value>\
            <value type=\"QString\" key=\"Id\">" + QtCreatorConfig::cmake_id + "</value>\
            <value type=\"QString\" key=\"QchFile\">" + Distributive::cmakeQchPath + "</value>\
            </valuemap>";

            pugi::xml_document doc;
    if (doc.load_file(path.toUtf8())){

        xml_node creatorNode = doc.child("qtcreator");
        xml_object_range<xml_named_node_iterator> dataNodes = creatorNode.children("data");


        xml_node countNode;
        int count = -1;


        xml_node defaultNode;


        for (xml_node dataNode: dataNodes){
            xml_node variable = dataNode.child("variable");
            QString varStr = variable.text().as_string();

            if (varStr == QString("CMakeTools.Count")){
                xml_node valueNode = dataNode.child("value");
                countNode = dataNode;
                count = valueNode.text().as_int();
            }
            else
                if(varStr == QString("CMakeTools.Default")){
                    defaultNode = dataNode;
                }
                else
                    if (varStr.contains("CMakeTools")){
                        QString toolsContentStr;
                        QTextStream toolsContentStream(&toolsContentStr);

                        xml_node variantmap = dataNode.child("valuemap");
                        xml_node idNode = variantmap.find_child([](xml_node node){return QString(node.attribute("key").as_string()) == "Id";});

                        if (QString(idNode.text().as_string()) == QtCreatorConfig::cmake_id){
                            cmaketoolStatus = ::existed;
                        }
                    }
        }

        if (cmaketoolStatus == ::failed){
            count++;
            countNode.child("value").first_child().set_value(QString::number(count).toUtf8());

            QString defaultValue = QString(defaultNode.child("value").first_child().text().as_string());
            if (defaultValue == ""){
                defaultValue = QtCreatorConfig::cmake_id;
                defaultNode.child("value").append_buffer(defaultValue.toUtf8(), defaultValue.size());
            }


            xml_node dataNode = creatorNode.append_child("data");
            xml_node variableNode = dataNode.append_child("variable");

            QString variableStr = "CMakeTools.";
            variableStr.append(QString::number(count - 1));
            variableNode.append_buffer(variableStr.toUtf8(), variableStr.size());

            dataNode.append_buffer(cmaketoolStr.toUtf8(),cmaketoolStr.size());


            cmaketoolStatus = ::added;
        }


        if (cmaketoolStatus != ::failed){
            //QString debugPath = Distributive::debugPath + "/cmaketools.xml";
            doc.save_file(path.toUtf8());
        }
    }
}



const QString QtCreatorConfig::debugger_name = "gdb_" + toolchain_name;


const QString QtCreatorConfig::debugger_id = "{181a0d00-e5a0-4bfc-84d2-5a9f9eb48947}";


QString QtCreatorConfig::debuggers_xml_path()
{
    return QDir::toNativeSeparators(qtcreatorDir.absolutePath() + "\\debuggers.xml");
}


void QtCreatorConfig::addDebugger()
{
    debuggerStatus = ::failed;
    QString path = debuggers_xml_path();


    pugi::xml_document doc;
    if (doc.load_file(path.toUtf8())){
        xml_node creatorNode = doc.child("qtcreator");
        xml_object_range<xml_named_node_iterator> dataNodes = creatorNode.children("data");

        xml_node countNode;
        int count = -1;

        for (xml_node dataNode: dataNodes){
            xml_node variable = dataNode.child("variable");
            QString varStr = variable.text().as_string();

            if (varStr == "DebuggerItem.Count"){
                countNode = dataNode;
                count = countNode.child("value").first_child().text().as_int();
            }
            else
                if (varStr.contains("DebuggerItem")){
                    xml_node valuemap = dataNode.child("valuemap");
                    xml_node idNode = valuemap.find_child([](xml_node node){return QString(node.attribute("key").as_string()) == "Id";});

                    if (QString(idNode.first_child().text().as_string()) == QtCreatorConfig::debugger_id){
                        debuggerStatus = ::existed;
                    }
                }
        }


        if (debuggerStatus == ::failed){
            count++;
            countNode.child("value").first_child().set_value(QString::number(count).toUtf8());

            QString debuggerStr = "<data>\
                    <variable>DebuggerItem." + QString::number(count - 1) + "</variable>\
                    <valuemap type=\"QVariantMap\">\
                    <valuelist type=\"QVariantList\" key=\"Abis\">\
                    <value type=\"QString\">arm-baremetal-generic-elf-32bit</value>\
                    </valuelist>\
                    <value type=\"bool\" key=\"AutoDetected\">false</value>\
                    <value type=\"QString\" key=\"Binary\">" + Distributive::gdbBinPath + "</value>\
                    <value type=\"QString\" key=\"DisplayName\">" + QtCreatorConfig::debugger_name + "</value>\
                    <value type=\"int\" key=\"EngineType\">1</value>\
                    <value type=\"QString\" key=\"Id\">" + QtCreatorConfig::debugger_id + "</value>\
                    <value type=\"QDateTime\" key=\"LastModified\"></value>\
                    <value type=\"QString\" key=\"Version\">10.0.0</value>\
                    <value type=\"QString\" key=\"WorkingDirectory\"></value>\
                    </valuemap>\
                    </data>\
                    <data>";

                    creatorNode.append_buffer(debuggerStr.toUtf8(), debuggerStr.length());

            debuggerStatus = ::added;
        }


        if (debuggerStatus != ::failed){
            //QString debugPath = Distributive::debugPath + "/debuggers.xml";
            doc.save_file(path.toUtf8());
        }
    }
}


const QString QtCreatorConfig::gcc_name = "gcc_" + toolchain_name;


const QString QtCreatorConfig::gcc_id = "ProjectExplorer.ToolChain.Gcc:{e84c39d4-9f86-4e03-833f-4f7b5cdcd23a}";


const QString QtCreatorConfig::gpp_name = "g++_" + toolchain_name;


const QString QtCreatorConfig::gpp_id = "ProjectExplorer.ToolChain.Gcc:{93409a04-b200-4b39-ab40-09cce0528131}";


QString QtCreatorConfig::toolchain_xml_path()
{
    return QDir::toNativeSeparators(qtcreatorDir.absolutePath() + "\\toolchains.xml");
}


void QtCreatorConfig::addToolchain()
{
    gccStatus = ::failed;
    QString path = toolchain_xml_path();


    pugi::xml_document doc;
    if (doc.load_file(path.toUtf8())){
        xml_node creatorNode = doc.child("qtcreator");
        xml_object_range<xml_named_node_iterator> dataNodes = creatorNode.children("data");

        xml_node countNode;
        int count = -1;

        for (xml_node dataNode: dataNodes){
            xml_node variable = dataNode.child("variable");
            QString varStr = variable.text().as_string();

            if (varStr == "ToolChain.Count"){
                countNode = dataNode;
                count = countNode.child("value").first_child().text().as_int();
            }
            else
                if (varStr.contains("ToolChain")){
                    xml_node valuemap = dataNode.child("valuemap");
                    xml_node idNode = valuemap.find_child([](xml_node node){return QString(node.attribute("key").as_string()) == "ProjectExplorer.ToolChain.Id";});

                    if (QString(idNode.first_child().text().as_string()) == QtCreatorConfig::gcc_id){
                        gccStatus = ::existed;
                    }
                    else
                        if (QString(idNode.first_child().text().as_string()) == QtCreatorConfig::gpp_id){
                            gppStatus = ::existed;
                        }
                }
        }


        //GCC
        if (gccStatus == ::failed){
            count++;
            countNode.child("value").first_child().set_value(QString::number(count).toUtf8());

            QString gccStr = "<data>\
                    <variable>ToolChain." + QString::number(count - 1) + "</variable>\
                    <valuemap type=\"QVariantMap\">\
                    <value type=\"QString\" key=\"ProjectExplorer.GccToolChain.OriginalTargetTriple\">arm-none-eabi</value>\
                    <value type=\"QString\" key=\"ProjectExplorer.GccToolChain.Path\">" + Distributive::gccBinPath + "</value>\
                    <valuelist type=\"QVariantList\" key=\"ProjectExplorer.GccToolChain.PlatformCodeGenFlags\"/>\
                    <valuelist type=\"QVariantList\" key=\"ProjectExplorer.GccToolChain.PlatformLinkerFlags\"/>\
                    <valuelist type=\"QVariantList\" key=\"ProjectExplorer.GccToolChain.SupportedAbis\">\
                    <value type=\"QString\">arm-baremetal-generic-elf-32bit</value>\
                    </valuelist>\
                    <value type=\"QString\" key=\"ProjectExplorer.GccToolChain.TargetAbi\">arm-baremetal-generic-elf-32bit</value>\
                    <value type=\"bool\" key=\"ProjectExplorer.ToolChain.Autodetect\">false</value>\
                    <value type=\"QString\" key=\"ProjectExplorer.ToolChain.DisplayName\">" + QtCreatorConfig::gcc_name + "</value>\
                    <value type=\"QString\" key=\"ProjectExplorer.ToolChain.Id\">" + QtCreatorConfig::gcc_id + "</value>\
                    <value type=\"int\" key=\"ProjectExplorer.ToolChain.Language\">1</value>\
                    <value type=\"QString\" key=\"ProjectExplorer.ToolChain.LanguageV2\">C</value>\
                    </valuemap>\
                    </data>";

                    creatorNode.append_buffer(gccStr.toUtf8(), gccStr.length());

            gccStatus = ::added;
        }


        if (gccStatus != ::failed){
            //QString debugPath = Distributive::debugPath + "/toolchains.xml";
            doc.save_file(path.toUtf8());
        }


        //G++
        if (gppStatus == ::failed){
            count++;
            countNode.child("value").first_child().set_value(QString::number(count).toUtf8());

            QString gppStr = "<data>\
                    <variable>ToolChain." + QString::number(count - 1) + "</variable>\
                    <valuemap type=\"QVariantMap\">\
                    <value type=\"QString\" key=\"ProjectExplorer.GccToolChain.OriginalTargetTriple\">arm-none-eabi</value>\
                    <value type=\"QString\" key=\"ProjectExplorer.GccToolChain.Path\">" + Distributive::gppBinPath + "</value>\
                    <valuelist type=\"QVariantList\" key=\"ProjectExplorer.GccToolChain.PlatformCodeGenFlags\"/>\
                    <valuelist type=\"QVariantList\" key=\"ProjectExplorer.GccToolChain.PlatformLinkerFlags\"/>\
                    <valuelist type=\"QVariantList\" key=\"ProjectExplorer.GccToolChain.SupportedAbis\">\
                    <value type=\"QString\">arm-baremetal-generic-elf-32bit</value>\
                    </valuelist>\
                    <value type=\"QString\" key=\"ProjectExplorer.GccToolChain.TargetAbi\">arm-baremetal-generic-elf-32bit</value>\
                    <value type=\"bool\" key=\"ProjectExplorer.ToolChain.Autodetect\">false</value>\
                    <value type=\"QString\" key=\"ProjectExplorer.ToolChain.DisplayName\">" + QtCreatorConfig::gpp_name + "</value>\
                    <value type=\"QString\" key=\"ProjectExplorer.ToolChain.Id\">" + QtCreatorConfig::gpp_id + "</value>\
                    <value type=\"int\" key=\"ProjectExplorer.ToolChain.Language\">2</value>\
                    <value type=\"QString\" key=\"ProjectExplorer.ToolChain.LanguageV2\">Cxx</value>\
                    </valuemap>\
                    </data>";

                    creatorNode.append_buffer(gppStr.toUtf8(), gppStr.length());

            gppStatus = ::added;
        }


        if (gppStatus != ::failed){
            //QString debugPath = Distributive::debugPath + "/toolchains.xml";
            doc.save_file(path.toUtf8());
        }
    }
}


const QString QtCreatorConfig::kit_name = device_name + "_" + toolchain_name;


const QString QtCreatorConfig::kit_id = "{c704997f-b404-415d-bcc4-02014ba85542}";


QString QtCreatorConfig::profiles_xml_path()
{
    return QDir::toNativeSeparators(qtcreatorDir.absolutePath() + "\\profiles.xml");
}


void QtCreatorConfig::addKit()
{
    kit_status = ::failed;
    QString path = profiles_xml_path();


    pugi::xml_document doc;
    if (doc.load_file(path.toUtf8())){
        xml_node creatorNode = doc.child("qtcreator");
        xml_object_range<xml_named_node_iterator> dataNodes = creatorNode.children("data");

        xml_node countNode;
        int count = -1;

        for (xml_node dataNode: dataNodes){
            xml_node variable = dataNode.child("variable");
            QString varStr = variable.text().as_string();

            if (varStr == "Profile.Count"){
                countNode = dataNode;
                count = countNode.child("value").first_child().text().as_int();
            }
            else
                if (varStr.contains("Profile")){
                    xml_node valuemap = dataNode.child("valuemap");
                    xml_node idNode = valuemap.find_child([](xml_node node){return QString(node.attribute("key").as_string()) == "PE.Profile.Id";});

                    if (QString(idNode.first_child().text().as_string()) == QtCreatorConfig::kit_id){
                        kit_status = ::existed;
                    }
                }
        }


        if (kit_status == ::failed){
            count++;
            countNode.child("value").first_child().set_value(QString::number(count).toUtf8());

            QString kitStr = "<data>\
                    <variable>Profile." + QString::number(count - 1) + "</variable>\
                    <valuemap type=\"QVariantMap\">\
                    <value type=\"bool\" key=\"PE.Profile.AutoDetected\">false</value>\
                    <value type=\"QString\" key=\"PE.Profile.AutoDetectionSource\"></value>\
                    <valuemap type=\"QVariantMap\" key=\"PE.Profile.Data\">\
                    <valuelist type=\"QVariantList\" key=\"CMake.ConfigurationKitInformation\">\
                    <value type=\"QString\">QT_QMAKE_EXECUTABLE:STRING=%{Qt:qmakeExecutable}</value>\
                    <value type=\"QString\">CMAKE_PREFIX_PATH:STRING=%{Qt:QT_INSTALL_PREFIX}</value>\
                    <value type=\"QString\">CMAKE_C_COMPILER:STRING=%{Compiler:Executable:C}</value>\
                    <value type=\"QString\">CMAKE_CXX_COMPILER:STRING=%{Compiler:Executable:Cxx}</value>\
                    </valuelist>\
                    <valuemap type=\"QVariantMap\" key=\"CMake.GeneratorKitInformation\">\
                    <value type=\"QString\" key=\"ExtraGenerator\"></value>\
                    <value type=\"QString\" key=\"Generator\">NMake Makefiles JOM</value>\
                    <value type=\"QString\" key=\"Platform\"></value>\
                    <value type=\"QString\" key=\"Toolset\"></value>\
                    </valuemap>\
                    <value type=\"QString\" key=\"CMakeProjectManager.CMakeKitInformation\">" + QtCreatorConfig::cmake_id + "</value>\
                    <value type=\"QString\" key=\"Debugger.Information\">" + QtCreatorConfig::debugger_id + "</value>\
                    <value type=\"QString\" key=\"PE.Profile.Device\">" + QtCreatorConfig::bareMetalDevice_id + "</value>\
                    <value type=\"QString\" key=\"PE.Profile.DeviceType\">BareMetalOsType</value>\
                    <valuemap type=\"QVariantMap\" key=\"PE.Profile.ToolChainsV3\">\
                    <value type=\"QByteArray\" key=\"C\">" + QtCreatorConfig::gcc_id + "</value>\
                    <value type=\"QByteArray\" key=\"Cxx\">" + QtCreatorConfig::gpp_id + "</value>\
                    </valuemap>\
                    </valuemap>\
                    <value type=\"QString\" key=\"PE.Profile.DeviceTypeForIcon\"></value>\
                    <value type=\"QString\" key=\"PE.Profile.Icon\"></value>\
                    <value type=\"QString\" key=\"PE.Profile.Id\">" + QtCreatorConfig::kit_id + "</value>\
                    <valuelist type=\"QVariantList\" key=\"PE.Profile.MutableInfo\"/>\
                    <value type=\"QString\" key=\"PE.Profile.Name\">" + QtCreatorConfig::kit_name + "</value>\
                    <value type=\"bool\" key=\"PE.Profile.SDK\">false</value>\
                    <valuelist type=\"QVariantList\" key=\"PE.Profile.StickyInfo\"/>\
                    </valuemap>\
                    </data>";

                    creatorNode.append_buffer(kitStr.toUtf8(), kitStr.length());

            kit_status = ::added;
        }


        if (kit_status != ::failed){
            //QString debugPath = Distributive::debugPath + "/toolchains.xml";
            doc.save_file(path.toUtf8());
        }
    }
}

