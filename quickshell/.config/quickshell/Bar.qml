import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "options"
import "widgets"

PanelWindow {
    id: root

    anchors {
        right: true
        top: true
        bottom: true
    }

    margins {
        top: 5
        bottom: 5
    }

    Colors {
        id: colors
    }

    implicitWidth: hoverHandler.hovered ? 400 : 10
    color: colors.bg

    Behavior on width {
        NumberAnimation { duration: 100; easing.type: Easing.InOutCubic }
    }

    HoverHandler {
        id: hoverHandler
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 16

        Clock {
            Layout.fillWidth: true
        }

        Player {}

        Item { Layout.fillHeight: true }

    }
}
