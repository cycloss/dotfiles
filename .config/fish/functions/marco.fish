function marco -d 'Sets a directory to return to with polo'
    set -Ux marco (pwd)
    echo "marco set to $marco"
end
