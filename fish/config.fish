if status is-interactive
    fastfetch --logo $HOME/.config/fastfetch/logo.png --logo-type kitty
end

alias nv=nvim
alias py=python
alias ttest="clearf && uv run pytest"
alias cmps="docker compose"
alias cat="bat"
alias c="clearf"
alias icat="kitten icat"
alias last_n="ls -lAth | head -n"
alias ll="lsd -lA"
alias ls="lsd"

alias "init_std"="uvx copier copy ~/code/templates/standard_template"
alias "init_lib"="uvx copier copy ~/code/templates/lib_template"

set -g fish_greeting ""
set -U fish_color_autosuggestion $COLOR_ACCENT

set -gx OLLAMA_REQUEST_TIMEOUT 300s
set -gx OLLAMA_KEEP_ALIVE 5m

set -gx HYPRSHOT_DIR $HOME/screenshots
set -gx PATH $HOME/.local/bin $PATH
set -gx DOCKER_HOST unix:///home/$USER/.docker/desktop/docker.sock
set -gx GIT_EDITOR vim
set -gx QS_NO_RELOAD_POPUP 1

# pyenv config for fish
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/mreblan/.ghcup/bin $PATH # ghcup-env
