import QtQuick
import qs.services   // adjust to match however your shell roots its local modules

Text {
    id: root
    color: "#f5e2c5"
    font.family: "mononoki nerd font propo"
    font.pixelSize: 16

    text: MPRIS.title
}