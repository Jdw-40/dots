pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root
    property bool centerOpen: false

    ListModel {
        id: historyModel
    }
    readonly property alias history: historyModel
    readonly property alias tracked: server.trackedNotifications

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true
        actionIconsSupported: true
        bodyMarkupSupported: true

        onNotification: n => {
            history.insert(0, {
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm:ss")
            })
            if (history.count > 50) history.remove(50, history.count - 50)
            n.tracked = true
        }
    }

    IpcHandler {
        target: "notifications"
        function toggle(): void { root.centerOpen = !root.centerOpen }
        function show(): void { root.centerOpen = true }
        function hide(): void { root.centerOpen = false }
    }
}