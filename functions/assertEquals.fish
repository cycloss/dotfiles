#works for lists as well as single variables
function assertEquals -a param1 -a param2

    set firstList $$param1
    set secondList $$param2

    if test (count $firstList) -ne (count $secondList)
        echo 'Lists must have an equal number of items'
        exit 1
    end


    for i in (seq (count $firstList))
        set val1 $firstList[$i]
        set val2 $secondList[$i]
        if test $val1 != $val2
            if test (count $firstList) -gt 1
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