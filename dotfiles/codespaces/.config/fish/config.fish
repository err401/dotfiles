function _fish_env_set
    set -gx fish_greeting
    set -U fish_prompt_pwd_dir_length 0
    set -gx TERM "xterm-256color"
    set -gx EDITOR micro
    set -gx VISUAL micro
    set -gx PAGER most
    set -gx fish_color_command "green"
end

function  _fish_alias_set
    alias ls="exa --icons"
    alias la="exa --icons -l"
    alias df="duf"
end

function _fish_prompt_set
    # directory
    set _fish_prompt_path (string replace $HOME "~" $PWD)
    # prompt glyph
    printf "$(set_color blue)$_fish_prompt_path $(set_color normal) \n▲ "
end

function _fish_right_prompt_set
    # branch_name_check
    function _right_prompt_git_branch
        command git branch --show-current 2>/dev/null
    end
    # staged_check
    function _righ_prompt_staged
        command git status --porcelain 2>/dev/null | grep -e "^[MADRCU]"
    end
    # unstaged_check
    function _right_prompt_unstaged
        command git status --porcelain 2>/dev/null | grep -e "^[MADRCU? ][MADRCU?]"
    end
    # default = green
    set _righ_prompt_color "green"
    # staged = red
    if test -n "$(_righ_prompt_staged)"
        set _righ_prompt_color "red"
    end
    # unstaged = yellow
    if test -n "$(_right_prompt_unstaged)"
        set _righ_prompt_color "bryellow"
    end
    # output
    printf "$(set_color $_right_prompt_color) %s" (_right_prompt_git_branch)
end

if status is-interactive
    _fish_env_set
    function fish_prompt
        _fish_prompt_set
    end
    function fish_right_prompt
        _fish_right_prompt_set
    end
end