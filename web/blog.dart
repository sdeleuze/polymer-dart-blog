import 'package:polymer/polymer.dart';
import '../bin/model.dart';
import 'dart:async';
import 'dart:html';


@CustomTag("x-blog")
class BlogElement extends PolymerElement with ObservableMixin {
  
  final Blog blog = new Blog();
   
  void created() {
    super.created();
    var root = getShadowRoot("x-blog");
    root.applyAuthorStyles = true;
    
    WebSocket ws = new WebSocket("ws://localhost:3000/socket");
    
    ws.onMessage.listen((MessageEvent e) {
      print(e.data);
      Post p = new Post.fromJson(e.data);
      blog.posts.add(p);
      
    });
       
    ws.onOpen.listen((Event) {
      print("connection opened");
    });
             
  }
    
}