import 'dart:convert';
import 'package:observe/observe.dart';

class Blog {
  @observable
  String title;
  
  @observable
  List<Post> posts = toObservable(new List<Post>());
  
  Blog(this.title);
  
  Blog.fromJson(Map map) {
    this.title = map['title'];
    (map['posts'] as List).forEach((Map m) => this.posts.add(new Post.fromJson(m)));
  }
  
  Map toJson() => {'title': title, 'posts': posts};
}

class Post {
  String title;
  String content;
  DateTime created;
  User author;
  
  Post(String title, String content, User author) {
    created = new DateTime.now();
    this.title = title;
    this.content = content;
    this.author = author;
  }
    
  Post.fromJson(Map map) {
    this.title = map['title'];
    this.content = map['content'];
    this.author = new User.fromJson(map['author']);
  }
  
  Map toJson() => {'title': title, 'content': content, 'created': created.toString(), 'author': author};
  
}

class User {
  String firstname;
  String lastname;
  
  User(this.firstname, this.lastname);
   
  User.fromJson(Map map) {
    this.firstname = map['firstname'];
    this.lastname = map['lastname'];
  }
  
  String get name => "$firstname $lastname";
  
  Map toJson() => {'firstname': firstname, 'lastname': lastname};
}

class RpcMessage {
  
  static const GET_BLOG_REQUEST = "getBlogRequest";
  static const GET_BLOG_RESPONSE = "getBlogResponse";
  static const NOTIFY_NEW_POST = "notifyNewPost";
    
  String method;
  var payload;
  
  RpcMessage(this.method, this.payload);
  
  RpcMessage.fromJsonString(String data) {
    Map m = JSON.decode(data);
    this.method = m['action'];
    this.payload = m['payload'];
  }
  
  Map toJson() => {'action': method, 'payload': payload};
  
  String toJsonString() => JSON.encode(this);
}