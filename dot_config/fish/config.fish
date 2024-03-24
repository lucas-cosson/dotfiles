fish_add_path /usr/local/go/bin
fish_add_path "$HOME/.cargo/bin"
source "$HOME/.asdf/asdf.fish"

if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# alias
alias ls "ls --color=auto"
alias cf "nvim ~/.config/fish/config.fish"
alias sf "source ~/.config/fish/config.fish"
alias vim nvim
alias gc "pnpx czg"
# alias end

# env
set -gx EDITOR "code -nw"
set -gx GPG_TTY (tty)
# env end

# pnpm
set -gx PNPM_HOME "/home/lcosson/.local/share/pnpm"
fish_add_path "$PNPM_HOME"
# pnpm end

starship init fish | source
