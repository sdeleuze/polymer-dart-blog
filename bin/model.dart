import 'dart:convert';
import 'package:observe/observe.dart';

class Blog {
  @observable
  String title;
  
  @observable
  List<Post> posts = toObservable(new List<Post>());
}

class Post {
  String title;
  String content;
  DateTime created;
  User author;
  
  Post(String title, String content) {
    created = new DateTime.now();
    author = new User("Sébastien", "Deleuze");
    this.title = title;
    this.content = content;    
  }
  
  Post.fromJson(String data) {
    Map p = JSON.decode(data);
    this.title = p['title'];
    this.content = p['content'];
  }
  
  Map toJson() => {'title': title, 'content': content};
  
}

class User {
  String firstname;
  String lastname;
  
  User(this.firstname, this.lastname);
  
  String get name => "[firstName= $firstname, lastName= $lastname]";
}