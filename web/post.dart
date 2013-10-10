import 'package:polymer/polymer.dart';
import '../lib/model.dart';
import 'package:intl/intl.dart';

@CustomTag("x-post")
class PostElement extends PolymerElement {
  
  @observable Post post;
  
  @observable String get formatedCreatedDate => (post != null) ? new DateFormat.yMd().format(post.created) : " empty post"; 
      
  void created() {
    super.created();
    
    // Use the global Bootstrap style
    var root = getShadowRoot("x-post");
    root.applyAuthorStyles = true;
    
    // Update formatedCreatedDate when post is modified
    // Does not work for the moment, need a setter ...
    // bindProperty(#formatedCreatedDate, this, 'post');
    new PathObserver(this, 'post').changes.listen((_) => notifyProperty(this, const Symbol('formatedCreatedDate')));
  }
 
  
}