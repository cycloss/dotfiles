function funcls
    ls /Users/ted/.config/fish/functions | ggrep -oP '.*(?=.fish)'
end
