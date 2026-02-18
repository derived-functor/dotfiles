import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../options"

Rectangle {
    id: root

    property string datetime: ""
    property string temperature: ""
    property string windSpeed: ""
    property string icon: ""

    property int textSize: 18

    implicitWidth: 200
    implicitHeight: textContainer.implicitHeight + 15

    Colors {
        id: colors
    }

    color: colors.bg1
    border.color: colors.accent
    border.width: 2

    Timer {
        interval: 600000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: getWeather.running = true
    }

    Process {
        id: getWeather

        command: [
            "bash",
            "/home/mreblan/.local/bin/get_weather.sh"
        ]

            stdout: SplitParser {
                onRead: data => {
                    console.log(data)
                    var splitted = data.split("|||")

                    root.datetime = splitted[0]
                    root.temperature = splitted[1]
                    root.windSpeed = splitted[2]
                    root.icon = splitted[3]
                }
            }
    }


    ColumnLayout {
        id: textContainer
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: root.icon + "\t" + root.temperature + "\t\t" + root.windSpeed
            color: colors.aqua
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            font.pixelSize: root.textSize + 2
        }

        Text {
            text: root.datetime
            color: colors.text
            Layout.fillWidth: true
            font.pixelSize: root.textSize - 2
        }
    }
}
