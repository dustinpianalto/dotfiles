alias vz="nvim $HOME/.zshrc"
alias vza="nvim $HOME/.config/zsh/aliases.zsh"
alias vnv="nvim $HOME/.config/nvim/init.vim"
alias vb="nvim $HOME/.config/bspwm/bspwmrc"
alias vsx="nvim $HOME/.config/sxhkd/sxhkdrc"
alias vw="nvim $HOME/Notes/index.md"
alias vlf="nvim $HOME/.config/lf/lfrc"
alias va="nvim $HOME/.config/alacritty/alacritty.yml"
alias sz="source $HOME/.zshrc"

alias ls='lsd --group-dirs first'
alias ll='lsd --group-dirs first -la'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias vi='nvim'
alias vim='nvim'
alias xclip='xclip -selection c'
alias maim-clip="maim -s -f png | copyq copy image/png -"
alias maim-window="maim -st 9999999 | convert - \( +clone -background black -shadow 80x3+5+5 \) +swap -background none -layers merge +repage $HOME/Media/Pictures/Screenshots/$(date -Ins).png"
alias maim-color="maim -st 0 | convert - -resize 1x1\! -format '%[pixel:p{0,0}]' info:-"
alias maim-fullscreen="maim -f png | copyq copy image/png -"
alias maim-clip-file="maim -s -f png $HOME/Media/Pictures/Screenshots/$(date -Ins).png"

