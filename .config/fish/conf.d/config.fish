function newLine --on-event fish_preexec
    echo
end

function newLine2 --on-event fish_postexec
    echo
end

function fish_user_key_bindings
    bind \t accept-autosuggestion
end

function fish_greeting
    #  neofetch
    echo
    echo \t\t\t\tWelcome Ted
    echo
    #  echo
end
