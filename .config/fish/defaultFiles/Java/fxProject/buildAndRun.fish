#! /usr/bin/env fish

echo 'building and running...'
javac --module-path $javafx --add-modules javafx.controls,javafx.fxml src/*.java -d bin
cp src/TestApp.fxml bin
java -cp bin --module-path $javafx --add-modules javafx.controls,javafx.fxml Main
