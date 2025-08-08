if command -v bat &> /dev/null; then
  alias cat='bat -p'
fi

if command -v eza &> /dev/null; then
  alias ls='eza'
fi
