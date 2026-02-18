/*
 * userContent.css — можно слегка подтонить фон страниц под системную тему.
 * Делается мягко, чтобы не ломать сайты.
 */

@-moz-document url-prefix(http), url-prefix(https) {
  :root {
    color-scheme: dark;
    background-color: ${COLOR_BG} !important;
  }

  body {
    background-color: ${COLOR_BG} !important;
    color: ${COLOR_FG} !important;
  }
}

