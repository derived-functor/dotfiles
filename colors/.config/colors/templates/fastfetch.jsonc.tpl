{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": {
            "type": "kitty",
            "source": "$HOME/.config/fastfetch/logo.png",
            "width": 30,
            "padding": {
                "top": 5,
                "left": 2
            }
        },
        "key": {
            "width": 17
        },
        "display": {
            "separator": " || ",
            "color": {
                "title": "${COLOR_ACCENT}",
                "keys": "${COLOR_BORDER}"
            }
        },
        "modules": [
        {
            "type": "title",
            "format": "{user-name-colored}@{host-name-colored}"
        },
        {
            "type": "separator",
            "string": "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        },
        {
            "type": "os",
            "key": "󰣇 OS ",
            "keyColor": "${COLOR_BORDER}"
        },
        {
            "type": "host",
            "key": "󰌢 HT ",
            "keyColor": "${COLOR_BORDER}"
        },
        {
            "type": "kernel",
            "key": " KR ",
            "keyColor": "${COLOR_BORDER}"
        },
        {
            "type": "shell",
            "key": " SH ",
            "keyColor": "${COLOR_BORDER}"
        },
        {
            "type": "wm",
            "key": " WM ",
            "keyColor": "${COLOR_BORDER}"
        },
        {
            "type": "terminal",
            "key": " TR ",
            "keyColor": "${COLOR_BORDER}"
        },
        {
            "type": "cpu",
            "key": " CP ",
            "keyColor": "${COLOR_AQUA}"
        },
        {
            "type": "gpu",
            "key": "󰢮 GP ",
            "keyColor": "${COLOR_AQUA}"
        },
        {
            "type": "memory",
            "key": " RAM",
            "keyColor": "${COLOR_AQUA}"
        },
        {
            "type": "disk",
            "key": "  /     ",
            "folders": "/",
            "format": "{size-used} / {size-total} ({size-percentage})"
        },
        {
            "type": "disk",
            "key": "  /home ",
            "folders": "/home",
            "format": "{size-used} / {size-total} ({size-percentage})"
        },
        "break",
        {
            "type": "colors",
            "symbol": "square"
        }
    ]
}

