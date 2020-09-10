function newLine --on-event fish_preexec                         
                  echo
          end

function newLine2 --on-event fish_postexec                         
                  echo
          end

function dev                          
        cd ~/Developer
    end

function devj                          
        cd ~/Developer/Java
    end

function graph                          
        git log --all --decorate --oneline --graph
    end

function fishconf                          
        code ~/.config/fish/
    end

function mvngen                          
    mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4
end