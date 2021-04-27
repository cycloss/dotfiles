# Defined in /var/folders/l6/4wtwvg1903l93zlk1_5rzrzr0000gn/T//fish.EnM2qk/toph.fish @ line 2
function toph --description 'Lists most used commands and totals'
    # first awk trims the leading white space
    history | ggrep -oP '^ *\w+ |(?<=\| )\w+' | awk '{print $1}' | sort | uniq -c | sort -n | awk 'BEGIN{total = 0}{total += $1}$1 > 10 {printf "%-15s %s\n", $2, $1}END{printf "Total:\t\t%i\n", total}'
end
