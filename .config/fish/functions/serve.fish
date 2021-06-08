function serve --description 'Start a local server for the current directory, open in browser'
    set -l port 8080
    if test (count $argv) -eq 1
        set port $argv[1]
    end
    # has to be put into background first so open will actually run
    python -m SimpleHTTPServer $port &
    open http://localhost:$port
    fg
end
