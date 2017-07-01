#!/usr/bin/env bash

__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL_DARWIN=''
    readonly PS_SYMBOL_LINUX='$'
    readonly PS_SYMBOL_OTHER='%'
    readonly VIRTUAL_ENV_SYMBOL='ⓔ '
    readonly GIT_BRANCH_SYMBOL=' '
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly GIT_NEED_PULL_SYMBOL='⇣'

    readonly FG_BASE03="\[$(tput setaf 234)\]"
    readonly FG_BASE02="\[$(tput setaf 235)\]"
    readonly FG_BASE01="\[$(tput setaf 240)\]"
    readonly FG_BASE00="\[$(tput setaf 241)\]"
    readonly FG_BASE0="\[$(tput setaf 244)\]"
    readonly FG_BASE1="\[$(tput setaf 245)\]"
    readonly FG_BASE2="\[$(tput setaf 15)\]"
    readonly FG_BASE3="\[$(tput setaf 230)\]"

    readonly BG_BASE03="\[$(tput setab 234)\]"
    readonly BG_BASE02="\[$(tput setab 235)\]"
    readonly BG_BASE01="\[$(tput setab 8)\]"
    readonly BG_BASE00="\[$(tput setab 241)\]"
    readonly BG_BASE0="\[$(tput setab 244)\]"
    readonly BG_BASE1="\[$(tput setab 245)\]"
    readonly BG_BASE2="\[$(tput setab 254)\]"
    readonly BG_BASE3="\[$(tput setab 230)\]"

    readonly FG_YELLOW="\[$(tput setaf 3)\]"
    readonly FG_ORANGE="\[$(tput setaf 9)\]"
    readonly FG_RED="\[$(tput setaf 1)\]"
    readonly FG_MAGENTA="\[$(tput setaf 5)\]"
    readonly FG_VIOLET="\[$(tput setaf 13)\]"
    readonly FG_BLUE="\[$(tput setaf 4)\]"
    readonly FG_CYAN="\[$(tput setaf 6)\]"
    readonly FG_GREEN="\[$(tput setaf 2)\]"

    readonly BG_YELLOW="\[$(tput setab 3)\]"
    readonly BG_ORANGE="\[$(tput setab 9)\]"
    readonly BG_RED="\[$(tput setab 1)\]"
    readonly BG_MAGENTA="\[$(tput setab 5)\]"
    readonly BG_VIOLET="\[$(tput setab 13)\]"
    readonly BG_BLUE="\[$(tput setab 4)\]"
    readonly BG_CYAN="\[$(tput setab 6)\]"
    readonly BG_GREEN="\[$(tput setab 2)\]"

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly BOLD="\[$(tput bold)\]"

    if [[ -z "$PS_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)
              PS_SYMBOL=$PS_SYMBOL_DARWIN
              ;;
          Linux)
              PS_SYMBOL=$PS_SYMBOL_LINUX
              ;;
          *)
              PS_SYMBOL=$PS_SYMBOL_OTHER
      esac
    fi

    __git_info() {
        [ -x "$(which git)" ] || return    # git not found

        # get current branch name or short SHA1 hash for detached head
        local branch="$(git symbolic-ref --short HEAD 2>/dev/null ||
            git describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks

        # branch is modified?
        [ -n "$(git status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead \d\+' | grep -o '\d\+')"
        local behindN="$(echo $stat | grep -o 'behind \d\+' | grep -o '\d\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        printf " $GIT_BRANCH_SYMBOL$branch$marks "
    }

    __venv_info() {
        # Get Virtual Env
        if [[ $VIRTUAL_ENV != "" ]]
        then
            # Strip out the path and just leave the env name
            venv=" ${VIRTUAL_ENV_SYMBOL}${VIRTUAL_ENV##*/} "
        else
            # In case you don't have one activated
            venv=''
        fi
        printf "$venv"
    }

    __vim_mode_info() {
        local VIMODE=$(bind -v | awk '/keymap/ {print $3}')
        echo $VIMODE
        if [ "$VIMODE" = 'vi-insert' ]; then
            printf "[I]"
        else
            printf "[N]"
        fi
    }


    ps1() {
        # Check the exit code of the previous command and display
        # different colors in the prompt accordingly.
        if [ $? -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
        else
            local BG_EXIT="$BG_RED"
        fi

        PS1="$(__vim_mode_info)"
        PS1="$BG_BASE01$FG_BASE2 \w $RESET"
        PS1+="$BG_BLUE$FG_BASE3$(__git_info)$RESET"
        PS1+="$BG_MAGENTA$(__venv_info)$RESET\n"
        PS1+="$BG_EXIT$FG_BASE3 $PS_SYMBOL $RESET "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline