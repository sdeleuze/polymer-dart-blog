import 'package:mongo_dart/mongo_dart.dart';
import 'package:unittest/unittest.dart';
import '../bin/model.dart';

main() {
  
  test('Simple MongoDB test', () {
    Db db = new Db("mongodb://127.0.0.1/blog");
    print("Connecting to ${db.serverConfig.host}:${db.serverConfig.port}");
    DbCollection blogCollection;
    DbCollection userCollection;
    
    Map<String,Map> users = new Map<String,Map>();
    
    db.open().then((o){
      print(">> Dropping blog db");
      db.drop();
      print("===================================================================================");
      print(">> Adding users");
      userCollection = db.collection('users');
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
      blogCollection = db.collection("blogs");
      blogCollection.insertAll([ new Blog("Blog 1").toJson(), new Blog("Blog 2").toJson(), new Blog("Blog 3").toJson()]);
      print("===================================================================================");
      print(">> Articles ordered by title ascending");
      return blogCollection.find(where.sortBy('title')).forEach((jsonBlog){
        Blog b = new Blog.fromJson(jsonBlog);
        print("[${b.title}]");
      });
    }).then((v){
      return db.collectionsInfoCursor().forEach((col) => col);
    }).then((dummy){
      db.close();
    });
  });


}