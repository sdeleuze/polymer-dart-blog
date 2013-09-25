import 'package:unittest/unittest.dart';
import '../lib/model.dart';

main() {
  
  test('User JSON serialization & deserialization', () {
    User u = new User("Sébastien", "Deleuze");
    Map m = u.toJson();
    User u2 = new User.fromJson(m);  
    expect(u2, equals(u));    
  });
  
  test('Post JSON serialization & deserialization', () {
    Post p = new Post("Initial post 1", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze"));
    Map m = p.toJson();
    Post p2 = new Post.fromJson(m);  
    expect(p2, equals(p));    
  });
  
  test('Blog JSON serialization & deserialization', () {
    Post p1 = new Post("Initial post 1", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze"));
    Post p2 = new Post("Initial post 2", "Lorem Ipsum Lorem Ipsum Lorem IpsumLorem IpsumLorem Ipsum", new User("Sébastien", "Deleuze"));
    Blog b = new Blog("Sample blog");
    b.posts.add(p1);
    b.posts.add(p2);
    Map m = b.toJson();
    Blog b2 = new Blog.fromJson(m);  
    expect(b2, equals(b));    
  });
  
}
