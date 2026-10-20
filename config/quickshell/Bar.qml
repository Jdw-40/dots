import Quickshell
import QtQuick
import QtQuick.Layouts
import "./bar"

PanelWindow {
    id: bar
    anchors { top: true; left: true; right: true }
    implicitHeight: 36
    color: "transparent"
    
    RowLayout { // left group
    anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10; topMargin: 2 }
        spacing: 7
        Pill { icon: ""; Workspaces {} }
    }
    
    RowLayout { //centre group
        anchors.centerIn: parent
        spacing: 7

        Pill { icon: ""; Clock {} }

        // future: group multiple things in one pill
        // Pill { icon: ""; Battery {}; Volume {} }
    }

    RowLayout { //right group
        spacing: 7
        anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: 10; topMargin: 2 }
        Pill {icon:""; Music{} }
        Pill {icon:""; Volume{} }
    }
    
}