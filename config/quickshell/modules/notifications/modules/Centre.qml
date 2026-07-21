import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services

PanelWindow {
    visible: Notifications.centerOpen
    anchors {
        top: true
        bottom: true
        right: true
    }
    margins {
        top: 12
        bottom: 12
        right: 12
    }
    implicitWidth: 360
    // no implicitHeight — top+bottom anchors define height now
    color: 'transparent'
    exclusionMode: ExclusionMode.Ignore

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: 'black'
        border.width: 2
        border.color: 'purple'

        ColumnLayout {
            id: centerCol
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                Text {
                    Layout.fillWidth: true
                    text: "Notifications"
                    color: 'white'
                    font.family: "Mononoki Nerd Font"
                    font.pixelSize: 14
                    font.bold: true
                }
                Text {
                    text: "Clear all"
                    visible: Notifications.history.count > 0
                    color: 'white'
                    font.family: "Mononoki Nerd Font"
                    font.pixelSize: 14
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Notifications.history.clear()
                    }
                }
            } // end header RowLayout

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ColumnLayout {
                    width: parent.width
                    spacing: 12

                    Repeater {
                        model: Notifications.history
                        delegate: RowLayout {
                            Layout.fillWidth: true

                            ColumnLayout {
                                Layout.fillWidth: true
                                Text {
                                    Layout.fillWidth: true
                                    text: model.summary
                                    color: 'white'
                                    font.family: "Mononoki Nerd Font"
                                    font.pixelSize: 14
                                    elide: Text.ElideRight
                                }
                                Text {
                                    Layout.fillWidth: true
                                    visible: model.body !== ""
                                    text: model.body
                                    color: 'white'
                                    font.family: "Mononoki Nerd Font"
                                    font.pixelSize: 14
                                    wrapMode: Text.WordWrap
                                }
                            } // end summary/body ColumnLayout

                            Text {
                                text: model.time
                                color: 'white'
                                font.family: "Mononoki Nerd Font"
                                font.pixelSize: 14
                            }

                            Text {
                                text: 'x'
                                color: 'white'
                                font.family: "Mononoki Nerd Font"
                                font.pixelSize: 14
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Notifications.history.remove(index)
                                }
                            }
                        } // end delegate RowLayout
                    } // end Repeater
                } // end inner ColumnLayout
            } // end ScrollView

        } // end centerCol
    } // end Rectangle
} // end PanelWindow