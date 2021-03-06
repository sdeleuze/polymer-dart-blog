import 'package:polymer/polymer.dart';
import '../lib/model.dart';
import 'dart:async';
import 'dart:html';
import 'router.dart';


@CustomTag("x-blog")
class BlogElement extends PolymerElement {
  
  @observable
  Blog blog = new Blog("Empty blog");
  
  @observable
  String mode = '';
    
  BlogElement.created():super.created() {
    
    WebSocket ws = new WebSocket("ws://localhost:3000/socket");
    
    ws.onMessage.listen((MessageEvent e) {
      RpcMessage m = new RpcMessage.fromJsonString(e.data);
      
      switch(m.method) {
        case RpcMessage.NOTIFY_NEW_POST:
          Post p = new Post.fromJson(m.payload);
          blog.posts.add(p);
          break;
        case RpcMessage.GET_BLOG_RESPONSE:
          blog = new Blog.fromJson(m.payload);
          print(blog.toString());
          break;
      }
    });
       
    ws.onOpen.listen((Event) {
      print("connection opened");
      ws.send(RpcMessage.GET_BLOG_REQUEST);
    });
    
    new Router(this);
             
  }
  
  bool get applyAuthorStyles => true;
    
}