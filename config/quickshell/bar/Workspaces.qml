import Quickshell
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

Row {
    spacing: 7
    
    Repeater {
        // remove special workspaces, sort into numerical order
        model: ScriptModel {
            values: Hyprland.workspaces.values
                .filter(ws => ws.id > 0)
                .sort((a, b) => a.id - b.id)
        }
        
        Text {
            // data type requirement
            required property HyprlandWorkspace modelData
            
            // workspaces as a list in plaintext
            text: modelData.id
            color: "#f5e2c5"
            
            font {
                family: "mononoki nerd font propo"
                pixelSize: 16
                weight: modelData.focused ? 1000 : 300
            }
        }
    }
}
