# Defined in /var/folders/l6/4wtwvg1903l93zlk1_5rzrzr0000gn/T//fish.RORZQn/fish_title.fish @ line 2
function fish_title
    # emacs' "term" is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS; or string match -vq '*,term:*' -- $INSIDE_EMACS
        # An override for the current command is passed as the first parameter.
        # This is used by `fg` to show the true process name, among others.
        echo -n (whoami)@(hostname)' '
        echo (set -q argv[1] && echo $argv[1] || status current-command) (__fish_pwd)
    end
end