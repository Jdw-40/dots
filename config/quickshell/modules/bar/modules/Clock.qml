import Quickshell
import QtQuick

Item {
    // ensure clock is always centred
    anchors.centerIn: parent

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        id: timeText
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "hh:mm:ss - dd/MM/yy")
    }
}
