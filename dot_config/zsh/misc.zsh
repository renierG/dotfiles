alias cwd="pwd | pbcopy"

alias myip='dig +short txt ch whoami.cloudflare @1.0.0.1'

if [[ `uname` == Darwin ]]; then
    MAX_MEMORY_UNITS=KB
else
    MAX_MEMORY_UNITS=MB
fi

TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M '$MAX_MEMORY_UNITS''$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'

alias lg=lazygit

alias imgcat='wezterm imgcat'

alias phpdebug='php -dxdebug.mode=debug -dxdebug.client_host=127.0.0.1 -dxdebug.client_port=9003 -dxdebug.start_with_request=yes'
alias php82debug='/usr/local/opt/php@8.2/bin/php -dxdebug.mode=debug -dxdebug.client_host=127.0.0.1 -dxdebug.client_port=9003 -dxdebug.start_with_request=yes'

alias sql_rm_definer="LC_ALL=C sed -i'.original' -e 's/DEFINER[ ]*=[ ]*[^*]*\*/\*/; s/DEFINER[ ]*=[ ]*[^*]*PROCEDURE/PROCEDURE/; s/DEFINER[ ]*=[ ]*[^*]*FUNCTION/FUNCTION/'"
