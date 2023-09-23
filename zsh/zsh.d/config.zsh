# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

declare -A ZINIT  # initial Zinit's hash definition
ZINIT[HOME]="${XDG_DATA_HOME:-$HOME/$ZSH_DIR}/zinit"
ZINIT[ZCOMPDUMP_PATH]="${XDG_DATA_HOME:-$HOME/$ZSH_DIR}/zcompdump"
ZINIT[PLUGINS_DIR]="${XDG_DATA_HOME:-$HOME/$ZSH_DIR}/zinit_plugins"
ZINIT[SNIPPETS_DIR]="${XDG_DATA_HOME:-$HOME/$ZSH_DIR}/zinit_snippets"
ZINIT[COMPLETIONS_DIR]="${XDG_DATA_HOME:-$HOME/$ZSH_DIR}/zinit_completions"
[ ! -d $ZINIT[HOME] ] && mkdir -p "$(dirname $ZINIT[HOME])"
[ ! -d $ZINIT[HOME]/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT[HOME]"
source "${ZINIT[HOME]}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# To customize prompt, run `p10k configure` or edit $HOME/$ZSH_DIR/p10k.zsh.
[[ ! -f $HOME/$ZSH_DIR/p10k.zsh ]] || source $HOME/$ZSH_DIR/p10k.zsh
[[ ! -f $HOME/$ZSH_DIR/lscolor.sh ]] || source $HOME/$ZSH_DIR/lscolor.sh

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit load zdharma-continuum/history-search-multi-word


# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# 补全
zinit ice lucid wait='0'
zinit load zsh-users/zsh-completions


# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/history.zsh
# zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
