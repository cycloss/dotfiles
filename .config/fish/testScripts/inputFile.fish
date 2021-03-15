function inputFile

set -l file $argv[1]
set -l count 1
set -l lines

while read -l line
set lines[$count] $line
set count (math $count + 1)
end < $file

set -l javaClass $argv[2]
java $javaClass $lines
end
