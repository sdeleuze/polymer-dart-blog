library model;

import 'dart:convert';
import 'dart:math';
import 'util.dart';
import 'package:observe/observe.dart';

// We have to implement manually class instance to JSON conversion since sadly it is not (yet) manage by Dart ... 

class Blog {
  
  @observable
  String title;
  
  @observable
  List<Post> posts = toObservable(new List<Post>());
  
  Blog(this.title);
  
  Blog.fromJson(Map map) {
    title = map['title'];
    // We convert a List of posts to a list of JSON Map representation of posts
    map['posts'].forEach((Map m) => posts.add(new Post.fromJson(m)));
  }
  
  Map toJson() {
    List jsonPosts = new List();
    posts.forEach((Post p) => jsonPosts.add(p.toJson()));
    return {'title': title, 'posts': jsonPosts};
  }
  
  bool operator ==(Blog other) {
    return (other.title == title) && listsAreEqual(other.posts, posts);
  }
}

class Post {
  num id;
  String title;
  String content;
  DateTime created;
  User author;
  
  Post(String title, String content, User author) {
    id = new Random().nextInt(1000000);
    created = new DateTime.now();
    this.title = title;
    this.content = content;
    this.author = author;
  }
    
  Post.fromJson(Map map) {
    id = map['id'];
    title = map['title'];
    content = map['content'];
    created = DateTime.parse(map['created']);
    author = new User.fromJson(map['author']);
  }
  
  Map toJson() => {'id': id, 'title': title, 'content': content, 'created': created.toString(), 'author': author.toJson()};
  
  bool operator ==(Post other) {
    return (other.id == id) && (other.title == title) && (other.content == content) && (other.created == created) && (other.author == author);
  }
  
}

class User {
  String firstname;
  String lastname;
  
  User(this.firstname, this.lastname);
   
  User.fromJson(Map map) {
    firstname = map['firstname'];
    lastname = map['lastname'];
  }
  
  String get name => "$firstname $lastname";
  
  Map toJson() => {'firstname': firstname, 'lastname': lastname};
  
  bool operator ==(User other) {
    return (other.name == name);
  }
}

/**
 * Simple message intended to be use to transfer JSON over Websocket 
 */
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