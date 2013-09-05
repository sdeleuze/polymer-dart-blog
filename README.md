# Polymer.dart sample blog

Sample fullstack (client + server) Dart project.
Based on : Dart, Polymer.dart, MongoDB, Websocket  

## How to run it ?

* Install and run MongoDB on localhost
* Run bin/server.dart to launch the WebSocket server
* Run web/index.html to launch the web interface
* You should see blog posts updated every seconds

## Tests

* You can execute server tests by running test/server_tests.dart while lib/server.dart is running
* You can execute MongoDB tests by running test/mongo_tests.dart while lib/server.dart is running
* You can execute model tests by running test/model_tests.dart
* You can execute client tests by running test/client_tests.html

## Known issues

Issue displaying Twitter Bootstrap style due to shadow dom, see this thread for more details https://groups.google.com/a/dartlang.org/d/msg/web-ui/z_cdW-s-4Xw/NYdS9GSpXC4J

## TODO

* Almost everything ;-)