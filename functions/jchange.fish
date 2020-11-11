function jchange
    if test (count $argv) -lt 1
        echo "Please provide a jdk version"
        return
    end
    set -Ux JAVA_HOME (/usr/libexec/java_home -v $argv)
    echo "JAVA_HOME: " $JAVA_HOME
    java -version
end
