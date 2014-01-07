import 'package:polymer/polymer.dart';
import '../lib/model.dart';
import 'package:intl/intl.dart';

@CustomTag("x-post")
class PostElement extends PolymerElement {
  
  @observable Post post;
  
  @observable String get formatedCreatedDate => (post != null) ? new DateFormat.yMd().format(post.created) : " empty post"; 
      
  PostElement.created():super.created() {
    
    // Update formatedCreatedDate when post is modified
    // Does not work for the moment, need a setter ...
    onPropertyChange(this, #post, () {
      notifyPropertyChange(#formatedCreatedDate, "", formatedCreatedDate);
    });
  }
  
  bool get applyAuthorStyles => true;
 
  
}