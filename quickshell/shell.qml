import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland

ShellRoot {

    Variants {
        model: Quickshell.screens

        delegate: Bar {
            required property ShellScreen modelData
            screen: modelData
        }
    }
}
