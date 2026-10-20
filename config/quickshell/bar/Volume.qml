import Quickshell.Services.Pipewire
import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout{
    id: root
    spacing:7
    property var sink: Pipewire.defaultAudioSink
    
    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100):0

    readonly property string icon: {
        if (!ready) return "󰸈"
        if (muted) return "󰝟"

        if (vol == 0) return "󰕿"
        if (vol <= 34) return "󰖀"
        if (vol <= 67) return "󰕾"

        return "󰕾"
    }
    
    Text {
        text: root.icon
        color: root.muted ? "red" : "#f5e2c5"

        font {
            family: "mononoki nerd font propo"
            pixelSize: 16
        }
    }

    Text {
        text: {
            if (!root.ready) return "-"
            if (root.muted) return root.vol + "%"
            return root.vol + "%"
        }
        color: root.muted ? "red" : "#f5e2c5"

        font {
            family: "mononoki nerd font propo"
            pixelSize: 16
        }
    }

    PwObjectTracker {
        objects: [root.sink]
    }
}