import 'package:polymer/polymer.dart';
import '../lib/model.dart';

@CustomTag("x-posts")
class PostsElement extends PolymerElement {
  
  @observable List<Post> posts;
        
  PostsElement.created(): super.created() {

  }
  
  bool get applyAuthorStyles => true;
}