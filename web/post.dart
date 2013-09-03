import 'package:polymer/polymer.dart';
import '../bin/model.dart';
import 'package:intl/intl.dart';

@CustomTag("x-post")
class PostElement extends PolymerElement with ObservableMixin {
  
  @observable Post post;
  
  @observable String get formatedCreatedDate => (post != null) ? new DateFormat.yMd().format(post.created) : " empty post"; 
      
  void created() {
    super.created();
    
    // Use the global Bootstrap style
    var root = getShadowRoot("x-post");
    root.applyAuthorStyles = true;
    
    // Update formatedCreatedDate when post is modified
    bindProperty(this, const Symbol('post'), () => notifyProperty(this, const Symbol('formatedCreatedDate')));
  }
 
  
}