fastfetch
autoload -Uz compinit promptinit
compinit
promptinit
zstyle ':completion:*' menu select
# This will set the default prompt to the walters theme
prompt walters

#add history
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY          # don’t overwrite history
setopt SHARE_HISTORY           # share between all sessions
setopt INC_APPEND_HISTORY      # write history immediately
setopt EXTENDED_HISTORY        # add timestamps
setopt HIST_IGNORE_DUPS        # ignore consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS    # remove older duplicates
setopt HIST_REDUCE_BLANKS      # trim extra spaces
setopt HIST_VERIFY             # edit before executing history expansion
setopt HIST_EXPIRE_DUPS_FIRST  # drop duplicates first when trimming
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[5C" forward-word
bindkey "^[[5D" backward-word
bindkey "^[OC" forward-word
bindkey "^[OD" backward-word
#set terminal
export TERMINAL="kitty"
export TERM="kitty"

#add ~/scripts to path, lower than sys binaries tho
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/.local/bin"
#for libadwaita
export GTK_THEME="$GTK_THEME"

#sets default editor to neovim
export EDITOR=nvim

# Tells GJS where the AstalApps-0.1.typelib is
export GI_TYPELIB_PATH=$GI_TYPELIB_PATH:/usr/local/lib/girepository-1.0

# Tells the system where the libastal-apps.so is
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

alias getAudio="yt-dlp -x --audio-format m4a" #alias for downloading audio through yt-dlp
alias lyrics="sptlrx"
alias music="ncmpcpp"
alias walkmanAudio='yt-dlp -x --audio-format mp3 --audio-quality 320K --ppa "ffmpeg:-ar 44100"'
