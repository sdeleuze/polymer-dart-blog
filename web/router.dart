library router;

import 'dart:html';
import 'blog.dart';
import 'package:route/client.dart' as client;

class Router {

  final homeUrl = new client.UrlPattern(r'(.*)index.html');
  final postUrl = new client.UrlPattern(r'(.*)index.html#post/(\d+)');
  final aboutUrl = new client.UrlPattern(r'(.*)index.html#about');
  
  BlogElement _blogElem;
  client.Router _router;
  
  Router(BlogElement blogElem) {
    _blogElem = blogElem;
    _router = new client.Router(useFragment: true)
    ..addHandler(homeUrl, showHome)
    ..addHandler(postUrl, showPost)
    ..addHandler(aboutUrl, showAbout)
    ..listen(); 
  }
  
  void showHome(String path) {
    _blogElem.mode = 'posts';
  }
  
  void showPost(String path) {
    String post = postUrl.parse(path).last;
    window.alert('Show post $post');
  }
  
  void showAbout(String path) {
    _blogElem.mode = 'about';
  }

}