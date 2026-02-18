@import "colors.css";

* {
	background-image: none;
	box-shadow: none;
}

window {
	background-color: alpha(@surface0, 0.9);
}

button {
    border-radius: 0;
    border-color: @surface1;
	text-decoration-color: #FFFFFF;
    color: @text;
	background-color: @base;
	border-style: solid;
	border-width: 1px;
	background-repeat: no-repeat;
	background-position: center;
	background-size: 25%;
}

button:focus, button:active, button:hover {
	background-color: @surface2;
	outline-style: none;
}

#lock {
    background-image: image(url("/usr/share/icons/${ICON_THEME}/actions/symbolic/system-lock-screen-symbolic.svg"), url("/usr/local/share/wlogout/icons/lock.png"));
}

#logout {
    background-image: image(url("/usr/share/icons/${ICON_THEME}/actions/symbolic/xfsm-logout.svg"), url("/usr/local/share/wlogout/icons/logout.png"));
}

#shutdown {
    background-image: image(url("/usr/share/icons/${ICON_THEME}/actions/symbolic/system-shutdown-panel.svg"), url("/usr/local/share/wlogout/icons/shutdown.png"));
}

#reboot {
    background-image: image(url("/usr/share/icons/${ICON_THEME}/actions/symbolic/system-reboot.svg"), url("/usr/local/share/wlogout/icons/reboot.png"));
}
