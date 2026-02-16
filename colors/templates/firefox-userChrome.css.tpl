:root {
  --ff-bg:            ${COLOR_BG};
  --ff-bg-soft:       ${COLOR_BG_SOFT};
  --ff-surface:       ${COLOR_SURFACE};
  --ff-overlay:       ${COLOR_OVERLAY};
  --ff-muted:         ${COLOR_MUTED};

  --ff-fg:            ${COLOR_FG};
  --ff-fg-dim:        ${COLOR_FG_DIM};

  --ff-accent:        ${COLOR_ACCENT};
  --ff-border:        ${COLOR_BORDER};

  --ff-red:           ${COLOR_RED};
  --ff-orange:        ${COLOR_ORANGE};
  --ff-yellow:        ${COLOR_YELLOW};
  --ff-green:         ${COLOR_GREEN};
  --ff-blue:          ${COLOR_BLUE};
  --ff-purple:        ${COLOR_PURPLE};
  --ff-aqua:          ${COLOR_AQUA};
}

#navigator-toolbox,
#TabsToolbar,
#nav-bar,
#PersonalToolbar {
  background-color: var(--ff-bg) !important;
  color: var(--ff-fg) !important;
  border-color: var(--ff-border) !important;
}

.tab-background[selected="true"] {
  background-color: var(--ff-accent) !important;
  border: 1px solid var(--ff-border) !important;
}

.tab-label[selected="true"],
.tab-label[selected="true"] * {
  color: var(--ff-bg) !important;
}

.tab-background:not([selected="true"]) {
  background-color: var(--ff-surface) !important;
}

.tab-label:not([selected="true"]),
.tab-label:not([selected="true"]) * {
  color: var(--ff-fg-dim) !important;
}

#urlbar,
#urlbar-background,
#searchbar {
  background-color: var(--ff-surface) !important;
  color: var(--ff-fg) !important;
  border-radius: 6px !important;
  border: 1px solid var(--ff-border) !important;
}

toolbarbutton,
toolbarbutton > * {
  color: var(--ff-fg) !important;
}

toolbarbutton:hover {
  background-color: var(--ff-overlay) !important;
}

