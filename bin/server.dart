import 'package:start/start.dart';
import '../lib/model.dart';
import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart';

Db _db = new Db("mongodb://127.0.0.1/blog");

void main() {
  
  initDb();  
  
  start(port: 3000).then((Server app) {
    
    app.get('/test').listen((request) {
      request.response
        .header('Content-Type', 'text/html; charset=UTF-8')
        .send('Test');
    });

    // We use Websocket for bidirectional data transfer between client and server
    app.ws('/socket').listen((socket) {
      
      // Send the blog when requested
      socket.on(RpcMessage.GET_BLOG_REQUEST, (data) {
        _db.collection("blogs").find(where.sortBy('title')).forEach((jsonBlog) => socket.send(new RpcMessage(RpcMessage.GET_BLOG_RESPONSE, jsonBlog).toJsonString())); 
      });
      
      // Send a new Post each second in order to test client auto-update
      new Timer.periodic(new Duration(seconds:1), (Timer t) {
        Post p = new Post("Additional post", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze"));
        RpcMessage m = new RpcMessage(RpcMessage.NOTIFY_NEW_POST, p.toJson());
        socket.send(m.toJsonString());
      });
                  
    });
    
    print("Blog server started!");
   
  });
}

void initDb() {
  
  print("Connecting to ${_db.serverConfig.host}:${_db.serverConfig.port}");
  DbCollection blogCollection;
  DbCollection userCollection;
  
  Map<String,Map> users = new Map<String,Map>();
  
  _db.open().then((o){
    print(">> Dropping blog db");
    _db.drop();
    print("===================================================================================");
    print(">> Adding users");
    userCollection = _db.collection('users');
    userCollection.insertAll(
        [new User("Sébastien", "Deleuze").toJson(), new User("Baptiste", "Meurant").toJson(), new User("Daphné", "Bellemin").toJson()] 
    );
    return userCollection.find().forEach((jsonUser){
      User u = new User.fromJson(jsonUser);
      print(u.name);  
    });
  }).then((v){
    print("===================================================================================");
    print(">> Adding blogs");
    blogCollection = _db.collection("blogs");
    
    Blog b1 = new Blog("Legendary");
    b1.posts.add(new Post("Initial post 1", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze")));
    b1.posts.add(new Post("Initial post 2", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze")));
    
    blogCollection.insertAll([ b1.toJson()]);
    print("===================================================================================");
    print(">> Blogs ordered by title ascending");
    return blogCollection.find(where.sortBy('title')).forEach((jsonBlog){
      Blog b = new Blog.fromJson(jsonBlog);
      print("[${b.title}]");
    });
  }).then((v){
    return _db.collectionsInfoCursor().forEach((col) => col);
  });
}