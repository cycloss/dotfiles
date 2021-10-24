function hs -d 'Search history'
    history -R | grep $argv
end
