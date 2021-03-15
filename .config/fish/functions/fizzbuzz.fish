function fizzbuzz --argument num
    if test -n "$num" && string match -qr '^[1-9][0-9]?(.[0-9])?$' $num
        for i in (seq "$num")
            set -l out
            if test (math "$i % 3") -eq 0
                set out 'fizz'
            end
            if test (math "$i % 5") -eq 0
                set out $out'buzz'
            end
            if test -z "$out"
                set -a out $i
            end
            echo $out
        end
    else
        echo 'Please enter a number'
    end
end
