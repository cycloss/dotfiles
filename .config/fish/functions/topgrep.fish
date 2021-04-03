function topgrep --description 'Launches top filtered by process name'
    set options i/insensitive
    argparse $options -- $argv

    if test (count $argv) -lt 1
        top
    else
        set command pgrep
        if set -q _flag_insensitive
            set -a command -i
        end
        set pids (eval $command $argv)
        set flaggedPids '-pid '{$pids}
        set splitArgs (string split " " -- $flaggedPids)
        top $splitArgs
    end
end
