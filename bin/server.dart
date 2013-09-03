import 'package:start/start.dart';
import 'model.dart';
import 'dart:async';

void main() {
  
  start(port: 3000).then((Server app) {
    
    app.get('/test').listen((request) {
      request.response
        .header('Content-Type', 'text/html; charset=UTF-8')
        .send('Test');
    });

    app.ws('/socket').listen((socket) {
      
      
      
      socket.on(RpcMessage.GET_BLOG_REQUEST, (data) {
        Blog b = new Blog("Legendary");
        b.posts.add(new Post("Initial post 1", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze")));
        b.posts.add(new Post("Initial post 2", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze")));
        RpcMessage m = new RpcMessage(RpcMessage.GET_BLOG_RESPONSE, b.toJson());
        socket.send(m.toJsonString());
      });
      
      new Timer.periodic(new Duration(seconds:1), (Timer t) {
        Post p = new Post("Additional post", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze"));
        RpcMessage m = new RpcMessage(RpcMessage.NOTIFY_NEW_POST, p.toJson());
        socket.send(m.toJsonString());
      });
                  
    });
    
    print("Blog server started!");
   
  });
}