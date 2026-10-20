pragma Singleton

import Quickshell.Services.Mpris
import Quickshell
import QtQuick

QtObject {
    id: root

    readonly property var player: {
        const list = Mpris.players.values;
        for (let i = 0; i < list.length; i++) {
            if (list[i].dbusName === "org.mpris.MediaPlayer2.mpd")
                return list[i];
        }
        return null;
    }

    readonly property bool available: player !== null
    readonly property string title: player && player.trackTitle ? player.trackTitle : "Unknown Title"
    readonly property string artist: player && player.trackArtist ? player.trackArtist : "Unknown Artist"
    readonly property string artUrl: player ? player.trackArtUrl : ""
    readonly property bool isPlaying: player ? player.isPlaying : false
}