export LS_COLORS='di=38:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export EXA_COLORS='da=38;5;245:di=38;5;14:sn=38;5;28:sb=38;5;28:uu=38;5;40:un=38;5;160:gu=38;5;40:gn=38:5:160:bl=38;5;220:ur=37:uw=37:ux=37:ue=37:gr=37:gw=37:gx=37:tr=37:tw=37:tx=37:su=37:sf=37:xa=37'

if [ "$(uname 2> /dev/null)" != "Linux" ]; then
    alias ls='exa'
    alias ll='exa -alhF --group-directories-first --time-style=long-iso'
    alias llx='ll' tr2='llx -T -L=2' tr3='llx -T -L=3' tr4='llx -T -L=4' tr5='llx -T -L=5'
else
    alias ll='ls -lah'
    alias tr2='tree -L 2' tr3='tree -L 3' tr4='tree -L 4' tr5='tree -L 5'
fi
