# a simple spinning animation
function spin
    set segs '|' '/' '-' '\\'
    for n in (seq 30)
        set j (count $segs)
        set ind (math "($n % $j) + 1")
        echo -ne "\r$segs[$ind]"
        sleep 0.1
    end
end
