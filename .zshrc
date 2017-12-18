#####
##### ���ϐ�
#####

# LANG�̐ݒ�
export LANG=ja_JP.UTF-8
case ${UID} in
    0)
	LANG=C
	;;
esac

# ls�̐F���w��
eval "$(dircolors -b)"		# ���ϐ� LS_COLORS ��ݒ�
  #----- �蓮�Őݒ肷��ꍇ
#export LS_COLORS='di=01;34:ln=01;36:ex=01;32:*.tar=01;31:*.gz=01;31'
  #-----

# less����g���G�f�B�^�̎w��
export VISUAL=emacs


#####
##### Default shell configuration
#####

# �v�����v�g�̐ݒ�
autoload colors
colors

# #----- begin for git
# autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
# setopt prompt_subst             # �v�����v�g���\������邽�ѕ]���A�u��
# function rprompt-git-current-branch {
#     local name st color gitdir action
#     if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
#         return
#     fi
#     name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
#     if [[ -z $name ]]; then
#         return
#     fi
#     gitdir=`git rev-parse --git-dir 2> /dev/null`
#     action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
#     st=`git status 2> /dev/null`
#     if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#         color=%F{green}
#     elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
#         color=%F{yellow}
#     elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
#         color=%B%F{red}
#     else
#         color=%F{red}
#     fi
#     echo "$color$name$action%f%b "
# }
# #----- end for git

#PROMPT="%B%F{magenta}[%n@%m] %(!.#.$) %f%b"
PROMPT="%B%F{magenta}[%n] %(!.#.$) %f%b"
PROMPT2="$B%F{magenta}%_> %f%b"
SPROMPT="%B%F{red} correct: %R -> %r [n,y,a,e]? %f%b"
# RPROMPT='%B%F{yellow}[%f%b`rprompt-git-current-branch`%B%F{yellow}%~]%f%b'
RPROMPT='%B%F{yellow}[%f%b%B%F{yellow}%~]%f%b'

#----- �蓮�Őݒ肷��ꍇ�̗�
#local DEFAULT=$'%{\e[1;37m%}'
#local MAGENTA=$'%{\e[1;35m%}'
#local RED=$'%{\e[1;31m%}'
#local YELLOW=$'%{\e[1;33m%}'
#PROMPT="
#${MAGENTA}[%n@%m] %(!.#.$) $DEFAULT"
#PROMPT2="${MAGENTA}%_> % $DEFAULT"
#SPROMPT="${RED}correct: %R -> %r [n,y,a,e]? $DEFAULT"
#RPROMPT="${YELLOW}[%~]$DEFAULT"
  #-----

# �^�[�~�i���̃^�C�g���̐ݒ�
case "${TERM}" in
    kterm*|xterm*)
	precmd() {
            echo -ne "\033]0;${USER}@${HOST}\007"
	}
	;;
    screen*)
        if [ "$OS" != "Windows_NT" ]
        then
            preexec() {
                mycmd=(${(s: :)${1}})
                echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):#$mycmd[1]\e\\"
            }
            precmd() {
                echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):$(basename $(pwd))\e\\"
            }
        fi
        ;;
esac 

# ����
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory		     # HISTFILE���㏑�������ɒǋL
setopt hist_ignore_all_dups          # �d�������Ƃ��A�Â��������폜
setopt hist_ignore_space	     # �擪�ɃX�y�[�X������Ɨ�����ۑ����Ȃ�
setopt share_history		     # ���������L����
  #----- �R�}���h��r���܂őł��Ă���AC-p, C-n�ň�v���闚��������
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
#-----

# �⊮
autoload -U compinit
compinit
zstyle ':completion:*:default' list-colors ${LS_COLORS} # �⊮����F�t���ŕ\��
  #----- �蓮�Őݒ肷��ꍇ
#zstyle ':completion:*' list-colors 'di=01;34:ln=01;36:ex=01;32:*.tar=01;31:*.gz=01;31' # �⊮����F�t���ŕ\��
  #-----
zstyle ':completion:*:default' menu select=1 # �⊮����Emacs�̃L�[�o�C���h�őI��
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31' # kill�̌���F�t���\��
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[-_.]=**' # �啶����⊮�A-_.�̑O��*��₤�悤�ɂ��ĕ⊮

zstyle ':completion:*' accept-exact '*(N)' # �����O���u��������č�����

# �I�u�W�F�N�g�t�@�C���Ƃ����ԃt�@�C���Ƃ���file�Ƃ��ĕ⊮�����Ȃ�
zstyle ':completion:*:*files' ignored-patterns '*?.meta' '*?~' '*\#'

setopt auto_list		# TAB���ڂŕ⊮�����ꗗ�\��
setopt auto_menu		# TAB���ڂŕ⊮�����ꗗ�\��
setopt complete_in_word		# �P��̓r���ł��J�[�\���ʒu�Œu��
setopt list_packed		# �⊮�����l�߂ĕ\��
setopt list_types      # �⊮���\�����Ƀt�@�C���̎�ނ�\���B*, @, /

# �f�B���N�g���ړ�
function chpwd() { ls --color=auto } # cd������A������ls
setopt autocd 			# cd�Ƒł����Ƀf�B���N�g���������ňړ�
setopt autopushd		# ������pushd����Bcd -[tab]�Ō��\��
setopt chase_links		# �����N�ֈړ�����Ƃ����ۂ̃f�B���N�g���ֈړ�
setopt pushd_ignore_dups	# �d������f�B���N�g���͋L�����Ȃ�

# �W���u
setopt NOBGNICE			# �o�b�N�O�����h�̃W���u�̃X�s�[�h�𗎂Ƃ��Ȃ�
setopt NOHUP			# ���O�A�E�g���Ă��o�b�N�O�����h�W���u�𑱂���

# ���̑�
bindkey -e			# Emacs�̃L�[�o�C���h
setopt brace_ccl # �u���[�X�W�J�ɂ�����{}�̒��g���\�[�g���ēW�J�A�܂��A{a-z}�ŕ����͈͎w��
setopt correct			# �R�}���h�̃X�y���~�X���w�E���Ē���
setopt extendedglob		# ���K�\���̂Ȃ񂩁H
setopt nomatch			# �}�b�`���Ȃ��ꍇ�̓G���[�H
setopt notify			# �W���u���I�������炽�����ɒm�点��
setopt rm_star_wait		# rm * �����s����O�Ɋm�F

#####
##### enhancd
#####

if [ -f ~/enhancd/init.sh ]; then
source ~/enhancd/init.sh
fi

#####
##### alias
#####

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -A'
alias lf='ls -F'
alias ll='ls -l'
alias rr='rm -r'


## �u/�v���P���؂�Ƃ݂Ȃ��B
WORDCHARS=${WORDCHARS:s,/,,}


#
# screen
#
#if [ $SHLVL = 1 ];then
#  screen
#fi

# �g���q�G�C���A�X
alias -s xlsx=cygstart
alias -s xls=cygstart
alias -s txt=cygstart
alias -s org=emacs

#####
##### �z�X�g���Ƃ̐ݒ肪����Γǂݍ���
#####


[ -f ~/.zshrc_mine ] && source ~/.zshrc_mine


