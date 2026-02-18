import QtQuick
import QtQuick.Layouts
import "../options"

RowLayout {
    spacing: 4

    Colors {
        id: colors
    }

    Text {
        id: timeText
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 32
        font.bold: true
        color: colors.text
    }

    Text {
        id: dateText
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 24
        color:colors.aqua
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            const now = new Date()
            timeText.text = now.toLocaleTimeString(Qt.locale(), "hh:mm AP")
            dateText.text = now.toLocaleDateString(Qt.locale(), "dd.MM.yyyy")
        }
    }
}
