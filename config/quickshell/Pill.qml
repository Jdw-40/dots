import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property string icon: ""
    property color iconColor: "#3dd1b0"
    default property alias content: row.data

    implicitWidth: row.implicitWidth + 22
    implicitHeight: 32
    radius: height / 2
    color: "#0f211f"

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 7

        Text {
            text: root.icon
            color: root.iconColor
            font.family: "mononoki nerd font propo"
            font.pixelSize: 16
            visible: root.icon !== ""
        }
    }
}