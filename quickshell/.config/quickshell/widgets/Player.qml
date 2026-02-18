// widgets/Player.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../options"

ColumnLayout {
    id: root
    spacing: 8

    property string textColor: "#e0e0e0"
    property var player2icon: {
        "spotify": "  Spotify",
        "firefox": "  Firefox"
    }
    property int controlButtonsSize: 30
    property int coverSize: 128

    Colors {
        id: colors
    }

    ListModel {
        id: trackList
    }

    function updateTrack(data) {
        var parts = data.split("|||")
        var entry = {
            playerName: parts[0].trim(),
            title:      parts[1].trim(),
            artist:     parts[2].trim(),
            status:     parts[3].trim(),
            position:   parseInt(parts[4]) || 0,
            length:     parseInt(parts[5]) || 0,
            coverUrl:   parts[6] ? parts[6].trim() : ""
        }

        for (var i = 0; i < trackList.count; i++) {
            if (trackList.get(i).playerName === entry.playerName) {
                trackList.set(i, entry)
                return
            }
        }

        trackList.append(entry)
    }

    // Получаем метаданные
    Process {
        id: metaProc
        command: [
            "playerctl",
            "-a",
            "metadata",
            "--format",
            "{{playerName}}|||{{title}}|||{{artist}}|||{{status}}|||{{position}}|||{{mpris:length}}|||{{mpris:artUrl}}"
        ]
        running: true

        stdout: SplitParser {
            onRead: data => root.updateTrack(data)
        }
    }

    function formatTime(us) {
        const s = Math.floor(us / 1_000_000)
        return `${Math.floor(s / 60)}:${String(s % 60).padStart(2, "0")}`
    }

    Process {
        id: playPauseProc
        function startWith(player) {
            command = ["playerctl", "-p", player, "play-pause"]
            running = true
        }
    }

    Process {
        id: nextProc
        function startWith(player) {
            command = ["playerctl", "-p", player, "next"]
            running = true
        }
    }

    Process {
        id: prevProc
        function startWith(player) {
            command = ["playerctl", "-p", player, "previous"]
            running = true
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            metaProc.running = false
            metaProc.running = true
        }
    }


    Repeater {
        model: trackList

        delegate: ColumnLayout {
            Rectangle {
                id: trackContainer
                Layout.fillWidth: true
                height: root.coverSize * 2.5
                color: colors.bg1

                border.color: (hoverHandler.hovered || status === "Playing") ? colors.accent : colors.bg
                border.width: 2
                clip: true

                HoverHandler {
                    id: hoverHandler
                }
                Behavior on border.color {
                    ColorAnimation { duration: 200; easing.type: Easing.InOutCubic }
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter

                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 1

                    // player
                    Text {
                        Layout.fillWidth: true
                        text: root.player2icon[playerName] ?? playerName
                        font.pixelSize: 15
                        elide: Text.ElideRight
                        color: colors.text
                    }

                    // cover
                    Rectangle {
                        width: root.coverSize
                        height: root.coverSize
                        color: "#222"
                        clip: true
                        Layout.alignment: Qt.AlignHCenter

                        Image {
                            anchors.fill: parent
                            source: coverUrl?? ""
                            fillMode: Image.PreserveAspectCrop
                            smooth: true
                        }
                    }

                    // title
                    Text {
                        Layout.fillWidth: true
                        text: title
                        elide: Text.ElideRight
                        color: colors.text
                        horizontalAlignment: Text.AlignHCenter
                    }

                    // artist
                    Text {
                        Layout.fillWidth: true
                        text: artist
                        color: colors.text
                        font.bold: true
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignHCenter
                    }

                    // status
                    Text {
                        Layout.fillWidth: true
                        text: status
                        color: colors.text
                    }

                    // progress bar
                    Rectangle {
                        Layout.fillWidth: true
                        height: 4
                        radius: 2
                        color: "#44ffffff"

                        Rectangle {
                            width: parent.width * (length > 0 ? position / length : 0)
                            height: parent.height
                            radius: parent.radius
                            color: colors.text
                        }
                    }

                    // position/length
                    RowLayout {
                        Layout.fillWidth: true

                        Text {
                            text: formatTime(position)
                            color: colors.text
                            font.pixelSize: 10
                        }

                        Item { Layout.fillWidth: true }  // спейсер

                        Text {
                            text: formatTime(length)
                            color: colors.text
                            font.pixelSize: 10
                        }
                    }

                    // control buttons
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Text {
                            text: "⏮"
                            color: colors.text
                            font.pixelSize: root.controlButtonsSize

                            MouseArea {
                                anchors.fill: parent
                                onClicked: prevProc.startWith(playerName)
                            }
                        }

                        Text {
                            text: status === "Playing" ? "⏸" : "▶"
                            color: colors.text
                            font.pixelSize: root.controlButtonsSize

                            MouseArea {
                                anchors.fill: parent
                                onClicked: playPauseProc.startWith(playerName)
                            }
                        }

                        Text {
                            text: "⏭"
                            color: colors.text
                            font.pixelSize: root.controlButtonsSize

                            MouseArea {
                                anchors.fill: parent
                                onClicked: nextProc.startWith(playerName)
                            }
                        }
                    }

                }
            }
        }
    }

    Process {
        id: playerctlCmd
        command: []
    }
}
