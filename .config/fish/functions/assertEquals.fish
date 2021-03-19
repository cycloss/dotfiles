
function assertEquals -a param1 -a param2 -d 'Tests if args are equal for unit test'
    # works for lists as well as single variables
    # must be named parameters to work for lists

    if test (count $param1) -lt 2 -o (count $param2) -lt 2
        set first $param1
        set second $param2
    else
        set first $$param1
        set second $$param2
    end



    if test (count $first) -ne (count $second)
        echo 'Lists must have an equal number of items'
        exit 1
    end


    for i in (seq (count $first))
        set -l val1 $first[$i]
        set -l val2 $second[$i]
        if test $val1 != $val2
            if test (count $first) -gt 1
                set -a errors "     -$val1 not equal to $val2 at index $i"
            else
                set -a errors "     -$val1 not equal to $val2"
            end
        end
    end

    set testNumber (math $testsRun + 1)
    if test (count $errors) -ne 0
        echo "Test $testNumber failed. Errors:"
        for error in $errors
            echo $error
        end
    else
        echo "Test $testNumber passed"
        set -g testsPassed (math "$testsPassed + 1")
    end
    set -g testsRun (math "$testsRun + 1")


end
