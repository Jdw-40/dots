import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import qs.services

PanelWindow {
    anchors { top: true; right: true }
    margins { top: 12; right: 12 }
    implicitWidth: 300
    implicitHeight: Math.max(1, column.implicitHeight)
    color: 'transparent'
    exclusionMode: ExclusionMode.Ignore

    ColumnLayout {
        id: column
        width: parent.width
        spacing: 12

        Repeater {
            model: Notifications.tracked
            delegate: Rectangle {
                id: card
                required property var modelData

                Timer {
                    running: card.modelData.urgency !== NotificationUrgency.Critical
                    interval: 5000
                    onTriggered: card.modelData.dismiss()
                }
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                radius: 4
                color: 'black'
                border.width: 2
                border.color: modelData.urgency === NotificationUrgency.Critical ? 'red' : 'purple'

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 12

                    Image {
                        Layout.preferredHeight: 36
                        Layout.preferredWidth: 36
                        Layout.alignment: Qt.AlignTop
                        fillMode: Image.PreserveAspectFit
                        visible: source.toString() !== ""
                        source: card.modelData.image || Quickshell.iconPath(card.modelData.appIcon, true) || ""
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 2
                        Text {
                            Layout.fillWidth: true
                            text: card.modelData.summary
                            color: 'white'
                            font.family: "Mononoki Nerd Font"
                            font.pixelSize: 12
                            font.bold: true
                            elide: Text.ElideRight
                        }
                        Text {
                            Layout.fillWidth: true
                            visible: text !== ""
                            text: card.modelData.body
                            color: 'white'
                            font.family: "Mononoki Nerd Font"
                            font.pixelSize: 12
                            font.bold: true
                            wrapMode: Text.WordWrap
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: card.modelData.dismiss()
                }
            } // end delegate Rectangle
        } // end Repeater
    } // end column
} // end PanelWindow