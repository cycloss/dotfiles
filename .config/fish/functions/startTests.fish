function startTests -d 'Starts unit test session'
    echo --------------
    set -g testName $argv[1]
    echo "Test battery: $testName"
    set -g testsPassed 0
    set -g testsRun 0
end
