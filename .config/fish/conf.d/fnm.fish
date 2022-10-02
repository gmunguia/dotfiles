if status is-interactive
    fnm env --use-on-cd | source
    fnm completions --shell fish | source
else
    fnm env --use-on-cd --log-level=quiet | source
end
