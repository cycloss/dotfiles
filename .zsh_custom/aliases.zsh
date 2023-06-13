
# some things I don't want to expand as abbrs

# show hidden files, add / after dirs, and color 
alias ls='ls -aF --color=auto'
# same as above but show properties
alias lsl='ls -aFlh --color=auto'

if [[ $OSTYPE == darwin* ]]; then
    alias marktext='/Applications/MarkText.app/Contents/MacOS/MarkText'
else
    alias keep='python3 ~/Developer/misc/keep/src/keep.py -r 60 100 -c > /dev/null &'
fi