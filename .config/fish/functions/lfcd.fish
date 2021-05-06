function lfcd -d 'lf with cd to lfs cwd on exit'
    # will only execute if lfDir is not zero length on exit
    # there is an abbr for lf that always uses lfcd
    /usr/local/bin/lf
    if test -n $lfDir && test -d $lfDir
        cd $lfDir
    end
end
