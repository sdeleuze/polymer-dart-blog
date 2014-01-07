import 'package:polymer/polymer.dart';

@CustomTag("x-about")
class AboutElement extends PolymerElement {
        
  AboutElement.created(): super.created() {

  }
  
  bool get applyAuthorStyles => true;
}