function toph -d 'Lists most used commands and totals'
    history | awk '{print $1}' | sort | uniq -c | sort -n | awk 'BEGIN{total = 0}{total += $1}$1 > 10 {printf "%-15s %s\n", $2, $1}END{printf "Total:\t\t%i\n", total}'
end
