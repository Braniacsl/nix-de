if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Zsh/OMZ Behavior ---
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="🌑🌒🌓🌔🌕🌖🌗🌘"
zstyle ':omz:update' mode reminder


# --- Aliases ---
alias ls='ls --color=auto'
alias ll='ls -lafh'
alias grep='grep --color=auto'
alias please='sudo-rs'
alias fetch='fastfetch'
alias eo="cd $HOME/Repos/emoji-optimizer/"
alias start-vm="sudo systemctl start libvirtd.service"
alias rebuild="sudo nix flake update && sudo nixos-rebuild switch --flake .#$NIX_CONFIG_TYPE"

alias nix-clean="sudo nix-collect-garbage -d && nix-collect-garbage -d ";
alias nix-orphans="nix store gc && sudo nix store optimise";
alias nix-wipe="sudo nix profile wipe-history";
alias nix-system-clean="nix-clean && nix-orphans && nix-wipe";

# --- Functions ---
function Repos() {
    cd "$HOME/Repos" || return
}

function cls(){
    clear
    fetch
}

function proj_config() {
    cd "$HOME/.config/development_initializer/projects/" || return
}

quiet() {
    if alias "$1" &>/dev/null; then
        eval cmd=( $(alias "$1" | sed "s/.*='//;s/'\$//") "${@:2}" )
    else
        cmd=("$@")
    fi
    "${cmd[@]}" > /dev/null 2>&1 &
}

tmux-help() {
    echo "tmux or tmux new -s <session-name>"
    echo "tmux ls"
    echo "tmux attach|a -t <session_id>"
    echo "Ctrl+B D — Detach from the current session."
    echo "Ctrl+B % — Split the window into two panes horizontally."
    echo "Ctrl+B \" — Split the window into two panes vertically."
    echo "Ctrl+B Arrow Key (Left, Right, Up, Down) — Move between panes."
    echo "Ctrl+B X — Close pane."
    echo "Ctrl+B C — Create a new window."
    echo "Ctrl+B N or P — Move to the next or previous window."
    echo "Ctrl+B 0 (1,2...) — Move to a specific window by number."
    echo "Ctrl+B : — Enter the command line to type commands. Tab completion is available."
    echo "Ctrl+B ? — View all keybindings. Press Q to exit."
    echo "Ctrl+B W — Open a panel to navigate across windows in multiple sessions."
}

# --- Startup Command ---
# Run fastfetch when the shell starts.
fetch

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
