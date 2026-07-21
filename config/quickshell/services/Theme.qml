pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string themeName: "adwaita"   // fallback default

    FileView {
        path: "/home/mrjw/.cache/current_theme"
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.themeName = text().trim()
    }

    property var data: ({})

    FileView {
        id: themeData
        path: `/home/mrjw/themes/${root.themeName}/qs/theme.json`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.data = JSON.parse(text())
    }

    readonly property string fontFamily: data.fontFamily ?? "sans-serif"
    readonly property color accent: data.accent ?? "#888888"
    readonly property color critical: data.critical ?? "#ff0000"
    readonly property int radiusMd: data.radiusMd ?? 6
    readonly property int spacingMd: data.spacingMd ?? 12
    // ...one readonly per value, same pattern
}
