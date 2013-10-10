import 'package:polymer/polymer.dart';

@CustomTag("x-about")
class AboutElement extends PolymerElement {
        
  void created() {
    super.created();
    
    // Use the global Bootstrap style
    var root = getShadowRoot("x-about");
    root.applyAuthorStyles = true;
  } 
}