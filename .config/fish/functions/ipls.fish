function ipls -d 'Displays all ip addresses for this machine'
    set -l locals (ifconfig | grep "inet " | awk '{ print $2 }')
    printf "%-15s %s\n" 'Localhost:' $locals[1]
    printf "%-15s %s\n" 'LAN:' $locals[2]
    set -l ext (curl -Ss icanhazip.com)
    printf "%-15s %s\n" 'External:' $ext
end
