import Quickshell
import QtQuick

Text {
    id: root
    color: "#f5e2c5"
    font.family: "mononoki nerd font propo"
    font.pixelSize: 16
    text: Qt.formatDateTime(clock.date, "hh:mm:ss - dd/MM/yy")

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}