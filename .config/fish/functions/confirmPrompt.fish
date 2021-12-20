function confirmPrompt -d 'Asks the user to confirm an action, returns 1 if no'

    # -l sets read string as the end variable
    # -P allows setting a prompt
    read -l -P 'Do you want to continue? [y/N] ' confirm

    switch $confirm
        case Y y
            return 0
        case '' N n
            return 1
    end
    return 1

end
