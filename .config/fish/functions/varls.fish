function varls --description 'Lists useful variables'
    set | grep -vE '^(_*fish|OMF|TERM|XPC|__CF|LaunchInstanceID|SECURITYSESSIONID|status_generation).*' | awk '{printf "%-17s", $1;if($2)print substr($0, index($0, " ")+1); else print ""}'
end
