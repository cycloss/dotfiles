function endTests
    if test $testsPassed -eq $testsRun
        set_color green
    else
        set_color red
    end
    echo "$testsPassed/$testsRun tests passed for test battery: $testName"
    set_color normal
    echo "--------------"
end