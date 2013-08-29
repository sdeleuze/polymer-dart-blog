import 'package:polymer/polymer.dart';
import '../bin/model.dart';

@CustomTag("x-post")
class PostElement extends PolymerElement with ObservableMixin {
  
  @observable Post post;
    
  void created() {
    super.created();
    var root = getShadowRoot("x-post");
    root.applyAuthorStyles = true;
  }
 
  
}