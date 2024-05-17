#PROMPT='%{$fg[green]%}%c%{$reset_color%}$(git_prompt_info)%{$fg[yellow]%} %(!.#.$)%{$reset_color%} '
NEWLINE=$'\n'
PROMPT='$(display_error)%{$fg[green]%}%0/%{$reset_color%}$(git_prompt_info)%{$fg[yellow]%} %(!.#.$)%{$reset_color%} '
#PROMPT='$(display_error)%{$fg[green]%}%0/%{$reset_color%}%{$fg[yellow]%} %(!.#.$)%{$reset_color%} '
#RPROMPT='$(git_prompt_info)' 

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:(%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX=" ["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

display_error() {
	echo "%(?..%{$fg[red]%}x %f)" # %(?.<if true>.<else>)
}
