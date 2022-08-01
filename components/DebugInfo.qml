import QtQuick 2.6
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import com.dibot 1.0


Item {
    visible: installer_vm.isDebug()

    InstallerMenuVM{
        id: installer_vm
    }

    function get_PATH_str(){
        var str = ""
        var elements = installer_vm.get_PATH_elements()

        elements.forEach(e => {
                             str += (e + "\n")
                         })

        return str
    }

    Text {
        id: name
        text: get_PATH_str()
        anchors.fill: parent
    }
}
