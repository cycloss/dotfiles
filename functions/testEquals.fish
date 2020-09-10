function testEquals
    set list 1 2
    count $list
    if test (count $list) -eq 1
        echo "Yes"
    else
        echo "No"
    end
end