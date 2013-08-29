import 'package:start/start.dart';
import 'model.dart';
import 'dart:convert';
import 'dart:async';

void main() {
  
  start(port: 3000).then((Server app) {
    
    app.get('/test').listen((request) {
      request.response
        .header('Content-Type', 'text/html; charset=UTF-8')
        .send('Test');
    });

    app.ws('/socket').listen((socket) {
      
      new Timer.periodic(new Duration(seconds:1), (Timer t) {
        Post p = new Post("Title 1", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum");
        socket.send(JSON.encode(p));
      });
                  
    });
    
    print("Jyuro server started!");
   
  });
}