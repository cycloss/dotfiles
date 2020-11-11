# a simple function that prints hello and then deletes itself slowly
function outBack
    set str hellooooo
    for char in (string split '' $str)
        echo -n $char
        sleep 0.2
    end
    for i in (seq (string length $str))
        echo -ne \b \b
        sleep 0.2
    end
end
