function polo -d 'Returns to the directory set by marco'
    if test -n "$marco"
        cd $marco
    else
        echo "no directory marco'd"
    end
end
