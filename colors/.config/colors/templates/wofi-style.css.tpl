/* For autogen, don't change by hand */
@define-color base    ${COLOR_BG};
@define-color text    ${COLOR_FG};
@define-color surface0 ${COLOR_SURFACE};
@define-color surface1 ${COLOR_OVERLAY};
@define-color surface2 ${COLOR_MUTED};

@define-color red     ${COLOR_RED_BRIGHT};
@define-color orange  ${COLOR_ORANGE_BRIGHT};
@define-color yellow  ${COLOR_YELLOW_BRIGHT};
@define-color green   ${COLOR_GREEN_BRIGHT};
@define-color blue    ${COLOR_BLUE_BRIGHT};
@define-color purple  ${COLOR_PURPLE_BRIGHT};
@define-color aqua    ${COLOR_AQUA_BRIGHT};

@define-color accent  ${COLOR_ACCENT};
@define-color border  ${COLOR_BORDER};

@define-color critical @red;
@define-color warning  @orange;

*:selected {
    background: alpha(@accent, 0.9);
}

window {
  background-color: @base;
  border: 1px solid @border;
}

* {
  font-family: "Jetbrains Mono";
  color: @text;
}

#scroll {
  padding: 0.5rem;
}

#input {
  background-color: @surface0;
  color: @text;
  outline: none;
  box-shadow: none;
  border: 1px solid @border;
  border-radius: 0rem;
  font-size: 1rem;
  padding: 0.5rem;
}

#inner-box {
  margin: 0.5rem;
  font-size: 1rem;
}

#img {
  margin: 10px 10px;
}

#entry {
  border-radius: 0rem;
  border: 1px solid transparent;
}

#entry:hover {
  border: 1px solid @border;
}

#entry:selected {
  background-color: @accent;
  outline: none;
}

#text:selected {
  color: @base;
}
